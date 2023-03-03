Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74218C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCCU0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCCU0a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 15:26:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3945942B
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 12:26:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d6so2219842pgu.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNe6b8N2w4v+I2mI/OWV06U0I4xnWJmBh6lnW3g1siA=;
        b=Ji6biEbO3LDstBJrj3rXP1CgTblUPHgLuhRZaqkmGp3YZJ80WvKJDvV9WPp36Q+iaD
         GtDBOP5YROFD43q23TCZDloW39J8N4kPQZK3YDkNkDJkODgwehi6aMZzvAbW7jMG9x6Z
         OFTUEpWvj7AtjXPLLkWSZrdyUrZH57XdzZmbZS00wxv1OPpNjmZyeHT3nwGDmxH3G06p
         8XrYXgHjDL0juheF6sG/+sSHpJGPDiDuKUMDQnWQJotIyGFVffG8MtFANBL9ta6cv2NH
         iRCkuR8Zs9TvbIvsaLHZqES5O0XTx+X0TrFHjmj39ADtaR0UoDoHydWckoIkE3d3ICJ8
         Thag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNe6b8N2w4v+I2mI/OWV06U0I4xnWJmBh6lnW3g1siA=;
        b=NW7axMC1FUcTOBqWFHWUh7TDEL9srt9HyEquSMmBwPERZixd18/wVkePiwj8FuljNC
         HVVjpF6kyt2wAauxgekqS/2uUa2hUkuzouW/8JHV3t7VuxotQpSh+o65qURTSskvy2Dk
         0RNxUvhNXTw9L2XJ6hI2/mBvYp8i8pNBUX4g7zNuXfQWBc90d1PHPbFR5dwKhMLvrDTB
         byvu/zhway3n80gKHRTd0aAqaaoEVKqHS2CQ0KSqdk6NOuET5dCQXr4zsWfjGb/P6uH4
         6UqnV6HmN7FkaacSy6SurxRVuHrT/Uaw+ajyU7dMfVWSmrGJUVKxOAlYCFd486cBVLS/
         zGeQ==
X-Gm-Message-State: AO0yUKWpPuaJJVpw9/KtqAu5VO0Fnvsp91fQUj2HJlSG3b9bGFn5oaBF
        dD1U3lXvlbhObE2pNOpN0VjTPx9soi4=
X-Google-Smtp-Source: AK7set/oCMgg1eYO39PiwI6PYeU+/bNwaUv03Vn/xWOZaR2woI/idH0RHsGNbf6zN70GOsZgO4GTPw==
X-Received: by 2002:a62:3042:0:b0:5a8:31a1:2f05 with SMTP id w63-20020a623042000000b005a831a12f05mr2902314pfw.5.1677875189084;
        Fri, 03 Mar 2023 12:26:29 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78381000000b005cd81a74821sm2003569pfm.152.2023.03.03.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:26:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 1/2] cat-file: extract printing batch error message
 into function
References: <20230116190749.4141516-1-toon@iotcl.com>
        <20230303191708.77894-1-toon@iotcl.com>
        <20230303191708.77894-2-toon@iotcl.com>
Date:   Fri, 03 Mar 2023 12:26:28 -0800
In-Reply-To: <20230303191708.77894-2-toon@iotcl.com> (Toon Claes's message of
        "Fri, 3 Mar 2023 20:17:07 +0100")
Message-ID: <xmqqcz5peg3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> There are two callsites that were formatting an error message in batch
> mode if an object could not be found. We're about to make changes to
> that and to avoid doing that twice, we extract this into a separate
> function.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ...
> +static void batch_print_error(const char *obj_name,
> +			      enum get_oid_result result,
> +			      struct batch_options* opt)
> +{
> +		switch (result) {

The body of this function is indented way too deep.  You should lose
one HT at the beginning from all its lines.

> +		case MISSING_OBJECT:
> +			printf("%s missing\n", obj_name);
> +			break;

This one expects that obj_name is always usable as a string.

> @@ -455,9 +486,7 @@ static void batch_object_write(const char *obj_name,
>  						       &data->oid, &data->info,
>  						       OBJECT_INFO_LOOKUP_REPLACE);
>  		if (ret < 0) {
> -			printf("%s missing\n",
> -			       obj_name ? obj_name : oid_to_hex(&data->oid));
> -			fflush(stdout);

This caller used to be prepared for the case where obj_name is NULL
and used the hexadecimal object name stored in data->oid in such a
case, but now ...

> +			batch_print_error(obj_name, MISSING_OBJECT, opt);

... the updated caller assumes that obj_name is always safe to feed
to printf("%s") above.

Maybe obj_name is always not-NULL when the control reaches this
point in which case the new code would be safe, but if that is the
case, the proposed log message should explain how that is true to
justify this change.

As batch_object_cb() makes a call to batch_object_write() with
obj_name set to NULL, I do not think this change is defensible,
though.
