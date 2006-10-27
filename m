X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] index-pack: minor fixes to comment and function name
Date: Fri, 27 Oct 2006 16:14:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610271609310.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 20:20:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30345>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdY60-0007fr-Dj for gcvg-git@gmane.org; Fri, 27 Oct
 2006 22:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752441AbWJ0UOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 16:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWJ0UOZ
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 16:14:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21430 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752441AbWJ0UOY
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 16:14:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7T0097Y9JZV0L0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 27 Oct 2006 16:14:23 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Use proper english. Be more exact in one comment.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/index-pack.c b/index-pack.c
index 5c747a6..3a389c1 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -324,8 +324,8 @@ static int find_delta(const union delta_
         return -first-1;
 }
 
-static int find_delta_childs(const union delta_base *base,
-			     int *first_index, int *last_index)
+static int find_delta_children(const union delta_base *base,
+			       int *first_index, int *last_index)
 {
 	int first = find_delta(base);
 	int last = first;
@@ -389,7 +389,7 @@ static void resolve_delta(struct object_
 	nr_resolved_deltas++;
 
 	hashcpy(delta_base.sha1, delta_obj->sha1);
-	if (!find_delta_childs(&delta_base, &first, &last)) {
+	if (!find_delta_children(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_REF_DELTA)
@@ -399,7 +399,7 @@ static void resolve_delta(struct object_
 
 	memset(&delta_base, 0, sizeof(delta_base));
 	delta_base.offset = delta_obj->offset;
-	if (!find_delta_childs(&delta_base, &first, &last)) {
+	if (!find_delta_children(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
 			if (child->real_type == OBJ_OFS_DELTA)
@@ -429,7 +429,7 @@ static void parse_pack_objects(unsigned
 	 * First pass:
 	 * - find locations of all objects;
 	 * - calculate SHA1 of all non-delta objects;
-	 * - remember base SHA1 for all deltas.
+	 * - remember base (SHA1 or offset) for all deltas.
 	 */
 	if (verbose)
 		fprintf(stderr, "Indexing %d objects.\n", nr_objects);
@@ -489,10 +489,10 @@ static void parse_pack_objects(unsigned
 		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA)
 			continue;
 		hashcpy(base.sha1, obj->sha1);
-		ref = !find_delta_childs(&base, &ref_first, &ref_last);
+		ref = !find_delta_children(&base, &ref_first, &ref_last);
 		memset(&base, 0, sizeof(base));
 		base.offset = obj->offset;
-		ofs = !find_delta_childs(&base, &ofs_first, &ofs_last);
+		ofs = !find_delta_children(&base, &ofs_first, &ofs_last);
 		if (!ref && !ofs)
 			continue;
 		data = get_data_from_pack(obj);
@@ -615,7 +615,7 @@ static void fix_unresolved_deltas(int nr
 		else die("base object %s is of type '%s'",
 			 sha1_to_hex(d->base.sha1), type);
 
-		find_delta_childs(&d->base, &first, &last);
+		find_delta_children(&d->base, &first, &last);
 		for (j = first; j <= last; j++) {
 			struct object_entry *child = objects + deltas[j].obj_no;
