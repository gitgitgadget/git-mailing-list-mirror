Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA51C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjDRTul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjDRTug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:50:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC078684
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:50:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-555bc7f6746so28042227b3.6
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681847434; x=1684439434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9+/hoZnA+OqtswDCfzoEflcfZVgYEFuqdsOGufLYJw=;
        b=uN2j/iCdb0qGEOKSCyWbaSwZrFSZ+tSST6fN/O47njqgSZD0kVcAeJhcTD/RWAZRlx
         Bvr8Qs5AHoEQOgKeIZBSEhwVqoDkraEZ9Ok2NIGc9UYiP7W+/qy/IM61uUUUaO3LNnlB
         HFIDGVoK39OXGl/RfI8dPUXCSoTsS3vL467p97v1AJsLTxmUWG1Fn0LHbZRNnU14ktZ8
         F2dkWl0njGkRW0O2UKAlenYNdNbTuhbKsTOa6LVMQsgQOSHu/FhfSbT6zy53/4T4fOwm
         2F7nvAqI3irkyoaYyz7ig3W17578lpude4o28dCAo4JatngTpxnnpoO5Nf3bZw/18qEp
         hK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847434; x=1684439434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9+/hoZnA+OqtswDCfzoEflcfZVgYEFuqdsOGufLYJw=;
        b=gOGcnoqRactyb3E11HLr7UiY4mXSduYnT/tBGmzeJvuISTFpId0MVpp2xLTZ0jdoC4
         FlSJ3rsufETk8wcSh41XDaeq8wfyeo7/etcKZJ8Ui0hUijNJd+/JkWmwlIGnwFiURmK+
         l52v4j0L/60bSS1DhmvmAg4xMYKvZAeJwiCQRaku+izqUaxG2aw3GVunJsTIIIKRq5qL
         lzMn1QmqxN3qI+JIUm5IPcZcg9ThStR7PMMWG0g6jTSZrO6rj345oCgjALJrHfG/rhR4
         vlwTwLBAZ+Ss0Ad79gpujtSf9i8JNqqrEF2fwmEP3aa5ivdcRd2tOYObpgmKLDqDu+uW
         U1DA==
X-Gm-Message-State: AAQBX9doPEzvYNB5G/Dd6fn00vp87QAcnsgpsc//p/WHzLIVm/bD+nxY
        TYxP+kxXELK8huPwXnmH1pEWzg==
X-Google-Smtp-Source: AKy350ZnYatveMwZs9Y773iFv1wcwd9nHD9qOB6RqQ8He26s33OKQdr1zTkkb+ZVyRqwcCy0MsfpXQ==
X-Received: by 2002:a81:494d:0:b0:54f:855e:c447 with SMTP id w74-20020a81494d000000b0054f855ec447mr923332ywa.38.1681847434477;
        Tue, 18 Apr 2023 12:50:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 62-20020a811741000000b0054605c23114sm3975352ywx.66.2023.04.18.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:50:33 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:50:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t/t6501-freshen-objects.sh: prepare for `gc
 --cruft` by default
Message-ID: <ZD70iXDdAqeDIeXX@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <4ccc525c39dd23db1136681bc0ffd572db0ed2f2.1681764848.git.me@ttaylorr.com>
 <20230418105622.GA516715@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418105622.GA516715@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 06:56:22AM -0400, Jeff King wrote:
> On Mon, Apr 17, 2023 at 04:54:36PM -0400, Taylor Blau wrote:
>
> > We could run this test twice, once with `--cruft` and once with
> > `--no-cruft`, but doing so is unnecessary, since the object rescuing and
> > freshening behavior is already extensively tested via t5329.
>
> That's doubtless true for the general case of freshening (after all,
> that's the point of cruft packs). I do wonder about these "broken links"
> cases:
>
> > @@ -151,7 +151,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
> >  	some message
> >  	EOF
> >  	commit=$(git hash-object -t commit -w broken-commit) &&
> > -	git gc -q 2>stderr &&
> > +	git gc --no-cruft -q 2>stderr &&
> >  	verbose git cat-file -e $commit &&
> >  	test_must_be_empty stderr
> >  '
>
> The idea is that we don't complain when repacking unreachable-but-broken
> segments of history. Which could perhaps behave differently for objects
> that are going into a cruft pack versus being turned loose. So maybe
> it's worth covering for the --cruft case, too. I dunno.

I think we already have coverage of those cases in t5329, specifically
in the tests:

  - cruft packs tolerate missing trees (expire $expire)
  - cruft packs tolerate missing blobs (expire $expire)

which are tested for both the pruning and non-pruning implementations
(by setting $expire to "2.weeks.ago", and "never", respectively).

Thanks,
Taylor
