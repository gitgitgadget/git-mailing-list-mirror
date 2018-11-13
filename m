Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2E01F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 03:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeKMNUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 08:20:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeKMNUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 08:20:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4272C113018;
        Mon, 12 Nov 2018 22:24:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IOeYAlF6PBRUjkRx58swk7TGS48=; b=hwOuHS
        ynz+sVl7+JedkUNC2LtYNEBvJXEue9veLI9t+oJOFmXH319DAFbxFVhslKPGMZe6
        tlDmZ2pbklHMBm5E9nsVGLTyeOhxGdNn0dXSXwoPtYAIWVne/sY5+LtPPKPxMhWt
        CFNX2CMPvz+CHOyDzNDIM2Gom8Dgecy90H6v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kFAQc+xg7LqlL2rLXZe1BIQK/mhkxBOe
        /c4MLPCqORJJmibGG7iWS1CZA8pcXIpJZr3hL0BaP2OtoGb/qfphy1r2d0s9+Upy
        Tl1c/NVyz3E9acDqOZinYt17U3KhZ9MXqSixrUJfg7bgx7c0grMSR08TFiZ10NFZ
        frJjROnuYbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39F7C113017;
        Mon, 12 Nov 2018 22:24:41 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A47C8113016;
        Mon, 12 Nov 2018 22:24:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re* [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        <CAGZ79kaPjw3UbYY=XL0gyKp2VxghwaUOJJoDhiO5sQpT8OWerQ@mail.gmail.com>
Date:   Tue, 13 Nov 2018 12:24:39 +0900
In-Reply-To: <CAGZ79kaPjw3UbYY=XL0gyKp2VxghwaUOJJoDhiO5sQpT8OWerQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 12 Nov 2018 14:33:57 -0800")
Message-ID: <xmqqy39xwtfs.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A81F7A44-E6F3-11E8-A9DE-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +       if (have_advertised_versions_already)
>> +               BUG(_("attempting to register an allowed protocol version after advertisement"));
>
> If this is a real BUG (due to wrong program flow) instead of bad user input,
> we would not want to burden the translators with this message.
>
> If it is a message that the user is intended to see upon bad input
> we'd rather go with die(_("translatable text here"));

Yeah, good suggestion.  

Perhaps we should spell it out in docstrings for BUG/die with the
above rationale.  A weatherbaloon patch follows.

 git-compat-util.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 96a3f86d8e..a1cf68cbbc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -420,7 +420,16 @@ static inline char *git_find_last_dir_sep(const char *path)
 
 struct strbuf;
 
-/* General helper functions */
+/*
+ * General helper functions
+ *
+ * Note that these are to produce end-user facing messages, and most
+ * of them should be marked for translation (the exception is
+ * messages generated to be sent over the wire---as we currently do not
+ * have a mechanism to notice and honor locale settings used on the
+ * other end, leave them untranslated.  We should *not* send messages
+ * that are localized for our end).
+ */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -1142,6 +1151,17 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
+/*
+ * BUG(fmt, ...) is to be used when the problem of reaching that point
+ * in code can only be caused by a program error.  To abort with a
+ * message to report impossible-to-continue condition due to external
+ * factors like end-user input, environment settings, data it was fed
+ * over the wire, use die(_(fmt),...).
+ * 
+ * Note that the message from BUG() should not be marked for
+ * translation while the message from die() is in general end-user
+ * facing and should be marked for translation.
+ */
 #ifdef HAVE_VARIADIC_MACROS
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
