From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: [PATCH 1/2] Resumable clone: create git-prime-clone (Draft)
Date: Wed, 18 May 2016 22:07:29 -0700
Message-ID: <1463634450-28265-2-git-send-email-kevin.m.wern@gmail.com>
References: <1463634450-28265-1-git-send-email-kevin.m.wern@gmail.com>
Cc: Kevin Wern <kevin.m.wern@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 07:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3GC6-0007ev-AN
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 07:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbcESFIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 01:08:12 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35175 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcESFIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 01:08:09 -0400
Received: by mail-pa0-f65.google.com with SMTP id rw9so6757047pab.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebr9tuEhTOJH5ViOKBvPPgCMzMw4fElW4a35uS5uO5E=;
        b=qRHQeJhsCsSo8vDQVOnOyPv1PPa+9VDK58sgACHYXXlZGJSHzE7QhaSwuUfFNhUBT2
         QJReQsxkdRiBa7HJ4JdfkQQ6IIK4y5hEAcbREQouu35t4+6cIZwG1jPv48NE2/+yTNWM
         DJ0a5Eef+ElbutL4H4DCRC+k5edMhA364mdow9SyUBBEvwaiU/cDr0Tu9Jw7PeSDvuSx
         hbvkqEgrY6Sob0khTzVdm7c62znuEJDsJxalU1CM2LgqQ6T+QVgmw43jp4rWHTKrJ8iH
         U6guLne06/MHQZ/4j+ut6fr4jxDkyUGnUc20//yB4kTNmfVY2DhxWsU2v72/bmDlV2Jk
         cIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebr9tuEhTOJH5ViOKBvPPgCMzMw4fElW4a35uS5uO5E=;
        b=fBvGPDP8NrUmvL9Z0LT797VYKA/dU35ephpkvsMErDDXkn1LhTuk0klsNBfpYkTBce
         HtfmbgtWTmm6R5Mthx/jpSCNq2Sr1kI3M5/+KWvlkiyA718kzDV44Tzp5Yw4Jq/R1FNj
         VY7vSlpAM2ABAZ0kBd5sgaJU0jL7z7pjk1g0xDYSnQw1uu/P/kDpNHs+TW/dFNDsufaU
         Kc2jQHL/kR11xYw3ehe/RNAcPkM4TRtyvEkZ2XbhThNiS1Y/aKaEzZ8YXmLXHEZyJh0H
         YwEnUYrjY21xnMBLVhYiIP64hanY1kCK1GysFgzVLEr3jqIFECfD1LgjSdOirH+OsnuO
         eXeA==
X-Gm-Message-State: AOPr4FWC1+pdFAE27G4/0P70h16cbNNedBXC5SA/gqLpIY70hNCgVpt8OxN7EMEzsbiTJA==
X-Received: by 10.66.134.15 with SMTP id pg15mr16381630pab.98.1463634488490;
        Wed, 18 May 2016 22:08:08 -0700 (PDT)
Received: from localhost.localdomain (47-35-3-42.dhcp.snlo.ca.charter.com. [47.35.3.42])
        by smtp.gmail.com with ESMTPSA id to9sm16078985pab.27.2016.05.18.22.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 May 2016 22:08:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463634450-28265-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295041>

Create a bare-bones version of git-prime-clone, which returns the
location of an alternate resource specified by the server that the
client should fetch and build before returning to perform an incremental
fetch.

At this point, no validation is performed of the file's existence, the
file's validity as a fully connected archive, or its correspondence
to the specified resource type in .git/config.
---
 Makefile      |  1 +
 prime-clone.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 prime-clone.c

diff --git a/Makefile b/Makefile
index 3f03366..34febdc 100644
--- a/Makefile
+++ b/Makefile
@@ -579,6 +579,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += prime-clone.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
diff --git a/prime-clone.c b/prime-clone.c
new file mode 100644
index 0000000..74fd8d4
--- /dev/null
+++ b/prime-clone.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "refs.h"
+
+#define PRIME_CLONE_ENABLED 1
+
+static const char prime_clone_usage[] = "git prime-clone [--strict] <dir>";
+
+static unsigned int enabled;
+static const char *url = "\0";
+static const char *filetype = "\0";
+
+static void prime_clone(void)
+{
+	if (enabled)
+	{
+		if (strlen(url) != 0 && strlen(filetype) != 0) {
+			packet_write(1, "url %s\n", url);
+			packet_write(1, "filetype %s\n", filetype);
+		}
+		else {
+			packet_write(1, "prime-clone not properly configured\n");
+		}
+	}
+	else {
+		packet_write(1, "prime-clone not enabled\n");
+	}
+	packet_flush(1);
+}
+
+static int prime_clone_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("primeclone.url",var)) {
+		return git_config_pathname(&url, var, value);
+	}
+	if (!strcmp("primeclone.enabled",var)) {
+		if (git_config_bool(var, value))
+			enabled = PRIME_CLONE_ENABLED;
+		else
+			enabled = ~PRIME_CLONE_ENABLED;
+	}
+	if (!strcmp("primeclone.filetype",var)) {
+		return git_config_string(&filetype, var, value);
+	}
+	return parse_hide_refs_config(var, value, "primeclone");
+}
+
+int main(int argc, char **argv)
+{
+	char *dir;
+	int i;
+	int strict = 0;
+
+	git_setup_gettext();
+
+	packet_trace_identity("prime-clone");
+	git_extract_argv0_path(argv[0]);
+	check_replace_refs = 0;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--strict")) {
+			strict = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+	}
+
+	if (i != argc-1)
+		usage(prime_clone_usage);
+
+	setup_path();
+
+	dir = argv[i];
+
+	if (!enter_repo(dir, strict))
+		die("'%s' does not appear to be a git repository", dir);
+
+	git_config(prime_clone_config, NULL);
+	prime_clone();
+	return 0;
+}
-- 
1.9.1
