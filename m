From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Thu,  9 Feb 2012 15:52:22 -0500
Message-ID: <1328820742-4795-2-git-send-email-stevenrwalter@gmail.com>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
 <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <swalter@lexmark.com>,
	Steven Walter <stevenrwalter@gmail.com>
To: gitster@pobox.com, normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:52:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvayv-0007bw-8j
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab2BIUwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 15:52:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41044 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab2BIUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 15:52:35 -0500
Received: by ghrr11 with SMTP id r11so1150163ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7jqrF4512pb1m6UhiGYlIpIpF0D7Oa04CTSpSSaHdiw=;
        b=IIoj5zC//cQotL5FbNVe//Hiwuhut8cz9xmW16ftzkjUpl47r7/nCz/S7JwSTvplHZ
         hGsGRiz76kSy2XBLy/mi03nNnGVycXWMdIrplLn/VGEQz12sVKIFK2+QY5AyguetYrqM
         V+0MovsEbzGPk7BiPN8Qw2jA9pmVaOey4MElw=
Received: by 10.236.155.225 with SMTP id j61mr5080792yhk.43.1328820754967;
        Thu, 09 Feb 2012 12:52:34 -0800 (PST)
Received: from brock (adsl-184-43-8-254.bgk.bellsouth.net. [184.43.8.254])
        by mx.google.com with ESMTPS id n35sm6026741yhh.19.2012.02.09.12.52.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 12:52:34 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1Rvaym-0001G0-Vb; Thu, 09 Feb 2012 15:52:32 -0500
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190319>

From: Steven Walter <swalter@lexmark.com>

If we delete a file and recreate it as a directory in a single commit,
we have to tell the server about the deletion first or else we'll get
"RA layer request failed: Server sent unexpected return value (405
Method Not Allowed) in response to MKCOL request"

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..06c9322 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5374,7 +5374,7 @@ sub DESTROY {
 sub apply_diff {
 	my ($self) = @_;
 	my $mods = $self->{mods};
-	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
+	my %o = ( D => 0, C => 1, R => 2, A => 3, M => 4, T => 5 );
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		my $f = $m->{chg};
 		if (defined $o{$f}) {
-- 
1.7.5.4
