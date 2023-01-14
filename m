Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DFC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjANQqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjANQqx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:46:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869865BB
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:46:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso27305013pjo.3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+nh/fhzMZJq7wODB+OOC0wc/AH28EOCPyAvxIktxwg=;
        b=KtSOQOAetBi2NzMQTR2jLe1cFRgIMOzqKdbBTRmrpEq4d24hkHyuEit/vrmIZrcUfZ
         US11KUZ+Rlytgj5SXSgnYzId+j6RCV4F9OYb6JpLbmC+iFwr0DUMli6HI83kuFrsmx5e
         Cquw3kUjHt0AKkkINrDttfzw8AkDDmrJTU1Y6H6WQdc+2EILx+5bHlTzsw0HLo2imxUR
         YXJtBeQtLlj3cfLmeVqhAagN5cXZlky/YIFwI5XymJS48NV9WsJNcYhLLYEWvhMBE731
         TPTGMaBezxdjGyFPIab48U9+lundzBPRPw9CGSs0K/97P7Om0keW4liwnPmB5ywLvfme
         fIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+nh/fhzMZJq7wODB+OOC0wc/AH28EOCPyAvxIktxwg=;
        b=c6Q/nvPDkrGUQEFnzwlwJBVN9g04uYBZ8vPs9t3ANF+UPiIQ/c7g7yAwjgUZaFI29g
         5dfX+RxKhXAg1fA5NnjjDkhEyno+WtuqppGvhUvVZp/c0THsEw26xatRSgmGXCX6PGzQ
         jC4qElW7bWbhYelwLD1ME0mwTMft23zBz1w4Vx02J5+Hfmt/IyaX5ib8XGNi/ouXRTVK
         QD/9tutlzV1ovtcRhQCWnUQDyURI0sjBeP+v9rj0YhMdiXnAbxBV6sobjLwzjaVrbCN5
         RfId9D6tRSf+9B+AGZ+ImR35CXLItbO1BcNmT7sSIYeLv4QIvwRBp2TyMF1nOTm3ZehK
         CxAA==
X-Gm-Message-State: AFqh2kpUi9IS0NqLDJUsDt7Ua2aHSZ+eoThgsWDBrHd7htEuIv0ve9fS
        nveApLAGHwyWFA6AO4nghWs=
X-Google-Smtp-Source: AMrXdXvxsSORALklnDYLJ30PAjBpN/J3FiYdI3txvatMa6E7aNsdcZFSJAuCGzdtbi2OuhwQRhCdsA==
X-Received: by 2002:a17:902:f68f:b0:192:ebbd:a634 with SMTP id l15-20020a170902f68f00b00192ebbda634mr19379350plg.10.1673714811264;
        Sat, 14 Jan 2023 08:46:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e547000000b00476d1385265sm13067367pgj.25.2023.01.14.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:46:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ls-tree: fix expansion of repeated %(path)
References: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de>
Date:   Sat, 14 Jan 2023 08:46:50 -0800
In-Reply-To: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 14 Jan 2023 15:37:53 +0100")
Message-ID: <xmqqmt6lkqrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> expand_show_tree() borrows the base strbuf given to us by read_tree() to
> build the full path of the current entry when handling %(path).  Only
> its indirect caller, show_tree_fmt(), removes the added entry name.
> That works fine as long as %(path) is only included once in the format
> string, but accumulates duplicates if it's repeated:
>
>    $ git ls-tree --format='%(path) %(path) %(path)' HEAD M*
>    Makefile MakefileMakefile MakefileMakefileMakefile
>
> Reset the length after each use to get the same expansion every time;
> here's the behavior with this patch:
>
>    $ ./git ls-tree --format='%(path) %(path) %(path)' HEAD M*
>    Makefile Makefile Makefile
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/ls-tree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

I wonder if this was broken from its introduction at 455923e0
(ls-tree: introduce "--format" option, 2022-03-23)?

It seems to be the case.  With the following applied on top of
455923e0, the new test fails as expected, and your patch fixes
the breakage, so I am tempted to squash the tests in ;-)

Thanks.

 t/t3104-ls-tree-format.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/t/t3104-ls-tree-format.sh w/t/t3104-ls-tree-format.sh
index 7f1eb699d3..7e6c4dc5da 100755
--- c/t/t3104-ls-tree-format.sh
+++ w/t/t3104-ls-tree-format.sh
@@ -37,6 +37,12 @@ test_ls_tree_format () {
 	'
 }
 
+test_expect_success "ls-tree --format='%(path) %(path) %(path)' HEAD top-file" '
+	git ls-tree --format="%(path) %(path) %(path)" HEAD top-file.t >actual &&
+	echo top-file.t top-file.t top-file.t >expect &&
+	test_cmp expect actual
+'
+
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	""
