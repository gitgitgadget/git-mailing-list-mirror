Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C760EC352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FC42082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPdxsRvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBJOiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:38:55 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34178 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBJOiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:38:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so3275566qvf.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7viMafEG6GlMRQ8eBx7yUnK389nD1yVs6FZqMPQS6DI=;
        b=sPdxsRvELd+Tgsmfmi5aresnBUG7PW2V2pYztEwW0SqeH8XVd+XjDLbzh7MLRiOGgu
         jwDcRmAE3jaztQvE7UceMwNg9XsoiaUhroBV1u6zqkQ6nLvjdJOY/i+VnRxWUkSxtf6C
         HTnbSkWdqLzle6m4k2wUaFspLzBDiR/y6DHaYkdtziSbsBTFrPGBls06+v662y+fhFX6
         cKY1lOIqW+Je9kgyPnZKkOBUWmfb+RARArURY0OXvSCAJlCbvIUAyfLzUUGQOn+T17QP
         l0ZdllojmUhDAMybaqGpU5mBetPRqG9ut0Aj0r5lkLODjOTtxGcFMUWfGuDk60Y8jNnz
         fgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7viMafEG6GlMRQ8eBx7yUnK389nD1yVs6FZqMPQS6DI=;
        b=X3/Ha6aLoBixjc91WPUFMnLW14AB7v2wDAanF6H/7muaO+A99cp0efkTuG7TVjrkWS
         uNdaB43BH9U6tDEFPHqoXb5Zmd+D6yaqQlK1cKIdyEIfsJsaVXX0oSgj43obXoB9bqtw
         SOaU8oosOsVrqOCHXfl1W4BmMv8pHn5CTK4Ma80Cbpqastx8odSseW6k8dYJgVXHb6sB
         5p/6nPV0MjlDvbQP9K1jzNIQz5o9E6/mQfmb4OXDl4+SUCvwmOz5bc1bAoxb0/kGMQ1i
         TEgI+LedTWM1ov0+0N0NAEtaiU0ecV80jf3Ek8HmMkqqcPRHV9Ry77wuIPziBX1/t1+G
         DXXg==
X-Gm-Message-State: APjAAAWRbN2TRyiDaiUOKhgv+Dp8pnOcpFHQvLYajMIbexDjKTXIv+0Q
        FUorMTv7QlYAwo81abXeHi+W5K7foJA=
X-Google-Smtp-Source: APXvYqwQ2e4FV+IaD1C41k3dvtkFejuxNJ//IReVLOxXaSaDk/LstcdYOe9waI8UFpg4usHKkOp6Fg==
X-Received: by 2002:ad4:5a52:: with SMTP id ej18mr9791751qvb.172.1581345534209;
        Mon, 10 Feb 2020 06:38:54 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3922:b15f:4fe8:fef? ([2001:4898:a800:1010:ea57:b15f:4fe8:fef])
        by smtp.gmail.com with ESMTPSA id 63sm231757qki.57.2020.02.10.06.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 06:38:52 -0800 (PST)
Subject: Re: [PATCH] advice: refactor advise API
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
Date:   Mon, 10 Feb 2020 09:38:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2020 12:04 AM, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Add a new advise_ng function that can check the visibility of advice
> messages before printing.
>
> Currently it's very easy for the callers to miss checking the
> visibility step. Also, it makes more sense for this step to be handled
> by the advice library.

This makes the advice API much easier and its uses much cleaner. Thanks!
 
> Also change the advise call in tag library from advise() to advise_ng()
> to construct an example of the usage of the new API.

This is a good example case.

> +static const char turn_off_instructions[] =
> +N_("\n"
> +"Turn this message off by running\n"
> +"\"git config %s false\"");

I have mixed feelings on the use of these instructions. Perhaps at
minimum the addition of these instructions could be left to a
separate patch than the creation of advise_ng().

My biggest concern is that this adds unexpected noise to users who
want the advice to stay. I'm calling attention to it, because this
part isn't a simple refactor like the rest of the patch.

If it _does_ stay, then I recommend condensing the message to
a single line. For example:

	Disable this message with "git config %d false"

> +void advise_ng(const char *key, const char *advice, ...)
> +{
> +	int value = 1;
> +	struct strbuf buf = STRBUF_INIT;
> +	va_list params;
> +	const char *cp, *np;
> +	
> +	git_config_get_bool(key, &value);
> +	
> +	if(value)
> +	{

Style: spacing, and opening braces are on the same line as the if:

	if (value) {

But also, this method would be simpler if the opposite case was
an early return:

	if (!value)
		return;

Then the rest could have one less indentation.

> +		va_start(params, advice);
> +		strbuf_vaddf(&buf, advice, params);
> +		va_end(params);
> +
> +		strbuf_addf(&buf, turn_off_instructions, key);
> +
> +		for (cp = buf.buf; *cp; cp = np) {
> +			np = strchrnul(cp, '\n');
> +			fprintf(stderr,	_("%shint: %.*s%s\n"),
> +				advise_get_color(ADVICE_COLOR_HINT),
> +				(int)(np - cp), cp,
> +				advise_get_color(ADVICE_COLOR_RESET));
> +			if (*np)
> +				np++;
> +		}
> +		strbuf_release(&buf);

This loop looks like it was copied from advise(). Perhaps we could
re-use that code better by creating a new vadvise() method that
takes a va_list, and have advise() and advise_ng() call it instead?
I include a patch at the end of this method that does this conversion.
(Feel free to incorporate it into your next version, if you want, but
be sure to add your sign-off.) Then, your advise_ng() can call these:

	vadvise(advice, params);
	advise(turn_off_instructions, key);

removing the need to re-implement the for loop.

> diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
> new file mode 100644
> index 0000000000..b6ec90fd18
> --- /dev/null
> +++ b/t/helper/test-advise.c
> @@ -0,0 +1,15 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "advice.h"
> +
> +int cmd__advise_ng(int argc, const char **argv)
> +{
> +	if (!argv[1] || !argv[2])
> +	die("usage: %s <key> <advice>", argv[0]);
> +
> +	setup_git_directory();
> +
> +	advise_ng(argv[1], argv[2]);
> +
> +	return 0;
> +}

I definitely tend to recommend more tests than most, but perhaps this
unit test is overkill? You demonstrate a good test below using a real
Git command, which should be sufficient. If the "turn this message off"
part gets removed, then you will still have coverage of your method.
It just won't require a test change because it would not modify behavior.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 6db92bd3ba..b7c8d41899 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1726,6 +1726,8 @@ test_expect_success 'recursive tagging should give advice' '
>  	hint: already a tag. If you meant to tag the object that it points to, use:
>  	hint: |
>  	hint: 	git tag -f nested annotated-v4.0^{}
> +	hint: Turn this message off by running
> +	hint: "git config advice.nestedTag false"
>  	EOF
>  	git tag -m nested nested annotated-v4.0 2>actual &&
>  	test_i18ncmp expect actual
> 
> base-commit: c7a62075917b3340f908093f63f1161c44ed1475

Thanks,
-Stolee

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 10 Feb 2020 09:33:20 -0500
Subject: [PATCH] advice: extract vadvise() from advise()

In preparation for a new advice method, extract a version of advise()
that uses an explict 'va_list' parameter. Call it from advise() for a
functionally equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 advice.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf3..fd836332da 100644
--- a/advice.c
+++ b/advice.c
@@ -96,15 +96,12 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-void advise(const char *advice, ...)
+static void vadvise(const char *advice, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -118,6 +115,14 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params);
+	va_end(params);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-- 
2.25.0.vfs.1.1.1.g9906319d24.dirty



