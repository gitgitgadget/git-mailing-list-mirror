Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8CC004D4
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 00:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjATAdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 19:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATAdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 19:33:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419527D61
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 16:33:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 36so2936887pgp.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTbZnmj9GuKDNMyDO6CvjXfaoJuWw3vwnrsrf5+nnsc=;
        b=lL5jiD51SYsMW3cnLw8RLbQAKhn6RlFV5XSIRz4CpsLPp9xZ8U1rrHnfGX+hp0zRNX
         AaucgnncQtJ8yCejnxU8Er9rBnsdEkavx5fVv5/UEjDMqhBR/hDqoNbWdle5ri6z488k
         aGkW5KPcxcCi4GqG/RJoM4Mb+5ox8tFCF8kLQDc4rUYH9nNWxyYhiERPpBmxE8Furrkb
         2ktnxCgqRuktXLpW9pmwuenwBp+Z3nE2ZiaWC1zYkmpvUC96t1KdjSHIHmmeaf+YBFf8
         +5FaA02b4z1cDSVAm55O9atFcLaXKDlHXW35/2VoXIzYF5WOZv+XrndnUCIH9tN2V4/I
         3Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTbZnmj9GuKDNMyDO6CvjXfaoJuWw3vwnrsrf5+nnsc=;
        b=gPt2TaIYEpyL/mLqnL4ZrVXB5sg6zRBDTu4qSo4tk4FCtqZG7KDqqPs/0mzxRM1nhh
         k+szW/yAN6WhnzBnJmI2dmC6o5VsWkOa686Xh37OTynv4Dzq5LrwNmglnsXnZxtQ2fQa
         hVTn1E5RsWyn4Lc5cUczDwlvfL0h6UwAlgcKkEpDqJJzzyK+M8HyvLAXX0hrgrN2dSyN
         FwvId1Q86tMp4AJwPrcQFiuVyewVYQqlTt5Ld9+TEp4PeuUqyY1m1aIvVpiTKd0dZais
         0LH6CwxqzV1NxhF3jRjNNX/EQGytwyn7K4GCjGyww/YhatyvjL5SgVAbO61wpveersjJ
         x7oA==
X-Gm-Message-State: AFqh2kqFe+ASyYiU8oPuXff9dZH/S+wXJ2lW1c5V1dFUsVlcynh3/kT+
        BKXqNJb5GomVct49SdSqEDs=
X-Google-Smtp-Source: AMrXdXszBH/nSLPBSnLzbGwD2QfX/QqnT0HhKxk2vKDQWtg6S2L+hOy4kMoxxkBbJtDMA1FjvgaCYw==
X-Received: by 2002:a05:6a00:331b:b0:58b:bf9a:fa81 with SMTP id cq27-20020a056a00331b00b0058bbf9afa81mr14146303pfb.4.1674174815350;
        Thu, 19 Jan 2023 16:33:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a20-20020aa79714000000b0058d9a5bac88sm8980280pfg.203.2023.01.19.16.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:33:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Emma Brooks <me@pluvano.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Patrick Hemmer <git@stormcloud9.net>
Subject: Re: [PATCH 3/5] log: Push to/cc handling down into show_log()
References: <20230119223858.29262-1-zev@bewilderbeest.net>
        <20230119223858.29262-4-zev@bewilderbeest.net>
Date:   Thu, 19 Jan 2023 16:33:34 -0800
In-Reply-To: <20230119223858.29262-4-zev@bewilderbeest.net> (Zev Weiss's
        message of "Thu, 19 Jan 2023 14:38:56 -0800")
Message-ID: <xmqqy1pyyrhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zev Weiss <zev@bewilderbeest.net> writes:

> Subject: Re: [PATCH 3/5] log: Push to/cc handling down into show_log()

s/Push/push/
cf. Documentation/SubmittingPatches[[summary-section]]

This is common to all these patches.

> @@ -1326,6 +1326,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
> +	format_recipients(rev, &sb);

This is where the two new members in the rev structure is used.

> @@ -2028,9 +2029,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		strbuf_addch(&buf, '\n');
>  	}
>  
> -	recipients_to_header_buf("To", &buf, &extra_to);
> -	recipients_to_header_buf("Cc", &buf, &extra_cc);
> -
> +	rev.to_recipients = &extra_to;
> +	rev.cc_recipients = &extra_cc;
>  	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);

And these two members point at borrowed memory.  extra_to and
extra_cc is freed after everything is done, near the end of the
cmd_format_patch() function.  We don't leak any extra memory by this
change, which is good.
