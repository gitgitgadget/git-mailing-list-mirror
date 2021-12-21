Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAFFC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhLUOUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbhLUOUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:20:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF0C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:20:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so25490165edc.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Shydqtf71UfJN2x1B0Vhq4u5iCgVX8xn41W8cJEKrSA=;
        b=H2ddbuNhyE+piuVWqDrOOc81hJSeofIC32R7hj5EdZaGNC2LFBICVizhmXlNse52OJ
         ktXXOpHWpOsBuB/EfBDZ8TkHZ4VmPd3Oj5XUvkyeMAiBLzlqF9ZMaD4NmnA74SC7Sd+m
         JJ3R0pJ7w64qetD1vnRx+i2SclHNOhv+W+vRvvJcQtxM/YsKiuTVxyhvOwxNKI+Su4b4
         HBAGYvd/oQBPVOt9UUqy7on/5RPdVPReq3gjMZq9rXoqnnUkXV+dgAYaIsjOrCx/0OT5
         MoMqZwMEbKnr+VPLzyVfhyGjNlGPvYy1ic0ESqZ2L2+fPzf74pCenWBzdlMiAWQKFXzc
         peOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Shydqtf71UfJN2x1B0Vhq4u5iCgVX8xn41W8cJEKrSA=;
        b=CSlrJr7eqwfwb/VZxeB1phOPVNoHj13ZkQVpd0Dzu+cwrhTEGmo1FXdZ4sBNq1cHhs
         5xuqlDOdCaK8pRFiHNM71j+9btARjSbyd+7SfGOXpTPWRW2Q1QgCkrAOJ3rKxo2LP893
         OGYH876ulNUI+ujiB2fFxl0SaP2nSXYyOvEb5E//A48/xWXpGYEsSTBSbUP2JUhXhSC2
         2i+2BvR4bApEHoTZaulsdQxIwf21eVk8dzjsyPSuH4d9INO/LjdcNoUel55ho0KVmh0i
         e4jy6aKJfZCyks7RpXA+xZiBzNcgwcOO+SrQ84urGD46QIdK5Fg5xg6I1UT6H2rw/fCm
         4vyQ==
X-Gm-Message-State: AOAM5304xIJwcJeqKR0MHeoZk37L90LX+Uptfc2oTwywAYvy1+Kml2+F
        Evi8vCycI2lTJjUvH5tyTTM=
X-Google-Smtp-Source: ABdhPJwJayNyO1MZjzcZ1ViGCLf+G8xdN5Tzvm4PbPLPyrp2dRoL2uK0whd7FMpUtzoIvqXLrkjRYA==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr3526403edc.136.1640096415256;
        Tue, 21 Dec 2021 06:20:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm8712487edd.31.2021.12.21.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:20:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzfzy-000kwy-7C;
        Tue, 21 Dec 2021 15:20:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v7 3/5] object-file.c: refactor write_loose_object() to
 reuse in stream version
Date:   Tue, 21 Dec 2021 15:16:57 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-4-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211221115201.12120-4-chiyutianyi@gmail.com>
Message-ID: <211221.867dbyrqe9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
> [...]
> @@ -1854,17 +1876,48 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
>  		strbuf_reset(tmp);
>  		strbuf_add(tmp, filename, dirlen - 1);
>  		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
> -			return -1;
> +			break;
>  		if (adjust_shared_perm(tmp->buf))
> -			return -1;
> +			break;
>  
>  		/* Try again */
>  		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
>  		fd = git_mkstemp_mode(tmp->buf, 0444);
> +	} while (0);
> +
> +	if (fd < 0 && !(flags & HASH_SILENT)) {
> +		if (errno == EACCES)
> +			return error(_("insufficient permission for adding an "
> +				       "object to repository database %s"),
> +				     get_object_directory());

This should be an error_errno() instead, ...

> +		else
> +			return error_errno(_("unable to create temporary file"));

...and we can just fold this whole if/else into one condition with a
briefer message, e.g.:

    error_errno(_("unable to add object to '%s'"), get_object_directory());

Or whatever, unless there's another bug here where you inverted these
conditions, and the "else" really should not use "error_errno" but
"error".... (I don't know...)
