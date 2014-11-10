From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add a few more values for
 receive.denyCurrentBranch
Date: Mon, 10 Nov 2014 13:54:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411101305510.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de> <xmqqvbmqg81g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 13:54:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnoUU-0008QF-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 13:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbaKJMyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 07:54:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:62169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbaKJMyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 07:54:37 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0LuKHz-1XyQnM0urn-011iAV;
 Mon, 10 Nov 2014 13:54:35 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqvbmqg81g.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:yBH4GS90q0z9PWlkE4ESrlcManyuTLyMR8vsy4ySjgqwSx7yAv3
 foz3Q9k67bsM6QHbRX94OKs5SX8Huk4JeP4WBNZHw2zFOP5dUcImrGPKhl7JQYxzIJ2JOmx
 vy5r6UrAYclJQPSEoSSlNwo+FyckLUZaARf9DcC/ZkVNLLmuMB8QEI7zmRpmsXm+r2aQDLn
 Bx/Qj13kQUJyAvEovEHEg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 7 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Under certain circumstances, it makes a *lot* of sense to allow pushing
> > into the current branch. For example, when two machines with different
> > Operating Systems are required for testing, it makes much more sense to
> > synchronize between working directories than having to go via a third
> > server.
> 
> Even if you do not have a third server, each time you decide to do
> such a push, you have a single source of truth, i.e. the repository
> you are pushing from, so instead of doing that push, all the others
> could instead pull from that single source of truth.  In that sense,
> even though I wouldn't say it is wrong to use "push" in the opposite
> direction for this synchronization, I have to say that the above is
> not a very strong argument.  It certainly does not deserve "*lot*"
> in bold font ;-)

I am sorry, I should have been more explicit about the fact that other
"Operating System" includes also Windows, where it is a major hassle to
set up an ssh daemon, hence the asymmetry of ease to connect from one to
another machine. I really thought that was obvious, my apologies. My next
patch iteration will have the Windows scenario as motivation.

Note that I did not even dive into the problem of many loaner laptops
where you are not allowed to set up an ssh daemon, or even know the
user's password. I did not mention those problems because I again assumed
(again, apologies) that this was obvious because it occurred to me
automatically when thinking about the multi-laptop problem.

And I must apologize yet again, for I also failed to specify explicitly
another reason why pushing makes a *lot* more sense than pulling: at least
for me, personally, having to switch keyboards just to synchronize Git
checkouts from one to another computer *is* a hassle.

> > Under different circumstances, the working directory needs to be left
> > untouched, for example when a bunch of VMs need to be shut down to save
> > RAM and one needs to push everything out into the host's non-bare
> > repositories quickly.
> 
> For this use case, if you assume that the tips of branches in the
> repositories on "a bunch of VMs" could be pointing at different
> commits (i.e. each of them has acquired more work without
> coordination), you are risking lossage by pushing into refs/heads/,
> not refs/remotes/vm$n/, aren't you?  When you want to save things
> away "quickly", you do not want to be worried about a push from VM1
> stomping on what was stored from VM0, and using separate remotes,
> i.e. refs/remotes/vm$n/, has been the recommended way to do so.  So
> this is not a very strong argument, either.

I thank you for your assessment of my personal working style.

:-)

And yet again I have to apologize because I find that relying on Git's
fast-forward default (you need to force non-fast-forward ref updates,
which I don't, at least not by default) saves me from that lossage, and
will therefore not change my personal working style that served me so well
for years.

> I do not think of a good justification of detachInstead offhand, but
> you must have thought things through a lot more than I did, so you
> can come up with a work flow description that is more usable by mere
> mortals to justify that mode.

The main justification is that it is safer than updateInstead because it
is guaranteed not to modify the working directory. I intended it for use
by developers who are uncomfortable with updating the working directory
through a push, and as uncomfortable with forgetting about temporary
branches pushed, say, via "git push other-computer HEAD:refs/heads/tmp".

However, I have to admit that I never used this myself after the first few
weeks of playing with this patch series.

> Without such a description to justify why detachInstead makes sense, for
> example, I cannot even answer this simple question:
> 
>     Would it make sense to have a third mode, "check out if the
>     working tree is clean, detach otherwise"?

I imagine that some developer might find that useful. If you insist, I
will implement it, even if I personally deem this mode way too complicated
a concept for myself to be used safely.

> > [... snip a lot of text that made me almost miss the comments below ...]
> >
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 32fc540..be4172f 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -26,7 +26,9 @@ enum deny_action {
> >  	DENY_UNCONFIGURED,
> >  	DENY_IGNORE,
> >  	DENY_WARN,
> > -	DENY_REFUSE
> > +	DENY_REFUSE,
> > +	DENY_UPDATE_INSTEAD,
> > +	DENY_DETACH_INSTEAD,
> 
> Don't add trailing comma after the last element of enum.

Will fix in the next iteration.

> > @@ -730,6 +737,44 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
> >  	return 0;
> >  }
> >  
> > +static void merge_worktree(unsigned char *sha1)
> > +{
> > +	const char *update_refresh[] = {
> > +		"update-index", "--refresh", NULL
> > +	};
> > +	const char *read_tree[] = {
> > +		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> > +	};
> > +	struct child_process child;
> > +	struct strbuf git_env = STRBUF_INIT;
> > +	const char *env[2];
> > +
> > +	if (is_bare_repository())
> > +		die ("denyCurrentBranch = updateInstead needs a worktree");
> 
> Why have extra SP only after "die" but not other function names?

Will remove the space in the next iteration.

> > +	strbuf_addf(&git_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> > +	env[0] = git_env.buf;
> > +	env[1] = NULL;
> 
> Doesn't child.env have managed argv_array these days?

I missed those developments, likewise the introduction of
CHILD_PROCESS_INIT. Fixed in the next iteration.

> > +	memset(&child, 0, sizeof(child));
> > +	child.argv = update_refresh;
> > +	child.env = env;
> > +	child.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
> > +	child.stdout_to_stderr = 1;
> > +	child.git_cmd = 1;
> > +	if (run_command(&child))
> > +		die ("Could not refresh the index");
> > +
> > +	child.argv = read_tree;
> > +	child.no_stdin = 1;
> > +	child.no_stdout = 1;
> > +	child.stdout_to_stderr = 0;
> > +	if (run_command(&child))
> > +		die ("Could not merge working tree with new HEAD.  Good luck.");
> 
> Drop "Good luck." and replace it with a more useful info.  At least,
> tell the user what state you left her repository in by this botched
> attempt, so that she can manually recover.

The best information Git can give at that point is that the working tree
could not be merged with the new HEAD. I stripped "Good luck." in the next
iteration, although I mourn the loss of comedy in Git.

Ciao,
Johannes
