From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t3703, t4208: add test cases for magic pathspec
Date: Mon, 9 May 2011 19:33:45 +0700
Message-ID: <BANLkTikONPUVvAEw+fSDva8RUp-YSm-Nxw@mail.gmail.com>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
 <1304852906-29272-1-git-send-email-pclouds@gmail.com> <7v7ha1t6o9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 14:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJPfJ-0005kl-Qg
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1EIMeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 08:34:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44415 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1EIMeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 08:34:16 -0400
Received: by bwz15 with SMTP id 15so3927737bwz.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=zze09NkdSQ7CvWa86c8RfZoqMq7JQdYSHUUJdg57HQQ=;
        b=OO1rdKyxS/kga86TdX4rnQkyC8BfjADwMoIaFPR+x1i5YqUzOLkA7FzSE3122KLpoq
         ISZhgNLyHg4N7jh6Vk4yCFiRvC4Z6jOXpL19BKVA2/1X8dpnCnKvh5gusoUNIbau1/hn
         q5DQ/EuekaLjQeA4fL2Wmwd/0i3b3uklu8Jyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pH6drqAkrCFZEOGD63Wj21HvSZQkImH+ONl0rmpe+tpaMK7n6AoK3I9iRL26MNWcFa
         gDBMOFSh9MNq687sm0AUbHL9TDVGXn/BDveCUS8S+2QP4w1N8eEVKtNLJwm6y/41SktA
         xse7Dyrr+nbj/QXyhNZTeOpzd+VjzPRJljUrA=
Received: by 10.204.35.206 with SMTP id q14mr2607887bkd.128.1304944455207;
 Mon, 09 May 2011 05:34:15 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Mon, 9 May 2011 05:33:45 -0700 (PDT)
In-Reply-To: <7v7ha1t6o9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173226>

2011/5/9 Junio C Hamano <gitster@pobox.com>:
>> +test_expect_failure 'colon alone magic can only used alone' '
>> + =C2=A0 =C2=A0 test_must_fail git add -n sub/foo : &&
>> + =C2=A0 =C2=A0 test_must_fail git add -n : sub/foo
>> +'
>
> I don't care too much about this case (it is a user error), but if yo=
u
> promise you will turn this expect-failure to expect-success in a foll=
ow-up
> patch, why not ;-)?

failed tests are (annoying enough) to be fixed, right? :)

>> +cat >expected <<EOF
>> +add 'anothersub/foo'
>> +add 'expected'
>> +add 'sub/actual'
>> +add 'sub/foo'
>> +EOF
>> +
>> +test_expect_success 'add :' '
>> + =C2=A0 =C2=A0 (cd sub && git add -n : >actual) &&
>> + =C2=A0 =C2=A0 test_cmp expected sub/actual
>> +'
>
> Shouldn't
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git anycmd :
>
> be equivalent to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ (cd $(git rev-parse --show-cdup)/. && gi=
t anycmd)
>
> for any command? =C2=A0I doubt this test is expecting the right outco=
me.
> Shouldn't it result in "Nothing specified, nothing added."?

It's gray area. Yes I'd rather see that behavior, but then a lot of
code needs to be audited. Perhaps we should delay introducing ":"
until get_pathspec() learns to modify argc. IOW die() for now when
users write ":".

>> +test_expect_success 'add :/non-existent' '
>> + =C2=A0 =C2=A0 (cd sub && test_must_fail git add -n :/non-existent)
>> +'
>
> Just being curious. What should the error message say? =C2=A0Can we m=
ake it to
> say "fatal: pathspec 'non-ex' from root did not match any files"?

My opinion is in the next test. It should show exactly what users type
in, ie. "pathspec ':/non-existent' did not match any files". "'non-ex'
from root" is nice when there's only one magic. If users specify a few
more in one pathspec, the text may become too verbose.

>> +test_expect_failure 'show pathspecs exactly what are typed in' '
>> + =C2=A0 =C2=A0 test_cmp expected error
>> +'
>
> Will this break under gettext-poison?

Never really known what that poison is. Will grep ":/non-existent" inst=
ead.

>> +test_expect_failure 'git log :/ ambiguous with [ref]:/path' '
>> + =C2=A0 =C2=A0 test_must_fail git log :/ 2>error &&
>> + =C2=A0 =C2=A0 grep ambiguous error
>> +'
>> +test_expect_failure 'git log :' '
>> + =C2=A0 =C2=A0 git log :
>> +'
>
> These two should expect exactly the same error, I think. ':', ':/' or
> anything magic will not satisify verify_filename(), and needs a
> double-dash before it.

Yes. Error from the latter "fatal: Path '' does not exist (neither on
disk nor in the index)." makes me wonder, why does log accept a sha1
syntax that may resolve to non-commit object?

> We could improve the disambiguation heuristics so that when we do not=
 have
> a '--' on the command line:
>
> =C2=A0- make sure all the earlier ones are refs and they cannot be a =
path on
> =C2=A0 the filesystem (otherwise we need a disambiguator "--").
>
> =C2=A0- the first non-ref argument and everything that follows must b=
e either a
> =C2=A0 ':' magic, a string with globbing character, or a path on the
> =C2=A0 filesystem, and none of them can be a ref.
>
> Do you want to take a stab at it?

A bit busy these days. If you're interested, go ahead.
--=20
Duy
