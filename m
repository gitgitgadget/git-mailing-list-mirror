From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 07/12] Add support for "import" helper command
Date: Wed, 18 Nov 2009 02:42:27 +0100
Message-ID: <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZaq-0000vW-O8
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZKRBnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756838AbZKRBnf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:49136 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZKRBnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:33 -0500
Received: by fg-out-1718.google.com with SMTP id d23so52188fga.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7fXpBXPQQZGrNWVc5I8DPBqSzsCU7qZIfVG8LjsoxMw=;
        b=O5qcw22gi9wLMPbqRCs+Kig43FJPePtE7VGX/igV4FoEZ1VDvX7/3REA1ECUiF17Bw
         xMlrv0GSHISW3jo5ZSny3R3UTf4QNx0xgmOl3i9zEM6tu7X5fshFsD3W19obIFbuCSvx
         9GMDAGmLLzBpqiaCVLsDJUWMaRTU/MGc60PRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MIwupR4HD7V0UwSGjeEhx5cMAjkal6HWdkrJ8CWc6jB5lz3xUhrGqM2pCOTOXV+Y86
         fiFgOCYUgljfA/EhtbW9KwDnMzVLdYR0TLI1v3lVQDHLrEsA/pSvgc8Zhg051Nxm9vLs
         b8bPxj6GBts+P5A3U3YxPrJoBthJubLstdiRA=
Received: by 10.216.88.79 with SMTP id z57mr756013wee.22.1258508618159;
        Tue, 17 Nov 2009 17:43:38 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:37 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133134>

From: Daniel Barkalow <barkalow@iabervon.org>

This command, supported if the "import" capability is advertized,
allows a helper to support fetching by outputting a git-fast-import
stream.

If both "fetch" and "import" are advertized, git itself will use
"fetch" (although other users may use "import" in this case).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Unchanged.

 Documentation/git-remote-helpers.txt |   10 ++++++
 transport-helper.c                   |   52 ++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 173ee23..e9aa67e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -43,6 +43,13 @@ Commands are given by the caller on the helper's standard input, one per line.
 +
 Supported if the helper has the "fetch" capability.
 
+'import' <name>::
+	Produces a fast-import stream which imports the current value
+	of the named ref. It may additionally import other refs as
+	needed to construct the history efficiently.
++
+Supported if the helper has the "import" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -57,6 +64,9 @@ CAPABILITIES
 'fetch'::
 	This helper supports the 'fetch' command.
 
+'import'::
+	This helper supports the 'import' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/transport-helper.c b/transport-helper.c
index 53d8f08..82caaae 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@ struct helper_data
 	const char *name;
 	struct child_process *helper;
 	unsigned fetch : 1;
+	unsigned import : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -48,6 +49,8 @@ static struct child_process *get_helper(struct transport *transport)
 			break;
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
+		if (!strcmp(buf.buf, "import"))
+			data->import = 1;
 	}
 	return data->helper;
 }
@@ -98,6 +101,52 @@ static int fetch_with_fetch(struct transport *transport,
 	return 0;
 }
 
+static int get_importer(struct transport *transport, struct child_process *fastimport)
+{
+	struct child_process *helper = get_helper(transport);
+	memset(fastimport, 0, sizeof(*fastimport));
+	fastimport->in = helper->out;
+	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
+	fastimport->argv[0] = "fast-import";
+	fastimport->argv[1] = "--quiet";
+
+	fastimport->git_cmd = 1;
+	return start_command(fastimport);
+}
+
+static int fetch_with_import(struct transport *transport,
+			     int nr_heads, struct ref **to_fetch)
+{
+	struct child_process fastimport;
+	struct child_process *helper = get_helper(transport);
+	int i;
+	struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (get_importer(transport, &fastimport))
+		die("Couldn't run fast-import");
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+
+		strbuf_addf(&buf, "import %s\n", posn->name);
+		write_in_full(helper->in, buf.buf, buf.len);
+		strbuf_reset(&buf);
+	}
+	disconnect_helper(transport);
+	finish_command(&fastimport);
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(posn->name, posn->old_sha1);
+	}
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
@@ -115,6 +164,9 @@ static int fetch(struct transport *transport,
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
+	if (data->import)
+		return fetch_with_import(transport, nr_heads, to_fetch);
+
 	return -1;
 }
 
-- 
1.6.5.3.164.g07b0c
