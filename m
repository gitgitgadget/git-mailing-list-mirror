Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9BC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF721775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nR5qTpUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBFTmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:42:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgBFTmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:42:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0724F43D1F;
        Thu,  6 Feb 2020 14:42:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D3tbRLkBYZaBnd8yBv2GqS1yu44=; b=nR5qTp
        ULNg2yR/YX2w4w9cSbOxnAPU7FFdcY/eDZcHY7vcG4IdX9WshmovwqWQLWyz9XET
        gXyW3nOAXD8pZb8qvQuBEuyo3qO3IywWSr5gwL8LL2/cnX39C0UJ5Ku8SlMHwoKJ
        uUt0nX8rICDw0KndchCB0hYo8kdPtkqbJrMfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Asv1xj1wuepfCYBl7yvKhdV2DbDSeM7w
        36j3UAEd+Sq+iKi9CMJstovDvnByAXHhOa1DREhvNOb+84xuOxkzCxNpDXt5wkoG
        lKF+Am5e5un5Wxu4lRygmKjQSiiWezANFbLvwenPbqQk2xH3ix4XmyB2bUA3sG9r
        GMFPDe2mGB8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0A3C43D1E;
        Thu,  6 Feb 2020 14:42:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B8C343D1D;
        Thu,  6 Feb 2020 14:42:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 3/5] git-p4: add --no-verify option
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <b538ad08b6f931cab27f084364669583743e4839.1581002149.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 11:42:08 -0800
In-Reply-To: <b538ad08b6f931cab27f084364669583743e4839.1581002149.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Thu, 06 Feb 2020 15:15:46
        +0000")
Message-ID: <xmqqpnerec4v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3F60B74-4918-11EA-B230-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> Add new command line option --no-verify:
>
> Add a new command line option "--no-verify" to the Submit command of
> git-p4.py.  This option will function in the spirit of the existing
> --no-verify command line option found in git commit. It will cause the
> P4 Submit function to ignore the existing p4-pre-submit.
>
> Change the execution of the existing trigger p4-pre-submit to honor the
> --no-verify option. Before exiting on failure of this hook, display
> text to the user explaining which hook has failed and the impact
> of using the --no-verify option.
>
> Change the call of the p4-pre-submit hook to use the new run_git_hook
> function. This is in preparation of additional hooks to be added.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  Documentation/git-p4.txt   | 10 ++++++++--
>  Documentation/githooks.txt |  5 ++++-
>  git-p4.py                  | 30 +++++++++++++++++++-----------
>  3 files changed, 31 insertions(+), 14 deletions(-)

Nicely done.  If your strategy is to "add a feature and use it in
the same patch as the feature is added", which is what is done for
the new "no-verify" feature that is applied to existing p4-pre-submit
hook, then the code that runs p4-pre-submit in the original should
be changed to use run_git_hook() in the previous step, which added
the new run_git_hook() feature.

I see new print() that is not protected with "if verbose:"; is it
debugging cruft added during development, or is it a useful addition
for end-users to see under --verbose mode?  I suspect it is the
latter.

Thanks.

> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 3494a1db3e..362b50eb21 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -374,14 +374,20 @@ These options can be used to modify 'git p4 submit' behavior.
>      been submitted. Implies --disable-rebase. Can also be set with
>      git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
>  
> -Hook for submit
> -~~~~~~~~~~~~~~~
> +Hooks for submit
> +----------------
> +
> +p4-pre-submit
> +~~~~~~~~~~~~~
> +
>  The `p4-pre-submit` hook is executed if it exists and is executable.
>  The hook takes no parameters and nothing from standard input. Exiting with
>  non-zero status from this script prevents `git-p4 submit` from launching.
> +It can be bypassed with the `--no-verify` command line option.
>  
>  One usage scenario is to run unit tests in the hook.
>  
> +
>  Rebase options
>  ~~~~~~~~~~~~~~
>  These options can be used to modify 'git p4 rebase' behavior.
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 50365f2914..8cf6b08b55 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -520,7 +520,10 @@ p4-pre-submit
>  
>  This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
>  from standard input. Exiting with non-zero status from this script prevent
> -`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
> +`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
> +command line option. Run `git-p4 submit --help` for details.
> +
> +
>  
>  post-index-change
>  ~~~~~~~~~~~~~~~~~
> diff --git a/git-p4.py b/git-p4.py
> index d4c39f112b..b377484464 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1583,13 +1583,17 @@ def __init__(self):
>                                       "work from a local git branch that is not master"),
>                  optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
>                                       help="Skip Perforce sync of p4/master after submit or shelve"),
> +                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
> +                                     help="Bypass p4-pre-submit"),
>          ]
>          self.description = """Submit changes from git to the perforce depot.\n
> -    The `p4-pre-submit` hook is executed if it exists and is executable.
> -    The hook takes no parameters and nothing from standard input. Exiting with
> -    non-zero status from this script prevents `git-p4 submit` from launching.
> +    The `p4-pre-submit` hook is executed if it exists and is executable. It
> +    can be bypassed with the `--no-verify` command line option. The hook takes
> +    no parameters and nothing from standard input. Exiting with a non-zero status
> +    from this script prevents `git-p4 submit` from launching.
>  
> -    One usage scenario is to run unit tests in the hook."""
> +    One usage scenario is to run unit tests in the hook.
> +    """
>  
>          self.usage += " [name of git branch to submit into perforce depot]"
>          self.origin = ""
> @@ -1607,6 +1611,7 @@ def __init__(self):
>          self.exportLabels = False
>          self.p4HasMoveCommand = p4_has_move_command()
>          self.branch = None
> +        self.no_verify = False
>  
>          if gitConfig('git-p4.largeFileSystem'):
>              die("Large file system not supported for git-p4 submit command. Please remove it from config.")
> @@ -1993,6 +1998,9 @@ def applyCommit(self, id):
>          applyPatchCmd = patchcmd + "--check --apply -"
>          patch_succeeded = True
>  
> +        if verbose:
> +            print("TryPatch: %s" % tryPatchCmd)
> +
>          if os.system(tryPatchCmd) != 0:
>              fixed_rcs_keywords = False
>              patch_succeeded = False
> @@ -2032,6 +2040,7 @@ def applyCommit(self, id):
>                  print("Retrying the patch with RCS keywords cleaned up")
>                  if os.system(tryPatchCmd) == 0:
>                      patch_succeeded = True
> +                    print("Patch succeesed this time")
>  
>          if not patch_succeeded:
>              for f in editedFiles:
> @@ -2400,13 +2409,12 @@ def run(self, args):
>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>                       (len(commits), num_shelves))
>  
> -        hooks_path = gitConfig("core.hooksPath")
> -        if len(hooks_path) <= 0:
> -            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> -
> -        hook_file = os.path.join(hooks_path, "p4-pre-submit")
> -        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> -            sys.exit(1)
> +        if not self.no_verify:
> +            if not run_git_hook("p4-pre-submit"):
> +                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
> +                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
> +                    "however,\nthis will also skip the p4-changelist hook as well.")
> +                sys.exit(1)
>  
>          #
>          # Apply the commits, one at a time.  On failure, ask if should
