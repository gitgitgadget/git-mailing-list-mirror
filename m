From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 18:49:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703131837280.18274@reaper.quantumfyre.co.uk>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRC3p-00078D-1i
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 19:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXCMStW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 14:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbXCMStW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 14:49:22 -0400
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:39077 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbXCMStV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 14:49:21 -0400
Received: (qmail 25241 invoked by uid 103); 13 Mar 2007 18:49:19 +0000
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2827. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.033896 secs); 13 Mar 2007 18:49:19 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 13 Mar 2007 18:49:18 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42143>

On Tue, 13 Mar 2007, Junio C Hamano wrote:

> * jc/fetch (Sun Mar 4 15:36:08 2007 -0800) 15 commits
> + .gitignore: add git-fetch--tool
> + builtin-fetch--tool: fix reflog notes.
> + git-fetch: retire update-local-ref which is not used anymore.
> + builtin-fetch--tool: make sure not to overstep ls-remote-result
>   buffer.
> + fetch--tool: fix uninitialized buffer when reading from stdin
> + builtin-fetch--tool: adjust to updated sha1_object_info().
> + git-fetch--tool takes flags before the subcommand.
> + Use stdin reflist passing in git-fetch.sh
> + Use stdin reflist passing in parse-remote
> + Allow fetch--tool to read from stdin
> + git-fetch: rewrite expand_ref_wildcard in C
> + git-fetch: rewrite another shell loop in C
> + git-fetch: move more code into C.
> + git-fetch--tool: start rewriting parts of git-fetch in C.
> + git-fetch: split fetch_main into fetch_dumb and fetch_native
>
> This is a partial C rewrite of heaviest part of git-fetch to
> help fetching between repositories with hundreds of refs.  I do
> not like the way it is split, but it may be a good idea to throw
> it in 'master' as it does not seem to regress anything and see
> if there are other interested people who want to finish the
> rewriting.

As it happens I was planning to start looking at writing a builtin fetch 
when I got home this evening ... the fetch--tool improvements have whetted 
my appetite for speed ... ;)

> * sb/fetch (Mon Mar 12 19:01:11 2007 -0700) 19 commits
> + git-fetch.sh:append_fetch_head() no longer has a remote_nick
>   argument
> + git-fetch: Split fetch and merge logic
>
> I have a soft spot to anything that claims to be a clean-up, but
> I suspect that the shell loop this series introduces may defeat
> the git-fetch--tool optimization.  Also I think having to base
> the patch on this made Paolo's "dot is special token to mean
> 'git pull' merges from a local branch" needlessly complex (but I
> haven't tried rewriting it myself without these two).  Although
> I merged these to 'next', I am considering to revert them.

I found that this series did introduce a regression, but not a serious 
one.  A null fetch went from ~30s to ~40s IIRC.  I moved 
canon_refs_list_for_fetch from git-parse-remote.sh to git-fetch--tool in 
response, and was pretty much able to get back to where I was before - I 
can send the patch if you want, I didn't think it that important.

-- 
Julian

  ---
The new Congressmen say they're going to turn the government around.  I
hope I don't get run over again.
