From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: new plan for cleaning up the worktree mess, was Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 28 Oct 2008 20:52:25 +0700
Message-ID: <fcaeb9bf0810280652x7f883e35h157f94144263c5fa@mail.gmail.com>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
	 <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
	 <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081021174303.GA25827@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0810211955250.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 28 14:54:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kup0w-0001Kk-O8
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 14:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYJ1Nw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 09:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYJ1Nw2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 09:52:28 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:20705 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYJ1Nw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 09:52:27 -0400
Received: by ik-out-1112.google.com with SMTP id c29so776544ika.5
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uufwngnFhMJKkD5cUYmzKunM8HvmW79cEq3XWUFP1tM=;
        b=nongfySa5IJrsxmV22beK4a4yhVFWuXUd+kaf2XDf5omlI8uEyFrfGE+yuzkZn+zMG
         iPlQGtiw27EzeLOuBAKzkYW7doz/a95hqr2l8GwbPxokKDXG7ZWt3eTWITvM67iRdaLF
         gGi91TI8L5WzzOq5gxMOdLKHTq+Bd7v0ssLMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=StMAOAc4r7Lgu5zGpF47V+jOkhDLFhx2uaHHBcKfrniPgQ2slT/8HwVoBpr57Bsb+G
         G7M4mpJW4mz3e/UcEd7vQBMIkDsNzdKL51ZbrdOYhT9bccMCdu7Q1haFv4qOeoVyZQop
         OyHnkEi2wQWQD94ARo55HEca6jBA/pk8+8ulw=
Received: by 10.86.72.15 with SMTP id u15mr4509797fga.45.1225201945367;
        Tue, 28 Oct 2008 06:52:25 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Tue, 28 Oct 2008 06:52:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810211955250.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99290>

On 10/22/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Tue, 21 Oct 2008, Jeff King wrote:
>
>  > On Tue, Oct 21, 2008 at 07:02:48PM +0200, Johannes Schindelin wrote:
>  >
>  > > So I propose this change in semantics:
>  > >
>  > > - setup_git_directory_gently(): rename to discover_git_directory(),
>  > >   and avoid any chdir() at all.
>  > > - setup_git_directory(): keep the semantics that it chdir()s to the
>  > >   worktree, or to the git directory for bare repositories.
>  > >
>  > > Using _gently() even for RUN_SETUP builtins should solve the long
>  > > standing pager problem, too.
>  >
>  > I'm not sure there aren't hidden problems lurking in that strategy
>  > (every time I look at this area of code, something unexpected prevents
>  > what I think should Just Work from Just Working), but I think that is a
>  > promising direction to go for clearing up some of the long-standing
>  > issues.
>
>  Same here.  I grew a pretty strong opinion about the whole worktree thing,
>  but maybe that is only because it was done trying to change as little as
>  possible.

I played a bit with code, extracted discover_git_directory() from
setup_git_directory_gently() then made the latter a wrapper of the
former with chdir(). Some more for thoughts from the experiment.

1. Because discover_git_directory() does not do chdir() until later in
setup_git_directory_gently(), setting GIT_DIR to a relative path seems
unsafe (or worse unset at all, in case .git is found in parent
directories). But making GIT_DIR absolute path breaks tests because
some of them expect "git rev-parse --git-dir" to return a relative
path. The approach used in 044bbbc (Make git_dir a path relative to
work_tree in setup_work_tree()) can be reused to performance loss, but
that won't solve the issue.

2. 044bbbc also brings up another issue: code duplication between
setup_git_directory_gently() and setup_work_tree(). The new
setup*gently() can be roughly like this if setup_work_tree() can
calculate prefix too:

const char *setup_git_directory_gently(int *nongit_ok)
{
        int nonworktree_ok;
        /*
         * Let's assume that we are in a git repository.
         * If it turns out later that we are somewhere else, the value will be
         * updated accordingly.
         */
        if (nongit_ok)
                *nongit_ok = 0;

        if (!discover_git_directory()) {
                if (nongit_ok) {
                        *nongit_ok = 1;
                        return NULL;
                }
                die("Not a git repository");
        }

        return setup_work_tree_gently(&nonworktree_ok); // gentle version
}

So I propose to make setup_work_tree() return a prefix, relative to
current cwd. The setup procedure then would become:

if (discover_git_directory())
    die("Git repository needed");
prefix = setup_work_tree(); // die() inside if cannot setup worktree

3. Dealing with cwd outside worktree. If cwd is inside a worktree,
prefix will be calculated correctly. If it is outside, the current
behavior (with both GIT_DIR and GIT_WORK_TREE set) is leave prefix as
NULL. I think that is not right. With a wrong prefix, git commands
will not be able to access on-disk files. I would propose either:
  - die() if cwd is outside worktree
  - setup*gently() discovers the situation and gives up, then lets git
commands handle themselves. Some commands, like git-archive, don't
care about on-disk files at all, they could just simply ignore the
prefix and keep going. Others may die() or handle it properly.

Again, this breaks things.
-- 
Duy
