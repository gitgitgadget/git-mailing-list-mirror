From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Tue, 15 Jul 2008 01:41:38 +0200
Message-ID: <200807150141.39186.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXgt-0000rW-8K
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611AbYGNXls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbYGNXls
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:41:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:56104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611AbYGNXlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:41:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2185835fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=/whYfgwjX7G3Qu1ZoMblcmkFW4uDrHNIrAaVWzAcPVQ=;
        b=SxO6wmUYgZymUfwUoA1C1gIX0t5uOxi8UiyeO5kxIjP4Z+IpN6XSZn/I6y6KfKDISp
         mrmwfEYqSE6R0Sluf4nnv6U7DuPH5WVvOJ9LewEVbSshnvMYhJCdGt4saPu0B/y/wubZ
         m7XJIzHubC7hPmU3osp9FxHdd3Nho3gkxHFfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=Obo6LWnuhwc+NEeaE+Jni4SThFcS3mVkSNDQDZHlPh0bt0wY+vcd/dlaS2/bZMbPmT
         bBwSjwR7y9YGaidzl1WUbOvkim6YZdoNU2EX/tX66LhY8WC7iP3cH2QlqZ0GX4EfejXF
         VJKyZHvGnd1dCNQ6KTwgsBQgSsztOfUMNSoqw=
Received: by 10.86.26.11 with SMTP id 11mr1598432fgz.35.1216078905575;
        Mon, 14 Jul 2008 16:41:45 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.43])
        by mx.google.com with ESMTPS id d6sm3242138fga.2.2008.07.14.16.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:41:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080714014051.GK10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88482>

On Mon, 14 July 2008, Petr Baudis wrote:
> On Fri, Jul 11, 2008 at 03:11:05AM +0200, Lea Wiemann wrote:
> >
> > This also adds the Git::Commit and Git::Tag classes, which are used by
> > Git::Repo, the Git::Object base class, and the Git::RepoRoot helper
> > factory class.
> 
> I really miss some more detailed writeup on the envisioned design here.
> And if we are redoing the API in a better way, we better should have
> some vision.

Once again: if you are adding some large amount of code, you'd better
describe "whys" of it.

> Most importantly, how is Git::Repo interacting with working copies, and
> how is it going to interact with them as the new OO model shapes up?
> You mention briefly Git::WC later, but it is not really clear how the
> interaction should work.
> 
> 
> First, I don't think it's good idea at all to put the pipe-related stuff
> to Git::Repo - this is botched up API just like the current one. This
> all is independent from any repository instances, in fact it's perfectly
> valid to call standalone remote commands (like ls-remote or, actually,
> clone).

There are three classes of git commands: 

 1. standalone i.e. those that doesn't require even repository, like
    e.g. git-ls-remote, git-clone or git-init (or git wrapper, like
    for example in "git --version").
 2. those that require repository (and should use --git-dir=<path>),
    like for example git-cat-file, git-log / git-rev-list,
    git-for-each-ref / git-show-refs, git-diff-tree, git-ls-tree;
 3. those that require both repository and working copy (and should
    probably use both --git-dir=<path> and --work-tree=<path>), like
    git-commit, git-clean, git-ls-files (the last one can require
    only index).
 3'. those that require both repository and working copy, and whose
    behavior depends on where in working copy we (current directory)
    is[*1*].

*All* git commands should know path to "git" wrapper binary, or where
$GIT_EXEC_PATH is.


[*1*] It is (besides pointer to Git::Repo instance) what Git::WC
differs from simple directory: the pointer where we are, and
wc_path(), wc_subdir(), [wc_cdup(),] and wc_chdir(<SUBDIR>) methods.

> Here is an idea: Introduce Git::Command object that will have very
> general interface and look like
> 
> 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
> 		'-p', 'bla'], {pipe_out=>1})
> 	...
> 	$c->close();

Errr... how do you read from such a pipe?  <$c> I think wouldn't work,
unless you would use some trickery...
 
> and a Git::CommandFactory with a nicer interface that would look like
> 
> 	my $cf = Git::CommandFactory->new('git', '--git-dir=.');
> 	my $c = $cf->output_pipe('cat-file', '-p', 'bla');
> 	$c->close();
> 
> Then, Git::Repo would have a single Git::CommandFactory instance
> pre-initialized with the required calling convention, and returned by
> e.g. cmd() method. Then, from the user POV, you would just:
> 
> 	my $repo = Git::Repo->new;
> 	$repo->cmd->output_pipe('cat-file', '-p', 'bla');
> 
> Or am I overdoing it?

You are probably overdoing it.


I think it would be good to have the following interface

Git->output_pipe('ls-remotes', $URL, '--heads');
[...]
$r = Git::Repo->new(<git_dir>);
$r->output_pipe('ls_tree', 'HEAD');
[...]
$nb = Git::Repo::NonBare->new(<git_dir>[, <working_area>]);
$nb->output_pipe('ls-files');


How can it be done with minimal effort, unfortunately I don't know...

> Git::Repo considers only bare repositories. Now, since "working copy" by
> itself has nothing to do with Git and is just an ordinary directory
> tree,

Well, it does provide also current subdir pointer, pointer to git
repository it is associated with, and a few methods to examine and
change both.

> I think Git::WC does not make that much sense, but something like 
> Git::Repo::Nonbare certainly would. This would be a Git::Repo subclass
> with:
> 
> 	* Different constructor
> 
> 	* Different Git::CommandFactory instance
> 
> 	* Git::Index object aside the existing ones (like Git::Config,
> 	  Git::RefTree, ...)
> 
> 	* Some kind of wc_root() method to help directory navigation
> 
> And that pretty much covers it?

Good idea, I think.


> Another thing is clearly describing how error handling is going to work.
> I have not much against ditching Error.pm, but just saying "die + eval"
> does not cut it - how about possible sideband data? E.g. the failure
> mode of Git.pm's command() method includes passing the error'd command
> output in the exception object. How are we going to handle it? Now, it
> might be actually okay to say that we _aren't_ going to handle this if
> it is deemed unuseful, but that needs to be determined too. I don't know
> off the top of my head.

I think that the solution might be some output_pipe option on how to
treat command exit status, command STDERR, and errors when invoking
command (for example command not found).

Mentioned http://http://www.perl.com/pub/a/2002/11/14/exception.html
explains why one might want to use Error.pm.


> > ---
> >
> > Please note before starting a reply to this: This is not an argument;
> > I'm just explaining why I implemented it the way I did.  So please
> > don't try to argue with me about what I should or should have done.
> > I'm not going to refactor Git::Repo to use Git.pm or vice versa; it's
> > really a much more non-trivial task than you might think at first
> > glance.
[...]
 
> I agree that your main objective is caching for gitweb, but that's not
> what everything revolves around for the rest of us. If you chose the way
> of caching within the Git API and introducing the API to gitweb, I think
> you should spend the effort to deal with the API properly now.

I think the idea is that gitweb caching as it is implemented (data
caching) requires some kind of Perl API, and that existing Git.pm
didn't cut -- therefore Git::Repo and friends was created.  But the
focus is gitweb caching, not Perl API (besides Perl API having to
be usable).

-- 
Jakub Narebski
Poland
