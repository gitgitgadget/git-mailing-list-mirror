Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD09C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F26610C9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbhIIX0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349533AbhIIX0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:26:12 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B6C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:25:02 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l10so90546ilh.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lw6WWh7oWv2wBEXcCqVbIGz0GPy9m3PgbNMhaMoaMzI=;
        b=iL6BPrcDBxqQaYaG0rnh3PfhKiqQ98JK060A8CjlMTbMq0+B/UWh/DLfCd0SFuBocb
         mRjEgPfs8oC1miznF1sgy6QSCjCKaLWRxd3XSupjSSKHQ+a6u9LwZX5KNeNo+JoZ5v+a
         FN25wLOaoSh6aR+TSR5jFHldaY0bc98u4pBZocpoyPW9jcNq9fz/vfU3CIkivrJbD4BA
         1RQlrbBhOhDyATl50wmX7gEr/K3jgmU7y33vQkoxRZujdKdzfMmFHWURr0pqRiF+4NHv
         XGsxGa/gDx42ZVqhBaWx+hbzRYGUgXcQkNIgTIXOc2nhKY9D+5VHvvup3bFd+6nVYamr
         OQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lw6WWh7oWv2wBEXcCqVbIGz0GPy9m3PgbNMhaMoaMzI=;
        b=SOZVUcY3WE7kaQT5Ggt6tPJKwqlYdtPMbNGAZzHu02cVt7BZcwAl11MpofNlaCqJn1
         C3Zah1AJJz0E0ZZ4MfkpevcVgkWqeRuAd6oOyevP4I/FEDB3yyttHxX903AOE7LyoC6u
         RZyXMhTWFzd/iaohp2bnYIKriAy+DAJdi544Rzk1s9j/1QsBtrl4A4a+ItlKbg1L1l6V
         mQp8gg2urEqnBxg5KOSfM7lj9ByNVTpVnOlBhzRjEkP49VPH8+qorqa2+2vt569VVWwI
         eKt6XWeU05jUmDMyrz8KkWRAm6i7ku/9jvtv6dRurzvf+K3iL0e460cZz9lAXBH5SH1y
         j8Eg==
X-Gm-Message-State: AOAM531EJnfrA+QSuGQIS+sOWx21Q3XTUngzIjB++wjVCPYoCpkGgx9P
        1gRslTH0JOVIOEQuKjeNSny3RzF6NiyrQxKW
X-Google-Smtp-Source: ABdhPJw2d0O210lVhap4WFy3ydBASLUPcUCOWJah9tLS0djOf+3qsyU+NbTyU0jpJ9CFZ/nM1fN9hQ==
X-Received: by 2002:a92:6605:: with SMTP id a5mr3945668ilc.17.1631229901593;
        Thu, 09 Sep 2021 16:25:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17sm1609496ilf.49.2021.09.09.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:25:01 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:25:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 9/9] pack-objects: rename .idx files into place after
 .bitmap files
Message-ID: <1409725509fad5708abc2586c5679887561c5ed6.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

In preceding commits the race of renaming .idx files in place before
.rev files and other auxiliary files was fixed in pack-write.c's
finish_tmp_packfile(), builtin/repack.c's "struct exts", and
builtin/index-pack.c's final(). As noted in the change to pack-write.c
we left in place the issue of writing *.bitmap files after the *.idx,
let's fix that issue.

See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
for commentary at the time when *.bitmap was implemented about how
those files are written out, nothing in that commit contradicts what's
being done here.

Note that this commit and preceding ones only close any race condition
with *.idx files being written before their auxiliary files if we're
optimistic about our lack of fsync()-ing in this are not tripping us
over. See the thread at [1] for a rabbit hole of various discussions
about filesystem races in the face of doing and not doing fsync() (and
if doing fsync(), not doing it properly).

We may want to fsync the containing directory once after renaming the
*.idx file into place, but that is outside the scope of this series.

1. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 944134b6f2..a01767a384 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1250,7 +1250,6 @@ static void write_pack_file(void)
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, hash, &idx_tmp_name);
-			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
@@ -1267,6 +1266,8 @@ static void write_pack_file(void)
 				strbuf_setlen(&tmpname, tmpname_len);
 			}
 
+			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
+
 			free(idx_tmp_name);
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
-- 
2.33.0.96.g73915697e6
