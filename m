Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FAC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FDB20801
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rrvZ4fcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSRc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:32:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55700 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSRc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:32:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 823F8C456A;
        Wed, 19 Feb 2020 12:32:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oVtRLqVru8lWrim4ZzrkqvrPFAo=; b=rrvZ4f
        cPVxZIzlDCjIhkvglf4N2d9iiwMRymC9L9MU8kOkGIk5mC1sxMdk7Q74C/l2syDu
        sd/7e7rNZ7JI080Cx/h49QjvtKcnOGEPQdXsdU6uYj01odD0nC0iasFR9VfumccA
        iWu6YxIGlzHmAu+wXCCe7eDSy39PLtU1pv0tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Akk1/7j8klcX80T4YWwVaswDSG4V/gB0
        2n8ZxufcmHVhhtCJ1Cx7U3rQTvr9BG/ByQsQfNlOOFEwP3/sm2deJmH1Q2JUBNyv
        PKp5vgfJwhRncs2i2F8iUtrEvQ5NE8h/KX6eUc9R12DA5DBfhzwonT2I7LEpVGR6
        9vKbDdO251w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B689C4569;
        Wed, 19 Feb 2020 12:32:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55E14C4568;
        Wed, 19 Feb 2020 12:32:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 1/5] lib-log-graph.sh: consolidate test_cmp_graph logic
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <xmqqk14mm61r.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 19 Feb 2020 09:32:50 -0800
In-Reply-To: <xmqqk14mm61r.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 16 Feb 2020 16:05:52 -0800")
Message-ID: <xmqqh7zmfpod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB2F526C-533D-11EA-970B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is what I said in the message I am responding to in the patch
form.

 t/lib-log-graph.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index 999f2600de..bc70f01e84 100644
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -1,6 +1,12 @@
 # Helpers shared by the test scripts for comparing log graphs.
 
-sanitize_output() {
+sanitize_output () {
+	# Versions of Git that predate 7f814632 ("Use correct grammar
+	# in diffstat summary line", 2012-02-01) did not correctly use
+	# singular when one path was involved, and a handful of rules
+	# were added to work with both older and newer versions of Git
+	# back then.  These are probably not relevant anymore, and
+	# we'd want to lose them someday...
 	sed -e 's/ *$//' \
 	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
 	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
@@ -15,25 +21,25 @@ sanitize_output() {
 }
 
 # Assume expected graph is in file `expect`
-test_cmp_graph_file() {
+test_cmp_graph_file () {
 	git log --graph "$@" >output &&
-	sanitize_output >output.trimmed <output &&
-	test_i18ncmp expect output.trimmed
+	sanitize_output >output.sanitized <output &&
+	test_i18ncmp expect output.sanitized
 }
 
-test_cmp_graph() {
+test_cmp_graph () {
 	cat >expect &&
 	test_cmp_graph_file "$@"
 }
 
 # Assume expected graph is in file `expect.colors`
-test_cmp_colored_graph_file() {
+test_cmp_colored_graph_file () {
 	git log --graph --color=always "$@" >output.colors.raw &&
 	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
 	test_cmp expect.colors output.colors
 }
 
-test_cmp_colored_graph() {
+test_cmp_colored_graph () {
 	cat >expect.colors &&
 	test_cmp_colored_graph_file "$@"
 }
-- 
2.25.1-440-g39558b81cc

