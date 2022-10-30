Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7EEECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 19:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ3TJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3TJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 15:09:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF9A459
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:09:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q142so2293280iod.5
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vtq/YB/G7AuO/bdmI7YyoHKKJ6myAJ8M6rx9ezh6bL8=;
        b=cUNRI+nHFn+Zd7xn1vYBFu61VZvBOFBkFzJLZreliK1HaaloxPxzX0K8etcly/HhBN
         6KvAY27EYuZBHIr8SoRm4EFpbMUZdOzS+KrBsFwc1gl+8HxKwU2ITXyhE7B269VlysmG
         mbcprgFksfoS7O/sALgH4FBdrKJ3or/rOOdi6TxyVMCcgzbAM8jKuNhc8AG4AOyppcU9
         /bdckf4DVrtE7vp9QsbwDVTK5E8ETOUundqfNksnQbSNeBlJVh6WFJBhGsvpukWAtjyG
         jMj7CPr8nBXKanJS4ivXL3lBYGOupk7cLmiqpUmybRSIxCkar1S4CgMLA0XPvGK9fJJv
         BkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtq/YB/G7AuO/bdmI7YyoHKKJ6myAJ8M6rx9ezh6bL8=;
        b=ZYuv8/qdj7ndXO0l42QOLI062tz+H2wkQDvwITKiusLNDGa3QppxITP0hzdFV/Wf9o
         tHm2nFR9XMUZNpa3DTjKcCshQDEMdcqk3J/XmfBV7h3wMIlF4Sh4UP1GnLOnnrJf6vZO
         B8yodvGFWEKsyVAjh+VGVqSnXT1RLn/r4iFaH4NxCvyr6X083ICC/CeAjMRob+PepTpk
         DLUD10OiHw1sVdP06wPk0Rkb4GpQyqKMr6FrrpzVBo7a262Aa322PKIl/IAEAtspjY8Z
         tNmbik7ZYEN1xvjuvpT2qAKkItG844wCmO3fhnXOtCosXktuQIxkqPg02/dkMYAVUZ8+
         UweQ==
X-Gm-Message-State: ACrzQf0/7qR6t4KWHtzOeOIkvnD/1ei9ozT/8SUUi9TSR9NgPQAS+MeK
        mhxkgTTXuDb5VMNA5/eANj3gOm7uWl2/aHxI
X-Google-Smtp-Source: AMsMyM4aOBIHW1mWxJTeZs73ZIJF4xfi6mSc3LCqzmBT2XyLKJfBdm8+Z5S+o/gUthUTKx/znsiHPA==
X-Received: by 2002:a05:6638:517:b0:375:16d:446b with SMTP id i23-20020a056638051700b00375016d446bmr5119000jar.86.1667156945959;
        Sun, 30 Oct 2022 12:09:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f9-20020a056602088900b006bc3bf6e5b5sm1980220ioz.55.2022.10.30.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 12:09:05 -0700 (PDT)
Date:   Sun, 30 Oct 2022 15:09:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y17L0IjELU5QlOPL@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 04:42:27PM +0200, Patrick Steinhardt wrote:
> This strategy has the major downside that it will not require any object
> to be sent by the client that is reachable by any of the repositories'
> references. While that sounds like it would be indeed what we are after
> with the connectivity check, it is arguably not. The administrator that
> manages the server-side Git repository may have configured certain refs
> to be hidden during the reference advertisement via `transfer.hideRefs`
> or `receivepack.hideRefs`. Whatever the reason, the result is that the
> client shouldn't expect that any of those hidden references exists on
> the remote side, and neither should they assume any of the pointed-to
> objects to exist except if referenced by any visible reference. But
> because we treat _all_ local refs as uninteresting in the connectivity
> check, a client is free to send a packfile that references objects that
> are only reachable via a hidden reference on the server-side, and we
> will gladly accept it.

You mention below that this is a correctness issue, but I am not sure
that I agree.

The existing behavior is a little strange, I agree, but your argument
relies on an assumption that the history on hidden refs is not part of
the reachable set, which is not the case. Any part of the repository
that is reachable from _any_ reference, hidden or not, is reachable by
definition.

So it's perfectly fine to consider objects on hidden refs to be in the
uninteresting set, because they are reachable. It's odd from the
client's perspective, but I do not see a path to repository corruption
with thee existing behavior.

> Besides the stated fix to correctness this also provides a huge boost to
> performance in the repository mentioned above. Pushing a new commit into
> this repo with `transfer.hideRefs` set up to hide 6.8 million of 7 refs
> as it is configured in Gitaly leads to an almost 7.5-fold speedup:

Nice, here we expect a pretty good speed-up, and indeed...

>     Summary
>       'pks-connectivity-check-hide-refs' ran
>         7.42 ± 0.16 times faster than 'main'

...that's exactly what we get. Good.

> @@ -1928,6 +1933,12 @@ static void execute_commands(struct command *commands,
>  	opt.err_fd = err_fd;
>  	opt.progress = err_fd && !quiet;
>  	opt.env = tmp_objdir_env(tmp_objdir);
> +	if (oidset_size(announced_oids) != 0) {

I'm nitpicking, but this would be preferable as "if (oidset_size(announced_oids))"
without the "!= 0".

> +		oidset_iter_init(announced_oids, &announced_oids_iter);
> +		opt.reachable_oids_fn = iterate_announced_oids;
> +		opt.reachable_oids_data = &announced_oids_iter;
> +	}

Why do we see a slowdown when there there aren't any hidden references?
Or am I misunderstanding your patch message which instead means "we see
a slow-down when there are no hidden references [since we still must
store and enumerate all advertised references]"?

If the latter, could we avoid invoking the new machinery altogether? In
other words, shouldn't receive-pack only set the reachable_oids_fn() to
enumerate advertised references only when the set of advertised
references differs from the behavior of `--not --all`?

>  	if (check_connected(iterate_receive_command_list, &data, &opt))
>  		set_connectivity_errors(commands, si);
>
> @@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  {
>  	int advertise_refs = 0;
>  	struct command *commands;
> +	struct oidset announced_oids = OIDSET_INIT;

This looks like trading one problem for another. In your above example,
we now need to store 20 bytes of OIDs 6.8M times, or ~130 MiB. Not the
end of the world, but it feels like an avoidable problem.

Could we enumerate the references in a callback to for_each_ref() and
only emit ones which aren't hidden? Storing these and then recalling
them after the fact is worth avoiding.

Thanks,
Taylor
