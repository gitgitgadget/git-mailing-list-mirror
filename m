From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not author
Date: Mon, 26 Jan 2009 12:50:15 +0100
Message-ID: <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ1C-0004CT-Gk
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbZAZLuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbZAZLuR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:17 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:43082 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbZAZLuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:14 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1246411eye.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZmSlAEsS63AMHP1my3KMGs7D7LKqlMOajPSKSUqaUI0=;
        b=J47//yUIGL5IXVGi3zKXGi1/bvWIG1qWdWvAJ3YZTlLToyneGzHZnmHWnC+WgiDjDQ
         R/Eey6S0v7YDi5MFZUMy22YuMGV8CZYF69XorjkGIVzEm4z4BxsJKiqx0urNeUuScwV9
         JqNDCoKuF0e1MJI3qjkGTTKs3cS92snkOUIVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xQzntRcHqMjGuex+RYlwAT+gVWhrRO+A/ljyxSRsya8bLFrACiq8cM5b+xMkEHDBm9
         un9j6aRFZWOyTUlHJA2B7QK0hQCSclPfh4IM+C7XCMYJfObmipnMgnJp/kvNE3DGzWRG
         Lem6mPE+crT4zjNdBXtu54ws4YSCfjOxLiLM4=
Received: by 10.103.214.8 with SMTP id r8mr1603263muq.6.1232970611995;
        Mon, 26 Jan 2009 03:50:11 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id i7sm22215810mue.15.2009.01.26.03.50.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:11 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107198>

The last-modified time header added by RSS to increase cache hits from
readers should be set to the date the repository was last modified. The
author time in this respect is not a good guess because the last commit
might come from a oldish patch.

Use the committer time for the last-modified header to ensure a more
correct guess of the last time the repository was modified.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 756868a..8c49c75 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6015,7 +6015,7 @@ sub git_feed {
 	}
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
-		%latest_date   = parse_date($latest_commit{'author_epoch'});
+		%latest_date   = parse_date($latest_commit{'committer_epoch'});
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
-- 
1.5.6.5
