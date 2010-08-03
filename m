From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn: URL-decode the left-hand side of an svn refspec
Date: Tue,  3 Aug 2010 19:21:25 -0400
Message-ID: <1280877685-4928-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <swalter@lpdev.prtdev.lexmark.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Aug 04 01:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgQnw-0000OK-1w
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 01:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab0HCXVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 19:21:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33191 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548Ab0HCXVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 19:21:34 -0400
Received: by iwn7 with SMTP id 7so5521228iwn.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=HUKbMO85bp+uSqTPv/Dv4kJ4leRtGR7twbozF4dTJgU=;
        b=o/PB839yR9/l1H2whNr6J161ss76SxLZrJPhkBMvdw7dHxqNsyqTQdImgrIGaJD8Xi
         IMB4kULYGbYzfAedbQ74bun2hI3u4NtDjJ5Wtgbn7TYLWjx1XcKcf3klf5cjTz+KfC27
         29RG1zoEuw7O0pIxbvXIK14sRXSyC0SPrTxd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=K5H1VtqQSvTJkWSoRhCe27eiYpy+BKTCpl8Pr4pch0GadiAnNnWC9n6PVfWAOKCTAn
         L8ZWYYbgo4bHZfDiXb80/2f3wkZoWSx5mb5vF3jdXxl6fh77LhIPRKVyjdI0lFZYnVHR
         7bsuXa6eTTcj/X5kPMVHmtvIulRxyv/Y0EVSE=
Received: by 10.231.177.25 with SMTP id bg25mr9107125ibb.154.1280877692974;
        Tue, 03 Aug 2010 16:21:32 -0700 (PDT)
Received: from brock (adsl-147-26-48.bgk.bellsouth.net [72.147.26.48])
        by mx.google.com with ESMTPS id n20sm7109845ibe.17.2010.08.03.16.21.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 16:21:31 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.71)
	(envelope-from <srwalter@dervierte>)
	id 1OgQnY-0001IC-QU; Tue, 03 Aug 2010 19:21:28 -0400
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152548>

From: Steven Walter <swalter@lpdev.prtdev.lexmark.com>

This change allows git-svn to handle an URL with colons in the path
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index af70353..5d08dc6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1812,6 +1812,8 @@ sub read_all_remotes {
 			die("svn-remote.$remote: remote ref '$remote_ref' "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
+                        # local_ref is an URL, so url-decode it
+                        $local_ref =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
 			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
 			$r->{$remote}->{svm} = {} if $use_svm_props;
 		} elsif (m!^(.+)\.usesvmprops=\s*(.*)\s*$!) {
-- 
1.7.0.3.gaa64d.dirty
