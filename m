X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 16:30:00 +0100
Organization: At home
Message-ID: <elh91b$v6r$1@sea.gmane.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <457C1E8E.4080407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 10 Dec 2006 15:28:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 54
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33895>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQbK-0001PH-Po for gcvg-git@gmane.org; Sun, 10 Dec
 2006 16:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761180AbWLJP2P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 10:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761183AbWLJP2P
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 10:28:15 -0500
Received: from main.gmane.org ([80.91.229.2]:41569 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1761180AbWLJP2O
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 10:28:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtQax-0006E3-Em for git@vger.kernel.org; Sun, 10 Dec 2006 16:28:03 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 16:28:03 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 10 Dec 2006
 16:28:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jeff Garzik wrote:

> Kyle Moffett wrote:
>>
>> I've recently become somewhat interested in the idea of using GIT to 
>> store the contents of various folders in /etc.  However after a bit of 
>> playing with this, I discovered that GIT doesn't actually preserve all 
>> permission bits since that would cause problems with the more 
>> traditional software development model.  I'm curious if anyone has done 
>> this before; and if so, how they went about handling the permissions and 
>> ownership issues.
>> 
>> I spent a little time looking over how GIT stores and compares 
>> permission bits; trying to figure out if it's possible to patch in a new 
>> configuration variable or two; say "preserve_all_perms" and 
>> "preserve_owner", or maybe even "save_acls".  It looks like standard 
>> permission preservation is fairly basic; you would just need to patch a 
>> few routines which alter the permissions read in from disk or compare 
>> them with ones from the database.  On the other hand, it would appear 
>> that preserving ownership or full POSIX ACLs might be a bit of a challenge.
> 
> It's a great idea, something I would like to do, and something I've 
> suggested before.  You could dig through the mailing list archives, if 
> you're motivated.
> 
> I actively use git to version, store and distribute an exim mail 
> configuration across six servers.  So far my solution has been a 'fix 
> perms' script, or using the file perm checking capabilities of cfengine.

Fix perms' script used on a checkout hook is a best idea I think.
 
> But it would be a lot better if git natively cared about ownership and 
> permissions (presumably via an option).

There is currently no place for ownership and extended attributes in
the tree object; and even full POSIX permissions might be challenge
because for example currently unused 'is socket' permission bit is
used for experimental commit-in-tree submodule support. And given Linus
stance that git is "content tracker"...

In the loooong thread "VCS comparison table" there was some talk
about using git (or any SCM) to manage /etc. Check out:

 * Message-ID: <Pine.LNX.4.64.0610220926170.3962@g5.osdl.org>
   http://permalink.gmane.org/gmane.comp.version-control.git/29765
 * Message-ID: <20061023051932.GA8625@evofed.localdomain>
   http://marc.theaimsgroup.com/?i=<20061023051932.GA8625@evofed.localdomain>

(and other messages in this subthread).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

