From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 07/16] transport: add infrastructure to support a protocol version number
Date: Mon,  1 Jun 2015 17:02:09 -0700
Message-ID: <1433203338-27493-8-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfX-0000j9-5w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbbFBACz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:55 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36041 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbbFBACl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:41 -0400
Received: by igbpi8 with SMTP id pi8so74556008igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/muTZNka5VYbScpIg0MOw39XbCNZVTUJxoLHYZMYJms=;
        b=cW9KfGw01DxA1Uo/1yaEhGPIA2RZk0SaGOHCxXldpDDzVsalrmP7zDJZZOC+WHFt2d
         FmesCjlaPgvb9yVZXJKXqNWgmP8JmFTjWTiZ3YQ/Kq1RuApDWUep1lqODGXzT1hmBktG
         M4wP77SFGrqKyp2vCnrgnV+Px5dtFNB+NzlKsN4AVY/KibBs/8wm9WqPz2jyGqgfy8f8
         HEe38P/2FD782Sfr2fNtWtzFLzp+hk9rTdPIiCig8pAJb1uoJrDVwqb41sjy0ST1ZUGk
         hsLlh27yq40Rm3RWfreecKY4pzmrSAQmNAs/jjG8yIWx8vbTxu4sNLGsqrANsvKNMmri
         7B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/muTZNka5VYbScpIg0MOw39XbCNZVTUJxoLHYZMYJms=;
        b=HKcLlx9BfJfnuq2J7DZjZkrErtTHE6cOqHdTTlk0Dx+NFLks2mWKEJs7HdLOqKSk03
         OGvmJc/GtMe4ydtopdW6ACpykxz/9BP8BR2E8labhLme1MMf2CrqM+Gvp7uVZsUNppjV
         dLLdN+s0y0p8B0BJ3EHwMMw8+4njFBwGTsasU5SqKhw5QzaTO3GlO/F8MvSPzLqNkge0
         L7ShcglUWiJsz6kduO9ZYs1LVkAeT4QJCC4Q171sSVmphlMd+xfICqsytdsjL9RMshM7
         Kt1zEjszYmCecJolLCUndKxhZxekgQLMEY9bfjHJTZmI9LXR8ujpL7iYQkLWnkbYUaKF
         1DXA==
X-Gm-Message-State: ALoCoQkCvk1c7owIzD2JDyjZCUUPVSDd5H9c0c7Z4jBCpAIqOQUn9aXgQgqQfFiEmQinMx+CH6IE
X-Received: by 10.107.15.149 with SMTP id 21mr31454918iop.44.1433203360840;
        Mon, 01 Jun 2015 17:02:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id av6sm8896241igc.17.2015.06.01.17.02.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270483>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This patch has been split up into 2 parts.
    This first part only introduces the infrastructure
    without exposing it to the user at all (no command line
    option nor a repository configuration option).
    
    The exposure to the user will be added in a later second
    patch. This allows us some time in between to build all
    the features we want without the requirement to be
    functional.

 remote.h           |  2 ++
 transport-helper.c |  1 +
 transport.c        | 15 +++++++++++++++
 transport.h        |  5 +++++
 4 files changed, 23 insertions(+)

diff --git a/remote.h b/remote.h
index 16cacfe..3767bed 100644
--- a/remote.h
+++ b/remote.h
@@ -50,6 +50,8 @@ struct remote {
 	const char *receivepack;
 	const char *uploadpack;
 
+	int transport_version;
+
 	/*
 	 * for curl remotes only
 	 */
diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..ab3cd5b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -247,6 +247,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static const char *unsupported_options[] = {
+	TRANS_OPT_TRANSPORTVERSION,
 	TRANS_OPT_UPLOADPACK,
 	TRANS_OPT_RECEIVEPACK,
 	TRANS_OPT_THIN,
diff --git a/transport.c b/transport.c
index f080e93..651f0ac 100644
--- a/transport.c
+++ b/transport.c
@@ -479,6 +479,16 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
 		opts->push_cert = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_TRANSPORTVERSION)) {
+		if (!value)
+			opts->transport_version = DEFAULT_TRANSPORT_VERSION;
+		else {
+			char *end;
+			opts->transport_version = strtol(value, &end, 0);
+			if (*end)
+				die("transport: invalid transport version option '%s'", value);
+		}
+		return 0;
 	}
 	return 1;
 }
@@ -970,6 +980,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
+		ret->smart_options->transport_version =
+			DEFAULT_TRANSPORT_VERSION;
 
 		data->conn = NULL;
 		data->got_remote_heads = 0;
@@ -988,6 +1000,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->smart_options->receivepack = "git-receive-pack";
 		if (remote->receivepack)
 			ret->smart_options->receivepack = remote->receivepack;
+		if (remote->transport_version)
+			ret->smart_options->transport_version =
+				remote->transport_version;
 	}
 
 	return ret;
diff --git a/transport.h b/transport.h
index 18d2cf8..6095d7a 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned push_cert : 1;
 	int depth;
+	int transport_version;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -162,6 +163,10 @@ struct transport *transport_get(struct remote *, const char *);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Use a new version of the git protocol */
+#define TRANS_OPT_TRANSPORTVERSION "transportversion"
+#define DEFAULT_TRANSPORT_VERSION 1
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.4.1.345.gab207b6.dirty
