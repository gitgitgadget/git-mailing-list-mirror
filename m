From: Alex Chiang <achiang@hp.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Tue, 26 Feb 2008 10:49:28 -0700
Message-ID: <20080226174928.GA15862@ldl.fc.hp.com>
References: <20080226145725.GA24987@ldl.fc.hp.com> <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU3wQ-0001Zk-Cd
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 18:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbYBZRta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 12:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761672AbYBZRta
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 12:49:30 -0500
Received: from g4t0015.houston.hp.com ([15.201.24.18]:22082 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796AbYBZRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 12:49:29 -0500
Received: from g4t0015.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id B63A48B48;
	Tue, 26 Feb 2008 17:49:28 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 97310826C;
	Tue, 26 Feb 2008 17:49:28 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 6FDAE1E646B;
	Tue, 26 Feb 2008 17:49:28 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 5A98B134006; Tue, 26 Feb 2008 10:49:28 -0700 (MST)
Mail-Followup-To: Alex Chiang <achiang@hp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75156>

* Catalin Marinas <catalin.marinas@gmail.com>:
> On 26/02/2008, Alex Chiang <achiang@hp.com> wrote:
> >  How does one do a stg rebase if there are merge conflicts?
> 
> Basically, you solve the conflict, refresh the current patch and
> continue with 'stg push' or 'stg goto <top patch>'.

Thanks.

> The 'rebase' command doesn't store any information about the state of
> the stack and cannot continue it. Maybe we'll do something in the next
> release as the refactored code has support for transactions.

I see.

> >  Doing an 'stg help rebase' isn't so helpful.
> 
> Yes, indeed. It could be made better.

How about this?

/ac

From: Alex Chiang <achiang@hp.com>

Enhance rebase help string by providing guidance on merge
conflict resolution during a rebase.

Based on text suggested by Catalin Marinas.

Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 12faaf8..29d741b 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -27,7 +27,19 @@ help = 'move the stack base to another point in history'
 usage = """%prog [options] <new-base-id>
 
 Pop all patches from current stack, move the stack base to the given
-<new-base-id> and push the patches back."""
+<new-base-id> and push the patches back.
+
+If you experience merge conflicts, resolve the problem and continue
+the rebase by executing the following sequence:
+
+	$ stg resolved -a [-i]
+	$ stg refresh
+	$ stg goto top-patch
+
+Or if you want to skip that patch:
+
+	$ stg push --undo
+	$ stg push next-patch.."""
 
 directory = DirectoryGotoToplevel()
 options = [make_option('-n', '--nopush',
