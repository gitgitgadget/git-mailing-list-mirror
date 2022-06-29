Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44025C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiF2Uhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiF2Uhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:37:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD73EF0E
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:37:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c137so12973538qkg.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aMjtplQK5CtH4CUndkzHRtu4NksJnUtad3u4iNFCmAo=;
        b=7fGUCUD+2TpYrPyYtJFvzZTUTyxQMjjbhz/0rnbgepajSJYMrXEEVeXgrXEd1umGB0
         Lkts5Qm2DgF2uxatbVgA6RoDaKCXGQEXUGfCB1gmCyWD5JmqXBNoX05hk00wL2dfGefN
         +J8LP5Ov5YSfop4OzbzxUBSdaJJZ68LOhcVNinQ88w6d7H917MsDehVlrUZKq18q1hvc
         jM9ELd4yLe4bOpMjpLbTR3mYf3wcpuxdt/IqOAezOkQBaIe4iosCYxOtO05PgQ+MHiR2
         dPxCzJy/DjhBSjJwhFGa9Xtza7RYeZmydGsmgUX+Se9mYcIZSv8pT2L52MTKlZYXuGmV
         20kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMjtplQK5CtH4CUndkzHRtu4NksJnUtad3u4iNFCmAo=;
        b=oK6cNQ6LN+VwP00uDBDQ7Jo4PoROYWc91/9zCOEOfHgZLIF1SGMjTB/fYS0uj2fJ97
         J1SE8aw4BeKHILi5FVfdaeHWFKr8mDsf3ChWvMqWogf5/Oyo51y8Klkb7eyjALSPjY4w
         WWz7PbSXZatKvD91Z9Bthfsy6Z54NiKDyH+KaJLIE2H0z+svc6cIH0dONX7kBL26lGqo
         uGMkSKXTNNr+vKYV/QZK0beSKx+pexUjmUa+EwShHLKi94/qHEGVe6eEDrRJ4l79quxb
         v9uqE2RY6k5i1PzFrgSxdc4nE+oweweViVJ7Wl/AhQMdGvqJNZaz9inMGmq7jijUaOwi
         DZdQ==
X-Gm-Message-State: AJIora8BVaW+yXYNyWen5YUKMNN+B4PnZl0VEaQaogJgS1sL8tyB70/K
        82e10TpwG4p/mnUElZTnfxFjew==
X-Google-Smtp-Source: AGRyM1vaNQNI9PI5yb/h/apOruJfIAf1xdGLcrXUyB4vb85fioA03Qu3pDSrQYcFIIW64qmf2Xk+RA==
X-Received: by 2002:a05:620a:4103:b0:6b1:43c9:467b with SMTP id j3-20020a05620a410300b006b143c9467bmr3400667qko.4.1656535059364;
        Wed, 29 Jun 2022 13:37:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05620a17a500b006af0d99c7fesm3144329qkb.132.2022.06.29.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:37:39 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:37:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <Yry4ElVFQEsVbqse@nand.local>
References: <YrojV5aYCzxXlV3c@nand.local>
 <20220628192555.23565-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628192555.23565-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 12:55:55AM +0530, Abhradeep Chakraborty wrote:
> > > +			commit_pos = get_be32(triplet);
> > > +			offset_xor = triplet_get_offset(triplet);
> > > +
> > > +			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
> >
> > Should it be an error if we can't look up the object's ID here? I'd
> > think so.
>
> I also am not sure about it. Morally, I think it is better to throw
> An error here.

Yeah.

> > Do we have a good way to make sure that we're testing this code in CI?
> > It *seems* correct to me, but of course, we should have a computer check
> > that this produces OK results, not a human ;).
>
> My current test file changes should test this code. As for now, the lookup
> Table is enabled by default, all the existing tests that include write and
> read bitmaps uses this lookup table. So, all the test case scenarios should
> Pass. So, I think it is being tested in CI. Do you have a good idea to test
> It better?

I think having some indication (maybe via a trace2 region?) that we're
actually executing this code would be good. Although it's going to be
*really* noisy, so probably not a good idea to do that in general.

Stolee runs some coverage tests that show lines that we aren't
exercising via tests. So making sure that this doesn't show up in that
report when you run it locally would be good.

See some information from him about how to run those tests locally here:

    https://lore.kernel.org/git/00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com/

(TL;DR: run `make coverage-test` and make sure that these lines don't
show up ;-)).

> > Hmm. I'm not sure I follow the purpose of tweaking
> > GIT_TEST_READ_COMMIT_TABLE like this with setenv(). Are we trying to
> > avoid reading the lookup table? If so, why? I'd rather avoid
> > manipulating the environment directly like this, and instead have a
> > function we could call to fault in all of the bitmaps (when a lookup
> > table exists, otherwise do nothing).
>
> The problem was that the `test-tool bitmap list-commit` command was
> Not printing any commits (the error that I notified you before). It
> is because of this function. As lookup table is enabled by default,
> `prepare_bitmap_git` function doesn't load each bitmap entries and
> thus the below code in this function doesn't provide the bitmapped
> commit list (because Hashtable didn't generated).
>
>         kh_foreach(bitmap_git->bitmaps, oid, value, {
> 		printf("%s\n", oid_to_hex(&oid));
> 	});
>
> So, the simplest fix I found was this. Should I make a function then
> (Which you suggested here)?

I see. I remember that issue, but I think we should go about fixing it
in a different way. Instead of tricking the code into loading all
bitmaps by pretending the lookup table doesn't exist, we should have a
function that forces loading in all bitmaps from the lookup table, if
one exists. If the lookup table doesn't exist, or we have already loaded
its entries, then that function can be noop.

If we had something like that, we could call that function from within
`test_bitmap_commits()` before reading the keys and values out of
`bitmap_git->bitmaps`.

An alternative approach would be to read the table directly when it
exists, perhaps something like this:

--- 8< ---

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9e09c5824f..3bda059b9f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1921,22 +1921,28 @@ int test_bitmap_commits(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = NULL;
 	struct object_id oid;
-	MAYBE_UNUSED void *value;
-
-	/* As this function is only used to print bitmap selected
-	 * commits, we don't have to read the commit table.
-	 */
-	setenv("GIT_TEST_READ_COMMIT_TABLE", "0", 1);

 	bitmap_git = prepare_bitmap_git(r);
 	if (!bitmap_git)
 		die("failed to load bitmap indexes");

-	kh_foreach(bitmap_git->bitmaps, oid, value, {
-		printf("%s\n", oid_to_hex(&oid));
-	});
+	if (bitmap_git->table_lookup) {
+		uint32_t i, commit_pos;
+		for (i = 0; i < bitmap_git->entry_count; i++) {
+			commit_pos = get_be32(bitmap_get_triplet(bitmap_git, i));
+			if (nth_bitmap_object_oid(bitmap_git, &oid,
+						  commit_pos) < 0)
+				return error("could not find commit at "
+					     "position %"PRIu32, commit_pos);
+			printf("%s\n", oid_to_hex(&oid));
+		}
+	} else {
+		MAYBE_UNUSED void *value;
+		kh_foreach(bitmap_git->bitmaps, oid, value, {
+			printf("%s\n", oid_to_hex(&oid));
+		});
+	}

-	setenv("GIT_TEST_READ_COMMIT_TABLE", "1", 1);
 	free_bitmap_index(bitmap_git);

 	return 0;

--- >8 ---

Thanks,
Taylor
