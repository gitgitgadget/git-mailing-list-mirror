Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE02C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545D56108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbhIIXZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349555AbhIIXZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:38 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098DC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:28 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a1so96863ilj.6
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8nWsul68ycamrtDyNInN7BeouFpWILWYWbqxL7Q3Wew=;
        b=j6t3nRy6xl2wLQ8wMdLfJtszYXHv8Kdg7jdQq0E3wzBVnIlPIk6HjgRZ2Bv8xxo8CV
         0bBH85/p7e/fGGfKU5qJUTRkMMHLH7zq+i4LAydciboLTi/l3DXjtqdl83CjbzgNdT6W
         qBoXJpdXZ2v33UXW6PlJ6bYNfUbC11/RrYGcHN5JFstmyzbo/qCcL5J0aMC31QJPff3G
         hHyMoXPaXDW6qOB+zZXjpp3dCppXcoFn7LwV1FEv0Gb7Q+vC3kkQpWttiz9FE0MMdA0p
         uOWn5Lw/DzHO3NNX0IStZKPNwI+pj0Un+rH3eaBo6XV+xUyOJTFHQki0EvKj1+a836Qb
         P5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8nWsul68ycamrtDyNInN7BeouFpWILWYWbqxL7Q3Wew=;
        b=LZu2uMppUqXNOWcrJ17nt2x1LZ4k0mABP3Q9F0JNEMjpLSgPeMOvWySjrmAvDeyQCS
         kVFb9YBvSJInD8rJmCZiRHr0UctdOFxIdD2ra8LsS8AteHp45HzNQXkDt2zHp62FUqVT
         DsDteuQ/K5eU2gxKPKzW+lzlvj0Fs0t3WkPvU36AsWdCwP6IKB05NPPqbLiLbaBNK8WV
         ZFGXgVlF9GsoX7wf7CgzTHqG3H6aN7z852b/fWPX4eDK2Bf7g4GLSaHsxbKK0F56qeKq
         fseEVj8uWs2s0LzIhFJn83qwBQ9OmsauAp4pbaXvZ8TJ2ORnWHrWZ2+OEAeL6b2nnE71
         IW1A==
X-Gm-Message-State: AOAM533Qc7UO5Y0h5puap1uuKruFtxFd9aG8z/HRapB6Tx0ImBatNTOH
        qCO3InGjzKVF7wg1WSNHOE0YGn+eaIK4RpVz
X-Google-Smtp-Source: ABdhPJxH1BnX+e1TkJdAgpTInR561HyKsDQ2T3/l19makv0FUt7SU1zQ0xIH9ELdvbAh68PinniOjw==
X-Received: by 2002:a05:6e02:1be7:: with SMTP id y7mr2511316ilv.15.1631229867301;
        Thu, 09 Sep 2021 16:24:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z10sm1582327ill.69.2021.09.09.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:26 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 0/9] packfile: avoid .idx rename races
Message-ID: <cover.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a relatively small reroll of mine and Ævar's series to prevent
packfile-related races when moving the `.idx` into place before other auxiliary
files are renamed.

All changes are cosmetic, but all of the feedback on the previous round was a
strict improvement in the overall quality, so it seemed pertinent to send an
improved version. Range-diff is below, and thanks in advance for your review.

Taylor Blau (4):
  bulk-checkin.c: store checksum directly
  pack-write.c: rename `.idx` files after `*.rev`
  builtin/repack.c: move `.idx` files into place last
  builtin/index-pack.c: move `.idx` files into place last

Ævar Arnfjörð Bjarmason (5):
  pack.h: line-wrap the definition of finish_tmp_packfile()
  pack-write: refactor renaming in finish_tmp_packfile()
  index-pack: refactor renaming in final()
  pack-write: split up finish_tmp_packfile() function
  pack-objects: rename .idx files into place after .bitmap files

 builtin/index-pack.c   | 48 +++++++++++++++++------------------
 builtin/pack-objects.c | 15 ++++++++---
 builtin/repack.c       |  2 +-
 bulk-checkin.c         | 31 +++++++++++++++++------
 pack-write.c           | 57 +++++++++++++++++++++---------------------
 pack.h                 | 10 +++++++-
 6 files changed, 96 insertions(+), 67 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  0b07aa4947 pack.h: line-wrap the definition of finish_tmp_packfile()
 1:  20b35ce050 !  2:  c46d3c29b4 bulk-checkin.c: store checksum directly
    @@ Commit message
         Store the hash directly in an unsigned char array. This behaves the same
         as writing to the `hash` member, but makes the intent clearer (and
         avoids allocating an extra four bytes for the `algo` member of `struct
    -    object_id`).
    +    object_id`). It likewise prevents the possibility of a segfault when
    +    reading `algo` (e.g., by calling `oid_to_hex()`) if it is uninitialized.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 2:  35052ef494 !  3:  2e907e309d pack-write: refactor renaming in finish_tmp_packfile()
    @@ pack-write.c: struct hashfile *create_tmp_packfile(char **pack_tmp_name)
      	return hashfd(fd, *pack_tmp_name);
      }
      
    -+static void rename_tmp_packfile(struct strbuf *nb, const char *source,
    ++static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
     +				const char *ext)
     +{
    -+	size_t nb_len = nb->len;
    ++	size_t name_prefix_len = name_prefix->len;
     +
    -+	strbuf_addstr(nb, ext);
    -+	if (rename(source, nb->buf))
    -+		die_errno("unable to rename temporary '*.%s' file to '%s'",
    -+			  ext, nb->buf);
    -+	strbuf_setlen(nb, nb_len);
    ++	strbuf_addstr(name_prefix, ext);
    ++	if (rename(source, name_prefix->buf))
    ++		die_errno("unable to rename temporary file to '%s'",
    ++			  name_prefix->buf);
    ++	strbuf_setlen(name_prefix, name_prefix_len);
     +}
     +
      void finish_tmp_packfile(struct strbuf *name_buffer,
 3:  0fb2c25f5a =  4:  41d34b1f18 pack-write.c: rename `.idx` files after `*.rev`
 4:  3b10a97ec0 =  5:  6b340b7eba builtin/repack.c: move `.idx` files into place last
 5:  3c9b515907 !  6:  1e4d0ea0f3 index-pack: refactor renaming in final()
    @@ Commit message
         helper, this is both a net decrease in lines, and improves the
         readability, since we can easily see at a glance that the logic for
         writing these three types of files is exactly the same, aside from the
    -    obviously differing cases of "*final_xyz_name" being NULL, and
    -    "else_chmod_if" being different.
    +    obviously differing cases of "*final_name" being NULL, and
    +    "make_read_only_if_same" being different.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ builtin/index-pack.c: static void write_special_file(const char *suffix, const c
      	strbuf_release(&name_buf);
      }
      
    -+static void rename_tmp_packfile(const char **final_xyz_name,
    -+				const char *curr_xyz_name,
    -+				struct strbuf *xyz_name, unsigned char *hash,
    -+				const char *ext, int else_chmod_if)
    ++static void rename_tmp_packfile(const char **final_name,
    ++				const char *curr_name,
    ++				struct strbuf *name, unsigned char *hash,
    ++				const char *ext, int make_read_only_if_same)
     +{
    -+	if (*final_xyz_name != curr_xyz_name) {
    -+		if (!*final_xyz_name)
    -+			*final_xyz_name = odb_pack_name(xyz_name, hash, ext);
    -+		if (finalize_object_file(curr_xyz_name, *final_xyz_name))
    ++	if (*final_name != curr_name) {
    ++		if (!*final_name)
    ++			*final_name = odb_pack_name(name, hash, ext);
    ++		if (finalize_object_file(curr_name, *final_name))
     +			die(_("unable to rename temporary '*.%s' file to '%s"),
    -+			    ext, *final_xyz_name);
    -+	} else if (else_chmod_if) {
    -+		chmod(*final_xyz_name, 0444);
    ++			    ext, *final_name);
    ++	} else if (make_read_only_if_same) {
    ++		chmod(*final_name, 0444);
     +	}
     +}
     +
 6:  8d67a71501 =  7:  906e75d707 builtin/index-pack.c: move `.idx` files into place last
 7:  5c553229b0 !  8:  90bebe4e51 pack-write: split up finish_tmp_packfile() function
    @@ bulk-checkin.c: static struct bulk_checkin_state {
      	unsigned char hash[GIT_MAX_RAWSZ];
     
      ## pack-write.c ##
    -@@ pack-write.c: static void rename_tmp_packfile(struct strbuf *nb, const char *source,
    - 	strbuf_setlen(nb, nb_len);
    +@@ pack-write.c: static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
    + 	strbuf_setlen(name_prefix, name_prefix_len);
      }
      
     -void finish_tmp_packfile(struct strbuf *name_buffer,
 8:  d8286cf107 !  9:  1409725509 pack-objects: rename .idx files into place after .bitmap files
    @@ Commit message
         about filesystem races in the face of doing and not doing fsync() (and
         if doing fsync(), not doing it properly).
     
    -    In particular, in this case of writing to ".git/objects/pack" we only
    -    write and fsync() the individual files, but if we wanted to guarantee
    -    that the metadata update was seen in that way by concurrent processes
    -    we'd need to fsync() on the "fd" of the containing directory. That
    -    concern is probably more theoretical than not, modern OS's tend to be
    -    more on the forgiving side than the overly pedantic side of
    -    implementing POSIX FS semantics.
    +    We may want to fsync the containing directory once after renaming the
    +    *.idx file into place, but that is outside the scope of this series.
     
         1. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/
     
-- 
2.33.0.96.g73915697e6
