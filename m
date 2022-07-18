Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1395C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiGRTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGRTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE671D0CB
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j12so10004085plj.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9FyNLoQcibmSd3o2XpRuD6AjH4MFES1WjOW4ZeTspw=;
        b=YIua4Dc/yrr3u4Zbtpgzgtsps76juXSFSQirInhBBTG9KSJm5FEm5Hv7Crkp+XAtWG
         9zf8ud4T2wyPHa3HdGt2ihL3ngMHd1wamKP/uBHgdML6MESA2C34J6067/4pHH/Q7PY7
         ox4WiiLXuVvJr1fEfqClXL67KsyxRJtsy9Vj810pDHM2aEd6ROFoog7VUfGnWl6mA1KI
         L3V8Ru5+biQhTkgWNwf+jMZyU6yq1+icQ0+3yEg3higmXpipGtMWLGOwntHzTHoiSWTR
         WJXFquagBMV51Qp+JZ0otvOZyl6F9X6CditJ6TuD19cez0RxrQ03oZJHfGzjH9uMjTqg
         6lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9FyNLoQcibmSd3o2XpRuD6AjH4MFES1WjOW4ZeTspw=;
        b=sJ4lf3DDADQKLBfAFAO0DcJaQV9jwk5EfuRMrJzmUndMLcTnotVKliAL4kQXG04sEK
         LO0a5q1Y88AovdwQK2EE3PNoAZ/+Z8wsMs8WbvzWX/fhserpWmAYYCXl+zTWXYhEItWe
         RFsJBPCfnFBKPKYoVjEIxxReM49YYXrUTqZTjPruNvMd67NNEeuyubMD/tDxMXADCG2h
         bPQ7MGIHsVeCy9wwM423m7Eq5f7RKvoEstOlnKO/BIkFWCRy4pTch1VtyjZKpjxE7Vm6
         1rRg4wpKA3rZMBfGppmaI2BvWuUcjFnel35F/CLqmYANGbk1fSSzrpBpT4XCq1bKG13h
         xWKg==
X-Gm-Message-State: AJIora9il/1m90p4O0qCTQL907UkthZkleP9ToEKJG4JqDiFZ8Ga3hmG
        Yfczu/DGN4qdZd7JLMXl1rqpEuaPh+vN1A==
X-Google-Smtp-Source: AGRyM1v8FzpL2w9E/5rP6qDjJlN8HpRBiZCxRsFyvJerBDL0RTigdbPPnAsYbhKY/nBIvTKxXvnzDQ==
X-Received: by 2002:a17:902:f811:b0:16c:40bc:d004 with SMTP id ix17-20020a170902f81100b0016c40bcd004mr30099086plb.33.1658173873789;
        Mon, 18 Jul 2022 12:51:13 -0700 (PDT)
Received: from HB2.. ([106.212.244.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm9855838plr.195.2022.07.18.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:51:13 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 0/4] Add support for mailmap in cat-file
Date:   Tue, 19 Jul 2022 01:20:58 +0530
Message-Id: <20220718195102.66321-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g63d6f8c201
In-Reply-To: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Junio for your suggestion :) I have made the suggested
changes.

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

Changes in v6:
- The function rewrite_ident_line() returns the difference between the
  new and the old length of the ident line. We were not using this
  information and instead parsing the buffer again to look for the line
  ending. This patch set starts using that information to update the
  buf_offset value in commit_rewrite_person().
- This patch set also tweaks the commit_rewrite_person() so that it is
  easier to understand and avoids unnecessary parsing of the buffer
  wherever possible.

Siddharth Asthana (4):
  revision: improve commit_rewrite_person()
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to apply_mailmap_to_header()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++
 builtin/cat-file.c             | 43 +++++++++++++++++++-
 cache.h                        |  6 +++
 ident.c                        | 74 ++++++++++++++++++++++++++++++++++
 revision.c                     | 50 ++---------------------
 t/t4203-mailmap.sh             | 59 +++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 48 deletions(-)

Range-diff against v5:
1:  8c29ad9351 ! 1:  7c086e4c8a revision: improve commit_rewrite_person()
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     +/*
     + * Returns the difference between the new and old length of the ident line.
     + */
    -+static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    -+								  struct string_list *mailmap)
    ++static ssize_t rewrite_ident_line(const char *person, size_t len,
    ++				   struct strbuf *buf,
    ++				   struct string_list *mailmap)
      {
     -	char *person, *endp;
    -+	char *endp;
    - 	size_t len, namelen, maillen;
    +-	size_t len, namelen, maillen;
    ++	size_t namelen, maillen;
      	const char *name;
      	const char *mail;
      	struct ident_split ident;
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -		return 0;
     -
     -	person += strlen(what);
    - 	endp = strchr(person, '\n');
    - 	if (!endp)
    +-	endp = strchr(person, '\n');
    +-	if (!endp)
    +-		return 0;
    +-
    +-	len = endp - person;
    +-
    + 	if (split_ident_line(&ident, person, len))
      		return 0;
    + 
     @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
      
      	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
      		strbuf_addf(&namemail, "%.*s <%.*s>",
      			    (int)namelen, name, (int)maillen, mail);
     @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *what, struct st
    + 		strbuf_splice(buf, ident.name_begin - buf->buf,
      			      ident.mail_end - ident.name_begin + 1,
      			      namemail.buf, namemail.len);
    - 
     +		newlen = namemail.len;
    -+
    + 
      		strbuf_release(&namemail);
      
     -		return 1;
    -+		return newlen - (ident.mail_end - ident.name_begin + 1);
    ++		return newlen - (ident.mail_end - ident.name_begin);
      	}
      
      	return 0;
      }
      
     +static void commit_rewrite_person(struct strbuf *buf, const char **header,
    -+								  struct string_list *mailmap)
    ++				   struct string_list *mailmap)
     +{
     +	size_t buf_offset = 0;
     +
    @@ revision.c: static int commit_rewrite_person(struct strbuf *buf, const char *wha
     +	for (;;) {
     +		const char *person, *line;
     +		size_t i;
    ++		int found_header = 0;
     +
     +		line = buf->buf + buf_offset;
     +		if (!*line || *line == '\n')
    -+			return; /* End of header */
    ++			return; /* End of headers */
     +
     +		for (i = 0; header[i]; i++)
     +			if (skip_prefix(line, header[i], &person)) {
    -+				rewrite_ident_line(person, buf, mailmap);
    ++				const char *endp = strchrnul(person, '\n');
    ++				found_header = 1;
    ++				buf_offset += endp - line;
    ++				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
     +				break;
     +			}
     +
    -+		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    -+		if (buf->buf[buf_offset] == '\n')
    -+			++buf_offset;
    ++		if (!found_header) {
    ++			buf_offset = strchrnul(line, '\n') - buf->buf;
    ++			if (buf->buf[buf_offset] == '\n')
    ++				buf_offset++;
    ++		}
     +	}
     +}
     +
2:  ccb7f72fcb ! 2:  2f8fba7f57 ident: move commit_rewrite_person() to ident.c
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +/*
     + * Returns the difference between the new and old length of the ident line.
     + */
    -+static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    -+								  struct string_list *mailmap)
    ++static ssize_t rewrite_ident_line(const char *person, size_t len,
    ++				   struct strbuf *buf,
    ++				   struct string_list *mailmap)
     +{
    -+	char *endp;
    -+	size_t len, namelen, maillen;
    ++	size_t namelen, maillen;
     +	const char *name;
     +	const char *mail;
     +	struct ident_split ident;
     +
    -+	endp = strchr(person, '\n');
    -+	if (!endp)
    -+		return 0;
    -+
    -+	len = endp - person;
    -+
     +	if (split_ident_line(&ident, person, len))
     +		return 0;
     +
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +		strbuf_splice(buf, ident.name_begin - buf->buf,
     +			      ident.mail_end - ident.name_begin + 1,
     +			      namemail.buf, namemail.len);
    -+
     +		newlen = namemail.len;
     +
     +		strbuf_release(&namemail);
     +
    -+		return newlen - (ident.mail_end - ident.name_begin + 1);
    ++		return newlen - (ident.mail_end - ident.name_begin);
     +	}
     +
     +	return 0;
     +}
     +
     +void commit_rewrite_person(struct strbuf *buf, const char **header,
    -+						   struct string_list *mailmap)
    ++			    struct string_list *mailmap)
     +{
     +	size_t buf_offset = 0;
     +
    @@ ident.c: int split_ident_line(struct ident_split *split, const char *line, int l
     +	for (;;) {
     +		const char *person, *line;
     +		size_t i;
    ++		int found_header = 0;
     +
     +		line = buf->buf + buf_offset;
     +		if (!*line || *line == '\n')
    -+			return; /* End of header */
    ++			return; /* End of headers */
     +
     +		for (i = 0; header[i]; i++)
     +			if (skip_prefix(line, header[i], &person)) {
    -+				rewrite_ident_line(person, buf, mailmap);
    ++				const char *endp = strchrnul(person, '\n');
    ++				found_header = 1;
    ++				buf_offset += endp - line;
    ++				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
     +				break;
     +			}
     +
    -+		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    -+		if (buf->buf[buf_offset] == '\n')
    -+			++buf_offset;
    ++		if (!found_header) {
    ++			buf_offset = strchrnul(line, '\n') - buf->buf;
    ++			if (buf->buf[buf_offset] == '\n')
    ++				buf_offset++;
    ++		}
     +	}
     +}
      
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -/*
     - * Returns the difference between the new and old length of the ident line.
     - */
    --static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    --								  struct string_list *mailmap)
    +-static ssize_t rewrite_ident_line(const char *person, size_t len,
    +-				   struct strbuf *buf,
    +-				   struct string_list *mailmap)
     -{
    --	char *endp;
    --	size_t len, namelen, maillen;
    +-	size_t namelen, maillen;
     -	const char *name;
     -	const char *mail;
     -	struct ident_split ident;
     -
    --	endp = strchr(person, '\n');
    --	if (!endp)
    --		return 0;
    --
    --	len = endp - person;
    --
     -	if (split_ident_line(&ident, person, len))
     -		return 0;
     -
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -		strbuf_splice(buf, ident.name_begin - buf->buf,
     -			      ident.mail_end - ident.name_begin + 1,
     -			      namemail.buf, namemail.len);
    --
     -		newlen = namemail.len;
     -
     -		strbuf_release(&namemail);
     -
    --		return newlen - (ident.mail_end - ident.name_begin + 1);
    +-		return newlen - (ident.mail_end - ident.name_begin);
     -	}
     -
     -	return 0;
     -}
     -
     -static void commit_rewrite_person(struct strbuf *buf, const char **header,
    --								  struct string_list *mailmap)
    +-				   struct string_list *mailmap)
     -{
     -	size_t buf_offset = 0;
     -
    @@ revision.c: int rewrite_parents(struct rev_info *revs, struct commit *commit,
     -	for (;;) {
     -		const char *person, *line;
     -		size_t i;
    +-		int found_header = 0;
     -
     -		line = buf->buf + buf_offset;
     -		if (!*line || *line == '\n')
    --			return; /* End of header */
    +-			return; /* End of headers */
     -
     -		for (i = 0; header[i]; i++)
     -			if (skip_prefix(line, header[i], &person)) {
    --				rewrite_ident_line(person, buf, mailmap);
    +-				const char *endp = strchrnul(person, '\n');
    +-				found_header = 1;
    +-				buf_offset += endp - line;
    +-				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
     -				break;
     -			}
     -
    --		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
    --		if (buf->buf[buf_offset] == '\n')
    --			++buf_offset;
    +-		if (!found_header) {
    +-			buf_offset = strchrnul(line, '\n') - buf->buf;
    +-			if (buf->buf[buf_offset] == '\n')
    +-				buf_offset++;
    +-		}
     -	}
     -}
     -
3:  38c18fd10d ! 3:  b4f2477b14 ident: rename commit_rewrite_person() to apply_mailmap_to_header()
    @@ cache.h: struct ident_split {
       * Compare split idents for equality or strict ordering. Note that we
     
      ## ident.c ##
    -@@ ident.c: static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
    +@@ ident.c: static ssize_t rewrite_ident_line(const char *person, size_t len,
      	return 0;
      }
      
     -void commit_rewrite_person(struct strbuf *buf, const char **header,
    --						   struct string_list *mailmap)
    +-			    struct string_list *mailmap)
     +void apply_mailmap_to_header(struct strbuf *buf, const char **header,
    -+							 struct string_list *mailmap)
    ++			       struct string_list *mailmap)
      {
      	size_t buf_offset = 0;
      
4:  0a459d4c53 = 4:  63d6f8c201 cat-file: add mailmap support
-- 
2.37.1.120.g63d6f8c201

