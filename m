From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] diff --stat: use "file" temporary variable to refer to
 data->files[i]
Date: Tue, 27 Nov 2012 13:21:48 -0800
Message-ID: <1354051310-29093-4-git-send-email-gitster@pobox.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSbj-00027f-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab2K0VWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:22:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756498Ab2K0VV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:21:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C08A93D6;
	Tue, 27 Nov 2012 16:21:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hkb1
	czpoXQCkYEWrpKQnL5EZkgw=; b=nyjlXm3j0akMsgnMGYYtbOZWP1vyficH8gLc
	EfRfA/eR9e+btb4warL6ZOliKjs+c7L/fVGUU9Pf7QK9YrfGVtgS//4YunHxSSpU
	K/R5kPOgDT5VDGbTbOMd9CWKik0iY5pQen4i1LvdG+Lw/vvQTIlEpBK7m6wdc3MU
	K4/CTZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lFMq640dI8JOSSsG6Ihdh722pCUbkLYXaMKqEalnDmeIa84p+ZiV4YImAPQrb5Of
	edBBgkX9HfMYI0HvTGSLQOxJF89pn2fQFy0vkgSxsopSWNyLZyMlN4dP67ZpmAED
	Oseb5ZwCGcf6w2fk3n6Oxmn7C0aqhSLxFqHkSazVdF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AF593D5;
	Tue, 27 Nov 2012 16:21:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C053D93D4; Tue, 27 Nov 2012
 16:21:57 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 798DA54A-38D8-11E2-B2FC-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210603>

The generated code shouldn't change but it is easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index ce6baa4..e4e70e5 100644
--- a/diff.c
+++ b/diff.c
@@ -1470,8 +1470,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; (i < count) && (i < data->nr); i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
-		if (!data->files[i]->is_interesting &&
-			 (change == 0)) {
+
+		if (!file->is_interesting && (change == 0)) {
 			count++; /* not shown == room for one more */
 			continue;
 		}
@@ -1586,13 +1586,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 	for (i = 0; i < count; i++) {
 		const char *prefix = "";
-		char *name = data->files[i]->print_name;
-		uintmax_t added = data->files[i]->added;
-		uintmax_t deleted = data->files[i]->deleted;
+		struct diffstat_file *file = data->files[i];
+		char *name = file->print_name;
+		uintmax_t added = file->added;
+		uintmax_t deleted = file->deleted;
 		int name_len;
 
-		if (!data->files[i]->is_interesting &&
-			 (added + deleted == 0)) {
+		if (!file->is_interesting && (added + deleted == 0)) {
 			total_files--;
 			continue;
 		}
@@ -1611,7 +1611,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				name = slash;
 		}
 
-		if (data->files[i]->is_binary) {
+		if (file->is_binary) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, " %*s", number_width, "Bin");
@@ -1628,7 +1628,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			fprintf(options->file, "\n");
 			continue;
 		}
-		else if (data->files[i]->is_unmerged) {
+		else if (file->is_unmerged) {
 			fprintf(options->file, "%s", line_prefix);
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, " Unmerged\n");
@@ -1668,10 +1668,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		fprintf(options->file, "\n");
 	}
 	for (i = count; i < data->nr; i++) {
-		uintmax_t added = data->files[i]->added;
-		uintmax_t deleted = data->files[i]->deleted;
-		if (!data->files[i]->is_interesting &&
-			 (added + deleted == 0)) {
+		struct diffstat_file *file = data->files[i];
+		uintmax_t added = file->added;
+		uintmax_t deleted = file->deleted;
+		if (!file->is_interesting && (added + deleted == 0)) {
 			total_files--;
 			continue;
 		}
-- 
1.8.0.1.331.g808d2af
