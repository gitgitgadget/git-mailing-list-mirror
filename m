X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Dec 2006 18:35:34 +0100
Message-ID: <20061217173534.GA16838@nan92-1-81-57-214-146.fbx.proxad.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <em1vgj$bc3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 18:36:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 3475 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 13:36:15 EST
Content-Disposition: inline
In-Reply-To: <em1vgj$bc3$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34698>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw0rz-00041Y-UX for gcvg-git@gmane.org; Sun, 17 Dec
 2006 19:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932358AbWLQSgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 13:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWLQSgQ
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 13:36:16 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:37968 "EHLO
 postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932358AbWLQSgQ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 13:36:16 -0500
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27]) by
 postfix1-g20.free.fr (Postfix) with ESMTP id EAACC5B6E18 for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 18:36:42 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id ABE519B5D9;
 Sun, 17 Dec 2006 18:35:38 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id B7D371F092;
 Sun, 17 Dec 2006 18:35:34 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Dec 17, 2006 at 12:29:25AM +0100, Jakub Narebski wrote:
> >    I am thinking about teaching fsck-objects and prune to keep
> >    revisions recorded in the reflog; we would need an end-user
> >    way to prune older reflog entries and I would appreciate
> >    somebody codes it up, but even without it, people can always
> >    use "vi" or "ed" on reflog files ;-).
> 
> I'd rather not have prune keep revisions recorded in reflog. Reflog
> keeps also amended commits, and blobs from incrementally staged
> commits. Or perhaps make it an configuration option, default to
> true for new users (or have an option to git-prune to ignore reflog).

I think that is quite near to other issues: we already have other pieces
of information that we would like to sometimes have ignored and
sometimes not, when running fsck-objects/prune.  Namely, revisions
hidden by grafts, as already discussed on this list.

An idea I had to handle that case, and which could be useful with the
current problem, as well as others, like dealing with stgit's patch
logging, would be to define "reachable commits" using a modular
architecture.  That way we would be able to select what we want
fsck-object/prune to consider reachable, in objects reachable from:

- raw "parents" field of commit objects
- the latter as modified by info/grafts
- reflogs
- stgit patchlogs

The set of rules to consider could be declared in repo-config, thus
stgit would be able to declare that its patchlogs should not be ignored,
and people wishing to prune commits hidden by grafts in one repo could
just remove the "raw-parents" rule from their repo's config.

Obviously, mentionning stgit-specific rules here immediately suggests a
plugin-based architecture.

Does that make any sense ?

-- 
