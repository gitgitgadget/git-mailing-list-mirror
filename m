Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917CC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587D96103D
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhIACOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIACOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:14:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C9C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:13:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so3645883wmi.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpLfzKnpJJHMHM5YraeY8f3EL0hs4O5NPYzGaTXpUwo=;
        b=O0tmW4salzMTxIZsmkuE3zRznBRmPM/UyHXZdZUujSzGnXqMUUfjuq6bsquha+M+5I
         0kDoDJ4pIsEZGcACc9oywxxfggt308FhjKHVMKWlG+CA8405nV0XLphTHbMMfigVbAr8
         GUGwU4cGQVMEVZ/i2J2mJCUc4Yslm+8WkEIx3ZCUjoHAUKTHr4aoqgyRSui1e8mrKMRs
         U6wUGyVR4K97KAo67r54nrzKk/4OLUaeL+Jse8fMdEe7+Hz3Z/okM5Pa2FGBTvDuA5hr
         mYJBpsWbcnxlS6e75gLhbXuks0PAsKJqODm+DwnZ1UP18CzPS6RKBi0ZVekwLxYYm97R
         3Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lpLfzKnpJJHMHM5YraeY8f3EL0hs4O5NPYzGaTXpUwo=;
        b=hWCaxgdQGArL0+dqzxlFen1VmNlu0SkNoXQzELuRfugmOSwEPb9Et6lL6jHG0om5D6
         1u6LbCD//aMOY4fXk2VisqaMdnodrep7Z4eK9adcxuWxldmFgyJgygXywGtVNsk0Gu2J
         IQwy7mSvThgXI9ap+apGJpNSLHjiYbdnyR/HzJ45bHNq9lUXLEYysnCEV5QmjzFZr1fe
         Iqn5kQwyRoT6k7w00VQ4ZSiftIzUWV84NMu56kogwD4TMR85wro9VhYEDcnNsQQ3dpe1
         qGllbkIoIURDrW2Z4840oXJt0MJrRWv8fTQ2ZzwJ4ovsDIhZsKrZOx5v/0NSE/IDB7QD
         dbfA==
X-Gm-Message-State: AOAM530nIPUaUxuacC/lNtwS3hxMNnLLJd0oZTjeRPKiFOiSQzDElCvv
        l734vbu4cE7xboGvZ6unRuImObQ/BE4=
X-Google-Smtp-Source: ABdhPJzYnWyhRZIQ53Ho3hH5+R4/XDan84MJYEBbWShrP/WhTfFW1IUROlNcfNIaakQKVJ+iSVJYmA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr7178601wmc.21.1630462386993;
        Tue, 31 Aug 2021 19:13:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm3898484wmz.26.2021.08.31.19.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:13:06 -0700 (PDT)
Message-Id: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>
In-Reply-To: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
References: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
From:   "Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 02:13:05 +0000
Subject: [PATCH v3] Make ident dynamic, not just a hardcoded value of "$Id".
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Maksym Sobolyev <sobomax@sippysoft.com>

This allows ident to be something like $FreeBSD$ so it provides matching
functionality for repos migrated from CVS / SVN.

This works by allowing ident to have a parameter, i.e.:

* ident=MyCustomId

In .gitattributes.

Extend the ident expansion tests to also verify custom ident.

Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
---
    Make ident dynamic, not just a hardcoded value of "$Id".
    
    This allows ident to be something like $FreeBSD$ so it provides matching
    functionality for repos migrated from CVS / SVN.
    
    This works by allowing ident to have a parameter, i.e.:
    
    * ident=MyCustomId
    
    In .gitattributes.
    
    cc: Philip Oakley philipoakley@iee.email

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1074%2Fsobomax%2Fpr-custom_ident-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1074/sobomax/pr-custom_ident-v3
Pull-Request: https://github.com/git/git/pull/1074

Range-diff vs v2:

 1:  16713788a26 ! 1:  74a705e5bbe Make ident dynamic, not just a hardcoded value of "$Id".
     @@ Commit message
      
          In .gitattributes.
      
     +    Extend the ident expansion tests to also verify custom ident.
     +
          Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
      
       ## Documentation/gitattributes.txt ##
     @@ convert.c: static int read_convert_config(const char *var, const char *value, vo
       }
       
      -static int count_ident(const char *cp, unsigned long size)
     -+#define ID_STR "Id"
     -+
     -+#define GIT_MAX_IDENT_LEN 255
     ++#define ID_STR_DEFAULT "Id"
      +
      +static int count_ident(const char *cp, unsigned long size,
      +		       const struct ident_action *idact)
     @@ convert.c: static int ident_to_git(const char *src, size_t len,
       
      -		if (len > 3 && !memcmp(src, "Id:", 3)) {
      -			dollar = memchr(src + 3, '$', len - 3);
     -+		if (len > idact->id_len + 1 && !memcmp(src, idact->id, idact->id_len) && src[idact->id_len + 1] == ':') {
     ++		if (len > idact->id_len + 1 && !memcmp(src, idact->id, idact->id_len) && src[idact->id_len] == ':') {
      +			dollar = memchr(src + idact->id_len + 1, '$', len - (idact->id_len + 1));
       			if (!dollar)
       				break;
     @@ convert.c: static struct convert_driver *git_path_check_convert(struct attr_chec
      -	return !!ATTR_TRUE(value);
      +	if (!ATTR_UNSET(value) && !ATTR_FALSE(value)) {
      +		if (ATTR_TRUE(value))
     -+			idact.id = ID_STR;
     ++			idact.id = ID_STR_DEFAULT;
      +		else
      +			idact.id = value;
      +		idact.id_len = strlen(idact.id);
     -+		if (idact.id_len > GIT_MAX_IDENT_LEN)
     -+			die(_("ident value length exceeds GIT_MAX_IDENT_LEN"));
      +	}
      +	return idact;
       }
     @@ convert.c: struct ident_filter {
       	struct stream_filter filter;
       	struct strbuf left;
       	int state;
     --	char ident[GIT_MAX_HEXSZ + 5]; /* ": x40 $" */
      +	const struct ident_action *idact;
     -+	char ident[GIT_MAX_HEXSZ + GIT_MAX_IDENT_LEN + 3]; /* ": x40 $" */
     + 	char ident[GIT_MAX_HEXSZ + 5]; /* ": x40 $" */
       };
       
     - static int is_foreign_ident(const char *str)
     +-static int is_foreign_ident(const char *str)
     ++static int is_foreign_ident(const struct ident_action *idact, const char *str)
     + {
     + 	int i;
     + 
     +-	if (!skip_prefix(str, "$Id: ", &str))
     ++	if (str[0] != '$' || strlen(str) < idact->id_len + 3 ||
     ++	    memcmp(str + 1, idact->id, idact->id_len) != 0 ||
     ++	    !skip_prefix(str + 1 + idact->id_len, ": ", &str))
     + 		return 0;
     + 	for (i = 0; str[i]; i++) {
     + 		if (isspace(str[i]) && str[i+1] != '$')
      @@ convert.c: static int ident_filter_fn(struct stream_filter *filter,
       			   char *output, size_t *osize_p)
       {
     @@ convert.c: static int ident_filter_fn(struct stream_filter *filter,
       		case IDENT_SKIPPING:
       			/* fallthrough */
      @@ convert.c: static int ident_filter_fn(struct stream_filter *filter,
     + 			strbuf_addch(&ident->left, ch);
       			if (ch != '\n' && ch != '$')
       				continue;
     - 			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
     +-			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
      -				strbuf_setlen(&ident->left, sizeof(head) - 1);
     ++			if (ch == '$' && !is_foreign_ident(idact, ident->left.buf)) {
      +				strbuf_setlen(&ident->left, idact->id_len + 1);
       				strbuf_addstr(&ident->left, ident->ident);
       			}
     @@ convert.h: enum convert_crlf_action {
       
      +struct ident_action {
      +	const char *id;
     -+	int id_len;
     ++	size_t id_len;
      +};
      +
       struct conv_attrs {
     @@ convert.h: enum convert_crlf_action {
       
      
       ## parallel-checkout.c ##
     +@@ parallel-checkout.c: static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
     + 		return 0;
     + 
     + 	packed_item_size = sizeof(struct pc_item_fixed_portion) + ce->ce_namelen +
     +-		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0);
     ++		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0) +
     ++		ca->ident_action.id_len;
     + 
     + 	/*
     + 	 * The amount of data we send to the workers per checkout item is
      @@ parallel-checkout.c: static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
       	size_t name_len = pc_item->ce->ce_namelen;
       	size_t working_tree_encoding_len = working_tree_encoding ?
     @@ parallel-checkout.h: struct pc_item_fixed_portion {
       	size_t name_len;
       };
      
     + ## t/t0021-conversion.sh ##
     +@@ t/t0021-conversion.sh: test_expect_success setup '
     + 	{
     + 	    echo "*.t filter=rot13"
     + 	    echo "*.i ident"
     ++	    echo "*.ci ident=customId"
     + 	} >.gitattributes &&
     + 
     + 	{
     + 	    echo a b c d e f g h i j k l m
     + 	    echo n o p q r s t u v w x y z
     + 	    echo '\''$Id$'\''
     ++	    echo '\''$customId$'\''
     + 	} >test &&
     + 	cat test >test.t &&
     + 	cat test >test.o &&
     + 	cat test >test.i &&
     +-	git add test test.t test.i &&
     +-	rm -f test test.t test.i &&
     +-	git checkout -- test test.t test.i &&
     ++	cat test >test.ci &&
     ++	git add test test.t test.i test.ci &&
     ++	rm -f test test.t test.i test.ci &&
     ++	git checkout -- test test.t test.i test.ci &&
     + 
     + 	echo "content-test2" >test2.o &&
     + 	echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
     + '
     + 
     +-script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
     ++script_i='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
     ++script_ci='s/^\$customId: \([0-9a-f]*\) \$/\1/p'
     + 
     + test_expect_success check '
     + 
     +@@ t/t0021-conversion.sh: test_expect_success check '
     + 	# ident should be stripped in the repository
     + 	git diff --raw --exit-code :test :test.i &&
     + 	id=$(git rev-parse --verify :test) &&
     +-	embedded=$(sed -ne "$script" test.i) &&
     ++	embedded=$(sed -ne "$script_i" test.i) &&
     ++	nembedded=$(sed -ne "$script_ci" test.i) &&
     + 	test "z$id" = "z$embedded" &&
     ++	test "z" = "z$nembedded" &&
     ++	embedded=$(sed -ne "$script_ci" test.ci) &&
     ++	nembedded=$(sed -ne "$script_i" test.ci) &&
     ++	test "z$id" = "z$embedded" &&
     ++	test "z" = "z$nembedded" &&
     + 
     + 	git cat-file blob :test.t >test.r &&
     + 
     +@@ t/t0021-conversion.sh: test_expect_success check '
     + 	test_cmp test.r test.t
     + '
     + 
     ++gen_expanded_keywords() {
     ++	local id="${1}"
     ++	echo "File with expanded keywords"
     ++	echo "\$$id\$"
     ++	echo "\$$id:\$"
     ++	echo "\$$id: 0000000000000000000000000000000000000000 \$"
     ++	echo "\$$id: NoSpaceAtEnd\$"
     ++	echo "\$$id:NoSpaceAtFront \$"
     ++	echo "\$$id:NoSpaceAtEitherEnd\$"
     ++	echo "\$$id: NoTerminatingSymbol"
     ++	echo "\$$id: Foreign Commit With Spaces \$"
     ++	printf "\$$id: NoTerminatingSymbolAtEOF"
     ++}
     ++
     ++gen_expected_output_0() {
     ++	local id="${1}"
     ++	local hid="${2}"
     ++	echo "File with expanded keywords"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: $hid \$"
     ++	echo "\$$id: NoTerminatingSymbol"
     ++	echo "\$$id: Foreign Commit With Spaces \$"
     ++}
     ++
     ++gen_expected_output() {
     ++	local id="${1}"
     ++	gen_expected_output_0 "${@}"
     ++	printf "\$$id: NoTerminatingSymbolAtEOF"
     ++}
     ++
     ++gen_expected_output_crlf() {
     ++	local id="${1}"
     ++	gen_expected_output_0 "${@}" | append_cr
     ++	printf "\$$id: NoTerminatingSymbolAtEOF"
     ++}
     ++
     + # If an expanded ident ever gets into the repository, we want to make sure that
     + # it is collapsed before being expanded again on checkout
     + test_expect_success expanded_in_repo '
     +-	{
     +-		echo "File with expanded keywords"
     +-		echo "\$Id\$"
     +-		echo "\$Id:\$"
     +-		echo "\$Id: 0000000000000000000000000000000000000000 \$"
     +-		echo "\$Id: NoSpaceAtEnd\$"
     +-		echo "\$Id:NoSpaceAtFront \$"
     +-		echo "\$Id:NoSpaceAtEitherEnd\$"
     +-		echo "\$Id: NoTerminatingSymbol"
     +-		echo "\$Id: Foreign Commit With Spaces \$"
     +-	} >expanded-keywords.0 &&
     +-
     +-	{
     +-		cat expanded-keywords.0 &&
     +-		printf "\$Id: NoTerminatingSymbolAtEOF"
     +-	} >expanded-keywords &&
     ++	gen_expanded_keywords Id >expanded-keywords &&
     ++	gen_expanded_keywords customId >expanded-keywords_ci &&
     + 	cat expanded-keywords >expanded-keywords-crlf &&
     ++	cat expanded-keywords_ci >expanded-keywords-crlf_ci &&
     + 	git add expanded-keywords expanded-keywords-crlf &&
     ++	git add expanded-keywords_ci expanded-keywords-crlf_ci &&
     + 	git commit -m "File with keywords expanded" &&
     + 	id=$(git rev-parse --verify :expanded-keywords) &&
     ++	id_ci=$(git rev-parse --verify :expanded-keywords_ci) &&
     + 
     +-	{
     +-		echo "File with expanded keywords"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: $id \$"
     +-		echo "\$Id: NoTerminatingSymbol"
     +-		echo "\$Id: Foreign Commit With Spaces \$"
     +-	} >expected-output.0 &&
     +-	{
     +-		cat expected-output.0 &&
     +-		printf "\$Id: NoTerminatingSymbolAtEOF"
     +-	} >expected-output &&
     +-	{
     +-		append_cr <expected-output.0 &&
     +-		printf "\$Id: NoTerminatingSymbolAtEOF"
     +-	} >expected-output-crlf &&
     ++	gen_expected_output Id $id >expected-output &&
     ++	gen_expected_output customId $id_ci >expected-output_ci &&
     ++	gen_expected_output_crlf Id $id >expected-output-crlf &&
     ++	gen_expected_output_crlf customId $id_ci >expected-output-crlf_ci &&
     + 	{
     + 		echo "expanded-keywords ident"
     ++		echo "expanded-keywords_ci ident=customId"
     + 		echo "expanded-keywords-crlf ident text eol=crlf"
     ++		echo "expanded-keywords-crlf_ci ident=customId text eol=crlf"
     + 	} >>.gitattributes &&
     + 
     + 	rm -f expanded-keywords expanded-keywords-crlf &&
     ++	rm -f expanded-keywords_ci expanded-keywords-crlf_ci &&
     + 
     + 	git checkout -- expanded-keywords &&
     + 	test_cmp expected-output expanded-keywords &&
     + 
     + 	git checkout -- expanded-keywords-crlf &&
     +-	test_cmp expected-output-crlf expanded-keywords-crlf
     ++	test_cmp expected-output-crlf expanded-keywords-crlf &&
     ++
     ++	git checkout -- expanded-keywords_ci &&
     ++	test_cmp expected-output_ci expanded-keywords_ci &&
     ++
     ++	git checkout -- expanded-keywords-crlf_ci &&
     ++	test_cmp expected-output-crlf_ci expanded-keywords-crlf_ci
     + '
     + 
     + # The use of %f in a filter definition is expanded to the path to
     +
       ## t/t2082-parallel-checkout-attributes.sh ##
      @@ t/t2082-parallel-checkout-attributes.sh: test_expect_success 'parallel-checkout with ident' '
       	(


 Documentation/gitattributes.txt         |   8 ++
 builtin/checkout--worker.c              |  17 +++-
 convert.c                               | 116 ++++++++++++++----------
 convert.h                               |   7 +-
 parallel-checkout.c                     |  14 ++-
 parallel-checkout.h                     |   8 +-
 t/t0021-conversion.sh                   | 115 ++++++++++++++---------
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 8 files changed, 192 insertions(+), 100 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a41..9e486f3e8d3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -382,6 +382,14 @@ sign `$` upon checkout.  Any byte sequence that begins with
 `$Id:` and ends with `$` in the worktree file is replaced
 with `$Id$` upon check-in.
 
+The `ident` attribute can also provide an optional value,
+which if supplied is going to be used for expansion instead of
+the string `Id`.
+
+------------------------
+*.[ch]		ident=FreeBSD
+------------------------
+
 
 `filter`
 ^^^^^^^^
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index fb9fd13b73c..61ba39402ad 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -9,7 +9,7 @@ static void packet_to_pc_item(const char *buffer, int len,
 			      struct parallel_checkout_item *pc_item)
 {
 	const struct pc_item_fixed_portion *fixed_portion;
-	const char *variant;
+	const char *variant, *ident_action;
 	char *encoding;
 
 	if (len < sizeof(struct pc_item_fixed_portion))
@@ -19,7 +19,8 @@ static void packet_to_pc_item(const char *buffer, int len,
 	fixed_portion = (struct pc_item_fixed_portion *)buffer;
 
 	if (len - sizeof(struct pc_item_fixed_portion) !=
-		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
+		fixed_portion->name_len + fixed_portion->working_tree_encoding_len +
+		fixed_portion->ident_action_len)
 		BUG("checkout worker received corrupted item");
 
 	variant = buffer + sizeof(struct pc_item_fixed_portion);
@@ -43,11 +44,21 @@ static void packet_to_pc_item(const char *buffer, int len,
 	pc_item->ce->ce_namelen = fixed_portion->name_len;
 	pc_item->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
+	variant += pc_item->ce->ce_namelen;
 	oidcpy(&pc_item->ce->oid, &fixed_portion->oid);
 
+	if (fixed_portion->ident_action_len) {
+		ident_action = xmemdupz(variant,
+					fixed_portion->ident_action_len);
+		variant += fixed_portion->ident_action_len;
+	} else {
+		ident_action = NULL;
+	}
+
 	pc_item->id = fixed_portion->id;
 	pc_item->ca.crlf_action = fixed_portion->crlf_action;
-	pc_item->ca.ident = fixed_portion->ident;
+	pc_item->ca.ident_action.id = ident_action;
+	pc_item->ca.ident_action.id_len = fixed_portion->ident_action_len;
 	pc_item->ca.working_tree_encoding = encoding;
 }
 
diff --git a/convert.c b/convert.c
index 0d6fb3410ae..111bfeeaf36 100644
--- a/convert.c
+++ b/convert.c
@@ -1056,7 +1056,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+#define ID_STR_DEFAULT "Id"
+
+static int count_ident(const char *cp, unsigned long size,
+		       const struct ident_action *idact)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
@@ -1069,13 +1072,13 @@ static int count_ident(const char *cp, unsigned long size)
 		size--;
 		if (ch != '$')
 			continue;
-		if (size < 3)
+		if (size < idact->id_len + 1)
 			break;
-		if (memcmp("Id", cp, 2))
+		if (memcmp(idact->id, cp, idact->id_len))
 			continue;
-		ch = cp[2];
-		cp += 3;
-		size -= 3;
+		ch = cp[idact->id_len];
+		cp += idact->id_len + 1;
+		size -= idact->id_len + 1;
 		if (ch == '$')
 			cnt++; /* $Id$ */
 		if (ch != ':')
@@ -1099,11 +1102,11 @@ static int count_ident(const char *cp, unsigned long size)
 }
 
 static int ident_to_git(const char *src, size_t len,
-			struct strbuf *buf, int ident)
+			struct strbuf *buf, const struct ident_action *idact)
 {
 	char *dst, *dollar;
 
-	if (!ident || (src && !count_ident(src, len)))
+	if (!idact->id || (src && !count_ident(src, len, idact)))
 		return 0;
 
 	if (!buf)
@@ -1122,17 +1125,18 @@ static int ident_to_git(const char *src, size_t len,
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
 
-		if (len > 3 && !memcmp(src, "Id:", 3)) {
-			dollar = memchr(src + 3, '$', len - 3);
+		if (len > idact->id_len + 1 && !memcmp(src, idact->id, idact->id_len) && src[idact->id_len] == ':') {
+			dollar = memchr(src + idact->id_len + 1, '$', len - (idact->id_len + 1));
 			if (!dollar)
 				break;
-			if (memchr(src + 3, '\n', dollar - src - 3)) {
+			if (memchr(src + idact->id_len + 1, '\n', dollar - src - (idact->id_len + 1))) {
 				/* Line break before the next dollar. */
 				continue;
 			}
 
-			memcpy(dst, "Id$", 3);
-			dst += 3;
+			memcpy(dst, idact->id, idact->id_len);
+			dst[idact->id_len] = '$';
+			dst += idact->id_len + 1;
 			len -= dollar + 1 - src;
 			src  = dollar + 1;
 		}
@@ -1143,16 +1147,16 @@ static int ident_to_git(const char *src, size_t len,
 }
 
 static int ident_to_worktree(const char *src, size_t len,
-			     struct strbuf *buf, int ident)
+			     struct strbuf *buf, const struct ident_action *idact)
 {
 	struct object_id oid;
 	char *to_free = NULL, *dollar, *spc;
 	int cnt;
 
-	if (!ident)
+	if (!idact->id)
 		return 0;
 
-	cnt = count_ident(src, len);
+	cnt = count_ident(src, len, idact);
 	if (!cnt)
 		return 0;
 
@@ -1161,7 +1165,7 @@ static int ident_to_worktree(const char *src, size_t len,
 		to_free = strbuf_detach(buf, NULL);
 	hash_object_file(the_hash_algo, src, len, "blob", &oid);
 
-	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
+	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + idact->id_len + 1));
 	for (;;) {
 		/* step 1: run to the next '$' */
 		dollar = memchr(src, '$', len);
@@ -1172,14 +1176,14 @@ static int ident_to_worktree(const char *src, size_t len,
 		src  = dollar + 1;
 
 		/* step 2: does it looks like a bit like Id:xxx$ or Id$ ? */
-		if (len < 3 || memcmp("Id", src, 2))
+		if (len < idact->id_len + 1 || memcmp(idact->id, src, idact->id_len))
 			continue;
 
 		/* step 3: skip over Id$ or Id:xxxxx$ */
-		if (src[2] == '$') {
-			src += 3;
-			len -= 3;
-		} else if (src[2] == ':') {
+		if (src[idact->id_len] == '$') {
+			src += idact->id_len + 1;
+			len -= idact->id_len + 1;
+		} else if (src[idact->id_len] == ':') {
 			/*
 			 * It's possible that an expanded Id has crept its way into the
 			 * repository, we cope with that by stripping the expansion out.
@@ -1187,18 +1191,18 @@ static int ident_to_worktree(const char *src, size_t len,
 			 * on checkout, which won't go away by stash, but let's keep it
 			 * for git-style ids.
 			 */
-			dollar = memchr(src + 3, '$', len - 3);
+			dollar = memchr(src + idact->id_len + 1, '$', len - (idact->id_len + 1));
 			if (!dollar) {
 				/* incomplete keyword, no more '$', so just quit the loop */
 				break;
 			}
 
-			if (memchr(src + 3, '\n', dollar - src - 3)) {
+			if (memchr(src + idact->id_len + 1, '\n', dollar - src - (idact->id_len + 1))) {
 				/* Line break before the next dollar. */
 				continue;
 			}
 
-			spc = memchr(src + 4, ' ', dollar - src - 4);
+			spc = memchr(src + idact->id_len + 2, ' ', dollar - src - (idact->id_len + 2));
 			if (spc && spc < dollar-1) {
 				/* There are spaces in unexpected places.
 				 * This is probably an id from some other
@@ -1215,7 +1219,8 @@ static int ident_to_worktree(const char *src, size_t len,
 		}
 
 		/* step 4: substitute */
-		strbuf_addstr(buf, "Id: ");
+		strbuf_addstr(buf, idact->id);
+		strbuf_addstr(buf, ": ");
 		strbuf_addstr(buf, oid_to_hex(&oid));
 		strbuf_addstr(buf, " $");
 	}
@@ -1286,11 +1291,19 @@ static struct convert_driver *git_path_check_convert(struct attr_check_item *che
 	return NULL;
 }
 
-static int git_path_check_ident(struct attr_check_item *check)
+static struct ident_action git_path_check_ident(struct attr_check_item *check)
 {
+	struct ident_action idact = {.id = NULL, .id_len = 0};
 	const char *value = check->value;
 
-	return !!ATTR_TRUE(value);
+	if (!ATTR_UNSET(value) && !ATTR_FALSE(value)) {
+		if (ATTR_TRUE(value))
+			idact.id = ID_STR_DEFAULT;
+		else
+			idact.id = value;
+		idact.id_len = strlen(idact.id);
+	}
+	return idact;
 }
 
 static struct attr_check *check;
@@ -1313,7 +1326,7 @@ void convert_attrs(struct index_state *istate,
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
 		ca->crlf_action = git_path_check_crlf(ccheck + 0);
-	ca->ident = git_path_check_ident(ccheck + 1);
+	ca->ident_action = git_path_check_ident(ccheck + 1);
 	ca->drv = git_path_check_convert(ccheck + 2);
 	if (ca->crlf_action != CRLF_BINARY) {
 		enum eol eol_attr = git_path_check_eol(ccheck + 3);
@@ -1433,7 +1446,7 @@ int convert_to_git(struct index_state *istate,
 			len = dst->len;
 		}
 	}
-	return ret | ident_to_git(src, len, dst, ca.ident);
+	return ret | ident_to_git(src, len, dst, &ca.ident_action);
 }
 
 void convert_to_git_filter_fd(struct index_state *istate,
@@ -1450,7 +1463,7 @@ void convert_to_git_filter_fd(struct index_state *istate,
 
 	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
-	ident_to_git(dst->buf, dst->len, dst, ca.ident);
+	ident_to_git(dst->buf, dst->len, dst, &ca.ident_action);
 }
 
 static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
@@ -1462,7 +1475,7 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 {
 	int ret = 0, ret_filter = 0;
 
-	ret |= ident_to_worktree(src, len, dst, ca->ident);
+	ret |= ident_to_worktree(src, len, dst, &(ca->ident_action));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1810,14 +1823,17 @@ struct ident_filter {
 	struct stream_filter filter;
 	struct strbuf left;
 	int state;
+	const struct ident_action *idact;
 	char ident[GIT_MAX_HEXSZ + 5]; /* ": x40 $" */
 };
 
-static int is_foreign_ident(const char *str)
+static int is_foreign_ident(const struct ident_action *idact, const char *str)
 {
 	int i;
 
-	if (!skip_prefix(str, "$Id: ", &str))
+	if (str[0] != '$' || strlen(str) < idact->id_len + 3 ||
+	    memcmp(str + 1, idact->id, idact->id_len) != 0 ||
+	    !skip_prefix(str + 1 + idact->id_len, ": ", &str))
 		return 0;
 	for (i = 0; str[i]; i++) {
 		if (isspace(str[i]) && str[i+1] != '$')
@@ -1847,13 +1863,16 @@ static int ident_filter_fn(struct stream_filter *filter,
 			   char *output, size_t *osize_p)
 {
 	struct ident_filter *ident = (struct ident_filter *)filter;
-	static const char head[] = "$Id";
+	const struct ident_action *idact = ident->idact;
 
 	if (!input) {
 		/* drain upon eof */
 		switch (ident->state) {
 		default:
-			strbuf_add(&ident->left, head, ident->state);
+			if (ident->state > 0)
+				strbuf_addch(&ident->left, '$');
+			if (ident->state > 1)
+				strbuf_add(&ident->left, idact->id, ident->state - 1);
 			/* fallthrough */
 		case IDENT_SKIPPING:
 			/* fallthrough */
@@ -1884,23 +1903,27 @@ static int ident_filter_fn(struct stream_filter *filter,
 			strbuf_addch(&ident->left, ch);
 			if (ch != '\n' && ch != '$')
 				continue;
-			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
-				strbuf_setlen(&ident->left, sizeof(head) - 1);
+			if (ch == '$' && !is_foreign_ident(idact, ident->left.buf)) {
+				strbuf_setlen(&ident->left, idact->id_len + 1);
 				strbuf_addstr(&ident->left, ident->ident);
 			}
 			ident->state = IDENT_DRAINING;
 			continue;
 		}
 
-		if (ident->state < sizeof(head) &&
-		    head[ident->state] == ch) {
+		if ((ident->state == 0 && ch == '$') ||
+		    (ident->state > 0 && ident->state < idact->id_len + 1 &&
+		     idact->id[ident->state - 1] == ch)) {
 			ident->state++;
 			continue;
 		}
 
-		if (ident->state)
-			strbuf_add(&ident->left, head, ident->state);
-		if (ident->state == sizeof(head) - 1) {
+		if (ident->state) {
+			strbuf_addch(&ident->left, '$');
+			if (ident->state > 1)
+				strbuf_add(&ident->left, idact->id, ident->state - 1);
+		}
+		if (ident->state == idact->id_len + 1) {
 			if (ch != ':' && ch != '$') {
 				strbuf_addch(&ident->left, ch);
 				ident->state = 0;
@@ -1935,7 +1958,7 @@ static struct stream_filter_vtbl ident_vtbl = {
 	ident_free_fn,
 };
 
-static struct stream_filter *ident_filter(const struct object_id *oid)
+static struct stream_filter *ident_filter(const struct object_id *oid, const struct ident_action *idact)
 {
 	struct ident_filter *ident = xmalloc(sizeof(*ident));
 
@@ -1944,6 +1967,7 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
 	strbuf_init(&ident->left, 0);
 	ident->filter.vtbl = &ident_vtbl;
 	ident->state = 0;
+	ident->idact = idact;
 	return (struct stream_filter *)ident;
 }
 
@@ -1963,8 +1987,8 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
 	if (classify_conv_attrs(ca) != CA_CLASS_STREAMABLE)
 		return NULL;
 
-	if (ca->ident)
-		filter = ident_filter(oid);
+	if (ca->ident_action.id)
+		filter = ident_filter(oid, &(ca->ident_action));
 
 	if (output_eol(ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
diff --git a/convert.h b/convert.h
index 5ee1c322058..2422e289784 100644
--- a/convert.h
+++ b/convert.h
@@ -76,11 +76,16 @@ enum convert_crlf_action {
 
 struct convert_driver;
 
+struct ident_action {
+	const char *id;
+	size_t id_len;
+};
+
 struct conv_attrs {
 	struct convert_driver *drv;
 	enum convert_crlf_action attr_action; /* What attr says */
 	enum convert_crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
-	int ident;
+	struct ident_action ident_action; /* What ident says */
 	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
index ddc0ff3c064..b5908c299af 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -91,7 +91,8 @@ static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
 		return 0;
 
 	packed_item_size = sizeof(struct pc_item_fixed_portion) + ce->ce_namelen +
-		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0);
+		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0) +
+		ca->ident_action.id_len;
 
 	/*
 	 * The amount of data we send to the workers per checkout item is
@@ -403,13 +404,15 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	size_t name_len = pc_item->ce->ce_namelen;
 	size_t working_tree_encoding_len = working_tree_encoding ?
 					   strlen(working_tree_encoding) : 0;
+	const char *ident_action_id = pc_item->ca.ident_action.id;
+	size_t ident_action_len = pc_item->ca.ident_action.id_len;
 
 	/*
 	 * Any changes in the calculation of the message size must also be made
 	 * in is_eligible_for_parallel_checkout().
 	 */
 	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
-		   working_tree_encoding_len;
+		   working_tree_encoding_len + ident_action_len;
 
 	data = xmalloc(len_data);
 
@@ -417,7 +420,7 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	fixed_portion->id = pc_item->id;
 	fixed_portion->ce_mode = pc_item->ce->ce_mode;
 	fixed_portion->crlf_action = pc_item->ca.crlf_action;
-	fixed_portion->ident = pc_item->ca.ident;
+	fixed_portion->ident_action_len = ident_action_len;
 	fixed_portion->name_len = name_len;
 	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
 	/*
@@ -434,6 +437,11 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 		variant += working_tree_encoding_len;
 	}
 	memcpy(variant, pc_item->ce->name, name_len);
+	variant += name_len;
+	if (ident_action_len) {
+		memcpy(variant, ident_action_id, ident_action_len);
+		variant += ident_action_len;
+	}
 
 	packet_write(fd, data, len_data);
 
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 80f539bcb77..c3c282f516b 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -76,9 +76,9 @@ struct parallel_checkout_item {
 
 /*
  * The fixed-size portion of `struct parallel_checkout_item` that is sent to the
- * workers. Following this will be 2 strings: ca.working_tree_encoding and
- * ce.name; These are NOT null terminated, since we have the size in the fixed
- * portion.
+ * workers. Following this will be 3 strings: ca.working_tree_encoding, ca.name
+ * and ca.ident_action.id; These are NOT null terminated, since we have the size
+ * in the fixed portion.
  *
  * Note that not all fields of conv_attrs and cache_entry are passed, only the
  * ones that will be required by the workers to smudge and write the entry.
@@ -88,7 +88,7 @@ struct pc_item_fixed_portion {
 	struct object_id oid;
 	unsigned int ce_mode;
 	enum convert_crlf_action crlf_action;
-	int ident;
+	size_t ident_action_len;
 	size_t working_tree_encoding_len;
 	size_t name_len;
 };
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index b5749f327dd..07df50a7e5d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -77,25 +77,29 @@ test_expect_success setup '
 	{
 	    echo "*.t filter=rot13"
 	    echo "*.i ident"
+	    echo "*.ci ident=customId"
 	} >.gitattributes &&
 
 	{
 	    echo a b c d e f g h i j k l m
 	    echo n o p q r s t u v w x y z
 	    echo '\''$Id$'\''
+	    echo '\''$customId$'\''
 	} >test &&
 	cat test >test.t &&
 	cat test >test.o &&
 	cat test >test.i &&
-	git add test test.t test.i &&
-	rm -f test test.t test.i &&
-	git checkout -- test test.t test.i &&
+	cat test >test.ci &&
+	git add test test.t test.i test.ci &&
+	rm -f test test.t test.i test.ci &&
+	git checkout -- test test.t test.i test.ci &&
 
 	echo "content-test2" >test2.o &&
 	echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
 '
 
-script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
+script_i='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
+script_ci='s/^\$customId: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
@@ -105,8 +109,14 @@ test_expect_success check '
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
 	id=$(git rev-parse --verify :test) &&
-	embedded=$(sed -ne "$script" test.i) &&
+	embedded=$(sed -ne "$script_i" test.i) &&
+	nembedded=$(sed -ne "$script_ci" test.i) &&
 	test "z$id" = "z$embedded" &&
+	test "z" = "z$nembedded" &&
+	embedded=$(sed -ne "$script_ci" test.ci) &&
+	nembedded=$(sed -ne "$script_i" test.ci) &&
+	test "z$id" = "z$embedded" &&
+	test "z" = "z$nembedded" &&
 
 	git cat-file blob :test.t >test.r &&
 
@@ -114,61 +124,84 @@ test_expect_success check '
 	test_cmp test.r test.t
 '
 
+gen_expanded_keywords() {
+	local id="${1}"
+	echo "File with expanded keywords"
+	echo "\$$id\$"
+	echo "\$$id:\$"
+	echo "\$$id: 0000000000000000000000000000000000000000 \$"
+	echo "\$$id: NoSpaceAtEnd\$"
+	echo "\$$id:NoSpaceAtFront \$"
+	echo "\$$id:NoSpaceAtEitherEnd\$"
+	echo "\$$id: NoTerminatingSymbol"
+	echo "\$$id: Foreign Commit With Spaces \$"
+	printf "\$$id: NoTerminatingSymbolAtEOF"
+}
+
+gen_expected_output_0() {
+	local id="${1}"
+	local hid="${2}"
+	echo "File with expanded keywords"
+	echo "\$$id: $hid \$"
+	echo "\$$id: $hid \$"
+	echo "\$$id: $hid \$"
+	echo "\$$id: $hid \$"
+	echo "\$$id: $hid \$"
+	echo "\$$id: $hid \$"
+	echo "\$$id: NoTerminatingSymbol"
+	echo "\$$id: Foreign Commit With Spaces \$"
+}
+
+gen_expected_output() {
+	local id="${1}"
+	gen_expected_output_0 "${@}"
+	printf "\$$id: NoTerminatingSymbolAtEOF"
+}
+
+gen_expected_output_crlf() {
+	local id="${1}"
+	gen_expected_output_0 "${@}" | append_cr
+	printf "\$$id: NoTerminatingSymbolAtEOF"
+}
+
 # If an expanded ident ever gets into the repository, we want to make sure that
 # it is collapsed before being expanded again on checkout
 test_expect_success expanded_in_repo '
-	{
-		echo "File with expanded keywords"
-		echo "\$Id\$"
-		echo "\$Id:\$"
-		echo "\$Id: 0000000000000000000000000000000000000000 \$"
-		echo "\$Id: NoSpaceAtEnd\$"
-		echo "\$Id:NoSpaceAtFront \$"
-		echo "\$Id:NoSpaceAtEitherEnd\$"
-		echo "\$Id: NoTerminatingSymbol"
-		echo "\$Id: Foreign Commit With Spaces \$"
-	} >expanded-keywords.0 &&
-
-	{
-		cat expanded-keywords.0 &&
-		printf "\$Id: NoTerminatingSymbolAtEOF"
-	} >expanded-keywords &&
+	gen_expanded_keywords Id >expanded-keywords &&
+	gen_expanded_keywords customId >expanded-keywords_ci &&
 	cat expanded-keywords >expanded-keywords-crlf &&
+	cat expanded-keywords_ci >expanded-keywords-crlf_ci &&
 	git add expanded-keywords expanded-keywords-crlf &&
+	git add expanded-keywords_ci expanded-keywords-crlf_ci &&
 	git commit -m "File with keywords expanded" &&
 	id=$(git rev-parse --verify :expanded-keywords) &&
+	id_ci=$(git rev-parse --verify :expanded-keywords_ci) &&
 
-	{
-		echo "File with expanded keywords"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: $id \$"
-		echo "\$Id: NoTerminatingSymbol"
-		echo "\$Id: Foreign Commit With Spaces \$"
-	} >expected-output.0 &&
-	{
-		cat expected-output.0 &&
-		printf "\$Id: NoTerminatingSymbolAtEOF"
-	} >expected-output &&
-	{
-		append_cr <expected-output.0 &&
-		printf "\$Id: NoTerminatingSymbolAtEOF"
-	} >expected-output-crlf &&
+	gen_expected_output Id $id >expected-output &&
+	gen_expected_output customId $id_ci >expected-output_ci &&
+	gen_expected_output_crlf Id $id >expected-output-crlf &&
+	gen_expected_output_crlf customId $id_ci >expected-output-crlf_ci &&
 	{
 		echo "expanded-keywords ident"
+		echo "expanded-keywords_ci ident=customId"
 		echo "expanded-keywords-crlf ident text eol=crlf"
+		echo "expanded-keywords-crlf_ci ident=customId text eol=crlf"
 	} >>.gitattributes &&
 
 	rm -f expanded-keywords expanded-keywords-crlf &&
+	rm -f expanded-keywords_ci expanded-keywords-crlf_ci &&
 
 	git checkout -- expanded-keywords &&
 	test_cmp expected-output expanded-keywords &&
 
 	git checkout -- expanded-keywords-crlf &&
-	test_cmp expected-output-crlf expanded-keywords-crlf
+	test_cmp expected-output-crlf expanded-keywords-crlf &&
+
+	git checkout -- expanded-keywords_ci &&
+	test_cmp expected-output_ci expanded-keywords_ci &&
+
+	git checkout -- expanded-keywords-crlf_ci &&
+	test_cmp expected-output-crlf_ci expanded-keywords-crlf_ci
 '
 
 # The use of %f in a filter definition is expanded to the path to
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 25254579618..822957a8dc8 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -20,16 +20,19 @@ test_expect_success 'parallel-checkout with ident' '
 	(
 		cd ident &&
 		echo "A ident" >.gitattributes &&
+		echo "C ident=MyCusomVeryLongAndWordyId" >>.gitattributes &&
 		echo "\$Id\$" >A &&
 		echo "\$Id\$" >B &&
+		echo "\$MyCusomVeryLongAndWordyId\$" >C &&
 		git add -A &&
 		git commit -m id &&
 
-		rm A B &&
+		rm A B C &&
 		test_checkout_workers 2 git reset --hard &&
 		hexsz=$(test_oid hexsz) &&
 		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
-		grep "\\\$Id\\\$" B
+		grep "\\\$Id\\\$" B &&
+		grep -E "\\\$MyCusomVeryLongAndWordyId: [0-9a-f]{$hexsz} \\\$" C
 	)
 '
 

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
