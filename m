From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 12/9] t7800: add tests for difftool --dir-diff
Date: Thu, 22 Mar 2012 02:53:26 -0700
Message-ID: <CAJDDKr7m3Ur-RNHffkW9rvbT6kpXWjKMG+Kiw5ausQw5058LHw@mail.gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
	<1332358560-13774-6-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:54:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAeiX-0007QP-AZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 10:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021Ab2CVJxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 05:53:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38528 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447Ab2CVJx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 05:53:27 -0400
Received: by yhmm54 with SMTP id m54so1545843yhm.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UGR3B0DUC4UbFboz5A1wBpyHDcfPT6TRCGGdDSNPnzg=;
        b=TPi/oJSgOEh/cjwIkFJ+7Wbr+L+tk822XtXRLm6nCgavLWsn9UnrzRbMDif2RpzwmC
         aSwUPtOOFHgWqHFj2OH7g0J1h8oFNP1R794i5sND8GNlgpVRdknu446iPCJNQQzpWT4Y
         Cr7EemDvoPQtt3h0WYYIGB2domWaFnsQPXiQXCOLJFgddTExV78hFB6876s53ZYaBwid
         3yDaq/pEfK4+qs8eED4ynn/GZNHqe6zaZRCSkstQqa8yg0weKooO7e6IEfRkROoHq69R
         XQE3bGIv4uTgyd0YU7f0Cg/lJLEe0QbtULvuEDDm0+OC4woAIdwvnG3/tRcN5bssbkbT
         zcRQ==
Received: by 10.236.46.232 with SMTP id r68mr7243762yhb.80.1332410006653; Thu,
 22 Mar 2012 02:53:26 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Thu, 22 Mar 2012 02:53:26 -0700 (PDT)
In-Reply-To: <1332358560-13774-6-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193640>

On Wed, Mar 21, 2012 at 12:36 PM, Tim Henigan <tim.henigan@gmail.com> w=
rote:
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
> =C2=A0t/t7800-difftool.sh | =C2=A0 38 +++++++++++++++++++++++++++++++=
+++++++
> =C2=A01 file changed, 38 insertions(+)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 663247c..fca49d1 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -305,4 +305,42 @@ test_expect_success PERL 'difftool --tool-help' =
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "$tool_help" | stdin_contains tool
> =C2=A0'
>
> +test_expect_success PERL 'setup change in subdirectory' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout master &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir sub &&
> + =C2=A0 =C2=A0 =C2=A0 echo master >sub/sub &&
> + =C2=A0 =C2=A0 =C2=A0 git add sub/sub &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "added sub/sub" &&
> + =C2=A0 =C2=A0 =C2=A0 echo test >>file &&
> + =C2=A0 =C2=A0 =C2=A0 echo test >>sub/sub &&
> + =C2=A0 =C2=A0 =C2=A0 git add . &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "modified both"
> +'
> +
> +test_expect_success PERL 'difftool -d' '
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool -d --extcmd ls branch) &=
&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains sub &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains file
> +'
> +
> +test_expect_success PERL 'difftool --dir-diff' '
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --dir-diff --extcmd ls b=
ranch) &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains sub &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains file
> +'
> +
> +test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --dir-diff --prompt --ex=
tcmd ls branch) &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains sub &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains file
> +'
> +
> +test_expect_success PERL 'difftool --dir-diff from subdirectory' '
> + =C2=A0 =C2=A0 =C2=A0 cd sub &&
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --dir-diff --extcmd ls b=
ranch) &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains sub &&
> + =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains file &&
> + =C2=A0 =C2=A0 =C2=A0 cd ..

If we wrap the subdir operations in parentheses then the sub-shell
saves us from having to do "cd ..".  It also helps prevent leakage
from earlier failures, which is helpful when writing new tests.

(Please excuse any gmail whitespace mangling)

e.g.:

test_expect_success PERL 'difftool --dir-diff from subdirectory' '
 =C2=A0 =C2=A0 =C2=A0 (
        =C2=A0 =C2=A0 =C2=A0 cd sub &&
        =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --dir-diff --extcmd =
ls branch) &&
        =C2=A0 =C2=A0 =C2=A0 echo "$diff" | stdin_contains sub &&
 =C2=A0 =C2=A0 =C2=A0        echo "$diff" | stdin_contains file
 =C2=A0 =C2=A0 =C2=A0 )
'

It'd also be pretty neat if we could gather file content somehow.
This would allow us to make assertions about the content of the
left/right parameters passed to the tool.  I don't know if that's test
overkill ;-) but it seems like it could be helpful.
--=20
David
