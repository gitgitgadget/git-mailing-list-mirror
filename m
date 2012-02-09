From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Thu,  9 Feb 2012 13:55:24 -0500
Message-ID: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 19:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZ9f-00063E-4g
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab2BISzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:55:33 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41719 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2BISzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:55:31 -0500
Received: by yhoo21 with SMTP id o21so1064886yho.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5UuwscyH7gw9vUzVxxBvtdwQnmvYInKF89xa4hp/kQA=;
        b=p+BLLUt1Dvf5yTa1bbzTHOIzVvJgbI1UE8VZWAPuOKsy+b2H8IOYCFTBVvgkPdAtW0
         QAsIsvBpWNYKN1VGMr/ev4anQ+XtOiTN3lEdJ79VQdtsEgvuwBaRmqpUSlM9hTjw7Reh
         0jxTXWwv8rVIUfAsI7E9VHnhVtFXJA65mYR2k=
Received: by 10.236.186.98 with SMTP id v62mr4420173yhm.22.1328813731205;
        Thu, 09 Feb 2012 10:55:31 -0800 (PST)
Received: from brock (adsl-184-43-8-254.bgk.bellsouth.net. [184.43.8.254])
        by mx.google.com with ESMTPS id k9sm7849467ang.17.2012.02.09.10.55.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 10:55:30 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1RvZ9U-0004Kv-VO; Thu, 09 Feb 2012 13:55:28 -0500
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190305>

If we delete a file and recreate it as a directory in a single commit,
we have to tell the server about the deletion first or else we'll get
"RA layer request failed: Server sent unexpected return value (405
Method Not Allowed) in response to MKCOL request"
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 570d83d..520b02b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5391,7 +5391,7 @@ sub DESTROY {
 sub apply_diff {
 	my ($self) = @_;
 	my $mods = $self->{mods};
-	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
+	my %o = ( D => -2, R => 0, C => -1, A => 3, M => 3, T => 3 );
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		my $f = $m->{chg};
 		if (defined $o{$f}) {
-- 
1.7.9.4.ge7a0d
