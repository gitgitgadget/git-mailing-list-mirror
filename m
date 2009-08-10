From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] http.c: free preq when aborting
Date: Mon, 10 Aug 2009 23:51:24 +0800
Message-ID: <20090810235124.e978869f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXA7-0001E8-A9
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbZHJPvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZHJPvm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:51:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:23594 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbZHJPvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:51:42 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1029003rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=o5VGO6vOPHJRdDus1zwaOOH+H0qJcspav+zNqiSeW54=;
        b=twVjJiNCzD81I08V+ZxwyIHchLt43vpqSesOUtq8vFNUJKNyqiEqBwr0VpaMM7Pi50
         B4zthrlHyxPMdVTNHrhrVKyE0dIJrYV1mBIjuR9d4yyIeZdRFaMYczeBcndlJ0rUS0Td
         QMOkyzwb8Z7+kJECItKzfcaiqyOxNB0m6Pj0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=F28qfruZkdrX46wbAxUEnJ1wUfJ1Jt/y5sJ9a/U1iC+soWC3RMXd+/VCJ3EyBdKE+l
         4yvEWIf9M/H1aSidhXeNp/sT04TVUHQHu5w1vXMWAlC0EM3RU6KCVq7Epx7oMF5zir4k
         av7B2RxdL/cUEsgu5HgR2e+GlYFlaldqokjPQ=
Received: by 10.141.21.12 with SMTP id y12mr1638283rvi.248.1249919503309;
        Mon, 10 Aug 2009 08:51:43 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta152.maxonline.com.sg [116.87.152.189])
        by mx.google.com with ESMTPS id g22sm23334711rvb.2.2009.08.10.08.51.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:51:42 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125469>

Free preq in new_http_pack_request when aborting. preq was allocated
before jumping to the 'abort' label so this is safe.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index a2720d5..cfe32f5 100644
--- a/http.c
+++ b/http.c
@@ -1059,6 +1059,7 @@ struct http_pack_request *new_http_pack_request(

 abort:
 	free(filename);
+	free(preq);
 	return NULL;
 }

--
1.6.3.1
