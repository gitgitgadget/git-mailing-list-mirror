From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Thu, 11 Nov 2010 20:31:08 -0500
Message-ID: <AANLkTinrhfmeeToMZfW942xvJGz9vgiQd6+2bXkSawJU@mail.gmail.com>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
	<AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
	<7vpqubfrkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 02:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGiTz-0005lY-0t
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 02:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405Ab0KLBbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 20:31:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54195 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845Ab0KLBbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 20:31:09 -0500
Received: by qwi4 with SMTP id 4so509332qwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Eh54AyaU+gv85oMdnGgDd7ZBJPZ0IZ1bTTi0K9MChXg=;
        b=BtEwjGUsVH3Oh90VDF9UUqPQzVIUCmPH1xgdn5wxSzVahVZIKja4FGdEisqwyF+1Ne
         dYsSVa0sz9KOBiiN1E8pf6muuFbt/gGHoffZGKUir1CR7eul4QRqhrjliYyi7iIMe/tM
         K7KIdNOoB7jzXbpFzVaKvhM+Hf/NJ3E9fuEtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hcBaGPM71o5XCCKeM/XOBzVZHbMjhFkoaTA28l2giCWMf9CkL7m9wx3R4ylxFeqz/V
         m4kcjwwtdEiDyZsw/wXAcVBLCMmAiBhBTYYTLmZHNDWW65istWqZcgEvAc0nyFrsDAj0
         DqeWGPqYSowBgrG2XknVkoPInfL4BzIemk1aI=
Received: by 10.224.204.134 with SMTP id fm6mr1590609qab.325.1289525468748;
 Thu, 11 Nov 2010 17:31:08 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Thu, 11 Nov 2010 17:31:08 -0800 (PST)
In-Reply-To: <7vpqubfrkj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161313>

On Thu, Nov 11, 2010 at 5:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> I don't think there are any merge strategies other than recursive th=
at
>> accept options, so what I could add a test case for is that e.g.
>> '-s ours -X foo' uses the 'ours' strategy, even though 'foo' will be
>> ignored.
>
> You would do something like this.
>
> -- >8 --
> Subject: [PATCH] t3402: test "rebase -s<strategy> -X<opt>"
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0t/t3402-rebase-merge.sh | =C2=A0 21 +++++++++++++++++++++
> =C2=A01 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index 2bea656..be8c1d5 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -117,4 +117,25 @@ test_expect_success 'picking rebase' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0'
>
> +test_expect_success 'rebase -s funny -Xopt' '
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "rm -fr test-bin funny.was.=
run" &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir test-bin &&
> + =C2=A0 =C2=A0 =C2=A0 cat >test-bin/git-merge-funny <<-EOF &&
> + =C2=A0 =C2=A0 =C2=A0 #!$SHELL_PATH
> + =C2=A0 =C2=A0 =C2=A0 case "\$1" in --opt) ;; *) exit 2 ;; esac
> + =C2=A0 =C2=A0 =C2=A0 shift &&
> + =C2=A0 =C2=A0 =C2=A0 >funny.was.run &&
> + =C2=A0 =C2=A0 =C2=A0 exec git merge-recursive "\$@"
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 chmod +x test-bin/git-merge-funny &&
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> + =C2=A0 =C2=A0 =C2=A0 git checkout -b test-funny master^ &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit funny &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PATH=3D./test-bin:=
$PATH
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git rebase -s funn=
y -Xopt master
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 test -f funny.was.run
> +'
> +
> =C2=A0test_done
> --
> 1.7.3.2.334.gd1031

That's clever. Thank you!

The fix for this bug touches the same parts of the code as my
refactoring of git rebase. If you don't mind, I will post your test
case and the fix as part of the refactoring series.
