From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/6] Fix some "printf format" warnings.
Date: Sat, 03 Mar 2007 18:28:22 +0000
Message-ID: <45E9BE46.1020801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 20:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZp3-0005rU-71
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 20:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbXCCTWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 14:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbXCCTWz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 14:22:55 -0500
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:50344 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030386AbXCCTWy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 14:22:54 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2646 "EHLO
	anchor-post-31.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S478745AbXCCS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 18:28:32 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYxz-000BrS-60; Sat, 03 Mar 2007 18:28:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41316>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

It's interesting to note that all of the warnings are caused by mismatching
parameter expression involving a call to ntohl().
[OK, it wasn't that interesting ;-)]

  builtin-ls-files.c       |    2 +-
  builtin-unpack-objects.c |    2 +-
  fetch-pack.c             |    2 +-
  index-pack.c             |    2 +-
  merge-index.c            |    2 +-
  read-cache.c             |    2 +-
  receive-pack.c           |    2 +-
  sha1_file.c              |    4 ++--
  unpack-trees.c           |    2 +-
  9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ac89eb2..5c990a5 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -193,7 +193,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
  		putchar(line_terminator);
  	}
  	else {
-		printf("%s%06o %s %d\t",
+		printf("%s%06lo %s %d\t",
  		       tag,
  		       ntohl(ce->ce_mode),
  		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index d351e02..d31d995 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -333,7 +333,7 @@ static void unpack_all(void)
  	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
  		die("bad pack file");
  	if (!pack_version_ok(hdr->hdr_version))
-		die("unknown pack file version %d", ntohl(hdr->hdr_version));
+		die("unknown pack file version %ld", ntohl(hdr->hdr_version));
  	fprintf(stderr, "Unpacking %d objects\n", nr_objects);

  	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
diff --git a/fetch-pack.c b/fetch-pack.c
index c787106..9d86ec3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -510,7 +510,7 @@ static int get_pack(int xd[2])

  		if (read_pack_header(fd[0], &header))
  			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+		snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%lu,%lu",
  			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
  		if (ntohl(header.hdr_entries) < unpack_limit)
  			do_keep = 0;
diff --git a/index-pack.c b/index-pack.c
index 72e0962..01104cb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -167,7 +167,7 @@ static void parse_pack_header(void)
  	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
  		die("pack signature mismatch");
  	if (!pack_version_ok(hdr->hdr_version))
-		die("pack version %d unsupported", ntohl(hdr->hdr_version));
+		die("pack version %ld unsupported", ntohl(hdr->hdr_version));

  	nr_objects = ntohl(hdr->hdr_entries);
  	use(sizeof(struct pack_header));
diff --git a/merge-index.c b/merge-index.c
index a9983dd..2d3cac3 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -60,7 +60,7 @@ static int merge_entry(int pos, const char *path)
  			break;
  		found++;
  		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
-		sprintf(ownbuf[stage], "%o", ntohl(ce->ce_mode) & (~S_IFMT));
+		sprintf(ownbuf[stage], "%lo", ntohl(ce->ce_mode) & (~S_IFMT));
  		arguments[stage] = hexbuf[stage];
  		arguments[stage + 4] = ownbuf[stage];
  	} while (++pos < active_nr);
diff --git a/read-cache.c b/read-cache.c
index c54a611..6d46dcd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -128,7 +128,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
  		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
  		break;
  	default:
-		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
+		die("internal error: ce_mode is %lo", ntohl(ce->ce_mode));
  	}
  	if (ce->ce_mtime.sec != htonl(st->st_mtime))
  		changed |= MTIME_CHANGED;
diff --git a/receive-pack.c b/receive-pack.c
index 7311c82..9e83371 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -282,7 +282,7 @@ static const char *unpack(void)
  	hdr_err = parse_pack_header(&hdr);
  	if (hdr_err)
  		return hdr_err;
-	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%lu,%lu",
  			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));

  	if (ntohl(hdr.hdr_entries) < unpack_limit) {
diff --git a/sha1_file.c b/sha1_file.c
index 8ad7fad..80abd10 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -592,13 +592,13 @@ static int open_packed_git_1(struct packed_git *p)
  	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
  		return error("file %s is not a GIT packfile", p->pack_name);
  	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %u and not supported"
+		return error("packfile %s is version %lu and not supported"
  			" (try upgrading GIT to a newer version)",
  			p->pack_name, ntohl(hdr.hdr_version));

  	/* Verify the pack matches its index. */
  	if (num_packed_objects(p) != ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %u objects"
+		return error("packfile %s claims to have %lu objects"
  			" while index size indicates %u objects",
  			p->pack_name, ntohl(hdr.hdr_entries),
  			num_packed_objects(p));
diff --git a/unpack-trees.c b/unpack-trees.c
index 2e2232c..0d1d8e7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -539,7 +539,7 @@ static void show_stage_entry(FILE *o,
  	if (!ce)
  		fprintf(o, "%s (missing)\n", label);
  	else
-		fprintf(o, "%s%06o %s %d\t%s\n",
+		fprintf(o, "%s%06lo %s %d\t%s\n",
  			label,
  			ntohl(ce->ce_mode),
  			sha1_to_hex(ce->sha1),
-- 
1.5.0
