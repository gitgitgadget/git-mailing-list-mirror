Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799DBC001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHDVfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDVfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 17:35:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F5E2
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 14:34:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5867fe87d16so27379977b3.2
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691184899; x=1691789699;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gZ7Zpp3ItMWyySIZQkM5w5mchD6omE3z0EQ05+lmXAk=;
        b=SMk9osdNgyMssXfW1hLTc8XQHsY8cVZU7fdZiFQipFivJQVZv6ey3TgOfyWC3sdfG/
         Lla2gVKAFZPVkoefqz3/xhX6yEAJaHZxS1QTJOOShscwkPRR6Z06Baa578rV7KKQbfG3
         zJCZd8LTSAiawx5TCsBkzGIvXN1rUAj0LG+sfvhGSd4dOt5IbOpyseyfb26G5KrKWOGy
         hq8WRxXWFKMNjgz8oFiVDLS/my4PddzATWRUR8iluATU2qUvX8uUMfZZq4iGVQmWWzsu
         xbVtPqjfn33kGl6yRpzUc22xCYz15jy72k+uoR3V29VtJkmVC6un9fjAvLxslPHrASBm
         32Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184899; x=1691789699;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ7Zpp3ItMWyySIZQkM5w5mchD6omE3z0EQ05+lmXAk=;
        b=hX5UrzZ015T0416miKq8+hnBpNu2Bz73SPdj0ERklFcYOsQcS1U+QXGY9LFPe7H/02
         ABhdsDovqrtIgTGyCm7LbGXDtB9aX2bVMyl+hEZmS4eDj2qeorpFvcbhGLuGcM3zGNCf
         s7Ruuv89el4vBD99QnZOcvy9LMPTC0SYR/o4iGYvBqdTYpgCRXkQ/Hoi4GZQUWyvBxv/
         bD+HqC/wBecy0p+PEckvfAJQ9E4uv6Yfl2LI9HRdHTH/WhgSJ9+Bp2bz2WI+8kNIoCsB
         ZfqgGCwWTAduEoQfsOntMZz4GhME/YUt0+7UxJfWG752Bqn3Zhr/mdG3d6oOu7OQWa/h
         u0BQ==
X-Gm-Message-State: AOJu0Yyihw5aLKWVUKsQJp61KxA0DywqtD4fZUVSY+1AvklW1jdhF2Sw
        DQxF5RZb0pJzUFFkT/xkx9gvsqOsft1oBsSkLzi3
X-Google-Smtp-Source: AGHT+IF057nah62aW2TI81N3TCDrk16dtNdZnaqBvnIcl4Ruouw4kVvvwYSYfsnUO9or1tCWnifRwSFJejI56sRObWev
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:c87f:19c8:415:a748])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af17:0:b0:583:3609:50d2 with
 SMTP id n23-20020a81af17000000b00583360950d2mr25145ywh.8.1691184899248; Fri,
 04 Aug 2023 14:34:59 -0700 (PDT)
Date:   Fri,  4 Aug 2023 14:34:57 -0700
In-Reply-To: <20230731234910.94149-4-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804213457.1174493-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v1.5 3/5] config: report config parse errors using cb
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +	/*
> +	 * FIXME for whatever reason, do_event passes the _previous_ event, so
> +	 * in order for our callback to receive the error event, we have to call
> +	 * do_event twice
> +	 */
> +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> +	return -1;
>  }

I think this is because do_event() uses the current position in the
config source as the end_offset and emits the previous event if there is
one (that is, if do_event() has been called before). It can't emit the
current event because it still does not know what the current event's
end_offset is.

I also noticed some more difficult-to-understand things, like _EOF and
_ERROR are never emitted as of current master (i.e. without this patch
set) because they are always the last events to be passed to do_event().
A refactoring to have separate "do" and "flush" would make things
clearer.
 
