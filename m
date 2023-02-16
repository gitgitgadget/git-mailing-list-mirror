Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC1C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 13:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBPNFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBPNFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 08:05:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48240BDCD
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i18so1957470pli.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFXyjR5teWfBq24NyKsWz+lefSwmv6AOWv964QjV2vQ=;
        b=ROdu2Egzdmwv4ciPjheEJeBYHdORhQbqibXiXWkRXpRUs+o73uX6nGwnlf/R5xodrc
         J+StSHr2grX44UwOQmeRvOZNC/1vY7ORNTfWvV0hkcJMlNZXRsyFD6arv5UJ8hHQ5YAM
         PEmDTbGgPHD8I+pJsvQX3RTu/eaj6mDmmePWgigYTmFujAjKdIA+2XnuSIH3EwDUUINw
         alG8STsfC6m5NNlu1UUEM2RLNgyjtFmgykb/UtYOygE6XKLWz3ARUNjxtXyTzx9tdgoe
         aA9Z9YxEU354GiA/PhaMVt4tjWIJMpkmRvG5+mafTx/zktbS41n3Eh03A0A/V4nhMMBj
         MJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFXyjR5teWfBq24NyKsWz+lefSwmv6AOWv964QjV2vQ=;
        b=FYYLU4etjEDc7n9hZoe2nCFpsfn05xlGGeCW5wpQGwD4YQyDZ4CzKzJNthXKrUn7Ww
         H1UDJSF7uLkRxxL9uGvCVKSs1rWUcVZE8OuAZiJeHDo5t6ehvDvXrxG+wcQO7Zja45SA
         wWGqi3AC2Yydb9J2IZrh/Rcqm0lYTbq3VrHx9cR/FsxICkfa3+wVGircyaqKu6Krka6p
         eJkO0hYmMXkO+hAwr49Oa8Ijxe9n4oZ8MBrAXezwk0ZBAzMUB4Srh/XIkNz608Yfw9Q9
         uVd+jNsI3VsqG4arO2ZuaM1jRyBnWLv741XExljcuFHIJD/hOhe8l/eE0O1PLXXupJyV
         OeFg==
X-Gm-Message-State: AO0yUKVrnIbYYpVbYlPTXCEuixxVIc/fehMJEm9hzpawzkSTGe5n4F7m
        6lXWBUHhpGk3I1CXwa+Jl3w=
X-Google-Smtp-Source: AK7set9xDLzokPJe8Ri3v+HC2Wj3dGP4yTmaOHP9UajT+faw8AkHL7/ZM9wqjMF9t0UEJSoxR7wiEw==
X-Received: by 2002:a17:903:41cb:b0:196:1678:3060 with SMTP id u11-20020a17090341cb00b0019616783060mr2083997ple.0.1676552714652;
        Thu, 16 Feb 2023 05:05:14 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b0019a75ea08e5sm1274581plb.33.2023.02.16.05.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:05:14 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 0/3] notes.c: introduce "--separator" option 
Date:   Thu, 16 Feb 2023 21:05:02 +0800
Message-Id: <cover.1676551077.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.g31d98a8e.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff since v4:

* Remove commits that may have compatibility issues
* Fix the problems that mentioned in v4
* Use OPT_STRING_LIST instead of OPT_CALLBACK_F to parse multiple "-m"

Thanks.

Teng Long (3):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: cleanup for "designated init"
  notes.c: introduce "--separator" option

 Documentation/git-notes.txt | 12 ++++++--
 builtin/notes.c             | 37 ++++++++++++++++++-----
 t/t3301-notes.sh            | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 10 deletions(-)

Range-diff against v4:
1:  f00a7596 ! 1:  9a450669 notes.c: cleanup 'strbuf_grow' call in 'append_edit'
    @@ Commit message
         needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
         "\n");" will do the "grow" for us.
     
    +    Best guess may be that the author originally inserted "\n" manually by
    +    direct manipulation of the strbuf rather than employing a strbuf
    +    function, but then switched to strbuf_insert() before submitting the
    +    series and forgot to remove the now-unnecessary strbuf_grow().
    +
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     
      ## builtin/notes.c ##
    +@@ builtin/notes.c: static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
    + 
    + 	BUG_ON_OPT_NEG(unset);
    + 
    +-	strbuf_grow(&d->buf, strlen(arg) + 2);
    + 	if (d->buf.len)
    + 		strbuf_addch(&d->buf, '\n');
    + 	strbuf_addstr(&d->buf, arg);
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      		enum object_type type;
      		char *prev_buf = read_object_file(note, &type, &size);
2:  29f7703b < -:  -------- notes.c: cleanup for "designated init" and "char ptr init"
3:  7b756b4c < -:  -------- notes.c: drop unreachable code in 'append_edit()'
4:  d41ba140 < -:  -------- notes.c: provide tips when target and append note are both empty
5:  f7edbd0e < -:  -------- notes.c: introduce "--separator" option
-:  -------- > 2:  e7bc6060 notes.c: cleanup for "designated init"
-:  -------- > 3:  a74c96d6 notes.c: introduce "--separator" option
-- 
2.39.2.459.g31d98a8e.dirty

