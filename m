Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A262047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdITF1K (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:27:10 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:56649 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdITF1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:27:09 -0400
Received: by mail-pg0-f44.google.com with SMTP id 7so1103737pgd.13
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t3R/voPSQL8/geF022mb3jhxy2eFV+pJIIX5arf3xgM=;
        b=GXVkyzgKWeEbwGwVGpW5aDzG/pH2ksqx/z9IoHYUvssTxNX5TvfZgOXB40vIu7ezr9
         5vVNbhqMcTfeWLiGHSPy30Tw1CpdVH2aEwW/lbRO5lrwWIpr8KHZlNlV9AJsoY3wspgm
         28+dhbliNna8x/cJxm6Qy9uon87R7YvFDMQNTeZE0pUm/8uVQp+3s099M1M+nIjG3RxO
         lwquR+MqHoULtpw/XlBKZ0/z3Q0ye/Hzmguh9xVM2DvJOB1IYEKDfWQA8tmLnugWJ6jL
         t5D9trFVe6TT/uf3omsjLojkJSxEWsqSBhV64KzeAsK89P/Hsd/pt/22uol+PhDoTf5G
         ARRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t3R/voPSQL8/geF022mb3jhxy2eFV+pJIIX5arf3xgM=;
        b=hmvAGYyxM75pQWWCeW5hYsv95Ze5Fk3h3Tuu7xiL553NTON5++9NxTdRa2vCV5JGLu
         1tN8qX0+dNpkEoZYu3YsZ5si+s4JJAk5le7AocNTjrypYePLqw3CwF4rGiPzd8ZuJBAZ
         ouGc94yjmUycdY5UUM1JK6qG2MJJRiy+kcYlQDx2GtnqOvKGvfs3H+07PRMXC8fzZIMb
         DWkRsnSGSnfr3qjcfV9DTdoLkUYInXCYT7vLMdPTsmh3PF8tZPyNTqaV09HxMpa52Sn3
         0PD+6sOYLMGqWwguTQPY9lmorIlqiDhR7+7rj0H+U2m0JO69kDHFAyiEYzymoae/vglJ
         +3iw==
X-Gm-Message-State: AHPjjUgJNzmpZTCeOURP5bTXHpyFN9lJ6UhJY+YvpGb7Nc37CJC2fY9y
        W6uFTtnq8y7vnvsAS300B1w=
X-Google-Smtp-Source: AOwi7QAaYcdNSoEKAXAHZ85REokV6sERrtbdMY0yPS8UPGsOcOhOTFiuoedTryAR+82oJNWypLJE4g==
X-Received: by 10.84.129.100 with SMTP id 91mr942150plb.198.1505885228349;
        Tue, 19 Sep 2017 22:27:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id i12sm5270049pgr.21.2017.09.19.22.27.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 22:27:07 -0700 (PDT)
Date:   Tue, 19 Sep 2017 22:27:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2] for_each_string_list_item: avoid undefined behavior for
 empty list
Message-ID: <20170920052705.GC126984@aiede.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <20170920023008.GB126984@aiede.mtv.corp.google.com>
 <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Haggerty <mhagger@alum.mit.edu>

If you pass a newly initialized or newly cleared `string_list` to
`for_each_string_list_item()`, then the latter does

    for (
            item = (list)->items; /* NULL */
            item < (list)->items + (list)->nr; /* NULL + 0 */
            ++item)

Even though this probably works almost everywhere, it is undefined
behavior, and it could plausibly cause highly-optimizing compilers to
misbehave.  C99 section 6.5.6 paragraph 8 explains:

    If both the pointer operand and the result point to elements
    of the same array object, or one past the last element of the
    array object, the evaluation shall not produce an overflow;
    otherwise, the behavior is undefined.

and (6.3.2.3.3) a null pointer does not point to anything.

Guard the loop with a NULL check to make the intent crystal clear to
even the most pedantic compiler.  A suitably clever compiler could let
the NULL check only run in the first iteration, but regardless, this
overhead is likely to be dwarfed by the work to be done on each item.

This problem was noticed by Coverity.

[jn: using a NULL check instead of a placeholder empty list;
 fleshed out the commit message based on mailing list discussion]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 string-list.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> ...  But a quick test with gcc 4.8.4
>> -O2 finds that at least this compiler does not contain such an
>> optimization.  The overhead Michael Haggerty mentioned is real.
>
> Still, I have a feeling that users of string_list wouldn't care
> the overhead of single pointer NULL-ness check.
>
>  - apply.c collects conflicted paths and reports them with fprintf().
>
>  - builtin/clean.c uses the function to walk the list of paths to be
>    removed, and either does a human interaction (for "-i" codepath)
>    or goes to the filesystem to remove things.
>
>  - builtin/config.c uses it in get_urlmatch() in preparation for
>    doing network-y things.
>
>  - builtin/describe.c walks the list of exclude and include patterns
>    to run wildmatch on the candidate reference name to filter it out.
>
>  ...
>
> In all of these examples, what happens for each item in the loop
> seems to me far heavier than the overhead this macro adds.

Yes, agreed.  As a small tweak,

   #define for_each_string_list_item(item, list) \
	for (item = ...; item && ...; ...)

produces nicer assembly than

   #define for_each_string_list_item(item, list) \
	for (item = ...; list->items && ...; ...)

(By the way, the potential optimization I described isn't valid: we
know that when item == NULL and list->items == NULL, list->nr is
always zero, but the compiler has no way to know that.  So it can't
eliminate the NULL test.  For comparison, a suitably smart compiler
should be able to eliminate a 'list->nr != 0 &&' guard if 'list'
doesn't escape in the loop body.)

Recapping the other proposed fixes:

A. Make it an invariant of string_list that items is never NULL and
   update string_list_init et al to use an empty array.  This is
   pretty painless until you notice some other structs that embed
   string_list without using STRING_LIST_INIT.  Updating all those
   would be too painful.

B. #define for_each_string_list_item(item, list) \
	if (list->items) \
		for (item = ...; ...; ... )

   This breaks a caller like
	if (foo)
		for_each_string_list_item(item, list)
			...
	else
		...

   making it a non-starter.

C. As Gábor suggested,
   #define for_each_string_list_item(item, list) \
   	if (!list->items) \
		; /* nothing to do */ \
	else \
		for (item = ...; ...; ...)

   This handles the caller from (B) correctly.  But it produces
   compiler warnings for a caller like

	if (foo)
		for_each_string_list_item(item, list)
			...

   There is only one instance of that construct in git today.  It
   looks nicer anyway with braces, so this approach would also be
   promising.

D. Eliminate for_each_string_list_item and let callers just do

	unsigned int i;
	for (i = 0; i < list->nr; i++) {
		struct string_list_item *item = list->items[i];
		...
	}

   Having to declare item is unnecessarily verbose, decreasing the
   appeal of this option.  I think I like it anyway, but I wasn't able
   to convince coccinelle to do it.

E. Use subtraction instead of addition:
   #define for_each_string_list_item(item, list) \
   	for (item = ...; \
	     (item == list->items ? 0 : item - list->items) < nr; \
	     item++)

   I expected the compiler to figure out that this is a long way of writing
   (item - list->items), but at least with gcc 4.8.4 -O2, no such
   luck.  This generates uglier assembly than the NULL check.

diff --git a/string-list.h b/string-list.h
index 29bfb7ae45..79ae567cbc 100644
--- a/string-list.h
+++ b/string-list.h
@@ -32,8 +32,10 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
-#define for_each_string_list_item(item,list) \
-	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
+#define for_each_string_list_item(item,list)            \
+	for (item = (list)->items;                      \
+	     item && item < (list)->items + (list)->nr; \
+	     ++item)
 
 /*
  * Apply want to each item in list, retaining only the ones for which
-- 
2.14.1.821.g8fa685d3b7

