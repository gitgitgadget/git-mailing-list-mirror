From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 03:07:32 -0700
Message-ID: <20090902100730.GA18226@gmail.com>
References: <20090901145213.GB4194@debian.b2j> <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org> <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org> <20090902011513.GA3874@coredump.intra.peff.net> <7vmy5egefh.fsf@alter.siamese.dyndns.org> <20090902051248.GB12046@coredump.intra.peff.net> <7vljkxdiil.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 12:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mimkk-00006N-Cz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 12:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZIBKHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 06:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZIBKHa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 06:07:30 -0400
Received: from mail-yw0-f188.google.com ([209.85.211.188]:64229 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZIBKH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 06:07:29 -0400
Received: by ywh26 with SMTP id 26so1075030ywh.5
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RRmf8l5CdM6UmVK9lJVgzEBXuD6GzQFI9P3LmKlD/AI=;
        b=ioLZA4M35kunB9K/wgo2oMELw7H2STgmG2fmeUyH8bryf2O8JnHCJO5m7/6ri8JHMC
         NwTH2JcunnzLZx5MPzl+sGurb61BMXz5MhXlEnrQaYhkNTCajhEE8u5o1GHSa9LvbBYf
         IA3Ue73AskRcb5mrkLDBzkRASITwYoI3oXfm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AhMHjfqxaxe0iafkEt6lmWp1NK+BMaPB+kJ6GZKT7PUVm+cP+LiswPMwkfyzhC/ov5
         rVlUUw9TS7jPon6Kyb41x1Ezx14DRDh5x1R6V8gWn5B2a9/3s3MCqX4r+LGptPSxa94z
         gtPP1PBhKh/CcckF1r3Kt9jysn5vlhySVPdhg=
Received: by 10.90.158.2 with SMTP id g2mr5956354age.92.1251886051509;
        Wed, 02 Sep 2009 03:07:31 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 10sm1581725agb.10.2009.09.02.03.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 03:07:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vljkxdiil.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127602>

On Tue, Sep 01, 2009 at 10:26:26PM -0700, Junio C Hamano wrote:
> 
> Here is how I would justify the change (the patch is the same as Hannes's
> first version.
> 
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 1 Sep 2009 22:13:53 +0200
> Subject: [PATCH] status: list unmerged files much later
> 
> When resolving a conflicted merge, two lists in the status output need
> more attention from the user than other parts.
> 
>  - the list of updated paths is useful to review the amount of changes the
>    merge brings in (the user cannot do much about them other than
>    reviewing, though); and
> 
>  - the list of unmerged paths needs the most attention from the user; the
>    user needs to resolve them in order to proceed.
> 
> Since the output of git status does not by default go through the pager,
> the early parts of the output can scroll away at the top. It is better to
> put the more important information near the bottom.  During a merge, local
> changes that are not in the index are minimum, and you should keep the
> untracked list small in any case, so moving the unmerged list from the top
> of the output to immediately after the list of updated paths would give us
> the optimum layout..

I agree with all of this but would also add that we can have
our cake and eat it too with respect to wanting to "keep
similar things together" and having "unmerged near bottom".

No one has suggested this, so I figured I would.
What do you think about this layout?

- untracked
- staged
- modified
- unmerged

This isn't the first thing someone would think of, but here's
why it is intuitive:

- untracked entries come first because in the git world they
  are weird.  We don't like to see these things and we tend to
  .gitignore them away.

- staged entries come next, though we know that in practice
  staged is often shown first since we tend to not care about
  untracked files.  This often contains entries when merging
  but we do not often do much with these besides review them.

- modified entries come next because they need our attention.
  When merging this list is often small or non-existant,
  thus unmerged often follows immediately after staged.

- unmerged comes last for all of the reasons listed above.
  We give these special treatment because they often
  require even more attention than modified files.

What do you guys think?


While I've got you guys.. I have a patch for the new 1.7
status that makes it:

	git status [<tree-ish>] [--] [pathspec]
	(it adds support for tree-ish)


I added that because I thought that the porcelain-ish short
status output could be useful for "what does commit --amend
do" from a script-writers' pov, and thus adding <tree-ish>
enables git status -s HEAD^.

Is this a good idea?  I'll send the patch if others are
interested.  It seemed useful to me; my rationale was that
right now git-status is hardcoded to HEAD and thus exposing
that variable seemed useful.

BTW is status -s intended to be something plumbing-like;
something we can build upon and expect to be stable?
I'm just curious because other commands have a --porcelain
option and I wasn't sure if this was the intent.


Thanks,

-- 

	David
