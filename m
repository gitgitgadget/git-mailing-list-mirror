From: Andreas Gruenbacher <agruen@suse.de>
Subject: Filenames and prefixes in extended diffs
Date: Wed, 13 Jan 2010 17:13:05 +0100
Organization: SUSE Labs
Message-ID: <201001131713.05505.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 17:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV5qL-0007aJ-KG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 17:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab0AMQNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 11:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558Ab0AMQNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 11:13:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:57427 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755299Ab0AMQNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 11:13:08 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 4F3ED74609
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:13:06 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
X-Length: 594
X-UID: 579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136836>

I'm having a problem filename prefixes in git's extended diffs for patches 
which rename or copy files: those patches include the old and new filenames in 
"rename from", "rename to", "copy from", and "copy to" headers, e.g.,

	$ git show -M
	diff --git a/f b/g
	similarity index 87%
	rename from f
	rename to g
	index f00c965..3bb459b 100644
	--- a/f
	+++ b/g
	@@ -8,3 +8,4 @@
	 8
	 9
	 10
	+11

Unlike the filenames in the "diff --git", "---", and "+++" headers, the 
"rename from", "rename to", "copy from", and "copy to" filenames do not 
include prefixes.

Now when applying a patch, GNU patch's -p option determines the number of 
pathname components to strip off from filenames.  This obviously can't work 
consistently for the prefixed and prefix-less headers.

Can git be changed to include prefixes in all filenames?

The only alternative I see is to ignore the filenames in the rename/copy 
headers and rely only on the "diff --git" line.  (The "---" and "+++" headers 
are not guaranteed to exist.)  What's worse, as already discussed here, the 
"diff --git" line uses space as a separator between filenames yet it doesn't 
quote spaces in filenames.  When being forced to ignore rename/copy headers, 
this defect would make things much worse.


Any ideas?


Thanks,
Andreas
