Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E9ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiH2IG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiH2IG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 04:06:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A11C128
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 01:06:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t129so7437605pfb.6
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=NuFbFRWoI7sgk5XjwvPvrPwtc7dA815eavw+X7xx0e4=;
        b=P38S0i4CJ9NWb18YOuuouh226KETZTlziwU5qtiAWWVOXS4LDzc/jt4Jb9+rIfW9d3
         gM+nGkZ/nAFrXRkaMDPjXt57XQB6zRTbUwUU1JiYgEUXMwj+qhEXUT6cwu8BJ9fD6KgF
         681Z8TIB+yVcwMsGc+NSn/+/hlzQlxR0uBqmtsxMiIeuKE+P88SXYRRAXDoPyMh03CO3
         /u8EfdDAQYFaYgCNz1mq1ePMQhTfWe7Osk4wELqR4U7VSEFpIsNMWXUVvownKbVBBjW+
         GFjCYkxxqy4Nl1EdVSkE4wCmYAa1AvcvpCxpTM3dChVQLQLMhWhl7IFLfgJQLLTJ+qqU
         dIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=NuFbFRWoI7sgk5XjwvPvrPwtc7dA815eavw+X7xx0e4=;
        b=RYZBV9NixUt9uJMyf4owQQiO9ekiwJCIU0qxB+CCpyxXrvxmiOC3Vo13mk/YZ6R3At
         9A6ev0QSDzxRxeMSGQTIEbO4A7V88kZ90/mNAs3mLCR4vsMh5kZ2mCy4YzS3SQLOkTSZ
         jPKfAuMosqzeO62KJJHcIh1lkeo6VZLwtoLnZUjurvSwbve4cv4RIcdGKOWPY0BT5nTw
         +hoyZsGLno1qu78KpOCl9OeSSkTPUahRGHF/xrFgHBqQ8csOMUFTLWMFk8n4dIrPSW/o
         Xke+txvW0T4Xkv/E+Mzjj/6vhNM0IAawQFMrtrUqN/DoS8AvQoERtdgbmHvEZ2ma12C4
         Qocw==
X-Gm-Message-State: ACgBeo1jNcoB0pdcw+FVWPeNyncEQ5sj0aHMHOVrUusbKbEphmbXJvbh
        FJN4jns9D6GNzt9w7wmd9HE=
X-Google-Smtp-Source: AA6agR7Bh7+MMK/JNz82yctYRiwGCUKybYGxb6+3SqrhD/0VGOEgvH9gBioyYpXtiFpUUhMFnrmABg==
X-Received: by 2002:a63:8042:0:b0:42b:b11d:16c5 with SMTP id j63-20020a638042000000b0042bb11d16c5mr6990029pgd.261.1661760384125;
        Mon, 29 Aug 2022 01:06:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b0016eea511f2dsm6862541plg.242.2022.08.29.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 01:06:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] add -p: handle `diff-so-fancy`'s hunk headers
 better
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661376112.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 01:06:23 -0700
Message-ID: <xmqq5yibqxs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  	else
>  		/* could not parse colored hunk header, showing nothing */
> -		header->colored_extra_start = hunk->colored_start;
> +		header->colored_extra_start = line - s->colored.buf;

This is the only thing that corresponds to the proposed log message.
The comment that says "showing nothing" is no longer correct, and
needs to be updated.

Everything else in this patch is about adding an extra space
depending on what is in the "funcname" part.  The code does not know
or care if it is an attempt to do diff-so-fancy's headers better by
doing something we didn't do to the normal header we managed to have
parsed; rather the extra space thing is done unconditionally and
does not know or care if extra_start is truly after " @@" or a place
in the line the new code computed.

So the following three hunks either need to be made into a separate
patch, or deserves to be explained in a new paragraph in the
proposed log message.

>  	header->colored_extra_end = hunk->colored_start;
>  
>  	return 0;
> @@ -649,6 +650,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  		size_t len;
>  		unsigned long old_offset = header->old_offset;
>  		unsigned long new_offset = header->new_offset;
> +		int needs_extra_space = 0;
>  
>  		if (!colored) {
>  			p = s->plain.buf + header->extra_start;
> @@ -658,6 +660,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  			p = s->colored.buf + header->colored_extra_start;
>  			len = header->colored_extra_end
>  				- header->colored_extra_start;
> +			if (utf8_strnwidth(p, len, 1 /* skip ANSI */) > 0)
> +				needs_extra_space = 1;
>  		}
>  
>  		if (s->mode->is_reverse)
> @@ -673,6 +677,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  			strbuf_addf(out, ",%lu", header->new_count);
>  		strbuf_addstr(out, " @@");
>  
> +		if (needs_extra_space)
> +			strbuf_addch(out, ' ');
>  		if (len)
>  			strbuf_add(out, p, len);
>  		else if (colored)
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 7e3c1de71f5..9deb7a87f1e 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -772,7 +772,8 @@ test_expect_success 'gracefully fail to parse colored hunk header' '
>  	echo content >test &&
>  	test_config interactive.diffFilter "sed s/@@/XX/g" &&
>  	printf y >y &&
> -	force_color git add -p <y
> +	force_color git add -p >output 2>&1 <y &&
> +	grep XX output
>  '

It is good to make sure that XX that was munged appears in the
output.  This however does not check anything about the
needs-extra-space logic.  It should.  If the extra-space logic is
moved to a separate patch, then this step can have the above test,
but then the separate patch needs to update it to check the
additional logic.

Other than that, looking very good.
