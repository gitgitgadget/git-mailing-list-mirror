From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 20:58:03 -0500
Message-ID: <AANLkTi=FjSFLsbXf2Rp_Onm26yyxX+xSPrh2pB=_f5RU@mail.gmail.com>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
	<4CEE2060.4020507@drmicha.warpmail.net>
	<AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
	<20101126214325.GC23462@burratino>
	<7vvd3jptch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:59:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMA4D-0007kI-Sd
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0K0B6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 20:58:07 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54682 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0K0B6F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 20:58:05 -0500
Received: by wyb28 with SMTP id 28so2521197wyb.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 17:58:03 -0800 (PST)
Received: by 10.227.145.139 with SMTP id d11mr3137919wbv.11.1290823083201;
 Fri, 26 Nov 2010 17:58:03 -0800 (PST)
Received: by 10.227.154.10 with HTTP; Fri, 26 Nov 2010 17:58:03 -0800 (PST)
In-Reply-To: <7vvd3jptch.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162294>

On Fri, Nov 26, 2010 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> =C2=A0Real history
>> =C2=A0------------
>> =C2=A04' --- 5 --- 6
>>
>> =C2=A01 --- 2 --- 3 --- 4
>>
>> =C2=A0Fake history
>> =C2=A0------------
>> =C2=A01 --- 2 --- 3 --- 4 --- 5 --- 6
>>
>> =C2=A0Replacement ref
>> =C2=A0---------------
>> =C2=A04' --> 4
>>
>> This way, a person a person can fetch either piece of real history
>> without trouble, and if they fetch the replacement ref, too, the
>> history is pasted together.
>>
>> It is not possible in git to push a commit without its ancestors;
>> replacement refs do not change that.
>
> True, but I suspect the above picture pretty much satisfies Cory's in=
itial
> wish, no? =C2=A0You can fetch recent 4'--5---6 history as if 4' were =
the root
> commit, and if you fetched replacement that tells us to pretend that =
4'
> has 3 as its parent (and the history leading to 3), you will get a de=
eper
> history.
>

Yes, both of these can be accomplished. I've managed to get that part
working, where a
default clone pulls in half history, and fetching refs/replace gives
you the rest. The only
problem is that it requires a filter-branch before pushing. Otherwise,
4 gets pushed rather
than 4', meaning that clones will require all the objects. So it
works, but I'll have to spend
quite a while making it 'perfect' so that I only have to rewrite histor=
y once.

A shallow clone does not fit for us, because we want the default clone
to only pull half.
Having a public 1gb repository that will be cloned quite often is
bound to make our host
unhappy, so we're doing everything we can to get the size down.

Also, maybe I haven't made this clear... the "real" commit IDs need to
match the "fake"
ones in order to prevent confusion. I think that's the part that makes
this so difficult.
Otherwise, something like this [1] would work just fine (probably
exactly what Junio was
suggesting)

Any other suggestions? Or do I just have to face the fact that I'm
going to have to break
hashes?

[1] http://progit.org/2010/03/17/replace.html

Cory
