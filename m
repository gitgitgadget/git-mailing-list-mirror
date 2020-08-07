Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A1C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76D420855
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 00:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vOy6joSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGAXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:23:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65474 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGAXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 20:23:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE3280C13;
        Thu,  6 Aug 2020 20:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fZ/HwrntflL1kr6WqWnhVPzYm30=; b=vOy6jo
        SBYpnsAv/8ytjVDeFzcka7FByxc5nDMeiv4z/13tHAt5nAdCJ2EhxHZtuSjAdfUI
        Qs+Su1Qwtni4Im0VSUzENTypTwDLUCG8NoCRaxfQCp5w7TpQLyRG4HZbktuJ2/ee
        HVjIZG+avm1rHkdqsjmJS0mdjo2HIaTBDYLJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QUZCp92mgqlPasYdXpruwElX4Tdy9rOM
        ByGHLCRIYayauuYv+mb6VFC1JH0FpXd34EmG8fT4MccD/ty+HQjr4XcAt4t7xfc9
        vdrroLLBdL4gp+42yqjqGlt4Ec0JD8UT6geL/psdMqcnof1eD/z8sEP93la5qZH7
        xGeKszexa3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C32F180C12;
        Thu,  6 Aug 2020 20:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AE8B80C10;
        Thu,  6 Aug 2020 20:23:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
        <20200807000126.GC8085@camp.crustytoothpaste.net>
Date:   Thu, 06 Aug 2020 17:23:07 -0700
In-Reply-To: <20200807000126.GC8085@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 7 Aug 2020 00:01:26 +0000")
Message-ID: <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B404DB6-D844-11EA-A227-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-08-06 at 23:47:34, Junio C Hamano wrote:
>> I am wondering if it is a good idea to use something like
>> 
>>     static inline void precompose_argv(int argc, const char **argv)
>>     {
>> 	; /* nothing */
>>     }
>> 
>> instead.  As long as the compiler is reasonable enough, this should
>> not result in any code change in the result, except that it would
>> still catch wrong arguments, even if these two parameters are unused
>> and optimized out.
>
> Yes, this seems like a prudent approach.  I believe it's widely used by
> the Linux kernel, so presumably compilers are capable enough to optimize
> it out.  As you noted, it provides type checking for all platforms,
> which is nice.

So I hope the following (untested and not signed off yet) may lead
us in the right direction?

-- >8 --
Subject: compat-util: type-check parameters of mocked functions

When there is no need to run a specific function on certain platforms,
we often #define an empty function to swallow its parameters and
make it into a no-op, e.g.

    #define precompose_argv(c,v) /* no-op */

While this guarantees that no unneeded code is generated, it also
discards type and other checks on these parameters, e.g. a new code
written with the argv-array API (diff_args is of type "struct
argv_array" that has .argc and .argv members):

    precompose_argv(diff_args.argc, diff_args.argv);

must be updated to use "struct strvec diff_args" with .nr and .v
members, like so:

    precompose_argv(diff_args.nr, diff_args.v);

after the argv-array API has been updated to the strvec API.
However, the "no oop" C preprocessor macro is too aggressive to
discard what is unused, and did not catch such a call that was left
unconverted.

Using a "static inline" function whose body is a no-op should still
result in the same binary with decent compilers yet catch such a
reference to a missing field or passing a value of a wrong type.

While at it, I notice that precompute_str() has never been used
anywhere in the code, since it was introduced at 76759c7d (git on
Mac OS and precomposed unicode, 2012-07-08).  Instead of turning it
into a static inline, just remove it.

---
 git-compat-util.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5637114b8d..7a0fb7a045 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -252,8 +252,10 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-#define precompose_str(in,i_nfd2nfc)
-#define precompose_argv(c,v)
+static inline void precompose_argv(int argc, const char **argv)
+{
+	; /* nothing */
+}
 #define probe_utf8_pathname_composition()
 #endif
 
@@ -270,7 +272,9 @@ struct itimerval {
 #endif
 
 #ifdef NO_SETITIMER
-#define setitimer(which,value,ovalue)
+static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
+	; /* nothing */
+}
 #endif
 
 #ifndef NO_LIBGEN_H
@@ -1231,8 +1235,14 @@ int warn_on_fopen_errors(const char *path);
 #endif
 
 #ifndef _POSIX_THREAD_SAFE_FUNCTIONS
-#define flockfile(fh)
-#define funlockfile(fh)
+static inline void flockfile(FILE *fh)
+{
+	; /* nothing */
+}
+static inline void funlockfile(FILE *fh)
+{
+	; /* nothing */
+}
 #define getc_unlocked(fh) getc(fh)
 #endif
 
