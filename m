From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH 2/2] moved some variables into narrower scopes
Date: Sat, 7 Mar 2009 21:02:26 +0100
Message-ID: <7f978c810903071202p18c4f8fjbddc0176b80c76b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2kX-00053W-AU
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZCGUCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbZCGUCa
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:02:30 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:60274 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZCGUC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:02:29 -0500
Received: by fxm24 with SMTP id 24so774946fxm.37
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3e3+tKvAZSaG6EOYZzg5nfjR3jePuY1AkbXF5V3p9pE=;
        b=GvHlBnqJ5ASJThmCXg7n1Ag/yGrjGXUz7uOwDfryXRuYi2ZSQATCOkxpe/0OpNH+Cm
         vDMjUKcWJTYUb/kptZJBDmROq5uLZ586TZ8z22Nx334wHWckGVM6DAI1Ac43fiGoLYa0
         N46QGdfprTIA6GyN5iKD6Ig/7MNjv+bQflm5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WfH6JM9tqn4r4QRFUmonlt6u7gEmfLRxaRmcmdWa+EyLopU46sHov88xZ434uaqnE/
         Fi1SPCBskCFSls3Rynp7YM533Kogk7GpPGBRPqNx4/5vvuAfuxWpabX97JL8Bzm8R4rM
         F4HdwdwubtRUT2+7+CenWhFdmvkZmu50Jut9I=
Received: by 10.103.24.11 with SMTP id b11mr1731953muj.76.1236456146239; Sat, 
	07 Mar 2009 12:02:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112573>

they weren't used outside and can be safely moved

builtin-fmt-merge-msg: moved variable to narrower scope
combine-diff: moved variable to narrower scope
log-tree: moved variable to narrower scope
upload-pack: moved variable to narrower scope
upload-pack: removed unused assignment

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 builtin-fmt-merge-msg.c |    5 ++---
 combine-diff.c          |    3 +--
 log-tree.c              |    6 +++---
 upload-pack.c           |    5 ++---
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index df18f40..5c5b310 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -257,7 +257,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 	int limit = 20, i = 0, pos = 0;
 	char line[1024];
-	char *p = line, *sep = "";
+	char *sep = "";
 	unsigned char head_sha1[20];
 	const char *current_branch;

@@ -271,9 +271,8 @@ int fmt_merge_msg(int merge_summary, struct strbuf
*in, struct strbuf *out) {
 	/* get a line */
 	while (pos < in->len) {
 		int len;
-		char *newline;
+		char *newline, *p = in->buf + pos;

-		p = in->buf + pos;
 		newline = strchr(p, '\n');
 		len = newline ? newline - p : strlen(p);
 		pos += len + !!newline;
diff --git a/combine-diff.c b/combine-diff.c
index bccc018..b3b86ae 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -526,7 +526,6 @@ static void dump_sline(struct sline *sline,
unsigned long cnt, int num_parent,
 		return; /* result deleted */

 	while (1) {
-		struct sline *sl = &sline[lno];
 		unsigned long hunk_end;
 		unsigned long rlines;
 		const char *hunk_comment = NULL;
@@ -592,7 +591,7 @@ static void dump_sline(struct sline *sline,
unsigned long cnt, int num_parent,
 			struct lline *ll;
 			int j;
 			unsigned long p_mask;
-			sl = &sline[lno++];
+			struct sline *sl = &sline[lno++];
 			ll = (sl->flag & no_pre_delete) ? NULL : sl->lost_head;
 			while (ll) {
 				fputs(c_old, stdout);
diff --git a/log-tree.c b/log-tree.c
index 84a74e5..63cff74 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -79,18 +79,18 @@ void show_decorations(struct rev_info *opt, struct
commit *commit)
  */
 static int detect_any_signoff(char *letter, int size)
 {
-	char ch, *cp;
+	char *cp;
 	int seen_colon = 0;
 	int seen_at = 0;
 	int seen_name = 0;
 	int seen_head = 0;

 	cp = letter + size;
-	while (letter <= --cp && (ch = *cp) == '\n')
+	while (letter <= --cp && *cp == '\n')
 		continue;

 	while (letter <= cp) {
-		ch = *cp--;
+		char ch = *cp--;
 		if (ch == '\n')
 			break;

diff --git a/upload-pack.c b/upload-pack.c
index e15ebdc..a49d872 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -397,12 +397,11 @@ static int get_common_commits(void)
 	static char line[1000];
 	unsigned char sha1[20];
 	char hex[41], last_hex[41];
-	int len;

 	save_commit_buffer = 0;

 	for(;;) {
-		len = packet_read_line(0, line, sizeof(line));
+		int len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();

 		if (!len) {
@@ -410,7 +409,7 @@ static int get_common_commits(void)
 				packet_write(1, "NAK\n");
 			continue;
 		}
-		len = strip(line, len);
+		strip(line, len);
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-- 
1.6.2.81.ge603.dirty
