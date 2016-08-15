Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259531F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbcHOVoa (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:44:30 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:33632 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbcHOVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:44:29 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so10372226ith.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:44:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DKl5yGTTTBMCYmqslUq1NLvZF7rOBo4SaFFWiLbsLGg=;
        b=lecqUIc5+MfOooeIdJZpHPRo0y1ZtT9TRqkGwfWevGkojldi87Y0zGZNjfbg9YG6A8
         13TfrBqWWu6mgYPEMLSXjNSrD5x+oVFM4MxpPIClvvDJOhNCkfj3nXYVz1jI4u67MeqD
         gVM6vFi4jmN2SJ9gSOcWd0uQyGMUz59ydyzmfJEk/ezHPVQgRNdUFQnf+5qzPgG/EPHA
         b0RDMQMrZ70iCjhNGLbDxRmxQHrAlKb+mIsUVgJjk6qrGDgbOa7VIEU14tiLEh/bxhXn
         4fIi2d/0gZW74scmogTGQr5TyQ/bJjVISWbeIoEqlozicCiClAEu8TbkE+xMNEMyR5Je
         gaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DKl5yGTTTBMCYmqslUq1NLvZF7rOBo4SaFFWiLbsLGg=;
        b=In9vrnV7TW3RLQMYfAFuv3qWBuRs5+91n31/sM+YFIvkO1xHqfUa9wFsNx1glhXHzA
         5VhukPFGIk6McXGg7s6LsLI87UGQwF8Ivy6z9P6LJqox4LL6ZdEji8PCmG1N75vLgb0K
         JLcBHsA3rqVBil5CAvcZcjnLhIt+596zz0DK6RAW3CFqfv1Xo2EOogTrK8/UWPGHs68k
         nqJtoQG9ybM0Px3+Bz91f1E9IDxlXQ53QA26NnbZcCazO9SOaS51dlNn6SnUd7zapbrk
         uG7HrZhZBRtCRN2SLqz87/GVehEZBRr1eTw+8OoN/5LhKIqcEv/Xf6AQpx7YNbuds3bf
         1rhA==
X-Gm-Message-State: AEkoouvzFWUiwQyvSGWa0JUHwuW00cDNzRb8VQyZadzd6JPV1/mfFpPmlERirNpEAHahl3uR+jE07tDCPROmNf0w
X-Received: by 10.36.227.130 with SMTP id d124mr16049713ith.97.1471297468669;
 Mon, 15 Aug 2016 14:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 15 Aug 2016 14:44:28 -0700 (PDT)
In-Reply-To: <xmqq1t1phir4.fsf@gitster.mtv.corp.google.com>
References: <20160811231405.17318-1-sbeller@google.com> <20160811231405.17318-6-sbeller@google.com>
 <xmqqa8ghvd3j.fsf@gitster.mtv.corp.google.com> <CAGZ79kYVh7N-H7iO4E7HydeOzdUfxGTc3sUo8RhCzR33u9gRHw@mail.gmail.com>
 <xmqq1t1phir4.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 15 Aug 2016 14:44:28 -0700
Message-ID: <CAGZ79kbFjvwXHVwCb4cBGeCpgmByVbf0mBdZYxuRMKVpg+1sWg@mail.gmail.com>
Subject: Re: [PATCHv4 5/8] clone: factor out checking for an alternate path
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 1:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Why do you need "err_buf", instead of directly writing the error to
>>> "err", especially if "err" is not optional?
>>>
>>>> + ...
>>>> +out:
>>>> +     if (err_buf.len) {
>>
>> If we were directly writing to err, we would have checked
>> err.len here. Then you open up a subtle way of saying "dry run"
>> by giving a non empty error buffer.
>>
>> I contemplated doing that actually instead of splitting up into 2 functions,
>> but I considered that bad taste as it would require documentation.
>
> Sorry, but I do not understand this response at all.

Me neither. I think I elided the interesting part.

> I am still
> talking about keeping one function "compute_alternate_path()".  The
> suggestion was just to drop "struct strbuf err_buf" local variable,
> and instead add the error messages the patch adds to err_buf with
> code like:
>
>> +     if (!ref_git_s) {
>> +             strbuf_addf(&err_buf, _("path '%s' does not exist"), path);
>> +             goto out;
>
> to directly do
>
>                 strbuf_addf(err, _("path '%s' does not exist"), path);

done.

> err->len at "out:" label, or (2) using a new bool "seen_error = 0"
> and setting it to true when you diagnose an error.  The latter would
> make the code a bit more verbose but I suspect the result would be
> easier to read than the former.
>

(2) is very readable, will reroll with that.
