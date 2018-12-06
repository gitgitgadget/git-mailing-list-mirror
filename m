Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE3F211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLFUU7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 15:20:59 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43382 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFUU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 15:20:59 -0500
Received: by mail-pl1-f202.google.com with SMTP id g7so1016164plp.10
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=SXZVSLcpYTG8C0oZY2Lz9qFjd3PvKyy9gbgj6/HSZGQ=;
        b=aBh4Rz/dSerTAVhqx0usGOM93/p+jh+t9iqGEGyalnCLhtPt3+EQX/3QOzXvjrCeIl
         VHSxsKVj1uiwdAfH4HZcYP90SugdsKYPt7oOGu5V+daSCLVmRJnQBJpV1zzRg3eMUX2Q
         skjNn3bmh6G/zDN1PU6/C3LAYMRRD7lDAINuKh6rZmnDnpIk6jvZidQ7VPuWzH0sqX28
         Jl+mmTLo0KVDloR/UNsp65nAAjmXkE5ThK6/sYNQgUSKtcyCBwyvNEkDM8TfC/VdZgfJ
         aOsYXtZ+0oBsetOLs6NuKdnUwbISFUhV1bSHc9X7LYbbcRwHVl1A/8gO7pS6GDFr2ggj
         A9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=SXZVSLcpYTG8C0oZY2Lz9qFjd3PvKyy9gbgj6/HSZGQ=;
        b=KZK7TOiArqPDrlZpf3fi4pFwY1PuY+Y+UO3N5rZoNYm4oBI5nKVaf6IVqYlcCzaDmq
         jUtzfXgCyLdIDW96vwFovBmJi5cEOu7OeBMJ1Rnpwp3//jYVrdBxMj2EiHfti3MyEuPy
         jO94Znl0p5sS7fOhtHLh8454z223oTRkN+RPkePO+XFnT+3sCO2oJzPl9D9mYnaP1XDH
         CVLL53jvtW0PIelRv/QrezBLo0BlhvisNtpSo0vqaEqrgo6BlGRtqRyfXShD/ksOcIxc
         cbFKcoubRQKGn5tHpJwVsMnsAVPkJ6nWuzBbUc5yu44EE2+cFQqrV1nMVpYZlFq5jTuV
         ku5g==
X-Gm-Message-State: AA+aEWZd5m+FncsqjWdnK3ZCezDNdqoV4S4K08h1+DHH3vBhM15dLr5k
        3GkUSJVTyfVEL2BKWsdUy+srbqypxDH3/B23hxPN3hnXoeXE7oyO15spSJZeXEg7vhpYdoOAbwe
        NwvlsjKRt+6i+sKqEu6zaoeeLGoepLQVUhyVf+KyIp0mbrR41pKa01fonCYMkZ3g=
X-Google-Smtp-Source: AFSGD/V0SrevYthxmjoGndY2ExgGdRNzAIJxxiy9V23IslcPMSEte2IcQGegCTuAuSCshpVt/qGiOdK1s5Qzrw==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr12365090plr.23.1544127658090;
 Thu, 06 Dec 2018 12:20:58 -0800 (PST)
Date:   Thu,  6 Dec 2018 12:20:52 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <cover.1544127439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 0/3] Add commit-graph fuzzer and fix buffer overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new fuzz test for the commit graph and fix a buffer read-overflow
that it discovered. Additionally, fix the Makefile instructions for
building fuzzers.

Changes since V1:
  * Moved the parse_commit_graph() declaration to the header file, since
    we don't mind if others use it.
  * Moved some unnecessary comments into commit messages.
  * Fixed some style issues.
  * Added a test case for detecting commit graphs with missing chunk
    lookup entries.
  * =C3=86var's comments on the Makefile made me realize the fuzzer build
    instructions were using the wrong variable. Added a new commit to
    fix this.

Josh Steadmon (3):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow
  Makefile: correct example fuzz build

 .gitignore              |  1 +
 Makefile                |  3 +-
 commit-graph.c          | 67 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 ++
 fuzz-commit-graph.c     | 16 ++++++++++
 t/t5318-commit-graph.sh | 28 +++++++++++++++++
 6 files changed, 98 insertions(+), 20 deletions(-)
 create mode 100644 fuzz-commit-graph.c

Range-diff against v1:
1:  53e62baaa8 ! 1:  0b57ecbe1b commit-graph, fuzz: Add fuzzer for commit-g=
raph
    @@ -4,7 +4,9 @@
    =20
         Breaks load_commit_graph_one() into a new function,
         parse_commit_graph(). The latter function operates on arbitrary bu=
ffers,
    -    which makes it suitable as a fuzzing target.
    +    which makes it suitable as a fuzzing target. Since parse_commit_gr=
aph()
    +    is only called by load_commit_graph_one() (and the fuzzer describe=
d
    +    below), we omit error messages that would be duplicated by the cal=
ler.
    =20
         Adds fuzz-commit-graph.c, which provides a fuzzing entry point
         compatible with libFuzzer (and possibly other fuzzing engines).
    @@ -35,17 +37,6 @@
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
    -@@
    - #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WID=
TH \
    - 			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
    -=20
    -+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    -+					size_t graph_size);
    -+
    -+
    - char *get_commit_graph_filename(const char *obj_dir)
    - {
    - 	return xstrfmt("%s/info/commit-graph", obj_dir);
     @@
      struct commit_graph *load_commit_graph_one(const char *graph_file)
      {
    @@ -70,7 +61,7 @@
      	graph_map =3D xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0)=
;
     +	ret =3D parse_commit_graph(graph_map, fd, graph_size);
     +
    -+	if (ret =3D=3D NULL) {
    ++	if (!ret) {
     +		munmap(graph_map, graph_size);
     +		close(fd);
     +		exit(1);
    @@ -79,10 +70,6 @@
     +	return ret;
     +}
     +
    -+/*
    -+ * This function is intended to be used only from load_commit_graph_o=
ne() or in
    -+ * fuzz tests.
    -+ */
     +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
     +					size_t graph_size)
     +{
    @@ -94,11 +81,9 @@
     +	uint32_t graph_signature;
     +	unsigned char graph_version, hash_version;
     +
    -+	/*
    -+	 * This should already be checked in load_commit_graph_one, but we s=
till
    -+	 * need a check here for when we're calling parse_commit_graph direc=
tly
    -+	 * from fuzz tests. We can omit the error message in that case.
    -+	 */
    ++	if (!graph_map)
    ++		return NULL;
    ++
     +	if (graph_size < GRAPH_MIN_SIZE)
     +		return NULL;
     +
    @@ -162,12 +147,25 @@
     =20
      static void prepare_commit_graph_one(struct repository *r, const char=
 *obj_dir)
    =20
    + diff --git a/commit-graph.h b/commit-graph.h
    + --- a/commit-graph.h
    + +++ b/commit-graph.h
    +@@
    +=20
    + struct commit_graph *load_commit_graph_one(const char *graph_file);
    +=20
    ++struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    ++					size_t graph_size);
    ++
    + /*
    +  * Return 1 if and only if the repository has a commit-graph
    +  * file and generation numbers are computed in that file.
    +
      diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
      new file mode 100644
      --- /dev/null
      +++ b/fuzz-commit-graph.c
     @@
    -+#include "object-store.h"
     +#include "commit-graph.h"
     +
     +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    @@ -179,9 +177,8 @@
     +{
     +	struct commit_graph *g;
     +
    -+	g =3D parse_commit_graph((void *) data, -1, size);
    -+	if (g)
    -+		free(g);
    ++	g =3D parse_commit_graph((void *)data, -1, size);
    ++	free(g);
     +
     +	return 0;
     +}
2:  ad2e761f44 ! 2:  af45c2337f commit-graph: fix buffer read-overflow
    @@ -22,7 +22,8 @@
     +		uint64_t chunk_offset;
      		int chunk_repeated =3D 0;
     =20
    -+		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH > data + graph_size) {
    ++		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH >
    ++		    data + graph_size) {
     +			error(_("chunk lookup table entry missing; graph file may be incom=
plete"));
     +			free(graph);
     +			return NULL;
    @@ -34,3 +35,49 @@
      		chunk_lookup +=3D GRAPH_CHUNKLOOKUP_WIDTH;
     =20
      		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
    +
    + diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
    + --- a/t/t5318-commit-graph.sh
    + +++ b/t/t5318-commit-graph.sh
    +@@
    + 	test_i18ngrep "$grepstr" err
    + }
    +=20
    ++
    ++# usage: corrupt_and_zero_graph_then_verify <corrupt_position> <data>=
 <zero_position> <string>
    ++# Manipulates the commit-graph file at <corrupt_position> by insertin=
g the data,
    ++# then zeros the file starting at <zero_position>. Finally, runs
    ++# 'git commit-graph verify' and places the output in the file 'err'. =
Tests 'err'
    ++# for the given string.
    ++corrupt_and_zero_graph_then_verify() {
    ++	corrupt_pos=3D$1
    ++	data=3D"${2:-\0}"
    ++	zero_pos=3D$3
    ++	grepstr=3D$4
    ++	orig_size=3D$(stat --format=3D%s $objdir/info/commit-graph)
    ++	cd "$TRASH_DIRECTORY/full" &&
    ++	test_when_finished mv commit-graph-backup $objdir/info/commit-graph =
&&
    ++	cp $objdir/info/commit-graph commit-graph-backup &&
    ++	printf "$data" | dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"=
$corrupt_pos" conv=3Dnotrunc &&
    ++	truncate --size=3D$zero_pos $objdir/info/commit-graph &&
    ++	truncate --size=3D$orig_size $objdir/info/commit-graph &&
    ++	test_must_fail git commit-graph verify 2>test_err &&
    ++	grep -v "^+" test_err >err &&
    ++	test_i18ngrep "$grepstr" err
    ++}
    ++
    + test_expect_success 'detect bad signature' '
    + 	corrupt_graph_and_verify 0 "\0" \
    + 		"graph signature"
    +@@
    + 		"incorrect checksum"
    + '
    +=20
    ++test_expect_success 'detect truncated graph' '
    ++	corrupt_and_zero_graph_then_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
    ++		$GRAPH_CHUNK_LOOKUP_OFFSET "chunk lookup table entry missing"
    ++'
    ++
    + test_expect_success 'git fsck (checks commit-graph)' '
    + 	cd "$TRASH_DIRECTORY/full" &&
    + 	git fsck &&
-:  ---------- > 3:  7519fc76df Makefile: correct example fuzz build
--=20
2.20.0.rc2.10.g7519fc76df

