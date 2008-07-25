From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Fri, 25 Jul 2008 19:18:57 +0930
Message-ID: <93c3eada0807250248l60c81090sd1953df24cca1421@mail.gmail.com>
References: <20080724031441.GA26072@laptop>
	 <alpine.DEB.1.00.0807241324040.8986@racer>
	 <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>
	 <alpine.DEB.1.00.0807241506340.8986@racer>
	 <fcaeb9bf0807241137h65292d7egad8cc5f797114607@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 11:50:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMJw2-0004i3-MA
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 11:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbYGYJs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYGYJs7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 05:48:59 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:53249 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYGYJs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 05:48:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so704609and.103
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=w2Mr+8ScHk6u0TPZxqLXhME/yKSs22Chpn20uZpqzT0=;
        b=EYxewu3IemHgc23PNbqFk1ucS+ufgSQ++06S7Rc2a8rw34ErI98WznylJjabuBo85+
         CYRwCbbamYC6pTcnnJmy5EG2USoLgply4c/9G+qPbPSWD+5DtHfdemdWgOWtxEF0vumf
         LXcR+6vY/HpMa1Iy8ngsWsYYnIbfdIZ27LwxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=UhtcycUbpRofrMe0dlwQS7M0MdEdxCcwfmLvwJswDLaFhfUwK60X1VskWWecCwaEHu
         NLod5LNOylj/mfgnxAVC9+4F7JFQhgUAcWs3h3NavkZVkJc968+wkuMXThvDZ01FxLJi
         /tpcSFCCscvgAVzGnYAFF7k0J61gWgmV1kSvk=
Received: by 10.100.190.15 with SMTP id n15mr2508355anf.113.1216979337470;
        Fri, 25 Jul 2008 02:48:57 -0700 (PDT)
Received: by 10.100.8.15 with HTTP; Fri, 25 Jul 2008 02:48:57 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807241137h65292d7egad8cc5f797114607@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90020>

Hi,

On 7/25/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > Hi,
>  >
>  >  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>  >
>  >  > On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  >  >
>  >
>  > > >  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>  >  > >
>  >  > >  > When GIT_DIR is not set, cwd is used to determine where .git is. If
>  >  > >  > core.worktree is set, setup_git_directory() needs to jump back to
>  >  > >  > the original cwd in order to calculate worktree, this leads to
>  >  > >  > incorrect .git location later in setup_work_tree().
>  >  > >
>  >  > > I do not understand.  core.worktree is either absolute, in which case
>  >  > > there is no problem.  Or it is relative to where the config lives, no?
>  >  >
>  >  > The problem is GIT_DIR is not absolute in this case. So cwd must stay
>  >  > where git dir is until it is absolute-ized by setup_work_tree().
>  >
>  >
>  > I do not see GIT_DIR being set in your test case at all.
>  >
>  >  I do not see how get_git_work_tree() ro get_relative_cwd() should ever be
>  >  allowed to chdir().
>  >
>  >  _If_ they were (which I strongly doubt), they should chdir() back
>  >  themselves.
>  >
>  >  I now wasted easily 30 minutes just trying to make sense of your patch and
>  >  your response.  And I am still puzzled.
>  >
>  >  Your commit message was of no help.
>
>
> Alright, let's look at the code.
>
>   1. cwd is moved to toplevel working directory by setup_git_directory_gently()
>   2. setup_git_env() by default will set git_dir variable as ".git" as
>  part of check_repository_format_gently()
>   3. now in setup_git_directory() finds out core.worktree, it chdir()
>  to get relative prefix
>   4. setup_work_tree() sees that git_dir is not absolute path, it makes
>  git_dir absolute
>
>  If in step 3, it does not chdir(), step 4 will be right. In this case,
>  step 3 does chdir() and not going back, access to git repository will
>  fail as Geoff Russell discovered.
>  --
>
> Duy
>


There seem to be plenty of things happening here which I know nothing
about, which
is really why I hit the problem in the first place. I was pretty
surprised to find that
my command line switch (--work-tree) was being stored in the config file, which
ended up causing the problem.  Duy thinks he can fix this, which is
fine, but as a matter of principle, I'm not keen on command line switches
being magically saved for me when I didn't ask for this to happen.
The reason for
using a command line switch is because I want to override default
behaviour on this execution, if I wanted to change the default behaviour, then
I'd set values in the config file.

Whatever you decide, I reckon its pretty magical to have a software
problem, send
an email to a list and get the solution in 45 minutes.  I've never got that
service from any other piece of software (or hardware)!

Cheers,
Geoff Russell
