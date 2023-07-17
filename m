Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96EC001B0
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGQOGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGQOGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 10:06:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C40C133
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 07:06:33 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-56fff21c2ebso45364917b3.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689602792; x=1692194792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvrH+AHtUAptkOTvu2xcrRu8ccovxj0xWOPvxM4yW9k=;
        b=Em+Lk1RinV4B95qnVTZHDMYj4OIqV63WWZ7eh7AqL67BS4L/aycuuUqxH0ZQ1tuV/b
         ldTYq3fHSOsK4Y4Blhdj7jFdTGaSxLzRKO9r4AicpGkswCDP3Zb3YEJKQkDfm/CqL8Yh
         9qyKXXpnzvitWIbJ+odBQnqgoH33vsClDRVnvFCfV/prtRNQ8iQsCbFROhMbfjWp00Zj
         WUBW53Q8EiX8km6NY1ZyGY+1g3uH/aicQEv0bKCAuYkH1ENfyx8DrFTjBlz5Lddi+XHs
         RKS2vDA5GaFmpdTR1gRVRnN0YlVZiLG8sQZ9OKgqORndRHvhGU7yRqnIB2DAB9IxVusX
         c/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602792; x=1692194792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvrH+AHtUAptkOTvu2xcrRu8ccovxj0xWOPvxM4yW9k=;
        b=VqrGSx4Vn9IgT2JJX1tPwjZMRp3hjh/MYNeKKeLnJ5aaNWC0nQIFgSc2IGtf9XqyOC
         /0IaZvJF6GSVoD63RAJ18zmi2euEf4/MXfyvK+dH+0ndu8mCNmU+JdEUuzNAJ5Vvy09T
         jxI4BQzS0KVj3vhDyF4eqi2oDnkvSAjDQ3llBaWYyaIeDqSyapqvdtXT7tw6545BwnDp
         y5Mw7g48cwQY3yy+aRr9SmDph1mrR1KWYkUMBel2ISkaN+PiTgZ3Njq7vOzVo1R1ESh3
         4J8NjZmVNa2bFWVfPDuFKvwThZXAG6yUkDCtVwNCjM6pGa+M6RdHsUflr0GfYKmWRtgs
         cWNA==
X-Gm-Message-State: ABy/qLbw9Z+sf+dLKrlBN0MQbbKaT0eqfiSAvOz+q7CtEjd7RvcGPKzw
        wSkyiD3yLQbmX62t8pVdl+NDVXqQkBf2OS9Oyka6Zw==
X-Google-Smtp-Source: APBJJlG4UEoLPrnywei6QPvjrGUsQMhscpZ2IoLf8V4XATCZHs48vpJFz50mu41H5lvc4Qu5Y+ZliQ==
X-Received: by 2002:a81:7507:0:b0:568:be91:c2b1 with SMTP id q7-20020a817507000000b00568be91c2b1mr11877572ywc.9.1689602792232;
        Mon, 17 Jul 2023 07:06:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020a0dee06000000b0056dfbc37d9fsm3884363ywe.50.2023.07.17.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:06:31 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:06:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org
Subject: Re: Teach git-fetch(1) to use a quarantine directory
Message-ID: <ZLVK5nzVZU48uvYE@nand.local>
References: <87edl6bx7o.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edl6bx7o.fsf@iotcl.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2023 at 12:48:17PM +0200, Toon Claes wrote:
> Hi,
>
> I've been looking into making git-fetch(1) to use a quarantine
> directory, but I'm a bit stuck on direction.

What are you hoping to accomplish? receive-pack quarantines its objects
to ensure that the pre-receive hook(s) are all OK before accepting the
push. See 722ff7f876c (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03) for more of the details there.

Are you suggesting that fetch be taught the same, so that we can
quarantine the pack sent from a remote before moving it into the main
repository?

> I took git-receive-pack(1) as an example how it uses a quarantine
> directory. It seems it sets the environment variables
> $GIT_OBJECT_DIRECTORY and $GIT_ALTERNATE_OBJECT_DIRECTORIES so the real
> object db is used as an alternative, and a temporary is set as the
> default. Then a sub-process is spawned to uses these. In case of
> git-receive-pack(1), it calls git-unpack-objects(1).
>
> At the moment git-fetch(1) does not spawn any similar subprocess, so if
> we want to take the same approach to use the quarantine, we'll need to
> split up that command.

That doesn't seem necessary, you can use `tmp_objdir_add_as_alternate()`
to register a temporary directory as an alternate. See the tmp-objdir.h
API for more convenience functions.

Thanks,
Taylor
