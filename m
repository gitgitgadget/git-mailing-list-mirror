Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDDC636CC
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBRRZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRRZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 12:25:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8915CBC
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:25:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w9-20020a17090a028900b00236679bc70cso1834069pja.4
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLqAROrdYNOjP+o0VzuJa+DgXpQ7khkgdzlWJr/vPaI=;
        b=KPfwFNfktmQp+o8FgVjjktQTJtV0n0LJgaRujGtfPuPVfYxkhHpWisa3RvJYRaX1CH
         c/92KoaM5jX0IVteX9nF3/NO5KUW69GO+LtJEAv8GfB/prXZTUFnx7toSePk9VChhoLZ
         QV3LfDynkgJ4Qf34BAnOopON07YzqZ8B9k8OUAjy7SAzikdlCp3j2SA/Oqv5DvfVKk94
         BUc1BexinPIkSX/W7Qp35N0MpLxQuhloSMXrZT9akUu+XYgm6lBMDJf/BNQ/utIOVfun
         VJZKNuHfQ3tgp3J4LlYAyYl6JKMaj+mC56TzplMmSKHIYVT5/5d5iJP3hBsdfxcBw6r6
         KJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLqAROrdYNOjP+o0VzuJa+DgXpQ7khkgdzlWJr/vPaI=;
        b=vtf/cgYe70IPIgvfbiFobWaI0aLmKxsMhZ6b0OS62flnMrg6QiVyurnHv0Fkn6yvnc
         +gA/5J2iHj47cT4y4/VUug1CQFY6bEiX+DoZXMTywYe6vBD5JKXxhYk0nBFYI+mMCOCn
         DBRKq8WvSnDi/yW9sMQO/BLxWTlgsDrFK6zldZZoMdDoFf6DNAJiSKR8+0xUGl0tR1Zv
         C8CgRMmBs4VZz91mbhxsx+p+kDeqq//aQkQ2mmMrDnks8oVnWqOEjDZ0WKvBfiDkX0Vc
         y2ye7mWyLvs0V2HLpvRWFbnK5bCEsvhMnCfRmJeut16g6pS/Tvz653ns53noaO8So31u
         uBWw==
X-Gm-Message-State: AO0yUKXhn78bvsrqdB9lb0VtkzdZZitpM85OuYJ7ve4elxHvlPBPuWLY
        Owv+9+Dtq+V0d7I+HiXopMM=
X-Google-Smtp-Source: AK7set8Vu+weM6cVKYmTYW7CDs7lEsfjVI+3oXS73vJcny22FM1tIBgI+faaUjBO2QMM7OEh3k4xSw==
X-Received: by 2002:a17:903:2806:b0:196:1c45:6fc8 with SMTP id kp6-20020a170903280600b001961c456fc8mr2580754plb.60.1676741105089;
        Sat, 18 Feb 2023 09:25:05 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001965f761e6dsm4936388plo.182.2023.02.18.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 09:25:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] archive: add --mtime
References: <Y+6G9n6cWRT9EKyl@google.com>
        <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de>
Date:   Sat, 18 Feb 2023 09:25:04 -0800
In-Reply-To: <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 18 Feb 2023 09:36:23 +0100")
Message-ID: <xmqqilfykhsf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> +--mtime=<time>::
> +	Set modification time of archive entries.  Without this option
> +	the committer time is used if `<tree-ish>` is a commit or tag,
> +	and the current time if it is a tree.
> +
>  <extra>::
>  	This can be any options that the archiver backend understands.
>  	See next section.
> diff --git a/archive.c b/archive.c
> index 81ff76fce9..122860b39d 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -472,6 +472,8 @@ static void parse_treeish_arg(const char **argv,
>  		commit_oid = NULL;
>  		archive_time = time(NULL);
>  	}
> +	if (ar_args->mtime_option)
> +		archive_time = approxidate(ar_args->mtime_option);

This is the solution with least damage, letting the existing code to
set archive_time and then discard the result and overwrite with the
command line option.

I wonder if we want to use approxidate_careful() to deal with bogus
input?  The code is perfectly serviceable without it (users who feed
bogus input deserve what they get), but some folks might prefer to
be "nicer" than necessary ;-)

Other than that, looks very good.  Thanks.
