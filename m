Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D4C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjFFFWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:22:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAED123
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:22:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-652dd220d67so4577918b3a.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686028938; x=1688620938;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN1yBXPdw5uB7AOooZ9Uq8afnW3I1FEU0HeadCaDOfk=;
        b=ZXr+Tw7ekUF0zhzrBsy27izeZ9XwnCuZnTJaTiPM2bHNWTQaAemJ6TPgC/95Ol8i14
         fkaFovg5IX09be+090C04qJogBXDiqikgESQXFqtiToUjJlzHvQSW9SDmYMZ+QbafSZM
         aH5DhwuwmDjfhfcYishUYCY4Sc7Q8coJz0pmecG8sIwVPi/W4kCJ6R9f4biz5ywCodIj
         AM6FFyG87wZ/nJmtdw/c4HfFzKnBTvdcmlLuV6pNkBLrkxbWS/c3S3Z2TVEMRa8iLO8c
         VoChaSA8Ump9N8z1lNS6NRxwKW7a7JV1yFLsN/kW7LrU1gLmf4UMlouKhGQGtAFtb3Ue
         B+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686028938; x=1688620938;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cN1yBXPdw5uB7AOooZ9Uq8afnW3I1FEU0HeadCaDOfk=;
        b=LwEf3x3WwtMHTnBktcUMWN/YQsewXTFS62nRGFPKBZrFw2BLrPTA5Yl6Bg6ZwTVGrW
         RnQCqCcvmXudnzOQh4Jt/tetJX+RtQr/wr5gLp8CF7zwz7NawA6UpfYzMGZ9HhhHtPar
         o33Bgv3qgUAm3WBMn5qGbNrvH0pPO2v4N/HOtzhCkmGQYzKLeJXIvIoZT6bWrLCw/3+P
         dChWsMUECYkXgEy2kkat+0c78lnqmoMDvqs6XzXl1/cnm391LE/TYWzbfwI+Id3TZgBJ
         i9y34YTNXBNP6QHuErKK614sEhtGbRtoSS/ak2hWgcBTuRZRKvW+vZxTiEaBNugGINB7
         OrVQ==
X-Gm-Message-State: AC+VfDyHhAjwg20AA3jaej07UFWHsGtjoWYNc13OEbEnnvzmzy5Hgx6N
        gFgjSW1eK6BldamtMGgbt1w=
X-Google-Smtp-Source: ACHHUZ7td++bqfRU/28yI4SC7OBDbwXmhUx1XdYJZbQHGBgtzZy26BS6qwKtqTwOcax5A5/PZsDkMw==
X-Received: by 2002:a05:6a21:6d90:b0:10a:99a9:cb4b with SMTP id wl16-20020a056a216d9000b0010a99a9cb4bmr1770641pzb.12.1686028937925;
        Mon, 05 Jun 2023 22:22:17 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79207000000b0064fdcc6b901sm6019884pfo.74.2023.06.05.22.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:22:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
References: <cover.1685710884.git.ps@pks.im>
        <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
        <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
        <xmqq35355utz.fsf@gitster.g> <ZH67eBAtFxo95aBL@ncase>
Date:   Tue, 06 Jun 2023 14:22:15 +0900
In-Reply-To: <ZH67eBAtFxo95aBL@ncase> (Patrick Steinhardt's message of "Tue, 6
        Jun 2023 06:52:08 +0200")
Message-ID: <xmqqsfb5np14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Hmph, I expected "-z" and "-Z" to be orthogonal, the former
>> controlling how input records are delimited, the latter controlling
>> how output records are delimited, as it usually is a good idea to
>> keep things that could be orthogonal to be orthogonal to avoid
>> unnecessarily robbing users flexibility.  "-Z is a new way that is
>> preferred over -z" was something I did not expect, actually.
>> 
>> I am not outright rejecting such a deliberately limiting design, but
>> I'll have to think about it a bit.
>
> Well, the way I see it we shouldn't have ever decoupled the input and
> output format, and I consider it a bug that `-z` did as it makes it
> unusable with arbitrary input. So I'd rather be helping the user of
> these modes to do the right thing and NUL-delimit both input and output
> than running into these edge cases later down the road.

If that is the direction we want to go in, then the title of this
step must be updated to say "-Z" does both output and input.  Also
with the same number of bytes it takes to say "new option", you can
say what that new option is, so do that.

> That being said I'd be fine to change this series to mean "-Z changes
> stdout" if you insist. In that case we should be pointing out in our
> documentation that "You should never use `-z` without `-Z` when you
> process arbitrary input".

You are not making sense.  If we were to leave them orthogonal to
keep flexibility, it is because there can be cases where using '-Z'
without using '-z' (and vice versa) makes sense; "you should never"
has no place to live in such a world.
