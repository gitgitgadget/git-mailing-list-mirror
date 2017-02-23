Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C3D2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdBWXUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:20:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35261 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdBWXUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:20:06 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so663105pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vaAefppQH/vxqKWNtLj+Qv0ijL+y4RnN3u6P59qnRWM=;
        b=jEuGzXIWh5atO1QCm9q4XGTvO1KZ0gB1dcFu/dTF1zmiMvcGP8q6EZhrgw9wpT1x8O
         7x95T6LRNUCjRvFHMudVeB9mMULZbbg8Eo66CeSkl6+nvW4/v6rq3Llh9WFOb0M1ND4N
         JR5JM1norizNWDrBcv+CMeGCJWST9gRsMov1voPUlGHzBJJx+zfvipiNamRhHqG/+y/0
         XMgA2LkrKbkmX+wvbe1Mn8BoSMELuuYwxkWvcGAY92f2WfJ1/S5w3+D1hMwUFBGvGITK
         qdgppMEhHCFb6avZ4vDt3DViu9v6saUXszw3EAjBslhXHgz+LnJbw3l1vQZ0ymWNeKXp
         w+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vaAefppQH/vxqKWNtLj+Qv0ijL+y4RnN3u6P59qnRWM=;
        b=sKn13wIccI1POUsAw/ovgqYP7BeGsiStAwG7Rh605NEoqnirBY56ykZeekXXr2qPqb
         3UgDy/hsegPORG9rxL5d4QcE0B8Lu1xufJ5gndOBUryiuoWjkzwc2PfjqKh23JvahBqn
         mH7C7fcpRsnowoU2+/HeFMYhHK5Ft/CBjHBNuXaX1+fDNwnz4YH+XDiVoO3diLUeW+O1
         qF/iO94fM3ZI5Sf/mp+lML1bGIw9t/b5UFB4nwd50kSm+lW85qDfRCIPFudvyfuqDeRd
         9d/CMr2bme08Ag+C6fxHK/8K0qlIHwd5duRx/EKhas2cYy1KJuf32kNX5KuLmguI9NGk
         8oEg==
X-Gm-Message-State: AMke39keqgzbXoBPiLiPbHOtis252bjnt0GeKL1k5e8Xij48xiWJzL2yBjpV5SpnTvw+Rg==
X-Received: by 10.98.56.2 with SMTP id f2mr24708529pfa.130.1487892000421;
        Thu, 23 Feb 2017 15:20:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id t12sm11658430pfg.14.2017.02.23.15.19.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:19:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
        <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
        <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
        <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Feb 2017 15:19:58 -0800
In-Reply-To: <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 22 Feb 2017 23:19:44 -0800")
Message-ID: <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> FWIW, the code looks OK here. It is a shame to duplicate the policy
>> found in git_config_parse_key(), though.
>>
>> I wonder if we could make a master version of that which canonicalizes
>> in-place, and then just wrap it for the git_config_parse_key()
>> interface. Actually, I guess the function you just wrote _is_ that inner
>> function, as long as it learned about the "quiet" flag.
>
> Hmm, I obviously missed an opportunity....
> ...
> But you are right.  config-parse-key does have the simpler string
> that can just be given to the canonicalize thing and we should be
> able to reuse it.

Actually, I think we can just use the existing config_parse_key()
instead of adding the new function.  It adds one allocation and
deallocation, but it's not like this is a performance-critical
codepath that we absolutely avoid extra allocations.  After all, we
are still using the strbuf-split thing :-/.

The attached patch shows the updated fix.  It needs a preparatory
code move (not shown here) to make git_config_parse_key() available
to git_config_parse_parameter(), though.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 23 Feb 2017 15:04:40 -0800
Subject: [PATCH] config: reject invalid VAR in 'git -c VAR=VAL command' and
 keep subsection intact

The parsing of one-shot assignments of configuration variables that
come from the command line historically was quite loose and allowed
anything to pass.  It also downcased everything in the variable name,
even a three-level <section>.<subsection>.<variable> name in which
the <subsection> part must be treated in a case sensible manner.

Existing git_config_parse_key() helper is used to parse the variable
name that comes from the command line, i.e. "git config VAR VAL",
and handles these details correctly.  Replace the strbuf_tolower()
call in git-config_parse_parameter() with a call to it to correct
both issues.  git_config_parse_key() does a bit more things that are
not necessary for the purpose of this codepath (e.g. it allocates a
separate buffer to return the canonicalized variable name because it
takes a "const char *" input), but we are not in a performance-critical
codepath here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c               | 14 ++++++++----
 t/t1300-repo-config.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index b8cce1dffa..39f20dcd2c 100644
--- a/config.c
+++ b/config.c
@@ -295,7 +295,9 @@ int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
+	char *canonical_name;
 	struct strbuf **pair;
+	int ret = 0;
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
@@ -313,13 +315,15 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
-	if (fn(pair[0]->buf, value, data) < 0) {
-		strbuf_list_free(pair);
+
+	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL))
 		return -1;
-	}
+
+	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
+
+	free(canonical_name);
 	strbuf_list_free(pair);
-	return 0;
+	return ret;
 }
 
 int git_config_from_parameters(config_fn_t fn, void *data)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5a26..ea371020fa 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1097,6 +1097,68 @@ test_expect_success 'multiple git -c appends config' '
 	test_cmp expect actual
 '
 
+test_expect_success 'last one wins: two level vars' '
+
+	# sec.var and sec.VAR are the same variable, as the first
+	# and the last level of a configuration variable name is
+	# case insensitive.
+
+	echo VAL >expect &&
+
+	git -c sec.var=val -c sec.VAR=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+
+	git -c sec.var=val -c sec.VAR=VAL config --get SEC.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.VAR >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'last one wins: three level vars' '
+
+	# v.a.r and v.A.r are not the same variable, as the middle
+	# level of a three-level configuration variable name is
+	# case sensitive.
+
+	echo val >expect &&
+	git -c v.a.r=val -c v.A.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.A.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+
+	# v.a.r and V.a.R are the same variable, as the first
+	# and the last level of a configuration variable name is
+	# case insensitive.
+
+	echo VAL >expect &&
+	git -c v.a.r=val -c v.a.R=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.a.R=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual
+'
+
+for VAR in a .a a. a.0b a."b c". a."b c".0d
+do
+	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
+		test_must_fail git -c "$VAR=VAL" config -l
+	'
+done
+
+for VAR in a.b a."b c".d
+do
+	test_expect_success "git -c $VAR=VAL works with valid '$VAR'" '
+		echo VAL >expect &&
+		git -c "$VAR=VAL" config --get "$VAR" >actual &&
+		test_cmp expect actual
+	'
+done
+
 test_expect_success 'git -c is not confused by empty environment' '
 	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
 '
-- 
2.12.0-rc2-289-g9f26f1516a




