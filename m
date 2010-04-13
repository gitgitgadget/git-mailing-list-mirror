From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Update on SoC proposal: git-remote-svn
Date: Tue, 13 Apr 2010 10:59:56 +0530
Message-ID: <1271136573-sup-5613@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Apr 13 07:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1YjS-0000fr-UG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 07:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab0DMFcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 01:32:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52028 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0DMFcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 01:32:12 -0400
Received: by gyg13 with SMTP id 13so3300811gyg.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=CDboNivd97lTuPJRZnSKYjkTqUm9q9QTIwuE4Euf7QY=;
        b=wC3BbGGzeXFD5PtKK93+EnymAxiWTuiRwMZlHS4SYvejPXVJzMaThuSsjy+L+f5QdC
         MkSUSJgRZ3YkVo0QQQIvg2jRaDWVowmsZGyxzl+INq5bQ9+xvmReSUjjy68g6JPdPNyF
         g4JGiSvzb+hQihPicLNOozf4rl/vUnxsGBxEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=VhYZ9af8noeP+x5i5qoNboFQr+B7z90Iev9NpdIeOVrQx7mciAjAGT3ZYtj9unfNRk
         8EVqS2vETWW+lgtdwxRV3QjQwY5l834LazgxE203rjrjGCg26hOhSr91Tu6zekn49O0i
         YXeFB1fspXc9r5qp5Tc+aSCTvmPMx3kN9kOTk=
Received: by 10.101.204.37 with SMTP id g37mr8599285anq.28.1271136731641;
        Mon, 12 Apr 2010 22:32:11 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 39sm1287611yxd.42.2010.04.12.22.32.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 22:32:11 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144791>


Hi,

Sam Vilain commented on my SoC proposal using Google's SoC interface,
and requested me to CC my response to the mailing list. His original
comment is also quoted below.

----------------------->8----------------------<8-------------------
Hi Sam,

> Hi Ramkumar, I've looked at this proposal and seen that it differs a
> bit from the version on the list, and I can't see the relevant
> discussion, so I'll just throw my bit in here - though note this is a
> technical comment and not a critique of your proposal.

There's been a lot of discussion, some on the list, and some more off
the list.

> First, consider not using the SVN API at all while prototyping the
> import part of the chain.  Instead, parse the 'svnadmin dump' stream
> from a local mirror.  This will allow you to tackle the actual
> problems involved and importing the data effectively, without
> suffering from the brain-damage that is the SVN API.  After all, the
> SVN API should be returning you all of the same information that the
> dump stream does, so you can treat making it work using the remote
> access API (eg svn_ra_replay, which is faster for mirroring AIUI) as a
> separate task.  You will also more easily spot information which you
> should be extracting from the API, but aren't - it's definitely all in
> the dump format; it has to be.  I received similar advice to this
> before building a perforce importer and let's just say it was
> invaluable.

Yes. I've studied the SVN API, and I agree with you- it's quite
horrible. Instead of providing a API that's transparently
backward-compatible, they've provided different methods for different
versions. There are also several variations of certain methods, and
this is quite confusing.

`svnadmin dump` is exactly how I plan to start out- I've already
discussed this with my to-be mentor, Sverre Rabbelier and David
Michael-Barr, who's building a new SVN exporter in his own time.

> Second, consider making the mirror phase emit directly to a tracking
> branch via git-fast-export, that is not intended to be checked out.
> Instead, it contains trees which correspond to revisions in the
> mirrored SVN repository.  Directory and file properties can be saved
> in the tree using specially named dotfiles, and revision properties
> can be saved in the commit log.  Perhaps I misread your intentions
> with the "stripped down svnsync" part, but syncing to a local SVN
> repository seems to me like a waste of time; people can just do that
> themselves if they choose anyway.  An SVN repository can easily be 10
> times the size of the corresponding git store, and it just seems like
> double-handling of the data and will make the whole process slower and
> more cumbersome than it needs to be.

> With all the blobs already in the git store, and the information
> needed to perform the data mining operation which is the extraction of
> git-style branch histories from the svn data, you will be working with
> data which is all in git-land, and exporting referencing blobs which
> are already in the store.  This will save you a LOT of time, as it
> means in this stage you are not handling the actual file images; just
> constructing branch histories in the git-fast-import stream.  Your
> branch miner will potentially be able to process thousands of
> revisions per second this way, even from python.

Agreed. Sverre, David and I discussed exactly this- The final version
of mirror-client will dump all the SVN information to a Git store
first, so we can do the mapping painlessly in Git. There are some
concerns about information loss though, which we'll have to deal with
as we go on.

> Also bear in mind
> that people might use SVN in a way that violates the expectations of
> this branch miner.  An example is putting a README file in the
> top-level projects directory, a heuristic approach might consider that
> the start of a new project and then mess up later stages.  Another
> example is people accidentally deleting trunk and re-adding it; the
> nice thing about this two-stage approach is that it allows advanced
> users to muck with the "raw" data (ie, this whole repository tracking
> branch) using git to do things like graft away the bad revisions, and
> then the second stage will use the corrected data.  Of course
> eventually, this detail will be hidden by the remote helper.

Excellent suggestion! I'll attempt to build the plumbing for the
mapping in a manner that exposes a sane interface.

> As a general comment - you must be careful in trying to assume that
> what you are attempting is even possible.  Sure, you want 'git clone
> svn://example.com/myrepo' to work, but what does that mean?  A
> repository in SVN is a filesystem, which can contain multiple
> projects.  In git, a repo is a single project.  People might expect to
> be able to clone the trunk URL for instance.  My advice there is to
> not support that use case at all, it's a complete can of worms which
> you will discover as you tackle the conversion algorithms.  Just focus
> on making the case where the complete repository is mirrored work for
> this project.  Mining a single branch out of SVN without all data
> available is the domain of git-svn and really you don't want to go
> there.

Hm, this is something that I hadn't thought about earlier. Thanks for
the suggestion- I will not attempt to go into complicated cases,
atleast in my summer term.

> Anyway like I say, please follow-up on the mailing list, and this
> advice can receive wider scrutiny.

Thank you for your valuable comment!

-- Ram
