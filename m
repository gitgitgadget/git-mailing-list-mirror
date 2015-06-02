From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 11/16] remote: have preselect_capabilities
Date: Mon,  1 Jun 2015 17:02:13 -0700
Message-ID: <1433203338-27493-12-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfj-0000kM-RX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbbFBADF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:05 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36098 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbbFBACr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:47 -0400
Received: by igbpi8 with SMTP id pi8so74557428igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iepAf0WjnPBpLhpSw5rHioVdZOj28uLF8U5GMhIgcio=;
        b=mfT/jKk7s/9J6flLJyneS8UF0Kn3RJNehT/JklmRc2jqDjwaqD6cpxt+RIeXGyfTQk
         42eKCCCUdbMXkEkJVkEBsESvAhhybHAY5CXr3q1j2kB3bDF/Ym8IHU65cEyntW74TTVf
         kcnhXTYKX55FIMa8kZbUZ95pRyjVyPUsRVMCHJSB5WlrVDOLJSR6+zP4075gADbbrA6n
         8iQLZNjinZxeQFhSG1A5HGULDJPw65fEi1LWeqYleFiCSIw0/C6osccxCrzbHVvjL3oo
         Dsc4Pqnf51JtdApC0sd4DTdWtUSqHNK4Qeg/YmKUwsha1naHmVow3p3P6HyQXP4/O9Jf
         i68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iepAf0WjnPBpLhpSw5rHioVdZOj28uLF8U5GMhIgcio=;
        b=S8ge2mVK+UJGs7ZCrzOshIgq7VeXrFEOxgAQcNnfd3dceDNxxf0yl7ThTcZoq7gvq7
         rIqZHZLZG9AuAAJtrMV+TH0PHyYZ6KfE+qVfdp0r5z8fR+l3tjOAFB7ZZZLgTDbgTRB2
         IIL8D2WnekN2TUjdo+UfA2D2N+ySwAZ1P0KNpQRsL3boQhtVE7gJ/2gr1E940XbLCTj/
         dzInGmeFw7NKTK58G2tCAvb6lSTcTr4p3rWFAdPj8a0NAt6Az7/nTuhVPn3D64TyS4bq
         6EucVUemrfjsyv7Vcxvep0+CMuiaj1OhTmCFha9wYgH+mAiHKopCQDrKw4/OJTkClodU
         TJxw==
X-Gm-Message-State: ALoCoQnffVtupIxyB4cHobyvayyuddYElbaVY9AbWDfYageK+QPl9+aj9CCWzchiFANGs0vudT5H
X-Received: by 10.42.166.200 with SMTP id p8mr23894393icy.25.1433203366982;
        Mon, 01 Jun 2015 17:02:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id rj5sm8925710igc.2.2015.06.01.17.02.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270488>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 28 ++++++++++++++++++++++++++++
 remote.h  |  1 +
 2 files changed, 29 insertions(+)

diff --git a/connect.c b/connect.c
index 4ebe1dc..752b9a5 100644
--- a/connect.c
+++ b/connect.c
@@ -126,6 +126,34 @@ void get_remote_capabilities(int in, char *src_buf, size_t src_len)
 	}
 }
 
+/* just select all options the server advertised. */
+void preselect_capabilities(struct transport_options *options)
+{
+	if (is_repository_shallow() && !server_supports("shallow"))
+		die("Server does not support shallow clients");
+
+	if (server_supports("multi_ack"))
+		options->multi_ack = 1;
+	else if (server_supports("multi_ack_detailed"))
+		options->multi_ack = 2;
+
+	if (server_supports("side-band"))
+		options->use_sideband = 1;
+	else if (server_supports("side-band-64k"))
+		options->use_sideband = 2;
+
+	if (server_supports("no-done"))
+		options->no_done = 1;
+	if (server_supports("thin-pack"))
+		options->use_thin_pack = 1;
+	if (server_supports("no-progress"))
+		options->no_progress = 1;
+	if (server_supports("include-tag"))
+		options->include_tag = 1;
+	if (server_supports("ofs-delta"))
+		options->prefer_ofs_delta = 1;
+}
+
 int request_capabilities(int out, struct transport_options *options)
 {
 	if (options->multi_ack == 2)    packet_write(out, "multi_ack_detailed");
diff --git a/remote.h b/remote.h
index 61619c5..264a513 100644
--- a/remote.h
+++ b/remote.h
@@ -166,6 +166,7 @@ extern void get_remote_heads(int in, char *src_buf, size_t src_len,
 			     struct sha1_array *shallow);
 
 void get_remote_capabilities(int in, char *src_buf, size_t src_len);
+void preselect_capabilities(struct transport_options *options);
 int request_capabilities(int out, struct transport_options*);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
-- 
2.4.1.345.gab207b6.dirty
