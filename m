From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Reduce cost of deletion in levenstein distance (4 -> 3)
Date: Thu, 24 May 2012 22:33:32 +0200
Message-ID: <vpq62blwc83.fsf@bauges.imag.fr>
References: <1335517082-29325-1-git-send-email-Matthieu.Moy@imag.fr>
	<4F9A6A4E.2070808@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu May 24 22:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeja-0006zn-WE
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab2EXUeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:34:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43896 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756730Ab2EXUeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 16:34:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4OKPTwJ008449
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 22:25:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXeiz-0008J8-IS; Thu, 24 May 2012 22:33:33 +0200
In-Reply-To: <4F9A6A4E.2070808@in.waw.pl> ("Zbigniew \=\?utf-8\?Q\?J\=C4\=99drze\?\=
 \=\?utf-8\?Q\?jewski-Szmek\=22's\?\=
	message of "Fri, 27 Apr 2012 11:43:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 May 2012 22:25:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4OKPTwJ008449
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338495934.99587@mWV5ZqzFmpOvoRuX6Aw4ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198419>

[ Sorry for the looong delay ]

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 04/27/2012 10:58 AM, Matthieu Moy wrote:
>> Before this patch, a character deletion has the same cost as 2 swaps=
, or
>> 4 additions, so Git prefers suggesting a completely scrambled comman=
d
>> name to removing a character. For example, "git tags" suggests "stag=
e",
>> but not "tag".
>>=20
>> By setting the deletion cost to 3, we keep it higher than swaps or
>> additions, but prefer 1 deletion to 2 swaps. "git tags" now suggests
>> "tag" in addition to staged.
>
> Hi,
> looks sensible, but I wonder if the algorithm shouldn't be tweaked ev=
en
> further. I understand why 'tags' and 'stage' are similar,
> but if I say 'tagz', git proposes (with your change), both 'stage' an=
d
> 'tag'. 'tag' is one deletion away, but 'stage' requires a deletion an=
d a
> replacement, so should loose to 'tag', I think.

=46irst, my patch is also an improvement here since it allows showing t=
ags
(previously, it showed only stage). The idea for showing stage before
tag is that the cost of deletion is greater than the cost of insertion,
which corresponds to the hypothesis that it's more common to miss one
character when typing than typing too many. That's probably subjective,
but I think it makes sense.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
