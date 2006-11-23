X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: "stgit clean" has problems with removed generated files
Date: Thu, 23 Nov 2006 20:28:31 +0100
Message-ID: <20061123192831.GL5443@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0611230833y5ffc14d3q922a821744ad05d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 19:29:27 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611230833y5ffc14d3q922a821744ad05d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32153>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnKG9-0001NR-UF for gcvg-git@gmane.org; Thu, 23 Nov
 2006 20:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756194AbWKWT3S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 14:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbWKWT3S
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 14:29:18 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33483 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S1756194AbWKWT3R (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 14:29:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 1D41A4A25B;
 Thu, 23 Nov 2006 20:29:16 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 0782F1F066;
 Thu, 23 Nov 2006 20:28:32 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 04:33:42PM +0000, Catalin Marinas wrote:
> >fatal: Untracked working tree file 'include/asm-arm/constants.h' would be  
> >overwritten by merge.
> 
> That's a git error and I think it is the correct behaviour. It is
> safer to notify that a local file is overridden by a merge/switch
> operation rather than just losing its content.

Right, I do not discuss the behaviour of git here.  But when I first
encountered this issue, I was really wondering about what was
happenning.  It would be really helpful in such a case, if stgit was
able to pinpoint the precise patch which could not be popped.  It could
also be helpful to tell when popping patches - currently it's done
"behind my back", and I could only understand what was happenning by
reading the code.


> >The root issue seems to be that stgit has problem with such generated
> >files, ie., files that were removed from version-control, but can still
> >legitimately exist in the tree.  Dealing with them could possibly be
> >done (eg. allowing to back them up, and restore them when pushing the
> >annoying patch), but is not a trivial issue (eg. we still need to guard
> >the user against real conflicts).
> 
> That's a GIT issue more than an StGIT one, unless GIT already has a
> way to deal with this and StGIT doesn't pass the right options.

I'm not sure if git itself should add support for this.  IMHO, such an issue
is more related to the nature of patch management - git itself does not
have a need to repetedly pop/push paches, with related merge
hassles like this one.


> >First, when cleaning patches, we could first look up which patches are
> >to be removed, and only pop the necessary ones.
> 
> OK, I mentioned it above as well. This should really be done for
> efficiency but it might not solve the problem if the empty patch is
> deeper into the stack.

Right, it could be advertised as good practice to burry those near the
bottom of the stack, and anyway to keep actively-changing ones near the
top.


> >BTW, maybe it would those make sense to allowthose special ranges in
> >most places a range is valid.
> 
> Is there any other place where ranges could be used but aren't?

Hm, let's see...  I'd say "export" (I have missed it already), "files"
and maybe "commit" and "pick", although the latter would require a syntax
for ranges in other branch.

While reviewing the various commands for this, I realized that "stg pop
<patch>" semantics is significantly different from "stg push <patch>" -
ie. it is an equivalent of "goto".  What about turning it into a
float+pop, to better match the "push" behaviour ?

I also realized that "stg help <command>" output does not go through to
the pager, while eg. the help for "mail" is quite long.

Best regards,
-- 
