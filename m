Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5EDC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4C060F4A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhHTGrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238484AbhHTGrR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 02:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629441999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9R+qBL7oqKNkoewVLcbjz6ujMB5iNu0A6vwCfyDnHq8=;
        b=gqPQShnulY7BzkY+/fKZIJSCOhFX/baqDWFRCJsCZPMm4hZKPO9O4bAzE8KFnEt9kzgpnu
        dvfMJDqJe/xaxVkYkOAAEyyOFGhLoN5yjs39EMxhmw2iUk24r+dULl0RhOjtqfLHB/f37v
        e91p//vOFgSSA3PbWcu+0COrCcB3Co8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-vmB9GXeTPrq030YVa5cXkQ-1; Fri, 20 Aug 2021 02:46:38 -0400
X-MC-Unique: vmB9GXeTPrq030YVa5cXkQ-1
Received: by mail-pl1-f197.google.com with SMTP id h19-20020a170902eed3b029012d3624d993so2590082plb.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 23:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9R+qBL7oqKNkoewVLcbjz6ujMB5iNu0A6vwCfyDnHq8=;
        b=oHtvYgD2noW61lftkZi84BFts3/aS5OpngUx067ntgLbwpMzR+t+MEhzTiyIbPoO9r
         9yIfSmThoiVnvTkSAeRH7JA03/LTWImG5mBxrk2fcS3ZSEAs08i3JW8YDQj0VRKoWYe0
         OeKlCkAHOtFRF4E8LK8Os3g9dBUQwKVqFM1gRBRdkBILuEFJ2jaiIhPE2mvDHdp24JeK
         W9BX3bI+66sNsxsw8fdAfZd26vro+p4cdKfmF/8SgAQCHMQ9L4nA3uVLPBi/Mx9/uCnB
         O9uSHlZKJ6ikzUcfic6O880tITpMoU55c6tyZ8TOwtzXKrk1+1WARWHbFOWYLIXGMKB3
         5inA==
X-Gm-Message-State: AOAM533DtlWC+PeUAMBVCtFaDwt2J5f1w+N0v2zsy89fzsyyOesrnm/1
        dNRwBrY2QfOGBaK2x67l5cW610N0A3GG+8u/HGKaOl8g7Mc/p3GTHpvelDR/yiOUFGhe8G6gvBc
        saT/9tifw/RQ=
X-Received: by 2002:aa7:8e4e:0:b029:3e0:28db:d73b with SMTP id d14-20020aa78e4e0000b02903e028dbd73bmr18113317pfr.8.1629441997103;
        Thu, 19 Aug 2021 23:46:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0mubLi+9zavDAoSfuEoPKqhZSzvvzIwMGyPJTG8Hh8WkgbQbUgf12MBwLFULmEAggVgN2Wg==
X-Received: by 2002:aa7:8e4e:0:b029:3e0:28db:d73b with SMTP id d14-20020aa78e4e0000b02903e028dbd73bmr18113303pfr.8.1629441996805;
        Thu, 19 Aug 2021 23:46:36 -0700 (PDT)
Received: from xps13k.happyassassin.net ([184.71.189.90])
        by smtp.gmail.com with ESMTPSA id fh2sm5205827pjb.12.2021.08.19.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:46:36 -0700 (PDT)
Message-ID: <2119ea2a7b8cd3cb3a84d69b9a9f4471f645667d.camel@redhat.com>
Subject: Re: git format-patch produces invalid patch if the commit adds an
 empty file?
From:   Adam Williamson <awilliam@redhat.com>
To:     Gwyneth Morgan <gwymor@tilde.club>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 19 Aug 2021 23:46:34 -0700
In-Reply-To: <YR9Iaj/FqAyCMade@tilde.club>
References: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
         <xmqq5yw1ywdk.fsf@gitster.g> <YR9Iaj/FqAyCMade@tilde.club>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 (3.41.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2021-08-20 at 06:15 +0000, Gwyneth Morgan wrote:
> On 2021-08-19 14:09:43-0700, Junio C Hamano wrote:
> > I do not think our patch injestion machinery in "git apply" minds if
> > we added the "--- /dev/null" + "+++ b/<path>" headers (and the
> > reverse for removal of an empty file) to the current output, and I
> > am not fundamentally opposed to such a change.
> > 
> > But because it is such a rare event (and a discouraged practice) to
> > record a completely empty file, I wouldn't place a high priority on
> > doing so myself.
> 
> GNU patch chokes in this case with an unquoted filename with spaces.
> However if we output
> 
> 	diff --git "a/test cases/common/56 array methods/a.txt" "b/test cases/common/56 array methods/a.txt"
> 
> instead of
> 
> 	diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt
> 
> GNU patch (and Git) will read it correctly. Rather than adding the "---"
> "+++" lines, could we instead quote filenames in the "diff --git" line
> when they contain spaces?

Aha, I did actually wonder about that, because even with the added
lines, the patches don't apply (via `patch`) on Fedora 33 and 34 (and
the error message after adding the lines does seem to indicate the
spaces in the filenames as the culprit). They only apply on Fedora 35
and 36. I hadn't thought to just add quote marks, though of course it
seems obvious now. So yeah, that seems likely to be the best fix. I'll
try and confirm your results tomorrow. Thanks!
-- 
Adam Williamson
Fedora QA
IRC: adamw | Twitter: adamw_ha
https://www.happyassassin.net


