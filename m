From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 6/6] clone: send refspec for single-branch clones
Date: Fri, 15 Apr 2016 15:19:09 -0400
Message-ID: <1460747949-3514-7-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HS-0006Y9-SS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbcDOTTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:40 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34683 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcDOTTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:38 -0400
Received: by mail-qg0-f49.google.com with SMTP id c6so86908389qga.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8vU1HaoO1lDBmLV502IKJmgEfW/gcMMvJBryC7c100=;
        b=i/bK7IaYf8KmFw45N/YfTzeVNNUF1+vzXwPrpjxakz0YW+/thDCUSE+bajFXa9jxRW
         0Ou534kjTn5+YcE7789cwjkqwVbT21/sRc9YCzAyMX3nKsJyUVPC3umTeR1xkIqkTTAV
         mHdwVa+If8I4Fk0T7Dpo9gILCz+NWTQkjS+T4uHJo+aAnEx72XyARJ4KjMZD76MqyuXg
         E2EqVkMD9TD7xAdJBQQwci4l1NAL84kLuDJ8JstjjalFsxq0SasKdX3TaEI1TFn12rZh
         Wtb2bZtlHrV+QvXaIaxg1ZY3xipX03wRDX42Pph0NIKoDM5sUVGN2iD6/UuXRqUra9kx
         WVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/8vU1HaoO1lDBmLV502IKJmgEfW/gcMMvJBryC7c100=;
        b=Mx7QsTOUKFjq9/phoyTFCOjywqhKm5bXRHEAX+iLYgmQv795vKRaN4GmOce46K+sYp
         zz47Lbmd1gGRYJXBCLMG/KUjCFm4t1uBX4G52UVf7MkGy3taGOTYPCYsp/Dg2HdKA7fi
         aiVHGBvBLOnoWoHHqQhsXH0b70mfXZyLGK2YbU9k0QMh5qEKo08WsC3LuBXxT8hAOfHw
         iWeC60+TsvZircuq4WkvIwv7yCaFddboN16VGZ6HNnlBRgcsnb0U8jIpmERFLXjUa9Xi
         I+BnoOq1yunCaytZloCmi6cvA1jzucn2UA64altdmsd8zr4EBTjtUjOV2UjsJ2Qv/e1E
         2Bgg==
X-Gm-Message-State: AOPr4FUya9T/dxJ1qrSdXynKjRL/UM/dUkMRFaI1YhD+jgE0NkOPyaI7u0DABt1PFKbWRQ==
X-Received: by 10.140.43.37 with SMTP id d34mr26807859qga.51.1460747977631;
        Fri, 15 Apr 2016 12:19:37 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291644>

For single-branch clones (when we know in advance what the remote
branch name will be), send a refspec so that the server doesn't
tell us about any other refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/clone.c              | 16 +++++++++++++++-
 t/t5552-http-fetch-branch.sh |  5 +++++
 transport-helper.c           | 12 +++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 91f668c..9a0291d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1010,7 +1010,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !option_depth)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	refs = transport_get_remote_refs(transport, NULL, 0);
+	if (option_single_branch && option_branch) {
+		struct refspec branch_refspec = {0};
+
+		if (starts_with(option_branch, "refs/")) {
+			branch_refspec.src = xstrdup(option_branch);
+		} else {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "refs/heads/%s", option_branch);
+			branch_refspec.src = strbuf_detach(&buf, NULL);
+		}
+		refs = transport_get_remote_refs(transport, &branch_refspec, 1);
+		free(branch_refspec.src);
+	} else {
+		refs = transport_get_remote_refs(transport, NULL, 0);
+	}
 
 	if (refs) {
 		mapped_refs = wanted_peer_refs(refs, refspec);
diff --git a/t/t5552-http-fetch-branch.sh b/t/t5552-http-fetch-branch.sh
index 0e905d9..8a8e218 100755
--- a/t/t5552-http-fetch-branch.sh
+++ b/t/t5552-http-fetch-branch.sh
@@ -38,5 +38,10 @@ test_expect_success 'fetch with refspec only fetches requested branch' '
 	)
 '
 
+test_expect_success 'single-branch clone only fetches requested branch' '
+	GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git clone --single-branch -b master $HTTPD_URL/smart/repo.git sbc &&
+	! grep "refs/heads/another_branch" trace
+'
+
 stop_httpd
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 7d75d64..3775d63 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -28,6 +28,7 @@ struct helper_data {
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
+		refspec : 1,
 		no_private_update : 1;
 	char *export_marks;
 	char *import_marks;
@@ -114,8 +115,15 @@ static struct child_process *get_helper(struct transport *transport, const struc
 	int code;
 	int i;
 
-	if (data->helper)
+	if (data->helper) {
+		if (!data->refspec && req_refspec_nr) {
+			for (i = 0; i < req_refspec_nr; i++)
+				set_helper_option(transport, "refspec",
+						  req_refspecs[i].src);
+			data->refspec = 1;
+		}
 		return data->helper;
+	}
 
 	helper = xmalloc(sizeof(*helper));
 	child_process_init(helper);
@@ -220,6 +228,8 @@ static struct child_process *get_helper(struct transport *transport, const struc
 
 	for (i = 0; i < req_refspec_nr; i++)
 		set_helper_option(transport, "refspec", req_refspecs[i].src);
+	if (req_refspec_nr)
+		data->refspec = 1;
 	standard_options(transport);
 	return data->helper;
 }
-- 
2.4.2.767.g62658d5-twtrsrc
