Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12FA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 03:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeDJDhq (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 23:37:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39481 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDJDhp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 23:37:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so11425456wrc.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FCTk6tjdLUDzEZ/9GWXMTokgWoTtJj3jnSOOfyAdYFI=;
        b=vBV+/B61Ofmzdkk8U2v3Q9BgtnZilT1i98TEeLIiVRoTw+BjCKVMPyj3exU75lMGv6
         N6HDPNIgQTiw4eUZY+vqe2uVRrqHaxdThUO4TERLfSH1qQ5kQWCIWNadMqy6mR3hHxDc
         Dyd7/uAsBgNpqZzODjntVIhhjOTRLU9TQ9tawjHiD8ZPIGiCl8MoF1xiaksJ0FcEwycu
         XBRX9F2ec0dNTzUUuZdNAl5gHljXJpCDK9M9hJTtW/xWgGERvU4g0iHKyfIk9GJ7hl5P
         //2FS/jdw6AjLdyYpgygOoJuIlEnEPN/rV+hN8NKvKoVyx2OS9qZtxZqW/22vRdHn++5
         70BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FCTk6tjdLUDzEZ/9GWXMTokgWoTtJj3jnSOOfyAdYFI=;
        b=hyCYyV6fsVgesHx6cKhXHeYa6CbX4YX+fMBSFIRiBFeYQpc0G3MuO5TsmNlC3aztwV
         JEGDDF1GxbrYp40+oViIVz0Z1O1IkJDNel1CLWfzt4dhgW9MGZDFv87zyTu3IlqmQ25I
         i8YU6+By9mGOKrLPnNj3cnikEuVivCB6zqSXnzFd4AS3AF/tKizjjdP2h6JJVDEedJEb
         g7CuHCWb3nCq8qC2qoW3WT3uhOCMAqkE9NuR03/cO7JR+gZjyOjllpsfIEJPm9pE681O
         4w+gA1i41Cy4hP42qQp8v7ovxMZfyZxq3LEysLl0sNg7d0jDu6iOx0jJiP2JnNpdisOp
         9dFg==
X-Gm-Message-State: AElRT7Fc3uAPvnrT3H92a6zyVxmxKAW4/ooX8Ni52ncSAB3Ps+V9d784
        8o9qBxnn2kmPko/vWAZ2S5c=
X-Google-Smtp-Source: AIpwx4/xEzQ21P0HiYXH3bIgzuYnpDztHDhpeTziBQaFlFAPOkCB8jJxkeSwmQZvWJyKB7+6G+YDvQ==
X-Received: by 10.223.139.206 with SMTP id w14mr28781811wra.169.1523331464108;
        Mon, 09 Apr 2018 20:37:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t76sm874755wme.17.2018.04.09.20.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 20:37:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 06/16] replace-object: check_replace_refs is safe in multi repo environment
References: <20180406232136.253950-1-sbeller@google.com>
        <20180409224533.17764-1-sbeller@google.com>
        <20180409224533.17764-7-sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:37:42 +0900
In-Reply-To: <20180409224533.17764-7-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Apr 2018 15:45:23 -0700")
Message-ID: <xmqqvacz3f5l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In e1111cef23 (inline lookup_replace_object() calls, 2011-05-15) a
> shortcut for checking the object replacement was added by setting
> check_replace_refs to 0 once the replacements were evaluated to
> not exist. This works fine in with the assumption of only one
> repository in existence.

"works fine in with the..."?  I guess s/ in with/ with/?

> The assumption won't hold true any more when we work on multiple
> instances of a repository structs (e.g. one struct per submodule),
> as the first repository to be inspected may have no replacements
> and would set the global variable. Other repositories would then
> completely omit their evaluation of replacements.
>
> This reverts back the meaning of the flag `check_replace_refs` of
> "Do we need to check with the lookup table?" to "Do we need to read
> the replacement definition?", adding the bypassing logic to
> lookup_replace_object after the replacement definition was read.
> As with the original patch, delay the renaming of the global variable

Hmph, if we decided that replace database is per repository
instance, shouldn't this variable also become per repository,
instead of staying to be a system-wide global?

Perhaps that will happpen in a later stage of the series that I
haven't seen yet, I guess.  And until that happens, we disable the
optimization and always call into do_lookup_replace_object() when
lookup_replace_object() is called, which is OK.

>  static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
>  {
> -	if (!check_replace_refs)
> +	if (!check_replace_refs ||
> +	    (the_repository->objects->replace_map &&
> +	     the_repository->objects->replace_map->map.tablesize == 0))

Ah, we still have the same optimization, so this looks alright.  The
variable's name and semantics do need to be updated--I didn't check
but if this variable is exposed to the end users in any way, such a
fundamental sematic change may be hard to transition, though.

This series looks good so far.

