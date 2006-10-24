X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Geert Bosch <bosch@adacore.com>
Subject: Would be nice to have a "git-checkpoint" command
Date: Tue, 24 Oct 2006 16:36:01 -0400
Message-ID: <8F8E6877-19F5-47F1-B7B6-E369BD39FC3E@adacore.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 24 Oct 2006 20:36:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30012>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcT0P-0002az-DN for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161216AbWJXUgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWJXUgJ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:36:09 -0400
Received: from nile.gnat.com ([205.232.38.5]:64647 "EHLO nile.gnat.com") by
 vger.kernel.org with ESMTP id S965185AbWJXUgH (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:36:07 -0400
Received: from localhost (localhost [127.0.0.1]) by filtered-nile.gnat.com
 (Postfix) with ESMTP id 3D27848D21D for <git@vger.kernel.org>; Tue, 24 Oct
 2006 16:36:07 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1]) by localhost (nile.gnat.com
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id 16823-01-9 for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 16:36:07 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124]) by
 nile.gnat.com (Postfix) with ESMTP id 1807B48D21C for <git@vger.kernel.org>;
 Tue, 24 Oct 2006 16:36:07 -0400 (EDT)
To: git List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

(Just an idea, no code yet.)

NAME
----
git-checkpoint - Save current state of the repository

SYNOPSIS
--------
'git-checkpoint' [--stdout] [-n]

DESCRIPTION
-----------
This command generates trees/blobs for all files
in the current git repository, including untracked files
and directories and the .git directory itself, only excluding
.git/objects.

With no options given, tree id is saved in .git/UNDO

OPTIONS
-------
--stdout::
	Write tree id of repository state to standard output, and
         do not write in .git/UNDO
-n|--no-create::
	Don't actually create new objects. Implies --stdout


(Discussion)

This could be used for implementing git-undo and git-redo commands.
Note that an implicit chain of undo commands is kept, by restoring
successive .git/UNDO files. Of course git-undo should save a .git/REDO
file. Ideally both operations would keep a nice undo/redo stack.

The reason for not using commits is that this not meant for keeping
history, just reverting mistakes. In particular, a prune will blow
away all older UNDOs keeping just the last, which is fine. Doing a
checkpoint should always succeed and never require user interaction.

