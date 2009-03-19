From: Amos King <amos.l.king@gmail.com>
Subject: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Thu, 19 Mar 2009 10:12:57 -0500
Message-ID: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJx8-000096-OJ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbZCSPNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbZCSPNA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:13:00 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:51546 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZCSPM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:12:59 -0400
Received: by qw-out-2122.google.com with SMTP id 8so478612qwh.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CVPziqJKFFQBO60NGKyndPzYpGipvApLU2GtI6uWwA8=;
        b=JOjrQ9aAPMuCCXxYM7rEAKfWJVn6VQI9TdLIAwxRHhsg45/s1W4vZzM8mch7fVpTXs
         hSJ0rNzyj7j+LFPnez1DHx5BusCrHsampmDQDzcu2m0BXjl4fbctlK02uCBRPB28Vdlg
         iIHjHxB6xf25iikic6jS8Mjzc+e7Svebj1QWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=nRgJqQBB4z/5OBragQSXXlCVzNLZzYhUcxLPsMG1X3EgPD/FctkGTKJvOnY8NcPIV5
         ovVlD20CSYQJtHw0FeDdHTdxbh3Sd6kzP5CHsSb3qJV2D52OgTvvzF3zS7xD6UbLvag6
         1hBcB0plsp/OUN1csjsF017A412njQ0SBsUWM=
Received: by 10.229.74.79 with SMTP id t15mr1465138qcj.2.1237475577488; Thu, 
	19 Mar 2009 08:12:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113778>

There is now a faux remote created in order to
be passed to http_init.

Signed-off-by: Amos King <amos.l.king@gmail.com>
---
 http-push.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9ac2664..468d5af 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2195,7 +2195,16 @@ int main(int argc, char **argv)

 	memset(remote_dir_exists, -1, 256);

-	http_init(NULL);
+	/*
+	 * This is a faked remote so that http_init can
+	 * get the correct data for builidng out athorization.
+	 */
+	struct remote *remote;
+	remote = xcalloc(sizeof(*remote), 1);
+	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
+	remote->url[remote->url_nr++] = repo->url;
+
+	http_init(remote);

 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");

-- 
1.6.2.GIT
