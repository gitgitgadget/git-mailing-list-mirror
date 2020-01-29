Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A1C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F5206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 13:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="all9eKWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA2N7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:59:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39971 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2N7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 08:59:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so13245101qto.7
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EgAQFrie9tXE7DrBaHe1b0iLwXCvu2W6Nl9fovy2Nu0=;
        b=all9eKWR9agGkUMErqyU6mFjsn2Cn8L9kMQOKAKEfxQ0CxLQwq6MlYMSfJA7s9H9Pb
         P/rgRoRW2axz+BECh1qg57dOzEfxBjOjeJS617UL6V7JQXdB8hVGZPvK7d96r0fW3LbE
         8vHJg861KS8JTwX3U6+77rSKJKb1EPa3kHAv0aSxPxls3kmcFQDrLeqwmsl1KXLMYjEY
         UjYquElh8Gj/7B16hRDHavvGzbqrJQU7dNbeDNX9Xd4ljc8JHxZymzHI/DwybSSqLpke
         dq5u1WWUowKuOMAeLZGv+h6NDAGPY1AeUS8jMPJZBNNWMmU5qDO/OsqhIhdGAe6lCIoO
         KvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EgAQFrie9tXE7DrBaHe1b0iLwXCvu2W6Nl9fovy2Nu0=;
        b=o4P2CUJgTlaV1lE5tAnn7ox6w55Qn+Ltcx8y1d7AO4cUlOtItso85fUwzJd5BPiaBA
         zPr7riGHS9pbsj+66fTcFtv/MUPKG0gn19yJtK4y+x1VNwj3TctJRhBFjN/2A/+HFA+q
         5pC0nZHCh5+v4hfaWYrzbWktDiH/KIYU0VI3iVkj7TeCEoUKhuD57NW+ljG1jGbqiH3x
         rLe8kjfz0V0t8wwggupkqn/I3VnhnpwarRDD3cJzPFTbKRwoFdNh8qYW4k/lQn/L+Tyk
         Eo826ktf5MnGjMrsts6GE1Mqus+mLmej99W3kaaNsgKpi32qDqZRJ+IZ1NmzDE6Mev79
         vx3w==
X-Gm-Message-State: APjAAAVwxMmY2rZ5wfzjmln2ropqrHNSRXq93k2IQSTYlPFIAAXYBgua
        MZ3TglksJjGHEPjoxAHO5Xo=
X-Google-Smtp-Source: APXvYqyeZ41RjDajyu4i4o1hoHztfawtEPV9d62zO4ZASkEi6csxHmzcPM/YxazKsI0Pjs1XCaVl+g==
X-Received: by 2002:ac8:cb:: with SMTP id d11mr21059351qtg.22.1580306340964;
        Wed, 29 Jan 2020 05:59:00 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id 64sm983633qkk.123.2020.01.29.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:59:00 -0800 (PST)
Subject: Re: [PATCH v3 09/12] sparse-checkout: properly match escaped
 characters
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <9ea69e90694e53842acd68d3ac85c9a00c4bd343.1580236003.git.gitgitgadget@gmail.com>
 <20200129100309.GA4218@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6003bbf2-ad16-0686-dc58-2010fe02ce05@gmail.com>
Date:   Wed, 29 Jan 2020 08:58:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200129100309.GA4218@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 5:03 AM, Jeff King wrote:
> On Tue, Jan 28, 2020 at 06:26:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> In cone mode, the sparse-checkout feature uses hashset containment
>> queries to match paths. Make this algorithm respect escaped asterisk
>> (*) and backslash (\) characters.
> 
> Do we also need to worry about other glob metacharacters? E.g., "?" or
> ranges like "[A-Z]"?

These are not part of the .gitignore patterns [1].

[1] https://git-scm.com/docs/gitignore#_pattern_format

>> +static char *dup_and_filter_pattern(const char *pattern)
>> +{
>> +	char *set, *read;
>> +	char *result = xstrdup(pattern);
>> +
>> +	set = result;
>> +	read = result;
>> +
>> +	while (*read) {
>> +		/* skip escape characters (once) */
>> +		if (*read == '\\')
>> +			read++;
>> +
>> +		*set = *read;
>> +
>> +		set++;
>> +		read++;
>> +	}
>> +	*set = 0;
>> +
>> +	if (*(read - 2) == '/' && *(read - 1) == '*')
>> +		*(read - 2) = 0;
>> +
>> +	return result;
>> +}
> 
> Do we need to check that the pattern is longer than 1 character here? If
> it's a single character, it seems like this "*(read - 2)" will
> dereference the byte before the string.

This method is only called by add_pattern_to_hashsets(), which
has a guard against paths of length less than 2, but thats' no
excuse for dangerous pointer arithmetic here.

But you also point out an even more confusing thing: why are we
modifying based on the 'read' pointer, and not the 'set' pointer?
This seems to work _accidentally_ only when the pattern has "<something>/*"
and "<something>" has no escape characters.

I had to recall exactly why we are dropping this "/*", but it's because
the pattern _actually_ ends with "/*/" but the in-memory pattern has
already dropped that last slash and applied PATTERN_FLAG_MUSTBEDIR.

Here is a diff that I can apply to this patch to fix this problem
_and_ demonstrate it in the tests:

diff --git a/dir.c b/dir.c
index 579f274d13..277577c8bf 100644
--- a/dir.c
+++ b/dir.c
@@ -633,6 +633,7 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 static char *dup_and_filter_pattern(const char *pattern)
 {
        char *set, *read;
+       size_t count  = 0;
        char *result = xstrdup(pattern);
 
        set = result;
@@ -647,11 +648,14 @@ static char *dup_and_filter_pattern(const char *pattern)
 
                set++;
                read++;
+               count++;
        }
        *set = 0;
 
-       if (*(read - 2) == '/' && *(read - 1) == '*')
-               *(read - 2) = 0;
+       if (count > 2 &&
+           *(set - 1) == '*' &&
+           *(set - 2) == '/')
+               *(set - 2) = 0;
 
        return result;
 }
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 0a21a5e15d..20b0465f77 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -383,6 +383,7 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
        /*
        !/*/
        /zbad\\dir/
+       !/zbad\\dir/*/
        /zdoes\*not\*exist/
        /zdoes\*exist/
        EOF

With this extra line in the test, but compiling the old version of this patch,
the test fails with:

'err' is not empty, it contains:
+ cat err
warning: unrecognized negative pattern: '/zbad\\dir/*'
warning: disabling cone pattern matching

To ensure this negative pattern exists in the later patch where we set
the patterns using the builtin, I'll add "zbad\\dir/bogus" to the list
of directories to include, which will add another pattern to the set.

Thanks,
-Stolee

