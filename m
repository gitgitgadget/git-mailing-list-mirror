Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD6A1FF7F
	for <e@80x24.org>; Sun, 11 Dec 2016 07:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbcLKHTd (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 02:19:33 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36679 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbcLKHTc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 02:19:32 -0500
Received: by mail-qk0-f169.google.com with SMTP id n21so56540505qka.3
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 23:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3D8DTdSaZ2Yklg52Hubglr/l+i2o09+yw5Fwj8A0Y/I=;
        b=Fza17XIfprT6MauYcZpCylF60XJerRziyduZUtMF6UjXaA25akdBZifi+G2UiHERFj
         Qta4QMTewkpS9NP1Jhz+NPJ83rJ+NHrzTXGxcO4KIaHCTqbEzGQAPspGGKFefWuIBpdg
         BtfCCSd60FQhyIuBSGVaZ3iRlWC6Z0eUsPAhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3D8DTdSaZ2Yklg52Hubglr/l+i2o09+yw5Fwj8A0Y/I=;
        b=PPf8XrHIEbmXPY0NKW40k1hU8LasTfCGZOWcg7GKFUuTzYhgJJ+y+w9He5XyMoa8qk
         hh7+IIxljNFZhplW8xeOzHntKbigSYroSvbjKWfBFbt9d3No/K97efvtipGBV5bZ24NK
         lQAqQ7zqSKnSibu+l7iw/MQ0QJWjin/aKjVF+ZLw4YJp4kPELkbFR/MZj+AxJSi4y9K2
         ayerBFOLi560kcDtWA2I3qnNPgfWUJLNFSUywnkWfv4WSHBhdaeUKtUGZFLHw+GDhZ+y
         qFO1shZ11IVM7B6JbnnCWC6046D35H0TPlugZVpXSr2xaMi+97+9Sjz4XE6GxiA49j3j
         mOvA==
X-Gm-Message-State: AKaTC00YTjjAEblU4jNjD6QaHpPCmom4uf4VTW8sYbgFQFnpYkCTfDZoJifc+cJfoDqNbAu/Cks3/+GnrR01WQ==
X-Received: by 10.55.176.131 with SMTP id z125mr70690377qke.286.1481440771406;
 Sat, 10 Dec 2016 23:19:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Sat, 10 Dec 2016 23:19:30 -0800 (PST)
In-Reply-To: <20161210215734.7468-2-luke@diamand.org>
References: <20161210215734.7468-1-luke@diamand.org> <20161210215734.7468-2-luke@diamand.org>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 11 Dec 2016 07:19:30 +0000
Message-ID: <CAE5ih7_6Ap_dY3mRb3Hk2yzDRMkZ3HnnQOaikF=ybx_XNdVWhQ@mail.gmail.com>
Subject: Re: [PATCHv2] git-p4: support git worktrees
To:     Git Users <git@vger.kernel.org>
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 December 2016 at 21:57, Luke Diamand <luke@diamand.org> wrote:
> git-p4 would attempt to find the git directory using
> its own specific code, which did not know about git
> worktrees. This caused git operations to fail needlessly.
>
> Rework it to use "git rev-parse --git-dir" instead, which
> knows about worktrees.

Actually this doesn't work as well as the original version. "git
rev-parse --git-dir" won't go and find the ".git" subdirectory. The
previous version would go looking for it, so this would introduce a
regression.

Luke


>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py               | 47 ++++++++++++++++++++++++++---------------------
>  t/t9800-git-p4-basic.sh | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+), 21 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..6aa8957 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -49,6 +49,13 @@ defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
>  # Grab changes in blocks of this many revisions, unless otherwise requested
>  defaultBlockSize = 512
>
> +def gitdir():
> +    d = read_pipe("git rev-parse --git-dir").strip()
> +    if not d or len(d) == 0:
> +        return None
> +    else:
> +        return d
> +
>  def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
>
> @@ -562,12 +569,6 @@ def currentGitBranch():
>      else:
>          return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
>
> -def isValidGitDir(path):
> -    if (os.path.exists(path + "/HEAD")
> -        and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
> -        return True;
> -    return False
> -
>  def parseRevision(ref):
>      return read_pipe("git rev-parse %s" % ref).strip()
>
> @@ -3462,7 +3463,7 @@ class P4Sync(Command, P4UserMap):
>          if self.tempBranches != []:
>              for branch in self.tempBranches:
>                  read_pipe("git update-ref -d %s" % branch)
> -            os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
> +            os.rmdir(os.path.join(gitdir(), self.tempBranchLocation))
>
>          # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
>          # a convenient shortcut refname "p4".
> @@ -3678,23 +3679,27 @@ def main():
>      (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
>      global verbose
>      verbose = cmd.verbose
> +
>      if cmd.needsGit:
> -        if cmd.gitdir == None:
> -            cmd.gitdir = os.path.abspath(".git")
> -            if not isValidGitDir(cmd.gitdir):
> -                cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
> -                if os.path.exists(cmd.gitdir):
> -                    cdup = read_pipe("git rev-parse --show-cdup").strip()
> -                    if len(cdup) > 0:
> -                        chdir(cdup);
> -
> -        if not isValidGitDir(cmd.gitdir):
> -            if isValidGitDir(cmd.gitdir + "/.git"):
> -                cmd.gitdir += "/.git"
> -            else:
> +        if cmd.gitdir:
> +            os.environ["GIT_DIR"] = cmd.gitdir
> +
> +            # did we get a valid git dir on the command line or via $GIT_DIR?
> +            if not gitdir():
>                  die("fatal: cannot locate git repository at %s" % cmd.gitdir)
>
> -        os.environ["GIT_DIR"] = cmd.gitdir
> +        else:
> +            # already in a git directory?
> +            if not gitdir():
> +                die("fatal: not in a valid git repository")
> +
> +        cdup = read_pipe("git rev-parse --show-cdup").strip()
> +        if len(cdup) > 0:
> +            chdir(cdup);
> +
> +        # ensure subshells spawned in the p4 repo directory
> +        # get the correct GIT_DIR
> +        os.environ["GIT_DIR"] = os.path.abspath(gitdir())
>
>      if not cmd.run(args):
>          parser.print_help()
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 0730f18..093e9bd 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -257,6 +257,26 @@ test_expect_success 'submit from detached head' '
>         )
>  '
>
> +test_expect_success 'submit from worktree' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --dest="$git" //depot &&
> +       (
> +               cd "$git" &&
> +               git worktree add ../worktree-test
> +       ) &&
> +       (
> +               cd "$git/../worktree-test" &&
> +               test_commit "worktree-commit" &&
> +               git config git-p4.skipSubmitEdit true &&
> +               git p4 submit
> +       ) &&
> +       (
> +               cd "$cli" &&
> +               p4 sync &&
> +               test_path_is_file worktree-commit.t
> +       )
> +'
> +
>  test_expect_success 'kill p4d' '
>         kill_p4d
>  '
> --
> 2.8.2.703.g78b384c.dirty
>
