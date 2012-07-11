From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 11 Jul 2012 22:40:19 +0100
Message-ID: <20120711214019.GF30213@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
 <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
 <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:41:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp4eb-0008GC-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 23:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235Ab2GKVki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 17:40:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52421 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758138Ab2GKVkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 17:40:24 -0400
Received: by wgbdr13 with SMTP id dr13so1448075wgb.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 14:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=ZK9dSvv1C1t/zWFOszsfweEes7q0PiLjT8yQc2s1IUk=;
        b=Fs22Cg2k4wan+dEJKQrGiRxE7AKMGhH2ap92boYa6GVjn5+Er6AYzAj7wPEzn7iSam
         zu4LdeNx8UoPMcumuHB4blkj9Akx4uV2UsmIk1v1+NL1N7NQBst1IA/WSxlshNNYKrCv
         fJ0Vr5kEMBUQUlew3ScgPE4whXrEKGxNGj0mxlHOSSAMbJNkwyBGgwkTGgvyPlmp7ZGu
         UI2WNOaoQyH+8rnYcmSOdl51OgpcxFqFHAfK2I9wxO2kvFVUysoOq7MYMgvVScIfO1DN
         s+jBSs6aMKz45nFfRaMHZIOuaSqIMh0t5sHcC9AisK7kiNCqVFc4Mn9AgwbCesEIMgJF
         O1Ew==
Received: by 10.216.135.158 with SMTP id u30mr9415414wei.55.1342042822325;
        Wed, 11 Jul 2012 14:40:22 -0700 (PDT)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id k20sm8686161wiv.11.2012.07.11.14.40.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 14:40:20 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1Sp4dv-0008Or-QK; Wed, 11 Jul 2012 22:40:19 +0100
Content-Disposition: inline
In-Reply-To: <20120711012617.GA18369@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQnP6vdANOsOJ3N0PTw9TdzCdJnd7NCzZIMnQhM1paz1+qbicg8KwVW4aGzxNUOYv61abEDa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201331>

On Wed, Jul 11, 2012 at 01:26:17AM +0000, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Marcin Owsiany <marcin@owsiany.pl> writes:
> > 
> > >> This makes my idea to do the same to "my something else instead of
> > >> master" much less attractive. In fact I don't think such behaviour would
> > >> be useful.
> > >> 
> > >> I think with the suggested patch git-svn works as I would like it to:
> > >>  - creates "master" at initial checkout - consistent with git clone
> > >>  - using a different "tracking-like" branch is possible with "dcommit"
> > >>  - does not re-create "master" on fetch - so the annoying part is gone
> > >
> > > Any comments?
> > 
> > Not from me.  Even though I'd love to hear Eric's opinion, your "I
> > don't think such behaviour would be useful." gave me an impression
> > that you would justify the change in a different way (i.e. a rewrite
> > of proposed log message) or tweak the patch (i.e. a modified
> > behaviour), or perhaps both, in your re-roll, the ball was in your
> > court, and we were waiting for such a rerolled patch.
> 
> Sorry, I keep forgetting this topic.  But yes, I thought you would tweak
> your patch.

Oh, I guess I got used to projects where people pay no attention to
patch comments. How about this:

From: Marcin Owsiany <marcin@owsiany.pl>
Date: Sun, 24 Jun 2012 22:40:05 +0100
Subject: [PATCH] git-svn: don't create master if another head exists

git-svn insists on creating the "master" head (unless it exists) on every
"fetch". It is useful that it gets created initially, when no head exists
- users expect this git convention of having a "master" branch on initial
clone.

However creating it when there already is another head does not provide any
value - the ref is never updated, so it just gets stale after a while.  Also,
some users find it annoying that it gets recreated, especially when they would
like the git branch names to follow SVN repository branch names. More
background in http://thread.gmane.org/gmane.comp.version-control.git/115030

Make git-svn skip the "master" creation if HEAD points at a valid head. This
means "master" does get created on initial "clone" but does not get recreated
once a user deletes it.

Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..2379a71 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1612,9 +1612,9 @@ sub post_fetch_checkout {
 		}
 	}
 
-	my $valid_head = verify_ref('HEAD^0');
+	return if verify_ref('HEAD^0');
 	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
-	return if ($valid_head || !verify_ref('HEAD^0'));
+	return unless verify_ref('HEAD^0');
 
 	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
-- 
1.7.7.3


-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
