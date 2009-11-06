From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 07/12] Add support for "import" helper command
Date: Fri,  6 Nov 2009 23:52:41 +0100
Message-ID: <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6XiB-00008E-IT
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbZKFWyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbZKFWyF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:54:05 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37835 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZKFWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:35 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so1557922ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nIsDaum+mTPioPfcAmAUZWpUE58BKY/dfUxqIwoiOKc=;
        b=nbE1zKs31amVQpTjqfsWIZC6MsNdqvT6t7n01kzIbNyYMO9FSmI8X9Nj0c+eUxijVy
         Fv9pNZsqW+BX2NRPCzBvdHfFUIpmM/l0YnP+g7q7wtpSzxobWlp7o49dnTsJW33nB16A
         HayfKYH0AwjFQJCnmT6/rHcm2NpgvyemnsJnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rbbhlv0jE72i/O6rZuBTBLFI95a2EhC84/iVNyL2rmmqTFplRYleAU/rT0p3tbtsbi
         d5Jur8xdv6bcTgwAl0fQj3qzP3j6b7NE8Nv5UuGvv3xjyIduqwyjdUPMt9dlVkYtSy7X
         QXROyBFawxBnC28C8On2/2hHtWc0LBQrOgdl4=
Received: by 10.213.57.65 with SMTP id b1mr5373151ebh.24.1257548020920;
        Fri, 06 Nov 2009 14:53:40 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:40 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132338>

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
1.6.5.2.158.g6dacb
