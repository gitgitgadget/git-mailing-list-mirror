From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] git stash: Give friendlier error when there is nothing to
	apply
Date: Tue, 11 Aug 2009 14:12:13 +0300
Message-ID: <4a81559c.05ae660a.591b.010b@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 13:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MapxN-0000cc-4E
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 13:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbZHKLy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZHKLy1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:54:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35752 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbZHKLy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 07:54:26 -0400
Received: by bwz19 with SMTP id 19so3115009bwz.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:sender:from:to
         :date:subject;
        bh=n0o9FYN3G1JLUU3c2NrYKia8XxT8kROij3OEgjKWdAc=;
        b=LeBxEs9huJsMR1cO7v5G9/jnBE4uf0P4MeAkWlNsbdwKKMXnC4ZpxQQ5F71vTCHjOU
         nRaIkoysx94l1kFwPdXLAIk8DLxhASgZMwFuxPvIEXPY6imWwDVc/AHq+Fyzb6/FCEw2
         pUR6ltCf8yakX/dtQ+3cZRXXf6OBqT04tGTxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        b=CKoxzDZ2fIaNUEYFcfDAkqDnTfq2vXx4pqTWkAhSoI2IG7xdDsE0o0nxDuG0rbZQrG
         KyZB0WXxHmFXdOmTIeXAJGy/DEuIX+eXOsDnWSG5v/Eem2GsiHISYfP2TPd38dGJGehr
         LjPJBpGraHZ9j3K3jJWKtmiw30+lKlWC2vpKs=
Received: by 10.103.5.2 with SMTP id h2mr2388883mui.132.1249990045622;
        Tue, 11 Aug 2009 04:27:25 -0700 (PDT)
Received: from ?127.0.1.1? (bzq-82-81-59-125.red.bezeqint.net [82.81.59.125])
        by mx.google.com with ESMTPS id w5sm25086947mue.4.2009.08.11.04.27.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 04:27:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125517>

The old message was scary and included a 'fatal' error from rev-parse:
     fatal: Needed a single revision
     : no valid stashed state found

The new message is identical to the one given by 'git stash branch', and
given *before* the check for a dirty working tree.

Previously, the command prompted the user to clean a dirty working tree
when there is nothing to apply.

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---
 git-stash.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..aa84144 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -162,6 +162,8 @@ show_stash () {
 }
 
 apply_stash () {
+	have_stash || die 'Nothing to apply'
+
 	git update-index -q --refresh &&
 	git diff-files --quiet --ignore-submodules ||
 		die 'Cannot apply to a dirty working tree, please stage your changes'
-- 
1.6.4.73.gc144.dirty
