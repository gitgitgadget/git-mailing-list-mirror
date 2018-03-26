Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783351F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCZMnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:43:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62411 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751903AbeCZMnM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Mar 2018 08:43:12 -0400
X-AuditID: 12074413-16bff70000000195-21-5ab8eadf9946
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.54.00405.FDAE8BA5; Mon, 26 Mar 2018 08:43:11 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCABB.dip0.t-ipconnect.de [87.188.202.187])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w2QCh5bR029836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Mar 2018 08:43:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 1/1] packed-backend: ignore broken headers
Date:   Mon, 26 Mar 2018 14:42:59 +0200
Message-Id: <fca2318b35cfd19f8fa2278919306ba4c6475382.1522062649.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cover.1522062649.git.mhagger@alum.mit.edu>
References: <cover.1522062649.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqHv/1Y4og1snlCy6rnQzWTT0XmG2
        uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUVw2Kak5mWWpRfp2CVwZ3S9WMBbc
        U644t/84awPjKtkuRk4OCQETicMLH7F1MXJxCAnsYJLYvHoxC4RziUni8KsWFpAqNgFdiUU9
        zUwgtoiAmsTEtkNgcWaBFImO592MILawgIXE6j3/wWwWAVWJs1Mngdm8AlES1268Y4TYJi/x
        fsF9MJsTqP7rr8+sILaQgLnEvp59TBD1ghInZz4Bms8BNF9dYv08IYhV8hLNW2czT2Dkn4Wk
        ahZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISs8A7GXSfl
        DjEKcDAq8fBKMO2IEmJNLCuuzD3EKMnBpCTKa3YQKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
        l28+UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG74yVQo2BRanpq
        RVpmTglCmomDE2Q4D9DwKSA1vMUFibnFmekQ+VOMuhw3XrxuYxZiycvPS5US5739AqhIAKQo
        ozQPbg4s1bxiFAd6S5h3M8goHmCagpv0CmgJE9CSbU1gS0oSEVJSDYw+5n4fX5vHlfCE878/
        axC9aHF1bE1mN2epkc+6zrm/c9yNzx/MjIpckc6hyX7mccWlSMUmp/MTw/bpd5loWPvWejyI
        2bPiYWPMgb17bDkNpoQtfPnfuly8999OBZm0lxNN7jnOvJ3YfvfmPaEph+70xwrHv49da6Bx
        +u9M96nb25Imfz1md0OJpTgj0VCLuag4EQCLm1lGEAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to

    9308b7f3ca read_packed_refs(): die if `packed-refs` contains bogus data, 2017-07-01

we silently ignored any lines in a `packed-refs` file that we didn't
understand. That policy was clearly wrong.

But at the time, unrecognized header lines were processed by the same
code as reference and peeled lines. This means that they were also
subject to the same liberal treatment. For example, any of the
following "header" lines would have been ignored:

* "# arbitrary data that looks like a comment"
* "# pack-refs with peeled fully-peeled" ← note: missing colon
* "# pack-refs"

Loosen up the parser to ignore any first line that begins with `#` but
doesn't start with the exact character sequence "# pack-refs with:".

(In fact, the old liberal policy meant that "comment" lines would have
been ignored anywhere in the file. But the file format isn't actually
documented to allow comments, and comments make little sense in this
file, so we won't go that far.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I *don't* think we actually want to merge this patch. See the cover
letter for my reasoning.

 refs/packed-backend.c | 21 +++++++++------------
 t/t3210-pack-refs.sh  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 65288c6472..f9d71bb60d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -635,21 +635,18 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
-			die_invalid_line(refs->path,
-					 snapshot->buf,
-					 snapshot->eof - snapshot->buf);
+		if (skip_prefix(tmp, "# pack-refs with:", (const char **)&p)) {
+			string_list_split_in_place(&traits, p, ' ', -1);
 
-		string_list_split_in_place(&traits, p, ' ', -1);
+			if (unsorted_string_list_has_string(&traits, "fully-peeled"))
+				snapshot->peeled = PEELED_FULLY;
+			else if (unsorted_string_list_has_string(&traits, "peeled"))
+				snapshot->peeled = PEELED_TAGS;
 
-		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
-			snapshot->peeled = PEELED_FULLY;
-		else if (unsorted_string_list_has_string(&traits, "peeled"))
-			snapshot->peeled = PEELED_TAGS;
+			sorted = unsorted_string_list_has_string(&traits, "sorted");
 
-		sorted = unsorted_string_list_has_string(&traits, "sorted");
-
-		/* perhaps other traits later as well */
+			/* perhaps other traits later as well */
+		}
 
 		/* The "+ 1" is for the LF character. */
 		snapshot->start = eol + 1;
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index afa27ffe2d..353ef3e655 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -20,7 +20,8 @@ test_expect_success \
     'echo Hello > A &&
      git update-index --add A &&
      git commit -m "Initial commit." &&
-     HEAD=$(git rev-parse --verify HEAD)'
+     HEAD=$(git rev-parse --verify HEAD) &&
+     git tag -m "A tag" annotated-tag'
 
 SHA1=
 
@@ -221,6 +222,36 @@ test_expect_success 'reject packed-refs with a short SHA-1' '
 	test_cmp expected_err err
 '
 
+test_expect_success 'handle packed-refs with a bogus header' '
+	git show-ref -d >expected &&
+	mv .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	sed -e "s/^#.*/# whacked-refs/" <.git/packed-refs.bak >.git/packed-refs &&
+	git show-ref -d >actual 2>err &&
+	test_cmp expected actual &&
+	test_must_be_empty err
+'
+
+test_expect_success 'handle packed-refs with a truncated header' '
+	git show-ref -d >expected &&
+	mv .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	sed -e "s/^#.*/# pack-refs/" <.git/packed-refs.bak >.git/packed-refs &&
+	git show-ref -d >actual 2>err &&
+	test_cmp expected actual &&
+	test_must_be_empty err
+'
+
+test_expect_success 'handle packed-refs with no traits in header' '
+	git show-ref -d >expected &&
+	mv .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	sed -e "s/^#.*/# pack-refs with:/" <.git/packed-refs.bak >.git/packed-refs &&
+	git show-ref -d >actual 2>err &&
+	test_cmp expected actual &&
+	test_must_be_empty err
+'
+
 test_expect_success 'timeout if packed-refs.lock exists' '
 	LOCK=.git/packed-refs.lock &&
 	>"$LOCK" &&
-- 
2.14.2

