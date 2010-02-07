From: Johan Herland <johan@herland.net>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 07 Feb 2010 23:46:22 +0100
Message-ID: <201002072346.22627.johan@herland.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 23:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeFv2-0004td-Sc
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 23:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250Ab0BGWqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 17:46:50 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55006 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757606Ab0BGWqf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 17:46:35 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXH0058DTXMWTE0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 23:46:34 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXH00AB8TXAKZ30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 23:46:34 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.7.223327
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20100207050255.GA17049@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139262>

On Sunday 07 February 2010, Jeff King wrote:
> I think I may have been the one to suggest trees or notes at one point.
> But let me clarify that this is not exactly what the OP is proposing in
> this thread.
> 
> My suggestion was that some use cases may have many key/value pairs of
> notes for a single sha1. We basically have two options:
> 
>   1. store each in a separate notes ref, with each sha1 mapping to
>      a blob. The note "name" is the name of the ref.
> 
>   2. store notes in a single notes ref, with each sha1 mapping to a
>      tree with named sub-notes. The note "name" is the combination of
>      ref-name and tree entry name.
> 
> The advantage of (1) is that notes are not bound tightly to each other.
> I can distribute the notes tree for one "name" independent of the
> others.  The advantage of (2) is that it is faster and smaller. In (1),
> each note has a separate index, and we must traverse each note index
> separately.
> 
> In practice, I would expect to use (1) for logically separate datasets.
> For example, automatic bug-tracking notes would go in a different ref
> from human annotations. But I would expect to use (2) if I had, say, 5
> different pieces of bug tracking information and I wanted an easy way to
> refer to them individually.
> 
> And a specialized merge for that is straightforward. In the simplest
> case, you simply say "notes of this ref are tree-type, or they are
> blob-type" and then you have no merge problems. But if you want to get
> fancy, you can say that a conflict between "sha1/blob" and
> "sha1/tree/key" should automatically "promote" the first one into
> "sha1/tree/default" or some other canonical name.
> 
> Note that all of this is my pie-in-the-sky "here is what I was thinking
> of when I looked at notes a long time ago". I don't care strongly if it
> gets implemented or not at this point; I just wanted to add some context
> to what Johan had in his notes todo list (or maybe I am wrong, and what
> is in his todo list was based on something totally different said by
> somebody else, and I have just confused the issue more. :) ).

No, My TODO item was indeed based on your suggestion (although poorly 
represented by me, both in the TODO list, and in my original answer to Jon). 
However, note that I don't feel this specific itch myself, so I'm unlikely 
to scratch it.

> With respect to the idea of storing an arbitrary tree, I agree it is
> probably too complex with respect to merging. In addition, it makes
> things like "git log --format=%N" confusing. I think you would do better
> to simply store a tree sha1 inside the note blob, and callers who were
> interested in the tree contents could then dereference it and examine as
> they saw fit.  The only caveat is that you need some way of telling git
> that the referenced trees are reachable and not to be pruned.

Agreed. Arbitrary trees as notes objects is probably not a good idea.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
