X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Dec 2006 22:37:09 +0000
Message-ID: <200612132237.10051.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:40:14 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=mzw81sZ/qzMze4sl5gRCKTyRPPkgatfORa4Fkh+/ua/9REaes4YLorUWMxorOKK51EfHRVEu/ZOQJeHyrGEdnXhZwKoFLDl0S15YanQxOC3jetjQ/le/08uo/rzS2IDyvcTcmpyThKospPUeFWcRytGVwN5vfrldifGVtSlLuAw=
User-Agent: KMail/1.9.5
In-Reply-To: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34244>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guclm-0002pE-Mc for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751661AbWLMWjy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWLMWjy
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:39:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43376 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751655AbWLMWjx (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:39:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so312367uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:39:51 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr226881ugl.1166049591299; Wed, 13
 Dec 2006 14:39:51 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id s7sm1553283uge.2006.12.13.14.39.50; Wed, 13 Dec
 2006 14:39:50 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, December 13 21:35, Junio C Hamano wrote:
> I am hoping that we can start a stabilization cycle for v1.5.0
> based on what we have in 'master'.  The theme is "usability and
> teachability".

This is what I have in my "niggles" list.  These are surface level things that 
I think are easy to fix.  A large part of the scariness is (I think) git's 
unfriendly output.  Too many messages require understanding of git internals.  

The major barrier to implementing these sorts of changes is, I think, worries 
about users of the output of these commands in scripts.  I say: screw them, 
porcelain is there for the breaking :-)

 * git-fetch has to be in working root.  If I can do git-push from anywhere in 
   my tree, why can't I do git-fetch?
 * git-reset has to be in working root.  If you typically sit in, say "src/", 
   it's annoying to have to change directory to do a reset.
 * git-commit doesn't (generally) have output - after a commit, it's difficult
   to know if anything happened.  Get users used to the idea of hashes to 
   identify commits by telling them which one they just made.  Tell them if 
   they made a branch as well, which branch they are now on.
 * git-init-db says "defaulting to local storage area", as if that is
   meant to be a helpful message
 * git-revert should be called git-invert.  It doesn't remove a change
   from history, it simply applies another commit that does the
   opposite of whatever commit you are "revert"ing.  That's an inversion.
 * git-merge output is horrible - this affects git-pull, git-rebase,
   and git-cherry-pick.  Issuing "fatal" errors and then carrying on is very
   confusing.  Errors in merges appear multiple times.  The files upon which
   which there is a conflict are spread throughout the output.  Most of the
   output is not relevant to an average user.
 * git-apply output is horrible.  It says a few things about whitespace on 
   stdin then just finishes.  When it succeeds.   When it fails, it just says
   failed, it doesn't say why a particular hunk failed.
 * git-branch is not verbose enough when creating a new branch, for a new user
   a little reassurance that what they meant to happen has happened would be 
   nice.
 * git-commit without "-a" and without an "update-index" says "nothing
   to commit", which isn't an adequate message to help a user who hasn't
   realised they need to update the index
 * git-rebase --skip requires that the offending file be clean with
     git-checkout HEAD file
   before the skip will work.  Why?  The fact of the skip is enough
   knowledge for rebase to know that I don't care if the merge is lost
 * git-rebase/git-cherry-pick/git-reset/etc should all tell the user that they 
   need to run git-prune to tidy up after themselves.
 * git-add has no output, whether it works or not
 * git-cat-file is badly named.  git-cat-object would be slightly
   better.
 * git-fetch output is confusing:
    remote: Generating pack...
    remote: Done counting 189146 objects.
    remote: Result has 186566 objects.
    remote: Deltifying 186566 objects.
    remote:  100% (186566/186566) done
    Unpacking 186566 objects
    24% (44792/186566) done
   Some questions from the point of view of a newbie: what is a pack?  what is 
   an object? Why is the remote counting them?  Which remote am I reading 
   from?  What am I fetching?  What is "Deltifying"?  How much data do I have 
   to download (number of objects doesn't tell me).  How long has this taken?  
   How long is left to go?
 * Similar things can be said about git-clone
 * Similar things can be said about git-push
 * git-show-branch output is cryptic.
 * In general the principle for messages should be the same as for 
   presentations:
    - say what you're going to do
    - do it
    - say what you did
   So for example, "git-branch newbranch existingbranch" would say
    Branching at "existingbranch", hash XXXXXXXXXXXXXXXXXX
     - created branch "newbranch"
     - your working branch is "existingbranch"
   Rather than the nothing that it currently outputs.
 * It would be really nice to be able to do an arbitrary checkout, rather than
   having to make a branch for it.  Then I could do
    git-checkout remotes/origin/master && make
   (obviously committing with a non-branch HEAD would be prevented)
 * git-verify-tag would be nicer as a switch to git-tag


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
