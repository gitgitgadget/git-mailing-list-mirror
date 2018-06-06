Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1761F403
	for <e@80x24.org>; Wed,  6 Jun 2018 00:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbeFFABu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 20:01:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46061 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeFFABt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 20:01:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so2027067pgv.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNi+MxDskk9ADXeu2cOxV5ub0TQ+SHkO7NNi5AxHcdA=;
        b=qGlRcwWFHrvulhAFkl2qGoro3gAQPJzwvb2T52kgg2bkEijEaiv80GC28wdHT9eLOb
         6eu5I6nILuVxySsNqLMrxZbGX49WgiiKoxBoHbOmlaW6nL6wd6o0sygCKrmhQqhnQGe9
         PvBoLuPvT0Oqtz2DTuThq91QFM55YHabUZANCC51PYFaH5F0rK5tc4GfQcvHui4ghjYM
         pD1XCfU97OuIoqD7ubGrgIWMfW1oa/REO04Y+snQ0yIR8r/VKlsjFacQuDgga/vK6Pwx
         e7wlMvpIvsLw6p6RhM3uloxGmbe0OE/eARpds/HA+sRUPV7A10blprL5b9W4v5PK1p4L
         YNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNi+MxDskk9ADXeu2cOxV5ub0TQ+SHkO7NNi5AxHcdA=;
        b=dD0YZRIDFmW84doIL0VYrXXjK5NoPeCqtq3ZMkIfS9LvC4HLxFQ+ROPxeDHFVGQZxS
         tPfuD3NeriJtSKQksmirf5qpoy/B5LL9MLIOeLzDa8ySsYXTDR388WCGMir+mNwBhZZO
         wu7fneArVHAdX/0TW67omXFCbP2g09S+wcHV7t6+kjneSHmCO+DUw2xc44TLOrwbi/mp
         MymztW1xbJHZd+N/4J5BuGvLjPcICK5zXwNeQ8cfv+Lvaf+HwSToy3NsAnvtoJIHtaQN
         Par08uRVM9ZP0/9MCw5YHJatOe26gjlu94H1VD5YSHAD//Pkj54J7KsQh+ZovlKy75AV
         D3mg==
X-Gm-Message-State: APt69E2caUIiYi6Q6khmFOVOX5OJxXHf0GfAc5yH6EpqU6o9vWDEuFRL
        vo8zLFMnrYqxNgjaakZtwMQ=
X-Google-Smtp-Source: ADUXVKIIoFYB1E08d1lIehzVR+fE6oiMWpDogv57LfBs7LM/bKli2xWNbMB6iBv85ctWotqLtJw2yw==
X-Received: by 2002:a63:7c0b:: with SMTP id x11-v6mr582458pgc.384.1528243308601;
        Tue, 05 Jun 2018 17:01:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a22-v6sm12316241pfi.124.2018.06.05.17.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 17:01:47 -0700 (PDT)
Date:   Tue, 5 Jun 2018 17:01:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 5/6] fetch-pack: move common check and marking together
Message-ID: <20180606000146.GH9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <02577402adaf0d109f74e59486d8a23f6ae68663.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02577402adaf0d109f74e59486d8a23f6ae68663.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> This enables the calculation of was_common and the invocation to
> mark_common() to be abstracted into a single call to the negotiator API
> (to be introduced in a subsequent patch).

I like it.  I think it should be possible to describe the benefit of
this patch without reference to the specifics of the subsequent one.
Maybe something like:

	When receiving 'ACK <object-id> continue' for a common commit,
	check if the commit was already known to be common and mark it
	as such if not up front.  This should make future refactoring
	of how the information about common commits is stored more
	straightforward.

	No visible change intended.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

With or without such a clarification,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
