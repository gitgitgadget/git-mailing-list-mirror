From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Mon, 28 Apr 2014 22:49:30 +0200
Message-ID: <535EBEDA.5070207@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com> <20140428193502.GD25993@sigill.intra.peff.net> <535EB167.4030804@web.de> <20140428200326.GA2961@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesVO-0002A6-HT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbaD1UuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:50:14 -0400
Received: from mout.web.de ([212.227.15.4]:49863 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbaD1Utm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:49:42 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M3Bqx-1Wv1jQ0knn-00syPA; Mon, 28 Apr 2014 22:49:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140428200326.GA2961@sigill.intra.peff.net>
X-Provags-ID: V03:K0:kdGAFfxDxTNhbyeBc+OBAW3c1L9K4fnqZVUpc0Qihbkoo9O3llP
 cxheS2sTjjlIYI+CzAqW4aMmBngCRfRmugV3HLcSbBCKI+sgtTomOqD78ldKitvojNDdnYe
 ZeQ2RcMBSZGTZRANAX8QtipvELNzuOL30GYFjA6XNDiJTHhg89jXh8wUOxRKB/vi2KR27n6
 KSzeuvclJ7VUTxE/NDmcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247446>

On 2014-04-28 22.03, Jeff King wrote:
> On Mon, Apr 28, 2014 at 09:52:07PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> To my knowledge repos with decomposed unicode should be rare in
>> practice.  I only can speak for european (or latin based) or cyrilli=
c
>> languages myself:
> I've run across several cases in the past few months, but only just
> figured out what was going on. Most were tickets to GitHub support, b=
ut
> we actually have such a case in our github/github repository. In most
> cases, I think they were created on older versions of git on OS X,
> either before core.precomposeunicode existed, or before it was turned=
 on
> by default. The decomposed form got baked into the tree (whatever the
> user originally typed, git probably found out about it via "git add .=
").
>
> I think reports are just coming in now because we didn't start turnin=
g
> on core.precomposeunicode by default until v1.8.5, shipped in Novembe=
r.
> And then, a person working on the repository would not notice anythin=
g,
> since we only set the flag during clone. So it took time for people t=
o
> upgrade _and_ to make fresh clones.
OK, thanks for the description.
In theory we can make Git "composition ignoring" by changing
index_file_exists() in name-hash.c.
(Both names must be precomposed first and compared then)

I don't know how much people are using Git before 1.7.12 (the
first version supporting precomposed unicode).

Could we simply ask them to upgrade ?
The next problem is that people need to agree if the repo should store
names in pre- or decomposed form.
(My voice is for precomposed)
Unfortunatly the core.precomposeunicode is repo-local, so everybody
needs to "agree globally" and "configure locally".

Side note:
I which we had this config variable travelling with the repo, like .git=
attributes does
for text dealing with CRLF-LF.

I don't know how many reports you have, reading all this it feels as if=
 the effected users
could "normalize" their repos and run "git config core.precomposeunicod=
e true", followed
by "git config --global core.precomposeunicode true".
Does that sound like a possible way forward ?
>> So for me the test case could sense, even if I think that nobody (TM=
)
>> uses an old Git version under Mac OS X which is not able to handle
>> precomposed unicode.
> Even when they do not, the decomposed values are baked into history f=
rom
> those old versions. So it is a matter of history created with older
> versions not interacting well with newer versions.
I'm not sure if I understood all the details here, but I would be happy=
 to help
with suggestions/tests/reviews.

> -Peff
