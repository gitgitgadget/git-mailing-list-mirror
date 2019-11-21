Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA7C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D32063A
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="kum9SS4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUXUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:20:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46464 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKUXUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:20:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so2267180plt.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DXs6JSIvW2NnLdPN6ruvUtUYGbbfLl0GxWlNLY/OP6o=;
        b=kum9SS4i43gK7mECzHmCluP3qX5+HtSNkAzppsMvfvR6/Rf8+5dHCN25wHSwPaAmlp
         b/jPHG5cI3TCc9Kwn24oqzzn9vBJKQAhAR6SUypHzyEfqbQkM5L8ipLvk3DBNYzVobPF
         JW+27VLQp2fs+Y8JL6sHPVEVirxQvJr0oPhGnjRPmfx9lx4cRyPPxd+T/T1sOTZusHJ/
         ag68l9N3gJkfDrAV3xeIHAa61xp4MSsRTEUvZfXk1fishcLulc2WdJo3lJrnHDSMv9+a
         3XhxDEDB9asNlvhrju/HZKwZnXNnhU/nMDKHqatv2ED9j8M8k7LFFpwcxJ3IPuvEKsNh
         MeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DXs6JSIvW2NnLdPN6ruvUtUYGbbfLl0GxWlNLY/OP6o=;
        b=Mm02gpfjZ0EZ6TkWD0PRaJ8eigDF8vGXJUBLJxutHYAPJIWOiCvtIZd0JPSZRsEXGi
         s+bQJBCmTIrARvWXVEZ9VptK+Wxygc6Rzc951/Jn4C06mmigzghHgHwU77UdeZeTQ1r7
         ZAjLyBHnnAgDu4vb0r+z5Q8lInEtISLg+LgKIrITFhumq2T6CjNiF8IJZa75062dnWH9
         8vpR/hi1lFI/mHdwM5qZpg79kNmPO/tH7ZLEYAbj74qmv4vxoRh7ZzR/8+v+bb6oZEqb
         AIr8CHs8MzGk+EXNCF5N8K6/0wiLNhgZsvRsQ/2RUVfRzBnk234IspaIxGGMtwUE/jz5
         sGEQ==
X-Gm-Message-State: APjAAAXbg9MjfjjnD+YuzFHw4c0Hq2n2FW4YmjFr9kerkjvPZzjGfJon
        PDjchsBuxHtR6zMPJzI942L5EJo47E0=
X-Google-Smtp-Source: APXvYqwpc1EQdeo1bVs+h1yJF0uXxxyXqzQGOzp0wyeKsEeKFadIHgRtc9KPX/kWU7dG2dnkkWhCkQ==
X-Received: by 2002:a17:90a:d58e:: with SMTP id v14mr15377126pju.142.1574378405923;
        Thu, 21 Nov 2019 15:20:05 -0800 (PST)
Received: from localhost ([182.232.28.41])
        by smtp.gmail.com with ESMTPSA id h4sm565855pjs.24.2019.11.21.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:20:05 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
In-Reply-To: <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
References: <20191116180655.10988-1-hji@dyntopia.com> <20191116180655.10988-2-hji@dyntopia.com> <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Nov 2019 23:19:12 +0000
Message-ID: <87d0dkbyxb.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18 2019, Junio C Hamano wrote:
> I wonder if it is simpler to define it next to 'next'.  Yes, this
> new variable is used only within this block, but it also gets used
> only in conjunction with that other variable.

Done in v3 (sorry for the messed up versioning going from v0 to v2!).

> A bigger question is, when this happens, what value do we want to
> leave in sigc->primary_key_fingerprint?  As we can see from the
> original code that makes sure the old value in the field will not
> leak by first free()ing, it seems that it is possible in this code
> that the field may not be NULL, but we just saw that on _our_
> signature verification system, the primary key is not available.
> Shouldn't we be nulling it out, after free()ing possibly leftover
> value in the field?

I investigated the code paths to `primary_key_fingerprint` and deduced
that it's only ever touched when GPG_STATUS_FINGERPRINT is encountered
and a primary fingerprint is extracted.  However, v3 will NULL it even
when no primary fingerprint is found.

>> +							xmemdupz(line,
>> +								 next - line);
>> +					}
>
> Avoid such an unnatural line-wrapping that makes the result harder
> to read.

Sorry about that!  I figured that some projects prefer to always trust
in the code formatter; so I just left it be.  Now I know that human
decisions are allowed :)

> A short helper
>
> 	static void replace_cstring(const char **field,
> 				    const char *line, const char *next)
> 	{
> 		free(*field);
> 		if (line && next)
> 			*field = xmemdupz(line, next - line);
> 		else
> 			*field = NULL;
> 	}
>
> may have quite a lot of uses in this function, not only for this
> field.

Implemented.  I wasn't sure whether to do it in a separate commit or
not, but #git-devel suggested that I do; so that's what I did.
