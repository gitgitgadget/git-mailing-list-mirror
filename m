Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84024C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGIPmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIPmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 11:42:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389C2A414
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 08:42:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w185so1423403pfb.4
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktPWmCoMHeiQT7VdpMqweRyipUCTPt8p0VqC25dS9m8=;
        b=Fbx6IR5iGWKLJT0RRgM/OBZCwDW7jPI96DJ6hXd4ee4WeZ+HiNa2QidUJtJ7jQT2Lg
         ThXEptHxVFLbNo2FR5o412tN4x4CK1/pZl5FOFhtALvjjWiRqEVAKclcrpwYaGp440mI
         tnULGjCj7vpXvCDZeLOE1diKPVP4tbYxdIMEJygxH0zkwtSMedf3i3YoaH0A2oyHhX/a
         e9xTTBHiB93spt63qno824rHil4q6dH251Xoj5M5+qL+uu2CfJl7Tbh3ilVbxg13C0+g
         uOKl9KfVxROO3Oylj1+IIV2CzjyB0noZYzPc31teT9LXGR0e7BdwfhfNX2cYLf0cqAz0
         50Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktPWmCoMHeiQT7VdpMqweRyipUCTPt8p0VqC25dS9m8=;
        b=iy4WpirvsuzPYszqhVSOu7AutDstGw4902udXeC8idEkTJj0/XUBcHJwit+Z23rrav
         YNM4PlSORrPe8eotpalKEbwHR7sg3GB1MZN2qX+2lovp/wEkx/1OtcUNEJtwIZT70b5s
         FgIOh0rmt3lLpsTfl0NlrPo3JKwyMbbZRyjyrUJbUKOsQfLYx54t7kHFsj2q+huc5cM/
         C80N/YppywSo7MxO894W3t7UtloYT8gGFs7oBoVATpvaXRO2iknxl3xloGNmqWiG65HO
         wWRWo6sIl3Vl81LHAd5+C5X/mxCDTYi2J64dfRbvpTVHSlIoiF1qEonzio2aybqFpjH/
         KRlg==
X-Gm-Message-State: AJIora8c5a2UvH12Np11f2gHC/ruZu2kEdTdXbPnxNNHoPoui0Nj1+JS
        cRyIGcH4G+Z7am0/i3c+y+EqreBQpQ3/wQzv
X-Google-Smtp-Source: AGRyM1tZlHn4t2dNG7HLmvwsV6DJXbrW6rZzmFOAp6tZ2voxxzUAuEJl/0zhmX5nbmOg8L00s1B6Ig==
X-Received: by 2002:a63:87c6:0:b0:415:e6bf:1fa6 with SMTP id i189-20020a6387c6000000b00415e6bf1fa6mr617906pge.406.1657381330499;
        Sat, 09 Jul 2022 08:42:10 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016be4d78792sm1473833plb.257.2022.07.09.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:42:09 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/4] Add support for mailmap in cat-file
Date:   Sat,  9 Jul 2022 21:11:45 +0530
Message-Id: <20220709154149.165524-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for the review and suggestions Junio, Danh and Johannes.
Really grateful for that :)

= Description

This patch series adds mailmap support to the git-cat-file command. It
adds the mailmap support only for the commit and tag objects by
replacing the idents for "author", "committer" and "tagger" headers. The
mailmap only takes effect when --[no-]-use-mailmap or --[no-]-mailmap
option is passed to the git cat-file command. The changes will work with
the batch mode as well.

So, if one wants to enable mailmap they can use either of the following
commands:
$ git cat-file --use-mailmap -p <object>
$ git cat-file --use-mailmap <type> <object>

To use it in the batch mode, one can use the following command:
$ git cat-file --use-mailmap --batch

= Patch Organization

- The first patch improves the commit_rewrite_person() by restricting it 
  to traverse only through the header part of the commit object buffer.
  It also adds an argument called headers which the callers can pass. 
  The function will replace idents only on these  passed headers. 
  Thus, the caller won't have to make repeated calls to the function.
- The second patch moves commit_rewrite_person() to ident.c to expose it
  as a public function so that it can be used to replace idents in the
  headers of desired objects.
- The third patch renames commit_rewrite_person() to a name which
  describes its functionality clearly. It is renamed to
  apply_mailmap_to_header().
- The last patch adds mailmap support to the git cat-file command. It
  adds the required documentation and tests as well.

Changes in v3:
- The decl-after-statement warnings have been fixed in all the patches.
- In commit_rewrite_person(), the data type of linelen and i variables
  have been changed from int to size_t.
- The return type of replace_idents_using_mailmap() function, size_t,
  has been explicitly typecasted to unsigned long using the
  cast_size_t_to_ulong() helper method.

Siddharth Asthana (4):
  revision: improve commit_rewrite_person()
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to apply_mailmap_to_header()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++
 builtin/cat-file.c             | 43 +++++++++++++++++++-
 cache.h                        |  6 +++
 ident.c                        | 72 ++++++++++++++++++++++++++++++++++
 revision.c                     | 50 ++---------------------
 t/t4203-mailmap.sh             | 54 +++++++++++++++++++++++++
 6 files changed, 183 insertions(+), 48 deletions(-)

Range-diff against v2:
1:  64e1f750e1 ! 1:  9e95326c58 revision: improve commit_rewrite_person()
    @@ Commit message
     
         The function, commit_rewrite_person(), is designed to find and replace
         an ident string in the header part, and the way it avoids a random
    -    occuranace of "author A U Thor <author@example.com" in the text is by
    +    occurrence of "author A U Thor <author@example.com" in the text is by
         insisting "author" to appear at the beginning of line by passing
         "\nauthor " as "what".
     
    @@ Commit message
         changed from int to void. This has been done because the caller of the
         function doesn't do anything with the return value of the function.
     
    -    By simplyfying the interface of the commit_rewrite_person(), we also
    +    By simplifying the interface of the commit_rewrite_person(), we also
         intend to expose it as a public function. We will also be renaming the
         function in a future commit to a different name which clearly tells that
         the function replaces idents in the header of the commit buffer.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
    +    Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## revision.c ##
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
     +		return;
     +
     +	for (;;) {
    -+		const char *person, *line = buf->buf + buf_offset;
    -+		int i, linelen = strchrnul(line, '\n') - line + 1;
    ++		const char *person, *line;
    ++		size_t i, linelen;
     +
    -+		if (!linelen || linelen == 1)
    ++		line = buf->buf + buf_offset;
    ++		linelen = strchrnul(line, '\n') - line + 1;
    ++
    ++		if (linelen <= 1)
     +			/* End of header */
     +			return;
     +
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
      {
      	int retval;
     @@ revision.c: static int commit_match(struct commit *commit, struct rev_info *opt)
    + 		strbuf_addstr(&buf, message);
    + 
    + 	if (opt->grep_filter.header_list && opt->mailmap) {
    ++		const char *commit_headers[] = { "author ", "committer ", NULL };
    ++
      		if (!buf.len)
      			strbuf_addstr(&buf, message);
      
     -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
     -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
    -+		const char *commit_headers[] = { "author ", "committer ", NULL };
     +		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
      	}
      
2:  b18ced0ece ! 2:  d9395cb8b2 ident: move commit_rewrite_person() to ident.c
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +		return;
     +
     +	for (;;) {
    -+		const char *person, *line = buf->buf + buf_offset;
    -+		int i, linelen = strchrnul(line, '\n') - line + 1;
    ++		const char *person, *line;
    ++		size_t i, linelen;
     +
    -+		if (!linelen || linelen == 1)
    ++		line = buf->buf + buf_offset;
    ++		linelen = strchrnul(line, '\n') - line + 1;
    ++
    ++		if (linelen <= 1)
     +			/* End of header */
     +			return;
     +
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -		return;
     -
     -	for (;;) {
    --		const char *person, *line = buf->buf + buf_offset;
    --		int i, linelen = strchrnul(line, '\n') - line + 1;
    +-		const char *person, *line;
    +-		size_t i, linelen;
    +-
    +-		line = buf->buf + buf_offset;
    +-		linelen = strchrnul(line, '\n') - line + 1;
     -
    --		if (!linelen || linelen == 1)
    +-		if (linelen <= 1)
     -			/* End of header */
     -			return;
     -
3:  2494ce1ed2 ! 3:  355bbda25e ident: rename commit_rewrite_person() to apply_mailmap_to_header()
    @@ ident.c: static ssize_t rewrite_ident_line(const char* person, struct strbuf *bu
     
      ## revision.c ##
     @@ revision.c: static int commit_match(struct commit *commit, struct rev_info *opt)
    + 		if (!buf.len)
      			strbuf_addstr(&buf, message);
      
    - 		const char *commit_headers[] = { "author ", "committer ", NULL };
     -		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
     +		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
      	}
4:  94838a2566 ! 4:  69b7ad898b cat-file: add mailmap support
    @@ Commit message
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.txt ##
    @@ builtin/cat-file.c: struct batch_options {
     +static struct string_list mailmap = STRING_LIST_INIT_NODUP;
     +static int use_mailmap;
     +
    -+char *replace_idents_using_mailmap(char *object_buf, size_t *size)
    ++static char *replace_idents_using_mailmap(char *, size_t *);
    ++
    ++static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    -+	strbuf_attach(&sb, object_buf, *size, *size + 1);
     +	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
    ++
    ++	strbuf_attach(&sb, object_buf, *size, *size + 1);
     +	apply_mailmap_to_header(&sb, headers, &mailmap);
     +	*size = sb.len;
     +	return strbuf_detach(&sb, NULL);
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      		if (!buf)
      			die("Cannot read object %s", obj_name);
      
    -+		if (use_mailmap)
    -+			buf = replace_idents_using_mailmap(buf, &size);
    ++		if (use_mailmap) {
    ++			size_t s = size;
    ++			buf = replace_idents_using_mailmap(buf, &s);
    ++			size = cast_size_t_to_ulong(s);
    ++		}
     +
      		/* otherwise just spit out the data */
      		break;
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      		buf = read_object_with_reference(the_repository, &oid,
      						 exp_type_id, &size, NULL);
     +
    -+		if (use_mailmap)
    -+			buf = replace_idents_using_mailmap(buf, &size);
    ++		if (use_mailmap) {
    ++			size_t s = size;
    ++			buf = replace_idents_using_mailmap(buf, &s);
    ++			size = cast_size_t_to_ulong(s);
    ++		}
      		break;
      	}
      	default:
    @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
      
      		contents = read_object_file(oid, &type, &size);
     +
    -+		if (use_mailmap)
    -+			contents = replace_idents_using_mailmap(contents, &size);
    ++		if (use_mailmap) {
    ++			size_t s = size;
    ++			contents = replace_idents_using_mailmap(contents, &s);
    ++			size = cast_size_t_to_ulong(s);
    ++		}
     +
      		if (!contents)
      			die("object %s disappeared", oid_to_hex(oid));
-- 
2.37.0.6.g69b7ad898b

