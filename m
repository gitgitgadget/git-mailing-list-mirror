From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] git-upload-pack: Setup exec_path before gettext
Date: Wed,  6 Jun 2012 13:03:29 +0000
Message-ID: <1338987809-7212-1-git-send-email-vfr@lyx.org>
References: <1338987675-7388-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 15:04:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScFuA-0006hY-80
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab2FFNEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:04:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58538 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2FFNEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:04:00 -0400
Received: by wgbdr13 with SMTP id dr13so6201722wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 06:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=nWIm/YFBU513A/BdVwhpm/l/C+aqGx5BN1Bf8r+HUEk=;
        b=ftIoN/NvSlPqlBpaoJ7y0lq3gW6mvi1ScqOdshm7N+v8y7pp6m4YqgrLwalyiWyBLy
         mdNV0/fFJrznMcyIBc+aGdjfS5ZCaFi0+SiZBepbMtzf+pmrOYLIB50YcowgipS1EtrQ
         Mh+DnaNQqEoTcoqhgsbn3ph8OjQvVFbh3Maw8nh3lsLtv9eY97l7vOoBsGm4TvKc0Rpt
         3KZ9M1wDdo47nOZE5RcRtZ3piv//8JTTw0xQfvEs/gqXUiiNqCI6ExXgCTOvgNXJK1pM
         vtCgCKQn4PMJdYes3/B22ahV9qqGz8VNEWbf46s3tv6KCs+oyXleUtzg5P+cIpyec7sf
         HVtQ==
Received: by 10.216.199.95 with SMTP id w73mr17960421wen.196.1338987838980;
        Wed, 06 Jun 2012 06:03:58 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id ei4sm4085230wid.5.2012.06.06.06.03.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 06:03:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <1338987675-7388-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQm3BYOHesfJpA6zXpOFbyseOIE7md91pDl0/fwoSuswHZrK/qxMadKZsvVd6TiVfaQpGjhy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199323>

If RUNTIME_PREFIX is set, git_setup_gettext() uses system_path() to find
the directory with po-files. The function system_path() needs the
exec_path so this needs to be setup first before setting up gettext().

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 upload-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..f5ba770 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -791,10 +791,11 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
-	git_setup_gettext();
-
 	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
+	
+	git_setup_gettext();
+
 	read_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
-- 
1.7.9.msysgit.0
