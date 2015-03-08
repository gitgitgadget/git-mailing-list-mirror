From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] Added test cases for git reset -
Date: Sun, 8 Mar 2015 11:09:37 -0700
Message-ID: <20150308180934.GA18215@gmail.com>
References: <vpqioeb22y8.fsf@anie.imag.fr>
 <1425826720-5899-1-git-send-email-sudshekhar02@gmail.com>
 <1425826720-5899-2-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 19:09:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUfeG-0000cJ-L4
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 19:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbbCHSJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 14:09:52 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46980 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbCHSJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 14:09:51 -0400
Received: by pdev10 with SMTP id v10so28910408pde.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=McrC/m25FRMM8OM3XEPWfQEN78LMaWACBHPwFDMd2Cs=;
        b=ohHFaZMW/N0jcz7tbSPyiiDcsIBc6gco7aFCwQhZPikWS97XMXUfEV+BA+uUUq4ImU
         VJERLxXOzkZWvpuTsP2sBhpw/+BifYqHlZo83bamJ6cx6I6qjM8pyKLxD4dcXUVm54IY
         VjE09sFce4Ic2PV47JhkEVNREDpyKwPujvYrXmCTXzQvSyNqIXXMUr3L+ZDhz0mLsS3L
         EY7GxEqb66ceHLDh22IMavd4nxV/hG4CJtlGRbXayqr3u1a7ngxhCLWFwxW9OsJTwb9Q
         axmowfUwB7qmn9vEpCrAKvf9KFWdizvUL4jENrz5n4JaEA3y/Tjadgg+VtwI+JFKyGti
         4pbw==
X-Received: by 10.66.66.75 with SMTP id d11mr44309149pat.132.1425838190406;
        Sun, 08 Mar 2015 11:09:50 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id qh6sm7277138pab.34.2015.03.08.11.09.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 11:09:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1425826720-5899-2-git-send-email-sudshekhar02@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265100>

Hi,

On Sun, Mar 08, 2015 at 08:28:40PM +0530, Sudhanshu Shekhar wrote:
> Four test cases have been added
> 
> 1) when user does reset - without any previous branch => Leads to error
> 2) when user does reset - with a previous branch      => Ensure it
> behaves like  <at> {-1}
> 
> Other two deal with the situation when we have a file named '-'. We
> ignore such a file and - is always treated either as a previous branch
> or a bad filename. Users who wish to reset a file named '-' should
> specify
> it as './-'
> 
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---


Please reword the commit message so that it uses an imperative
mood; see ~line 112 in Documentation/SubmittingPatches for an
explanation.


>  t/t7102-reset.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..ade3d6a 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,66 @@ test_expect_success 'reset --mixed sets up work tree' '
>  	test_cmp expect actual
>  '
>  
> +cat > expect << EOF


Please drop the space after ">" and "<<".


> +fatal: bad flag '-' used after filename
> +EOF
> +
> +test_expect_success 'reset - with no previous branch' '
> +	git init no_previous --quiet &&
> +	(
> +	cd no_previous
> +	) &&
> +	test_must_fail git reset - 2>output &&
> +	test_cmp expect output
> +'


Please indent lines inside the (...) parens so that it's easier
to notice that they are executing within a subshell, e.g.

	git init no_previous --quiet &&
	(
		cd no_previous &&
		...
	) &&
	...

As written, the above test verifies that we can "cd" into
"no_previous", but because it's a subshell the subsequent
commands after the parens will not be run within that
subdirectory.

Thus, the "git reset -" that we assert must fail is happening in
the outer directory, not the inner no_previous repo.

If that's all we wanted to verify then the (...) sub-shelled cd
command could be replaced entirely by "test -d no_previous", but
I don't think that's the intention of this test.

I believe you may have intended to write the following instead:

test_expect_success 'reset - with no previous branch' '
	git init no_previous --quiet &&
	(
		cd no_previous &&
		test_must_fail git reset - 2>../output
	) &&
	test_cmp expect output
'

"output" becomes "../output" because we're one directory down.


> +
> +test_expect_success 'reset - while having file named - and no previous branch' '
> +	git init no_previous --quiet &&
> +	(
> +	cd no_previous &&
> +	touch ./-
> +	) &&
> +	test_must_fail git reset - 2>output &&
> +	test_cmp expect output
> +'


Ditto; please indent (...) subshells and move the "git reset"
invocation into the subshell so that it runs in the context of
the no_previous repo.  The output path will need the same
adjustment as above.


> +
> +cat > expect << EOF


Ditto; no space after > and <<.


> +Unstaged changes after reset:
> +M	-
> +M	1
> +EOF
> +
> +test_expect_success 'reset - in the prescence of file named - with previou branch' '
> +	git init no_previous --quiet &&
> +	cd no_previous &&


Tests that need to change the current directory with "cd" should
generally always use a (...) subshell.  It prevents them from
needing to manually undo the "cd" before running subsequent
commands that need to be in the original, parent directory.


> +	touch ./- 1 &&
> +	git add 1 - &&
> +	git commit -m "add base files" &&
> +	git checkout -b new_branch &&
> +	echo "random" >./- &&
> +	echo "wow" >1 &&
> +	git add 1 - &&
> +	git reset - >output &&
> +	test_cmp output ../expect


When applying the previous note, if we keep the test_cmp line
outside of the (...) subshell then we won't need to use "../"
when referring to "expect" here, but we will need it for
"../output" file on the line above it.


> +'
> +test_expect_success 'reset - works same as reset @{-1}' '
> +	git init no_previous --quiet &&
> +	cd no_previous &&


Ditto; please use a subshell when entering "no_previous".


> +	echo "random" >random &&
> +	git add random &&
> +	git commit -m "base commit" &&
> +	git checkout -b temp &&
> +	echo new-file >new-file &&
> +	git add new-file &&
> +	git commit -m "added new-file" &&
> +	git reset - &&
> +
> +	git status >../first &&
> +	git add new-file &&
> +	git commit -m "added new-file" &&
> +	git reset @{-1} &&
> +	git status >../second &&
> +	test_cmp ../first ../second
> +'
> +
>  test_done


This test uses "git status" to capture the worktree state so
that we can verify that calling "reset -" and "reset @{-1}" are
equivalent.

Bare "git status" is not a plumbing command.  This doesn't make a
practical difference for the purpose of this test, but it's
probably a good idea to use the plumbing form of "git status" by
passing the "--porcelain" flag when calling it here.


In addition to these tests, it might also be worth adding test
cases to ensure that we unambiguously differentiate the "-"
shortcut from a file when the "--" marker is used in a repo that
contains a "-" file.  When running the following two commands,

	git reset - --
	git reset -- -

we should test that these are unambiguous because of the "--".

The first command should notice the dash-dash and treat "-" like
a shortcut despite the existence of a file named "-".

The second command should operate on the "-" file only and
otherwise leave the repo state as-is.

If we want to be especially thorough then we should also test
this invocation:

	git reset - -- -

This invocation should reset the index to the previous commit
for the "-" file only.

I don't want to increase the scope of this commit so it might
not hurt to add these additional tests as a separate patch.
-- 
David
