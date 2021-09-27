Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E2BC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81A760FED
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhI0QrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhI0QrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:47:17 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D6C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:45:39 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x9so5365659qvn.12
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ERENKiDfEA1xI3z1uai42+h8U92Njkewcd6QdPrT6M=;
        b=MVwFGWQn+J1pKY0YCxP2Yo8fEqLhhFnCCD1qHASyCP09EriKJIFwRHgbN0bDAdvzBq
         ZvRdQuUwJJgLLRpLqTjJ1abzyjZe4KoV797S9TU5iRWBc02vqSYXT7Nvswb+S2fNnzG3
         KvT+WxMoiPf4286PwiZRMsGhs4qxJwnUvQTASOj4OtWrMMcoz9mCT39u+ot9DBO5itMI
         56J7Ua9RJ4BLsGdq0wyirIUwCGjp1XQ9mOK2zv4pFGnWX5cAUhSkkAT09fu46XhbAaWU
         xtXln/KPwocCPs9vFd+1mNHvBmVCFEL8gTGQB+jVoHpWlrf5DtIyizVEvRMEk9r8PvAE
         wh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ERENKiDfEA1xI3z1uai42+h8U92Njkewcd6QdPrT6M=;
        b=rcX/4X/ibgGL2M/QD42rXe/7fYDEzK9vYxDzeOGPhGEsaqyrANFEMoVewGFiK0PH3x
         m7Bm3EV2udvDtOLLta+OOHR9v5N+05BznMCRZReU548wAQ5wIiPkPIOxY/r19lVPOL5I
         VLSPAW/Z2vJMu7O7/CAdzfQWxvnDR1H2L2meoPQReG3iEbMvLv4GKu+I6rWdv6+Upd9m
         ijSnvsjqQPXth0rZKXWFHAlEnc8TmAxBZE/d/C2ygWI1pIyiMOnNgmGqxx0TBnS34XEe
         Bpotx2ToRqyEVIdjz9WfwSi9rYOR8/H0xxDbMFye2CCDGcPhbXfobAM+a8bNvjgaDaSJ
         iC4Q==
X-Gm-Message-State: AOAM532Xew1S4puiCPqZS2sEdNZqaQ0szrPsoCFr3P03+EZlbc5KIito
        M2ngsa+/TdXE0bC1rIaROjUM5w==
X-Google-Smtp-Source: ABdhPJwTHSJLZg4Z2qYtQWfJPhSTRqMcbIGq7XpdwjFBGYC1v9SVJ5MYqACOdw863kOwAFa+wV8/4g==
X-Received: by 2002:a0c:f053:: with SMTP id b19mr829489qvl.54.1632761137837;
        Mon, 27 Sep 2021 09:45:37 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id e22sm11164120qtm.10.2021.09.27.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:45:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        matheus.bernardino@usp.br
Subject: Re: [RFC PATCH 0/3] grep: don'\''t add subrepos to in-memory alternates
Date:   Mon, 27 Sep 2021 13:45:30 -0300
Message-Id: <296230071f2cabda213b2a5f6f435f9308718569.1632754555.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <878rzi1ape.fsf@evledraar.gmail.com>
References: <878rzi1ape.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 9:09 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>
> On Mon, Aug 16 2021, Jonathan Tan wrote:
>
> > Record the repository whenever an OID grep source is created, and teach
> > the worker threads to explicitly provide the repository when accessing
> > objects.
> > [...]
> > diff --git a/grep.h b/grep.h
> > index 480b3f5bba..128007db65 100644
> > --- a/grep.h
> > +++ b/grep.h
> > @@ -120,7 +120,20 @@ struct grep_opt {
> >       struct grep_pat *header_list;
> >       struct grep_pat **header_tail;
> >       struct grep_expr *pattern_expression;
> > +
> > +     /*
> > +      * NEEDSWORK: See if we can remove this field, because the repository
> > +      * should probably be per-source. That is, grep.c functions using this
> > +      * field should probably start using "repo" in "struct grep_source"
> > +      * instead.
> > +      *
> > +      * This is potentially the cause of at least one bug - "git grep"
> > +      * ignoring the textconv attributes from submodules. See [1] for more
> > +      * information.
> > +      * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
> > +      */
> >       struct repository *repo;
> > +
>
> I ran into this comment and read the linked E-Mail, and then the
> downthread
> https://lore.kernel.org/git/CAHd-oW6uG1fap-T4UF17bJmjoHAqWCDq9KbY+_8a3cEnnfATxg@mail.gmail.com/;
>
> Given Matheus's "I've somehow missed this guard and the..." there I'm
> not quite sure what/if we should be doing here & what this comment is
> recommending? I.e. do we still need to adjust the call chains as noted
> in the E-Mail the comment links to, or not?

I think we should still adjust the call chains, yes. The downthread
message you mentioned is kind of a tangent about performance, where
Junio helped me understand something I had previously missed in the
code, regarding the persistence of the attributes stack.

But the issue that started the thread was about a correctness problem:
the superproject textconv attributes are being used on submodules'
files when running `git grep` with `--recurse-submodules --textconv`.
The three cases to consider are:

- .gitattributes from the working tree
- .gitattributes from the index
- .git/info/attributes

On all these cases, the superproject attributes are being used on the
submodule. Additionally, if the superproject does not define any
attribute, the submodule attributes are being ignored in all cases
except by the first one (but that is only because the code sees the
.gitattributes file on the submodule as if it were a "regular"
subdirectory of the surperproject. So the submodule's .gitattribures
takes higher precedence when evaluating the attributes for files in
that directory).

Another issue is that the textconv cache is always saved to (and read
from) the superproject gitdir, even for submodules' files.

Here are some test cases that demonstrate these issues:

-- snipsnap --
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3172f5b936..d01a3bc5d8 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -441,4 +441,104 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
 	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
 	test_must_be_empty actual
 '
+
+test_expect_failure 'grep --textconv: superproject .gitattributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+	git add .gitattributes &&
+	rm .gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	super_attr="$(git rev-parse --path-format=relative --git-path info/attributes)" &&
+	test_when_finished rm -f "$super_attr" &&
+	echo "a diff=d2x" >"$super_attr" &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --textconv corectly reads submodule .gitattributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv corectly reads submodule .gitattributes (from index)' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+	git -C submodule add .gitattributes &&
+	rm submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv corectly reads submodule .git/info/attributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+
+	# Workaround: we use --path-format=relative because the absolute path
+	# contains whitespaces and that seems to confuse test_when_finished
+	#
+	submodule_attr="submodule/$(git -C submodule rev-parse --path-format=relative --git-path info/attributes)" &&
+	test_when_finished rm -f "$submodule_attr" &&
+	echo "a diff=d2x" >"$submodule_attr" &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep saves textconv cache in the appropriated repository' '
+	reset_and_clean &&
+	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
+	test_config_global diff.d2x_cached.cachetextconv true &&
+	echo "a diff=d2x_cached" >submodule/.gitattributes &&
+
+	# Note: we only read/write to the textconv cache when grepping from an
+	# OID as the working tree file might have modifications. That is why
+	# we use --cached here.
+	#
+	git grep --textconv --cached --recurse-submodules x &&
+	test_path_is_missing "$(git rev-parse --git-path refs/notes/textconv/d2x_cached)" &&
+	test_path_is_file "$(git -C submodule rev-parse --git-path refs/notes/textconv/d2x_cached)"
+'
+
 test_done
--

Junio seemed to agree that the behavior I described above is not the
correct one:

"None of the attributes defined in the superproject
should affect the paths in the submodule, as it is a totally
separate project, oblivious to the existence of enclosing the
superproject."

But he raised an important concern regarding how to fix this without
affecting [too much] performance:

"As there is only one attribute cache IIUC, invalidating
the whole cache for the top-level and replacing it with the one for
a submodule, every time we cross the module boundary, would probably
have a negative effect on the performance, and I am not sure what
would happen if you run more than one threads working in different
repositories (i.e. top-level and submodules)."

Maybe we would need a different attributes stack for each repository?
