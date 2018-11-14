Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461181F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeKNK1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38482 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731048AbeKNK1F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0IbQt024221;
        Tue, 13 Nov 2018 16:26:03 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by051r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Nov 2018 16:26:02 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 13 Nov 2018 16:25:55 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 13 Nov 2018 16:25:55 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id EA3FA2212286;
        Tue, 13 Nov 2018 16:26:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 00/11] fast export and import fixes and features
Date:   Tue, 13 Nov 2018 16:25:49 -0800
Message-ID: <20181114002600.29233-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g2b8e4a4f82.dirty
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of small fixes and features for fast-export and
fast-import, mostly on the fast-export side.

Changes since v1 (full range-diff below):
  - used {tilde} in asciidoc documentation to avoid subscripting and
    escaping problems
  - renamed ABORT/ERROR enum values to help avoid further misusage
  - multiple small testcase cleanups (use $ZERO_OID, remove grep -A, etc.)
  - add FIXME comment to code about string_list usage
  - record Peff's idea for a future optimization in patch 8 commit message
    (is there a better place to put that??)
  - New patch (9/11): remove the unmaintained copy of fast-import stream
    format documentation at the beginning of fast-import.c
  - Rewrite commit message for 10/11 to match the wording Peff liked
    better, s/originally/original-oid/, and add documentation to
    git-fast-import.txt
  - Rewrite commit message for 11/11; the last one didn't make sense to
    Peff.  I hope this one does.

Elijah Newren (11):
  git-fast-import.txt: fix documentation for --quiet option
  git-fast-export.txt: clarify misleading documentation about rev-list
    args
  fast-export: use value from correct enum
  fast-export: avoid dying when filtering by paths and old tags exist
  fast-export: move commit rewriting logic into a function for reuse
  fast-export: when using paths, avoid corrupt stream with non-existent
    mark
  fast-export: ensure we export requested refs
  fast-export: add --reference-excluded-parents option
  fast-import: remove unmaintained duplicate documentation
  fast-export: add a --show-original-ids option to show original names
  fast-export: add --always-show-modify-after-rename

 Documentation/git-fast-export.txt |  34 +++++-
 Documentation/git-fast-import.txt |  23 +++-
 builtin/fast-export.c             | 172 ++++++++++++++++++++++--------
 fast-import.c                     | 166 +++-------------------------
 t/t9350-fast-export.sh            | 116 +++++++++++++++++++-
 5 files changed, 308 insertions(+), 203 deletions(-)

 1:  0744f65b0d =  1:  8870fb1340 git-fast-import.txt: fix documentation for --quiet option
 2:  aba1e22fdd !  2:  16d1c3e22d git-fast-export.txt: clarify misleading documentation about rev-list args
    @@ -13,7 +13,7 @@
      	current master reference to be exported along with all objects
     -	added since its 10th ancestor commit.
     +	added since its 10th ancestor commit and all files common to
    -+	master\~9 and master~10.
    ++	master{tilde}9 and master{tilde}10.
      
      EXAMPLES
      --------
 3:  6983e845b2 <  -:  ---------- fast-export: use value from correct enum
 -:  ---------- >  3:  e19f6b36f9 fast-export: use value from correct enum
 4:  761ba324d5 !  4:  2b305561d5 fast-export: avoid dying when filtering by paths and old tags exist
    @@ -49,18 +49,14 @@
     +	(
     +		cd rewrite_tag_predating_pathspecs &&
     +
    -+		touch ignored &&
    -+		git add ignored &&
     +		test_commit initial &&
     +
     +		git tag -a -m "Some old tag" v0.0.0.0.0.0.1 &&
     +
    -+		echo foo >bar &&
    -+		git add bar &&
    -+		test_commit add-bar &&
    ++		test_commit bar &&
     +
    -+		git fast-export --tag-of-filtered-object=rewrite --all -- bar >output &&
    -+		grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}
    ++		git fast-export --tag-of-filtered-object=rewrite --all -- bar.t >output &&
    ++		grep from.$ZERO_OID output
     +	)
     +'
     +
 5:  64e9f0d360 =  5:  607b1dc2b2 fast-export: move commit rewriting logic into a function for reuse
 6:  fd14d9749a !  6:  ec1862e858 fast-export: when using paths, avoid corrupt stream with non-existent mark
    @@ -54,22 +54,18 @@
     +	(
     +		cd avoid_non_existent_mark &&
     +
    -+		touch important-path &&
    -+		git add important-path &&
    -+		test_commit initial &&
    ++		test_commit important-path &&
     +
    -+		touch ignored &&
    -+		git add ignored &&
    -+		test_commit whatever &&
    ++		test_commit ignored &&
     +
     +		git branch A &&
     +		git branch B &&
     +
    -+		echo foo >>important-path &&
    -+		git add important-path &&
    ++		echo foo >>important-path.t &&
    ++		git add important-path.t &&
     +		test_commit more changes &&
     +
    -+		git fast-export --all -- important-path | git fast-import --force
    ++		git fast-export --all -- important-path.t | git fast-import --force
     +	)
     +'
     +
 7:  4e67a2bc7f !  7:  9da26e3ccb fast-export: ensure we export requested refs
    @@ -21,9 +21,6 @@
         were just silently omitted from being exported despite having been
         explicitly requested for export.
     
    -    NOTE: The usage of string_list should really be replaced with the
    -    strmap proposal, once it materializes.
    -
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      diff --git a/builtin/fast-export.c b/builtin/fast-export.c
    @@ -41,6 +38,12 @@
      			export_blob(&diff_queued_diff.queue[i]->two->oid);
      
      	refname = *revision_sources_at(&revision_sources, commit);
    ++	/*
    ++	 * FIXME: string_list_remove() below for each ref is overall
    ++	 * O(N^2).  Compared to a history walk and diffing trees, this is
    ++	 * just lost in the noise in practice.  However, theoretically a
    ++	 * repo may have enough refs for this to become slow.
    ++	 */
     +	string_list_remove(&extra_refs, refname, 0);
      	if (anonymize) {
      		refname = anonymize_refname(refname);
 8:  be02337f29 !  8:  7e5fe2f02e fast-export: add --reference-excluded-parents option
    @@ -30,6 +30,15 @@
         repository which already contains the necessary commits (much like the
         restriction imposed when using --no-data).
     
    +    Note from Peff:
    +      I think we might be able to do a little more optimization here. If
    +      we're exporting HEAD^..HEAD and there's an object in HEAD^ which is
    +      unchanged in HEAD, I think we'd still print it (because it would not
    +      be marked SHOWN), but we could omit it (by walking the tree of the
    +      boundary commits and marking them shown).  I don't think it's a
    +      blocker for what you're doing here, but just a possible future
    +      optimization.
    +
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
    @@ -41,14 +50,15 @@
      
     +--reference-excluded-parents::
     +	By default, running a command such as `git fast-export
    -+	master~5..master` will not include the commit master\~5 and
    -+	will make master\~4 no longer have master\~5 as a parent (though
    -+	both the old master\~4 and new master~4 will have all the same
    -+	files).  Use --reference-excluded-parents to instead have the
    -+	the stream refer to commits in the excluded range of history
    -+	by their sha1sum.  Note that the resulting stream can only be
    -+	used by a repository which already contains the necessary
    -+	parent commits.
    ++	master~5..master` will not include the commit master{tilde}5
    ++	and will make master{tilde}4 no longer have master{tilde}5 as
    ++	a parent (though both the old master{tilde}4 and new
    ++	master{tilde}4 will have all the same files).  Use
    ++	--reference-excluded-parents to instead have the the stream
    ++	refer to commits in the excluded range of history by their
    ++	sha1sum.  Note that the resulting stream can only be used by a
    ++	repository which already contains the necessary parent
    ++	commits.
     +
      --refspec::
      	Apply the specified refspec to each ref exported. Multiple of them can
    @@ -58,10 +68,10 @@
      	to export.  For example, `master~10..master` causes the
      	current master reference to be exported along with all objects
     -	added since its 10th ancestor commit and all files common to
    --	master\~9 and master~10.
    +-	master{tilde}9 and master{tilde}10.
     +	added since its 10th ancestor commit and (unless the
     +	--reference-excluded-parents option is specified) all files
    -+	common to master\~9 and master~10.
    ++	common to master{tilde}9 and master{tilde}10.
      
      EXAMPLES
      --------
 -:  ---------- >  9:  14306a8436 fast-import: remove unmaintained duplicate documentation
 9:  7ab314849d ! 10:  72487a61e4 fast-export: add a --show-original-ids option to show original names
    @@ -2,16 +2,24 @@
     
         fast-export: add a --show-original-ids option to show original names
     
    -    Knowing the original names (hashes) of commits, blobs, and tags can
    -    sometimes enable post-filtering that would otherwise be difficult or
    -    impossible.  In particular, the desire to rewrite commit messages which
    -    refer to other prior commits (on top of whatever other filtering is
    -    being done) is very difficult without knowing the original names of each
    -    commit.
    +    Knowing the original names (hashes) of commits can sometimes enable
    +    post-filtering that would otherwise be difficult or impossible.  In
    +    particular, the desire to rewrite commit messages which refer to other
    +    prior commits (on top of whatever other filtering is being done) is
    +    very difficult without knowing the original names of each commit.
    +
    +    In addition, knowing the original names (hashes) of blobs can allow
    +    filtering by blob-id without requiring re-hashing the content of the
    +    blob, and is thus useful as a small optimization.
    +
    +    Once we add original ids for both commits and blobs, we may as well
    +    add them for tags too for completeness.  Perhaps someone will have a
    +    use for them.
     
         This commit teaches a new --show-original-ids option to fast-export
    -    which will make it add a 'originally <hash>' line to blob, commits, and
    -    tags.  It also teaches fast-import to parse (and ignore) such lines.
    +    which will make it add a 'original-oid <hash>' line to blob, commits,
    +    and tags.  It also teaches fast-import to parse (and ignore) such
    +    lines.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -19,12 +27,12 @@
      --- a/Documentation/git-fast-export.txt
      +++ b/Documentation/git-fast-export.txt
     @@
    - 	used by a repository which already contains the necessary
    - 	parent commits.
    + 	repository which already contains the necessary parent
    + 	commits.
      
     +--show-original-ids::
     +	Add an extra directive to the output for commits and blobs,
    -+	`originally <SHA1SUM>`.  While such directives will likely be
    ++	`original-oid <SHA1SUM>`.  While such directives will likely be
     +	ignored by importers such as git-fast-import, it may be useful
     +	for intermediary filters (e.g. for rewriting commit messages
     +	which refer to older commits, or for stripping blobs by id).
    @@ -33,6 +41,54 @@
      	Apply the specified refspec to each ref exported. Multiple of them can
      	be specified.
     
    + diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
    + --- a/Documentation/git-fast-import.txt
    + +++ b/Documentation/git-fast-import.txt
    +@@
    + ....
    + 	'commit' SP <ref> LF
    + 	mark?
    ++	original-oid?
    + 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
    + 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
    + 	data
    +@@
    + to another object simply by reusing the same `<idnum>` in another
    + `mark` command.
    + 
    ++`original-oid`
    ++~~~~~~~~~~~~~~
    ++Provides the name of the object in the original source control system.
    ++fast-import will simply ignore this directive, but filter processes
    ++which operate on and modify the stream before feeding to fast-import
    ++may have uses for this information
    ++
    ++....
    ++	'original-oid' SP <object-identifier> LF
    ++....
    ++
    ++where `<object-identifer>` is any string not containing LF.
    ++
    + `tag`
    + ~~~~~
    + Creates an annotated tag referring to a specific commit.  To create
    +@@
    + ....
    + 	'tag' SP <name> LF
    + 	'from' SP <commit-ish> LF
    ++	original-oid?
    + 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
    + 	data
    + ....
    +@@
    + ....
    + 	'blob' LF
    + 	mark?
    ++	original-oid?
    + 	data
    + ....
    + 
    +
      diff --git a/builtin/fast-export.c b/builtin/fast-export.c
      --- a/builtin/fast-export.c
      +++ b/builtin/fast-export.c
    @@ -51,7 +107,7 @@
     -	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
     +	printf("blob\nmark :%"PRIu32"\n", last_idnum);
     +	if (show_original_ids)
    -+		printf("originally %s\n", oid_to_hex(oid));
    ++		printf("original-oid %s\n", oid_to_hex(oid));
     +	printf("data %lu\n", size);
      	if (size && fwrite(buf, size, 1, stdout) != 1)
      		die_errno("could not write blob '%s'", oid_to_hex(oid));
    @@ -64,7 +120,7 @@
     -	       refname, last_idnum,
     +	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
     +	if (show_original_ids)
    -+		printf("originally %s\n", oid_to_hex(&commit->object.oid));
    ++		printf("original-oid %s\n", oid_to_hex(&commit->object.oid));
     +	printf("%.*s\n%.*s\ndata %u\n%s",
      	       (int)(author_end - author), author,
      	       (int)(committer_end - committer), committer,
    @@ -77,7 +133,7 @@
     -	       name, tagged_mark,
     +	printf("tag %s\nfrom :%d\n", name, tagged_mark);
     +	if (show_original_ids)
    -+		printf("originally %s\n", oid_to_hex(&tag->object.oid));
    ++		printf("original-oid %s\n", oid_to_hex(&tag->object.oid));
     +	printf("%.*s%sdata %d\n%.*s\n",
      	       (int)(tagger_end - tagger), tagger,
      	       tagger == tagger_end ? "" : "\n",
    @@ -96,44 +152,13 @@
      --- a/fast-import.c
      +++ b/fast-import.c
     @@
    - 
    -   new_blob ::= 'blob' lf
    -     mark?
    -+    originally?
    -     file_content;
    -   file_content ::= data;
    - 
    -   new_commit ::= 'commit' sp ref_str lf
    -     mark?
    -+    originally?
    -     ('author' (sp name)? sp '<' email '>' sp when lf)?
    -     'committer' (sp name)? sp '<' email '>' sp when lf
    -     commit_msg
    -@@
    - 
    -   new_tag ::= 'tag' sp tag_str lf
    -     'from' sp commit-ish lf
    -+    originally?
    -     ('tagger' (sp name)? sp '<' email '>' sp when lf)?
    -     tag_msg;
    -   tag_msg ::= data;
    -@@
    -   data ::= (delimited_data | exact_data)
    -     lf?;
    - 
    -+  originally ::= 'originally' sp not_lf+ lf
    -+
    -     # note: delim may be any string but must not contain lf.
    -     # data_line may contain any data but must not be exactly
    -     # delim.
    -@@
      		next_mark = 0;
      }
      
     +static void parse_original_identifier(void)
     +{
     +	const char *v;
    -+	if (skip_prefix(command_buf.buf, "originally ", &v))
    ++	if (skip_prefix(command_buf.buf, "original-oid ", &v))
     +		read_next_command();
     +}
     +
    @@ -160,7 +185,7 @@
      		die("Invalid ref name or SHA1 expression: %s", from);
      	read_next_command();
      
    -+	/* originally ... */
    ++	/* original-oid ... */
     +	parse_original_identifier();
     +
      	/* tagger ... */
    @@ -177,7 +202,7 @@
     +test_expect_success 'fast-export --show-original-ids' '
     +
     +	git fast-export --show-original-ids master >output &&
    -+	grep ^originally output| sed -e s/^originally.// | sort >actual &&
    ++	grep ^original-oid output| sed -e s/^original-oid.// | sort >actual &&
     +	git rev-list --objects master muss >objects-and-names &&
     +	awk "{print \$1}" objects-and-names | sort >commits-trees-blobs &&
     +	comm -23 actual commits-trees-blobs >unfound &&
10:  82735bcbde ! 11:  1796373474 fast-export: add --always-show-modify-after-rename
    @@ -2,29 +2,53 @@
     
         fast-export: add --always-show-modify-after-rename
     
    -    fast-export output is traditionally used as an input to a fast-import
    -    program, but it is also useful to help gather statistics about the
    -    history of a repository (particularly when --no-data is also passed).
    -    For example, two of the types of information we may want to collect
    -    could include:
    -      1) general information about renames that have occurred
    -      2) what the biggest objects in a repository are and what names
    -         they appear under.
    +    I wanted a way to gather all the following information efficiently
    +    (with as few history traversals as possible):
    +      * Get all blob sizes
    +      * Map blob shas to filename(s) they appeared under in the history
    +      * Find when files and directories were deleted (and whether they
    +        were later reinstated, since that means they aren't actually gone)
    +      * Find sets of filenames referring to the same logical 'file'. (e.g.
    +        foo->bar in commit A and bar->baz in commit B mean that
    +        {foo,bar,baz} refer to the same 'file', so someone wanting to just
    +        "keep baz and its history" need all versions of those three
    +        filenames).  I need to know about things like another foo or bar
    +        being introduced after the rename though, since that breaks the
    +        connection between filenames)
    +    and then I would generate various aggregations on the data and display
    +    some type of report for the user.
     
    -    The first bit of information can be gathered by just passing -M to
    -    fast-export.  The second piece of information can partially be gotten
    -    from running
    -        git cat-file --batch-check --batch-all-objects
    -    However, that only shows what the biggest objects in the repository are
    -    and their sizes, not what names those objects appear as or what commits
    -    they were introduced in.  We can get that information from fast-export,
    -    but when we only see
    +    The only way I know of to get blob sizes is via
    +      cat-file --batch-all-objects --batch-check
    +
    +    The rest of the data would traditionally be gathered from a log command,
    +    e.g.
    +
    +      git log --format='%H%n%P%n%cd' --date=short --topo-order --reverse \
    +          -M --diff-filter=RAMD --no-abbrev --raw -c
    +
    +    however, parsing log output seems slightly dangerous given that it is a
    +    porcelain command.  While we have specified --format and --raw to try
    +    to avoid the most obvious problems, I'm still slightly concerned about
    +    --date=short, the combinations of --raw and -c, options that might
    +    colorize the output, and also the --diff-filter (there is no current
    +    option named --no-find-copies or --no-break-rewrites, but what if those
    +    turn on by default in the future much as we changed the default with
    +    detecting renames?).  Each of those is a small worry, but they add up.
    +
    +    A command meant for data serialization, such as fast-export, seems like
    +    a better candidate for this job.  There's just one missing item: in
    +    order to connect blob sizes to filenames, I need fast-export to tell me
    +    the blob sha1sum of any file changes.  It does this for modifies, but
    +    not always for renames.  In particular, if a file is a 100% rename, it
    +    only prints
             R oldname newname
         instead of
             R oldname newname
             M 100644 $SHA1 newname
    -    then it makes the job more difficult.  Add an option which allows us to
    -    force the latter output even when commits have exact renames of files.
    +    as occurs when there is a rename+modify.  Add an option which allows us
    +    to force the latter output even when commits have exact renames of
    +    files.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>

-- 
2.19.1.1063.g2b8e4a4f82.dirty
