Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02105C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C909C61038
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhHMUzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHMUzU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:55:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64036C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:54:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y3-20020a17090a8b03b02901787416b139so8528979pjn.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=re06yzYgVwuMjjndOtrCFk6AaabJcuYmM3BFMKhk5EQ=;
        b=PJLcdSl71XYHRMGJC6rAJx82xgji0Awt+ng1KOWgwZu2vF21BIbSU3sa0/3dIRNMjB
         9Q4aWE7eJvajSmEEAIzhRlTmmWA97pP9vLG/6Peff+ffcrkYf7sjQTXmjsA/rb1JYbDz
         8F03pZCPbg+ULb5uciZcUE3JZ0STKOta4K5p01gC1G0+/a7sI9rwOyZ3rLPyNRDfihol
         NaQVeG8tBp8Pl7XNWtaVwiZV7JpOQbll+ouffOEUud8zBpiucaGyxoGA+AsMfwIvVii9
         +gJL77dHt5bEBbCIBOPtKkKHcTsEWjlIT/5Y5+XhmxAhLkT70oSyhkW60PGKW09lKbpi
         zhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=re06yzYgVwuMjjndOtrCFk6AaabJcuYmM3BFMKhk5EQ=;
        b=Dt2xbQ+NtqDw+POp36FFPUGS30/ZNcHrBwf1Q8TbPtvDLuLtg9X6FxD9AxjNK0QPlI
         a+bc6tuW1H6dY3zEmr63FSid68o8hJb9q2wR/yDu3DzJ/dx957m5HZ1VBpTb2PkSLPzq
         CVybi2VNoRrFfO6M0JejtC6hsYxt42myfsMELtuZpLaFHVts9R8JKvZQx8hMp/ssTgIb
         lXpUiHOLqI9pV2Whq4icNeClrpDwnhllqNsSR7LNeduC9VW+WRaH/xQzHt/pTI6oezA+
         APjtqd6jbFLMwi5XlA4t74/wMaanDs67m2E2cs+mJHivdBZB7RSpe14giLeeWIkV2n66
         ru2Q==
X-Gm-Message-State: AOAM531HbC+k5ZY3khj0D2t7lfYrn29FBYX+1yKttRuPyE6GCl3B0HVJ
        70Vxzo2DVMQMym6VzpXY7WBiCH2dSCiI5Qtev080
X-Google-Smtp-Source: ABdhPJyw4pH44iezEKbyhlGI1Rr1Dt0n2VJSfZs39pXx4lVYwUDXjmutrXDMMXg/b9UzNywGhANHdT9GwT+Zb9r6uLvg
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:fd2:: with SMTP id
 gd18mr4305178pjb.155.1628888092815; Fri, 13 Aug 2021 13:54:52 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:54:49 -0700
In-Reply-To: <patch-6.7-57e3f246f4f-20210720T102644Z-avarab@gmail.com>
Message-Id: <20210813205449.1198555-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-6.7-57e3f246f4f-20210720T102644Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v9 6/7] refs: explicitly return failure_errno from parse_loose_ref_contents
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        hanwen@google.com, mhagger@alum.mit.edu, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -448,26 +454,28 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  	}
>  	strbuf_reset(&sb_contents);
>  	if (strbuf_read(&sb_contents, fd, 256) < 0) {
> -		int save_errno = errno;
>  		close(fd);
> -		errno = save_errno;
>  		goto out;
>  	}

[snip unrelated code]

>  out:
> -	*failure_errno = errno;
> +	if (ret && !myerr)
> +		BUG("returning non-zero %d, should have set myerr!", ret);

At $DAYJOB, some people have observed this BUG triggering. Right now I
don't have a consistent reproduction recipe, but we noticed that the
block starting with "if (strbuf_read" quoted above does not set myerr
upon an error, and instead immediately jumps to "out" with ret being -1.
