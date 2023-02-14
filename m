Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1267C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBNVtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNVs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:48:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EB24C89
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:48:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so156709pjq.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0T0HptDgJ+GH0ewI+USBMMt6jskjrd1xd0gV/jgbSI=;
        b=GWX+ih2VatH/LYsYZ5WZZhxyFlOsU1wcY2oOvJMbV385imDbqZHyOqKjs63fLjPDRh
         EHB4AYpfXDcjt+3fy7nX3RK1cOr1GghRXTt7GPVVm2SyrT02y66d1GXHmOcRe+HPpX4Y
         v4EUfD6J4YeidDFLh5olphmOd5Ukvvv6aTPkgAPqfp4GvR60X6+0QAuiDQqoTjN+u4HI
         mgz+gqwM2tQyX9yCLttbyGSG1r8VT07GqOqyNImBKMI5yn3xLq7bJPAIb9In0Czxj0o4
         oQNNPXTpQcbfZcpqto7IiVeelLL8/in9uPo6lqAg53iChBb7SOIMhiD8PrJVRqPFFtD3
         XFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0T0HptDgJ+GH0ewI+USBMMt6jskjrd1xd0gV/jgbSI=;
        b=nu7uTw4KLUQBT2PikeGzoI3goFFoUcTtxDpFFhSoJF8OUFrUxHuVdaZ1oW/FpD5L/0
         JWYaFiiHY2QpXAmy6SRi2IXHRTVn3haFtNQiZKmMGulUb8jfCb0Kvv7sCpYH7TB0Q+W1
         NHt2nG1iYt3tKKjInLm9gl4Vqd0Y4WRsotwnFBkoQrV69o/m4lwvJ+T3hwLYUfa5a/54
         JV8nVgY3O4uSFLeFjUNbgFyeEdULIcctHMbovJavDVRypT1QMSeh5QNa0reYyLyce1/K
         kHMmHjixRMI4Vb8DC5pM4ALodxZlP5YBE1s7AsyEv6g23rnbmR64mFlzRXIXtsRjCMlg
         OssA==
X-Gm-Message-State: AO0yUKUwrW5Q93Ppb/PdFRZFMuTE5TA3x+//ZSrgYKDJwclnoIpLYR9G
        Icnz0NdMeKSStpTzyxqj4pY=
X-Google-Smtp-Source: AK7set82bxbeoIcZWu2NcSgLOtxjNN2vI65LmdhoooPSlW55h21h4kLPLnypfRLvpZJQeFkXCHbYZA==
X-Received: by 2002:a05:6a20:7291:b0:bf:f8a:330b with SMTP id o17-20020a056a20729100b000bf0f8a330bmr436797pzk.10.1676411338214;
        Tue, 14 Feb 2023 13:48:58 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b00592d16e9a12sm4001172pfo.135.2023.02.14.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:48:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 13:48:57 -0800
In-Reply-To: <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 13:41:52 -0500")
Message-ID: <xmqqmt5f535i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +/*
> + * Check that the string refname matches a rule of the form
> + * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
> + * "foo/%.*s/baz", and return the string "bar".
> + */
> +static const char *match_parse_rule(const char *refname, const char *rule,
> +				    size_t *len)
> +{
> +	/*
> +	 * Check that rule matches refname up to the first percent
> +	 * in the rule. This is basically skip_prefix(), but
> +	 * ending at percent in the prefix, rather than end-of-string.
> +	 */
> +	do {
> +		if (!*rule)
> +			BUG("rev-parse rule did not have percent");
> +		if (*rule == '%')
> +			break;
> +	} while (*refname++ == *rule++);

So, if we have refname="refs/heads/frotz" and rule="refs/%.*s", then
we'll scan refname and rule to skip over their "refs/" prefix, and
the next iteration, where post-increment moved the pointers to point
at 'h' (at the beginning of "heads/frotz") on the refname side and
'%' on the rule side, we iterate once more, notice *rule is '%', and
break out of the loop.  We have refname="heads/frotz" and rule="%.*s"

If we have refname="refsXheads/frotz" and rule="refs/%.*s", after
skipping over "refs", refname points at 'X' while rule points at '/'
and the loop needs to break.  Both pointers are post-incremented,
and now we have refname="heads/frotz" and rule="%.*s".

Am I reading the loop correctly?  I wanted the bogus refname not to
match the rule, but without peeking back refname[-1], I cannot tell
the two cases apart at this point.

> +	/*
> +	 * Check that we matched all the way to the "%" placeholder,
> +	 * and skip past it within the rule string. If so, "refname" at
> +	 * this point is the beginning of a potential match.
> +	 */
> +	if (!skip_prefix(rule, "%.*s", &rule))
> +		return NULL;

And we now have rule pointing at "" (i.e. "refs/%.*s" has been fully
consumed).  refname points at "heads/frotz".

> +	/*
> +	 * And now check that our suffix (if any) matches.
> +	 */
> +	if (!strip_suffix(refname, rule, len))
> +		return NULL;
> +
> +	return refname; /* len set by strip_suffix() */
> +}

And the suffix "" is stripped and we yield "heads/frotz".

