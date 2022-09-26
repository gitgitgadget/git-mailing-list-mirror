Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A5C6FA86
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiIZMGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiIZMFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 08:05:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085157251
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso6322648pjd.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J17wnMf9kUETHbhhAhPMQ1tZQPUGt9P1sgn2Khhml+A=;
        b=gfCzvhOpyiZ+pWjSaafgRSdacSDMJn+p0NOIV1zRqmus0njkZKlDBv//3RL1idoqqd
         bd8iofs1FHsRe6OlspfYxEmkgI9YnyecSRnWs66EOT1AL4Y2n9HdVsPFz9y70jYTkrOL
         ZFQ8N6iVjphKjbMjpcNVgSNWbDw2YKgMhC+hc/MWpVsEhuFBYLr7/VUKs1h085peet5Z
         QzphYraSqILe1g2u2g4534WgUx4cCIvLVboyI5KfaVWv73CPEoBiyU2yKwxrx1JTxgWp
         xsouNtjeDlQu1XW+Sec7BrTw8eWAzfR4Ty5UfzobRzP0DrA208ejeDRmWuXfW1OjKXRu
         RXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J17wnMf9kUETHbhhAhPMQ1tZQPUGt9P1sgn2Khhml+A=;
        b=YMgsyJyTJJwCunZpPG/3Ha2QNkfc4f99YBVoE3c8h0uh9fZk7N/0BVwLsIu0B/bcw+
         NtZF09jK2CAt6fDu4nCd5e7ca+Gwv7oWCkGJd+pIvzSrGSRzvBvjQvGSpJwcpGI9g1KZ
         UvxfC323YIasN1zkuHZ/Q7OGeb5obzR8sbZxVNGs1o2lJcuw++8H9vpAlfRBdmhcAsGV
         HH78xD3wq96YLsn9gaJjUL4qbF+3FS/PI5IHPsJNAjnKmHm0hLNqqFPX6OgjlLJx+m4U
         okIc5UCtUwJw6mWBDKUopOQ9KZZFuUMbBnpPTVcg1RTkPX2XJEUXvAWOslSestbS1Mle
         eN0w==
X-Gm-Message-State: ACrzQf1uDoYOjf/5h5VdAMmYAIM4iRqm3X2cZyTtIrsrLbVbgE3cSkjv
        AFBj6Jc1TnefQLW2RP6VuIpLISlnh2373g==
X-Google-Smtp-Source: AMsMyM7trwuWfNiH5aDC+XCavDpMkR4lC9I6zdJTBRXtez5bSNbpYJuyoE30PkM6K/Uc9tui44hAkg==
X-Received: by 2002:a17:90b:4d8f:b0:202:6634:997e with SMTP id oj15-20020a17090b4d8f00b002026634997emr24620501pjb.237.1664189646099;
        Mon, 26 Sep 2022 03:54:06 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e0a:3b3c:baa6:3f:18b6:80cf])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001782aee4881sm11031794plk.153.2022.09.26.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:54:05 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 0/2] Add mailmap mechanism in cat-file options
Date:   Mon, 26 Sep 2022 16:23:41 +0530
Message-Id: <20220926105343.233296-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.8.g9592ff2ba4
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Junio for the review :) I have made the suggested changes.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used bt `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.

= Changes in v2:

- The commit messages of both the patches have been improved.
- In the second patch, we were populating the `contentp` field of the
  `object_info` structure when `--batch-check` was combined with
  `--use-mailmap`. Which made us read the contents of tree and blob
  object types as well, which affected the performance. We should only
  be reading the contents for commit or tag object types. The second
  patch has been updated to do just that.

Siddharth Asthana (2):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt |  6 +++++-
 builtin/cat-file.c             | 27 +++++++++++++++++++++++++++
 t/t4203-mailmap.sh             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  513ad3b5f7 < -:  ---------- doc/cat-file: allow --use-mailmap for --batch options
2:  6f3dcce9e3 ! 1:  60cf7bc28c cat-file: add mailmap support to -s option
    @@ Metadata
      ## Commit message ##
         cat-file: add mailmap support to -s option
     
    -    Using `git cat-file --use-mailmap` with `-s` option, like the following is
    -    allowed:
    +    Even though the cat-file command with `-s` option does not complain when
    +    `--use-mailmap` option is given, the latter option is ignored. Compute
    +    the size of the object after replacing the idents and report it instead.
     
    -     git cat-file --use-mailmap -s <commit/tag object sha>
    +    In order to make `-s` option honour the mailmap mechanism we have to
    +    read the contents of the commit/tag object. Make use of the call to
    +    `oid_object_info_extended()` to get the contents of the object and store
    +    in `buf`. `buf` is later freed in the function.
     
    -    The current implementation will return the same object size irrespective
    -    of the mailmap option, which is not as useful as it could be. When we
    -    use the mailmap mechanism to replace the idents, the size of the object
    -    can change and `-s` option would be more useful if it shows the size of
    -    the changed object. This patch implements that.
    -
    -    Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
    -    Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.txt ##
3:  af90241d32 ! 2:  06c74dd017 cat-file: add mailmap support to --batch-check option
    @@ Metadata
      ## Commit message ##
         cat-file: add mailmap support to --batch-check option
     
    -    Using `git cat-file --use-mailmap` with --batch-check option, like the
    -    following is allowed:
    +    Even though the cat-file command with `--batch-check` option does not
    +    complain when `--use-mailmap` option is given, the latter option is
    +    ignored. Compute the size of the object after replacing the idents and
    +    report it instead.
     
    -     git cat-file --use-mailmap -batch-check
    +    In order to make `--batch-check` option honour the mailmap mechanism we
    +    have to read the contents of the commit/tag object.
     
    -    The current implementation will return the same object size irrespective
    -    of the mailmap option, which is not as useful as it could be. When we
    -    use the mailmap mechanism to replace the idents, the size of the object
    -    can change and --batch-check option would be more useful if it shows the
    -    size of the changed object. This patch implements that.
    +    There were two ways to do it:
     
    -    Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
    -    Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
    +    1. Make two calls to `oid_object_info_extended()`. If `--use-mailmap`
    +       option is given, the first call will get us the type of the object
    +       and second call will only be made if the object type is either a
    +       commit or tag to get the contents of the object.
    +
    +    2. Make one call to `oid_object_info_extended()` to get the type of the
    +       object. Then, if the object type is either of commit or tag, make a
    +       call to `read_object_file()` to read the contents of the object.
    +
    +    I benchmarked the following command with both the above approaches and
    +    compared against the current implementation where `--use-mailmap`
    +    option is ignored:
    +
    +    `git cat-file --use-mailmap --batch-all-objects --batch-check --buffer
    +    --unordered`
    +
    +    The results can be summarized as follows:
    +                           Time (mean ± σ)
    +    default               827.7 ms ± 104.8 ms
    +    first approach        6.197 s ± 0.093 s
    +    second approach       1.975 s ± 0.217 s
    +
    +    Since, the second approach is faster than the first one, I implemented
    +    it in this patch.
    +
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
    +    Mentored-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.txt ##
     @@ Documentation/git-cat-file.txt: OPTIONS
    - 	with `--use-mailmap`, `--textconv` or `--filters`. In the case of `--textconv` or
    - 	`--filters` the input lines also need to specify the path, separated by whitespace.
    - 	See the `BATCH OUTPUT` section below for details.
    -+	If used with `--use-mailmap` option, will show the size of updated object after
    -+	replacing idents using the mailmap mechanism.
    + 	`--textconv` or `--filters`, in which case the input lines also
    + 	need to specify the path, separated by whitespace.  See the
    + 	section `BATCH OUTPUT` below for details.
    ++	If used with `--use-mailmap` option, will show the size of
    ++	updated object after replacing idents using the mailmap mechanism.
      
      --batch-command::
      --batch-command=<format>::
     
      ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
    - 
    - static void print_default_format(struct strbuf *scratch, struct expand_data *data)
    - {
    -+	if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
    -+		size_t s = data->size;
    -+		*data->info.contentp = replace_idents_using_mailmap((char*)*data->info.contentp, &s);
    -+		data->size = cast_size_t_to_ulong(s);
    -+	}
    -+
    - 	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
    - 		    type_name(data->type),
    - 		    (uintmax_t)data->size);
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    - 			       struct packed_git *pack,
    - 			       off_t offset)
    - {
    -+	void *buf = NULL;
    -+
      	if (!data->skip_object_info) {
      		int ret;
      
     +		if (use_mailmap)
    -+			data->info.contentp = &buf;
    ++			data->info.typep = &data->type;
     +
      		if (pack)
      			ret = packed_object_info(the_repository, pack, offset,
      						 &data->info);
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    - 		print_object_or_die(opt, data);
    - 		batch_write(opt, "\n", 1);
    - 	}
    + 			fflush(stdout);
    + 			return;
    + 		}
     +
    -+	free(buf);
    - }
    ++		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
    ++			size_t s = data->size;
    ++			char *buf = NULL;
    ++
    ++			buf = read_object_file(&data->oid, &data->type, &data->size);
    ++			buf = replace_idents_using_mailmap(buf, &s);
    ++			data->size = cast_size_t_to_ulong(s);
    ++
    ++			free(buf);
    ++		}
    + 	}
      
    - static void batch_one_object(const char *obj_name,
    + 	strbuf_reset(scratch);
     
      ## t/t4203-mailmap.sh ##
     @@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
-- 
2.38.0.rc1.8.g9592ff2ba4

