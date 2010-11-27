From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: Re: 'git replace' and pushing
Date: Sat, 27 Nov 2010 12:54:17 -0500
Message-ID: <AANLkTikQfQsGrh27Bsegm97E706BVUto7Bp5QQ=sr0J2@mail.gmail.com>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
	<4CEE2060.4020507@drmicha.warpmail.net>
	<AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
	<20101126214325.GC23462@burratino>
	<7vvd3jptch.fsf@alter.siamese.dyndns.org>
	<AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
	<20101127075236.GB24433@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, martin.von.zweigbergk@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 18:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMOyf-0001ry-Qz
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 18:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab0K0RyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 12:54:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64787 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab0K0RyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 12:54:20 -0500
Received: by wwa36 with SMTP id 36so3198027wwa.1
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 09:54:18 -0800 (PST)
Received: by 10.227.127.75 with SMTP id f11mr3869356wbs.69.1290880458168; Sat,
 27 Nov 2010 09:54:18 -0800 (PST)
Received: by 10.227.154.10 with HTTP; Sat, 27 Nov 2010 09:54:17 -0800 (PST)
In-Reply-To: <20101127075236.GB24433@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162319>

On Sat, Nov 27, 2010 at 2:52 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Cory Fields wrote:
>> On Fri, Nov 26, 2010 at 6:18 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>
>>> True, but I suspect the above picture pretty much satisfies Cory's =
initial
>>> wish, no? =C2=A0You can fetch recent 4'--5---6 history as if 4' wer=
e the root
>>> commit, and if you fetched replacement that tells us to pretend tha=
t 4'
>>> has 3 as its parent (and the history leading to 3), you will get a =
deeper
>>> history.
>>
>> Yes, both of these can be accomplished. I've managed to get that par=
t
>> working, where a default clone pulls in half history, and fetching
>> refs/replace gives you the rest. The only problem is that it require=
s a
>> filter-branch before pushing.
>
> That's a one-time thing, not per-push, right? =C2=A0A filter-branch w=
ould
> indeed be needed to transform the history
>
> =C2=A01 --- 2 --- 3 --- 4 --- 5' --- 6'
>
> into
>
> =C2=A01 --- 2 --- 3 --- 4
> =C2=A04' --- 5 --- 6
>
> and that is unavoidable: the object names encode the entire list of
> ancestors, you cannot push an object without its ancestors, etc.
> But afterwards you can build on the history rooted at 4' and all
> should be well, and you can use checkout --orphan to get a new
> root when the current line of history is about to grow too long.
>
> In other words, the distinction between real history and fake history
> is very relevant. =C2=A0Object transport only cares about the real hi=
story
> (barring bugs); if you want to tweak what objects get transferred, yo=
u
> really need to rewrite the real history (or use --depth).
>
>> A shallow clone does not fit for us, because we want the default clo=
ne to
>> only pull half. =C2=A0Having a public 1gb repository that will be cl=
oned quite
>> often is bound to make our host unhappy, so we're doing everything w=
e can to
>> get the size down.
>
> Why not publish a "git bundle" of the first 1gb using HTTP,
> BitTorrent, or some other cache-friendly protocol and use a hook to
> reject attempts to fetch too many objects at once from the host?
>
>> Also, maybe I haven't made this clear... the "real" commit IDs need =
to
>> match the "fake" ones in order to prevent confusion.
>
> Not sure what this means. =C2=A0But commit IDs are defined based on
> content, and for simplicity and sanity the object transport machinery
> deliberately does not look beyond that.
>
> Regards,
> Jonathan
>

I think a one-time filter-branch is going to be our best bet. I had
assumed that this was the case, I just wanted reassurance that it was
necessary. I have that now. Thanks to all for the responses.

Martin: That sounds very interesting indeed. However, the docs make
shallow clones sound scary. From the docs: "A shallow repository has a
number of limitations (you cannot clone or fetch from it, nor push
from nor into it)"

I suppose these limitations would need to be addressed if/when looking
into serverside depth defaults?

Cory
