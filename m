Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B031F453
	for <e@80x24.org>; Mon,  1 Oct 2018 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeJAR6f (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 13:58:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45797 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbeJAR6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 13:58:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so12340702eds.12
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyRyjQqb8Mk4ojrUggpsKR7Q7R9H4mCxpPjWjQPAOLw=;
        b=cqxawfppHFXONqorpzTAN/8wsM1RUs/dXtDQz4g9vmfKIOBfbB44k9ICWN51FhmzUq
         rZOBmx/Gx5OS3dGGmDaKvLDW1pgOt9xCwePOEVJN06pa91MbVZhToyVdgugwYdjQV9uo
         mXLnhJDqCAmbeFvocEU17f8Q265QnJzUlumyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyRyjQqb8Mk4ojrUggpsKR7Q7R9H4mCxpPjWjQPAOLw=;
        b=fpA3GS+XKYA/iwaLv1a9GwpxycbakajOAdHyXyi9bmEDMCn9PNr3PYT7sCcRm7/vo2
         6sE0bJgRcMsvgx7aeNFCRfS+hcOJbY0NC42hJB9F31O+IyvkuWH9+WPL8C9bw0expdVA
         ur005blMVjqVVDnlGgExPGds3JHHXkTkvQhMZnBz1D8h+kL/nXxU9xndj0b3KzLqb4sf
         fhS9aHBECTdEBSQRY/kZZVvJ/Q2FMkTSQ/55dPsB4SG0pgracJI3fhbzOs9oByhVwdOm
         UWmDEiYnaGYLaCzcGV7QWgZXsY/6SHHYuEQOZs9HwVRbZo6io3/7TgT1HvNHiPB0ZPfC
         FtRg==
X-Gm-Message-State: ABuFfoiIlLVxayHHgzaqXPShjZhmaI1OasiKVNdisYiVqTNXrgSkLjnm
        PKqZ02W0dn66Weal7PLWuyg+LPrePU3WSA==
X-Google-Smtp-Source: ACcGV63xDfJEBWDGhKB4vOl+sPBUQ9hmNJJy7Pq1VdNGcfiFYQC+iOBv0ieo9ixr2hLTpofof4luyw==
X-Received: by 2002:a50:b68b:: with SMTP id d11-v6mr17423127ede.283.1538392874955;
        Mon, 01 Oct 2018 04:21:14 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1908560eda.51.2018.10.01.04.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 04:21:14 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 2/3] git.c: handle_alias: prepend alias info when first argument is -h
Date:   Mon,  1 Oct 2018 13:21:06 +0200
Message-Id: <20181001112107.28956-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most git commands respond to -h anywhere in the command line, or at
least as a first and lone argument, by printing the usage
information. For aliases, we can provide a little more information that
might be useful in interpreting/understanding the following output by
prepending a line telling that the command is an alias, and for what.

When one invokes a simple alias, such as "cp = cherry-pick"
with -h, this results in

$ git cp -h
'cp' is aliased to 'cherry-pick'
usage: git cherry-pick [<options>] <commit-ish>...
...

When the alias consists of more than one word, this provides the
additional benefit of informing the user which options are implicit in
using the alias, e.g. with "cp = cherry-pick -n":

$ git cp -h
'cp' is aliased to 'cherry-pick -n'
usage: git cherry-pick [<options>] <commit-ish>...
...

For shell commands, we cannot know how it responds to -h, but printing
this line to stderr should not hurt, and can help in figuring out what
is happening in a case like

$ git sc -h
'sc' is aliased to '!somecommand'
somecommand: invalid option '-h'

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git.c b/git.c
index a6f4b44af5..0211c2d4c0 100644
--- a/git.c
+++ b/git.c
@@ -318,6 +318,9 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_command = (*argv)[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
+		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
+			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
+				   alias_command, alias_string);
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
 			int nongit_ok;
-- 
2.19.0

