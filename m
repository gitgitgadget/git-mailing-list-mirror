Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E8C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCUSQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCUSQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:16:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7018B3F
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:16:42 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i19so8555400ila.10
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679422601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCg7WJKuS+rdOfBWn2iwgsXwUBUCeKsYpIUy36cEHv0=;
        b=yqlfLTEL4qO9jHn8P2Zie4ZxOdnU3zZq4aDRqptrYzhGRwL0sKHMDY78Lv9m8myt+K
         ma7Emig983S/EF6OenPP8yAYDo/pH5yjsK8Ed0SiWLFx9kfcJcnJEIsM25gy89y3b0rQ
         D2G8EkEqItiPVJR8F59UefXYjzyHP0LMtDRxrPBh/0yIo1CReT7X8vDwzBoOXtkJE3bN
         1MbjZ/Yt7WyhfMTsSdEtLSoXYTfHOhHv0+Mq/Ng9IRKO88PiCfsE83p2ASs8ltMY2O5Y
         Uso/evvFnVvEgTvgYjBHjDH4cUC+cb5sYqZRzXv+ESU173kOcbHgUM94jAjFyWZMuck5
         h62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCg7WJKuS+rdOfBWn2iwgsXwUBUCeKsYpIUy36cEHv0=;
        b=3hozHTR9eGbAs3gB9tFnFnB1lcfvjG2P8Qs9U1+xp4VeR1sBI3Y7Fin0lP2cWieZig
         hmdk799KFOuApZ1Y7/Df+bOOxlZyYrl7/HbADTIy9hsqvtuloEUa3P+Fws8t65zWGsCB
         aWmZVeKGyR+bzLJ97zgQh9ulDrOCnzl68jIg+7TAEL73ePQbpP14bYETBOoDryShdd+a
         YhWsjh5IioTRf/cZMTI3TKk097QN5SfARXVYqCHgGyhGPr2pn8MZls4RjJQ6mWGvOa24
         k48k+Ma7969Yay4/POIYk+GMNn/w9Prcz2+SOipuydLrkwd5qZuW/SGMUKo+xw5mDlLX
         OtoQ==
X-Gm-Message-State: AO0yUKVzydbs88NatSYTgBJl7Za+7FSk5gjRPzT64OXQNIlK0cOvdEMT
        xEgzOjr7EKOBoE1rZm3luo528A==
X-Google-Smtp-Source: AK7set+WGHugzDdBeklbHkDwnU2Dy75T+fReWRTf1dQ3EvXBchglN72yWgdFsnjzfaBfyNCiVbelmw==
X-Received: by 2002:a92:ca90:0:b0:313:c74c:725a with SMTP id t16-20020a92ca90000000b00313c74c725amr2458075ilo.12.1679422601730;
        Tue, 21 Mar 2023 11:16:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i35-20020a056638382300b004063e9acb00sm1388516jav.127.2023.03.21.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:16:41 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:16:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 6/6] pack-bitmap.c: factor out
 `bitmap_index_seek_commit()`
Message-ID: <ZBn0iFE5qOJKVeel@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
 <20230321181315.GH3119834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321181315.GH3119834@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 02:13:15PM -0400, Jeff King wrote:
> I'm not 100% sure on where these offsets come from. But it looks like
> they're coming from the bitmap lookup table. In which case a bogus value
> there should be an error(), and not a BUG(), I would think.

They do come from the lookup table, yes. I'm not sure that I agree that
bogus values here should be an error() or a BUG(), or if I even have a
strong preference between one and the other.

But I do think that trying to make it an error() makes it awkward for
all of the other callers that want it to be a BUG(), since the detail of
whether to call one or the other is private to bitmap_index_seek().

We *could* open-code it, introduce a variant of bitmap_index_seek(),
make it take an additional parameter specifying whether to call one over
the other, *or* check the bounds ourselves before even calling
bitmap_index_seek().

But none of those seem like great options to me, TBH. I would be just as
happy to leave this as a BUG(), to be honest.

Thanks,
Taylor
