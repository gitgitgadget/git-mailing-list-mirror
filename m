From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Sat, 15 Mar 2014 17:11:08 +0100
Message-ID: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
	<xmqqk3c0o3cj.fsf@gitster.dls.corp.google.com>
	<53244777.2040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrB4-0007G4-Nk
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbaCOQLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2014 12:11:10 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:62144 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbaCOQLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2014 12:11:09 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so3923567oag.41
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nzjpPwrZO5oHdLI6nRE559u+RQlKhT8uslk9IuHlSyE=;
        b=siUBqNIlaSqc66R14VIxMYG8tx5dZSrbSp3aALsoMDKtIyiW4AV1p4wXQfKb5n37lf
         hQNAW2tZUnX8JXk1vRVtzEHQ6jsdGz/NtU+5kC8EFk7HqXlFVy68dGAC28aJ3/6Il25M
         cWn6dZGiA+DCyL7wwei38KRq8TmljImYBWxRPEGTNE0r0mKAUSVX9kzcyfHnSMoerukg
         s5HjxjSM9mCDcnrjmrASBYHO/6aJjZdkxYBC/g0cS4lrzfKWnQkYk2FSqyd7UDY/RQvc
         ALu4imlvivCxbzZGe5XD3w4TarothIE1IazBVHZtP46gJtjXm9nJ/UW8szhIzecD6IBA
         ypqg==
X-Received: by 10.182.43.161 with SMTP id x1mr12387427obl.5.1394899868363;
 Sat, 15 Mar 2014 09:11:08 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Sat, 15 Mar 2014 09:11:08 -0700 (PDT)
In-Reply-To: <53244777.2040302@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244156>

On Sat, Mar 15, 2014 at 1:28 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2014-03-11 22.03, Junio C Hamano wrote:
>> Benoit Pierre <benoit.pierre@gmail.com> writes:
>>
>>> Add (failing) test: with commit changing the environment to let hoo=
ks
>>> now that no editor will be used (by setting GIT_EDITOR to ":"), the
>>> "edit hunk" functionality does not work (no editor is launched and =
the
>>> whole hunk is committed).
>>>
>>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>>> ---
>>>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 +++++++++++++++++++++++++++=
+++++++
>>>  1 file changed, 34 insertions(+)
>>>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>>>
>>> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_=
-m_hunk_edit.sh
>>
>> I'll move this to t/t7514-commit-patch.sh for now while queuing.
>
> This line is problematic:
>         echo e | env GIT_EDITOR=3D"sed s/+line3\$/+line2/ -i" git com=
mit -p -m commit2 f
>
> (sed -i is not portable:
> http://pubs.opengroup.org/onlinepubs/007908799/xcu/sed.html)
>
> The whole test hangs in a forever loop loop under MacOS:
> debug=3Dt verbose=3Dt ./t7514-commit-patch.sh
> Stage this hunk [y,n,q,a,d,/,e,?]? @@ -1 +1,2 @@
>  line1
> +line3
>
> I think perl can be used instead of sed (but I haven't found the exac=
t syntax yet)

Or maybe change the test to just 'touch' a temporary file or change
its content like Jun Hao did with for its version of the tests:

https://github.com/bloomberg/git/compare/commit-patch-allow-hunk-editin=
g

Should I make a third version? I'll simplify and move the tests to
t/t7514-commit-patch.sh and add a test for the '--dry-run' case. And
also:
- 'now' =3D> 'know' in one of the commit message
- sign off the last patch (which I forgot to do)
- fix the indentation in one of the patch

--=20
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
