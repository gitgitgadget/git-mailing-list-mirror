Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED367C55185
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACA22075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+GrlMYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDWBUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWBUo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 21:20:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F243C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:20:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q18so2026712pgm.11
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FSAtoTYklJcXBWodtdmOQseSUXBXOgyrYSgFH2oXWwI=;
        b=m+GrlMYUV/0w9N5DmVZAX4qhf1c0Ve1WIIV4Fr7IYyOYeJFFZqB4u0aXefSMmjXkjy
         +QJhsK2qx+lR6D1/5a54UDSwjT86ZSKZzP0eBdwXBe5i7g3+C4ua+sH/aAiW3e0KZyiy
         TQduWxq4cbakQpxHTbYka0ihXoEKMcDx0Y8mXLCs+RaNFZH/WaBmoQ7QhA5Q8R17ese3
         MJVWvDWnixPxIWyAdzoF05F7tOtZj7MXHXJAqLXlL/YNItesjohsVC6xqqb4zCGvtpF6
         vaG0rLcyVPbe0n8viaayy3/4IbIVFmFVOVas6q7sHwPsqt4ZKx0CsYqgr0jN/0eu1AD5
         csqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FSAtoTYklJcXBWodtdmOQseSUXBXOgyrYSgFH2oXWwI=;
        b=qbJdjcCZbql0ZrzYE8YJqBhyurLp5SNC9paimiKrdS+1wNVyjDRpTaFtAknotwGA9W
         4tyOYlkgx9ZRT0UGWK19cG/WKpzDqej+LVoZ8V0Y2ROVmsXdqzjB4rHUN526+gzD5sla
         NjZTa6YDBF5DMLlyOmz2bmG6L7PJ7qzPK1JsxJDKnR07LXwnD+NWeez+R1/XUWIgZC5X
         Fw2Bsv5V9h3xtAfjvFmCaUW5pb9Wz3O8cFBkcMiGi9ltfDGskovDWlmXpuDGE8tFn2/V
         9qWD9U6Gz/zlvPKAw7gnkP2tebGxJSF9K0pFkIqJNWqnaq4lj5M35izIsvVNaGbhj/DU
         O9HA==
X-Gm-Message-State: AGi0PuZ7P7LBwt6Sb2AeDFJWSKuiUwFYUpX7YYcVqecIlcTjnvZkCzzk
        zy33agXeqdne7FRlnIq61UQ=
X-Google-Smtp-Source: APiQypLMZgIS9QdsRDRDsDbNQ1vLmFnOau+EvLwUOyOWUj7dk/z6B3/UTg+rRb71OfZnFapCuuCsmw==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr1352363pfj.256.1587604842933;
        Wed, 22 Apr 2020 18:20:42 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id o99sm469671pjo.8.2020.04.22.18.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:20:42 -0700 (PDT)
Date:   Thu, 23 Apr 2020 08:20:40 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] date.c: allow compact version of ISO-8601 datetime
Message-ID: <20200423012040.GB1930@danh.dev>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <225b6401bd1f7eddc245acfd2c4b37c50c978491.1587559135.git.congdanhqx@gmail.com>
 <xmqqftcvjv80.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqftcvjv80.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-22 10:17:35-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  date.c          | 22 ++++++++++++++++++++++
> >  t/t0006-date.sh |  3 +++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/date.c b/date.c
> > index 62f23b4702..882242c2db 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -672,6 +672,28 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
> >  		n++;
> >  	} while (isdigit(date[n]));
> >  
> > +	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
> > +	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
> > +	if (n == 8 || n == 6) {
> > +		unsigned int num1 = num / 10000;
> > +		unsigned int num2 = (num % 10000) / 100;
> > +		unsigned int num3 = num % 100;
> > +		if (n == 8 && num1 > 1900 &&
> > +		    num2 > 0 && num2 <= 12 &&
> > +		    num3 > 0  && num3 <= 31) {
> > +			tm->tm_year = num1 - 1900;
> > +			tm->tm_mon  = num2 - 1;
> > +			tm->tm_mday = num3;
> > +		} else if (n == 6 && num1 < 60 && num2 < 60 && num3 <= 60) {
> > +			tm->tm_hour = num1;
> > +			tm->tm_min  = num2;
> > +			tm->tm_sec  = num3;
> > +			if (*end == '.' && isdigit(end[1]))
> > +				strtoul(end + 1, &end, 10);
> > +		}
> > +		return end - date;
> > +	}
> > +
> 
> Looks sensible except that on our planet, one day has only 24 hours
> ;-).

My bad, I admit that I wouldn't run into this error if we have the
helper is_hms (or is_time)

> 
> I think we should try to reuse existing helpers as much as possible
> in date.c to avoid such stupid errors.  During my review of [1/2] I
> found is_date() would be a good thing to try reusing and also

I'll look into this and see which value should be passed to is_date

> extracted is_hms() as another candidate we could reuse.

-- 
Danh
