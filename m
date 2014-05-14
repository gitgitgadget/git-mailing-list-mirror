From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Please pull the patch series "use the $( ... ) construct for
 command substitution"
Date: Wed, 14 May 2014 17:21:00 -0400
Message-ID: <CAPig+cT-Nn_hnqE0CK=c0-9+_QG9hpsp9j4cERsvvjwkrLmSMw@mail.gmail.com>
References: <CA+EOSBk4YvQHTG=gRd1TF9gX0OgjLpjRidh7NAa9wmjr6bSkBQ@mail.gmail.com>
	<vpqoaz0i8od.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 14 23:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgc1-0001Ck-HD
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbaENVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:05 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:50148 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbaENVVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:21:02 -0400
Received: by mail-yk0-f170.google.com with SMTP id 10so142835ykt.15
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hDisFE4rO4FkeyP8xkqOT/ihwHADfNBu6kPLXjl7Ews=;
        b=tqpRwI6VntNdpmzQsW5xgYstqM2cZcEc8TbFtxUw2q64gEvCTXHn7kAZ6nMBj5baLk
         ruRgZya+1YLBhO676AAzgURBAsw6O3Pe1DJ0sXmuRlmLIaeC10PyIoWBT46Sj0qYqExG
         QKQ8uVCMaKQGeNzbuYXBu9Myac6goRHnk6Dk3Iu3tkuzOCekPaPmmr4iq77HfS8kcMFS
         BTkoOxYSZiCIywKuYOO4+9/mUpVo7bx1or24o/CHnt5JAgbGvmow0+yqNYW75hLKOH5o
         MxVloEPwPi1M3E9la7s7CzqEXSyvRDWYUEoBBTnmulD35qEspO2n+UsSmllJqe+F6Qog
         6usQ==
X-Received: by 10.236.137.8 with SMTP id x8mr8879887yhi.4.1400102461075; Wed,
 14 May 2014 14:21:01 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Wed, 14 May 2014 14:21:00 -0700 (PDT)
In-Reply-To: <vpqoaz0i8od.fsf@anie.imag.fr>
X-Google-Sender-Auth: gEDgrYEqmodGfw8l-AoavqoB0QM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248988>

On Wed, May 14, 2014 at 1:14 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> The following changes since commit 6308767f0bb58116cb405e1f4f77f5dfc1589920:
>>   Merge branch 'fc/prompt-zsh-read-from-file' (2014-05-13 11:53:14 -0700)
>> are available in the git repository at:
>>   https://github.com/devzero2000/git-core.git  ep/shell-command-substitution-v4
>
> There's a mis-replacement of multiple `..` `..` on the same line in
> t9300-fast-import.sh. I've sent you a pull request with a fixup.
>
> I'm not sure about this one:
>
> commit e69c77e580d56d587381066f56027c8a596c237a
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Wed May 14 03:28:11 2014 -0700
>
>     t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct for command substitution
> [...]
> @@ -38,20 +38,20 @@ test_expect_success 'some unrelated changes to git' "
>         "
>
>  test_expect_success 'change file but in unrelated area' "
> -       test x\"\`sed -n -e 4p < file\`\" = x4 &&
> -       test x\"\`sed -n -e 7p < file\`\" = x7 &&
> +       test x"$(sed -n -e 4p < file)" = x4 &&
> +       test x"$(sed -n -e 7p < file)" = x7 &&
>               ^
>             here
>
> We're inside " from the test_expect_success line. We used to have a
> literal " (because of the backslash), we now have a closing " because
> you removed the \. So, the sed command used to be protected by
> double-quotes, and it is now outside them. Compare:
>
> $ sh -c "echo \"\`date\`\""
> Wed May 14 18:47:54 MEST 2014
> $ sh -c "echo "$(date)""
> Wed
>
> In your case, it doesn't break because the expected output of sed
> contains no space, but that seems dangerous to me.
>
> I do not understand the use of the \ in front of the ` in the original
> code.

The second argument of test_expect_success is double-quoted, so a bare
`...` would be evaluated before test_expect_success is even invoked.
Quoting it as \'...\' correctly suppresses the automatic evaluation,
giving test_expect_success the opportunity to evaluate it on-demand.

In this case, it doesn't matter since "file" is populated outside the
invocation of test_expect_success, but it would matter if "file" was
populated or modified within the test itself. In that sense, the
original code with delayed \`...\` evaluation is more robust and
future-proof.

> The correct code should be
>
>         test x\"$(sed -n -e 4p < file)\" = x4 &&
>
> I guess.

Same issue. The $(...) is being evaluated even before
test_expect_success is invoked. Better would be to suspend evaluation
via \$(...) to allow test_expect_success to evaluate it on-demand.

>         perl -i.bak -p -e 's/^4\$/4444/' file &&
>         perl -i.bak -p -e 's/^7\$/7777/' file &&
> -       test x\"\`sed -n -e 4p < file\`\" = x4444 &&
> -       test x\"\`sed -n -e 7p < file\`\" = x7777 &&
> +       test x"$(sed -n -e 4p < file)" = x4444 &&
> +       test x"$(sed -n -e 7p < file)" = x7777 &&
>
> Likewise.
>
> -               test x\"\`sed -n -e 4p < file\`\" = x4444 &&
> -               test x\"\`sed -n -e 7p < file\`\" = x7777 &&
> -               test x\"\`sed -n -e 58p < file\`\" = x5588 &&
> -               test x\"\`sed -n -e 61p < file\`\" = x6611
> +               test x"$(sed -n -e 4p < file)" = x4444 &&
> +               test x"$(sed -n -e 7p < file)" = x7777 &&
> +               test x"$(sed -n -e 58p < file)" = x5588 &&
> +               test x"$(sed -n -e 61p < file)" = x6611
>
> Likewise.
>
>
> More or less the same issue with
>
> commit 020568b9c36c023810a3482b7b73bcadd6406a85
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Mon Apr 28 05:49:50 2014 -0700
>
>     t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for command substitution
> [...]
> diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
> index fb41876..cf2e25f 100755
> --- a/t/t9114-git-svn-dcommit-merge.sh
> +++ b/t/t9114-git-svn-dcommit-merge.sh
> @@ -68,8 +68,8 @@ test_expect_success 'setup git mirror and merge' '
>  test_debug 'gitk --all & sleep 1'
>
>  test_expect_success 'verify pre-merge ancestry' "
> -       test x\`git rev-parse --verify refs/heads/svn^2\` = \
> -            x\`git rev-parse --verify refs/heads/merge\` &&
> +       test x\$(git rev-parse --verify refs/heads/svn^2\) = \
> +            x\$(git rev-parse --verify refs/heads/merge\) &&
>         git cat-file commit refs/heads/svn^ | grep '^friend$'
>         "
>
> I'm not sure what's the intent of the \ in front of ` in the original
> code, but changing it to $(...) changes the meaning:
>
> $ sh -c "echo \`date\`"
> Wed May 14 18:58:19 MEST 2014
> $ sh -c "echo \$(date\)"
> sh: 1: Syntax error: end of file unexpected (expecting ")")
>
> I didn't investigate closely, but I'm getting test failures without your
> patch, and the script stops in the middle with it so it does break
> something.
>
> @@ -80,10 +80,10 @@ test_expect_success 'git svn dcommit merges' "
>  test_debug 'gitk --all & sleep 1'
>
>  test_expect_success 'verify post-merge ancestry' "
> -       test x\`git rev-parse --verify refs/heads/svn\` = \
> -            x\`git rev-parse --verify refs/remotes/origin/trunk \` &&
> -       test x\`git rev-parse --verify refs/heads/svn^2\` = \
> -            x\`git rev-parse --verify refs/heads/merge\` &&
> +       test x\$(git rev-parse --verify refs/heads/svn\) = \
> +            x\$(git rev-parse --verify refs/remotes/origin/trunk \) &&
> +       test x\$(git rev-parse --verify refs/heads/svn^2\) = \
> +            x\$(git rev-parse --verify refs/heads/merge\) &&
>
> Likewise.
>
>
> commit 7e29ac501ce24aa5af3a50f839cd3ad176481a96
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Wed Mar 26 04:48:40 2014 -0700
>
>     t9100-git-svn-basic.sh: use the $( ... ) construct for command substitution
>
> -test_expect_success 'able to dcommit to a subdirectory' "
> +test_expect_success 'able to dcommit to a subdirectory' '
>
> There is an actual change other than sed + review and trivial fix here.
> That makes the review harder. Such change should IMHO not be part of the
> same series.
>
> -       git commit -m '/bar/d should be in the log' &&
> +       git commit -m "bar/d should be in the log" &&
>
> You lost a / here.
>
>         git svn dcommit -i bar &&
> -       test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
> +       test -z $(git diff refs/heads/my-bar refs/remotes/bar) &&
>
> Did you not loos the \"...\" whitespace protection here?
>
> -       test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
> +       test -z "$(git diff refs/heads/my-bar refs/remotes/bar)" &&
>
> That seems to be the correct way of doing what you tried right above.
>
> commit b438455b7b97d90a1b8da4ec4e9de0063c20f63c
> Author: Elia Pinto <gitter.spiros@gmail.com>
> Date:   Wed Mar 26 04:48:40 2014 -0700
>
>     t9107-git-svn-migrate.sh: use the $( ... ) construct for command substitution
>
> [...]
>
> @@ -75,7 +75,7 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
>         for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
>                 git rev-parse --verify refs/remotes/origin/\$i^0 >> refs.out || exit 1;
>             done &&
> -       test -z \"\`sort < refs.out | uniq -d\`\" &&
> +       test -z \"\$(sort < refs.out | uniq -d\)\" &&
>
> Same problem as above, this \$( is broken.
>
> My advice: apply my small fix for multiple `...` `...`, and eject the
> other patches from the series for now, they are distracting reviewers.
>
> That should lead to a trivially-correct series with ~80 patches. Once
> this one is accepted, the 4 remaining patches can be fixed and reviewed
> more carefully (Cc Eric Wong <normalperson@yhbt.net> since the patches
> are about git-svn).
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
