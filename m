Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1519C77B73
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 02:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjDUCQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 22:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDUCQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 22:16:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A407138
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:16:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso325583276.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682043398; x=1684635398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syETBlZhbwDGdRGkOZujzL5lj/LDAuMebG6qNEoTpRY=;
        b=jfPmn9cLcdFrnKuXCM0adoYvprl59AGdOrdMInyz8BG1B50Jmo7K3lyntNqGEJXDeh
         FoIHcUDNBb+nA8ygLqe0MjlDdhO20Siye7uuovjcMYjqflSROCvjCVT2H6IiRZ1fz5d7
         pMY9vdLiULdsIndAzdK53vELqzFo8uzjHSOCg6g7ofWk29DN/ycqwJlZvUlHbCouFCcP
         jsZsEZyCDy8Xyi8PGPJxzNjXkWA+xH0FFHLpxfrxY7BHPJGCKd5gfS+fWKkPNANte82q
         s9iSP1gs5MBFgBMIIywIqg8l+feDhVTilQ+vuqn0VtxQRiOOnFcEPbpCaBVfyomwRWvv
         81Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682043398; x=1684635398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syETBlZhbwDGdRGkOZujzL5lj/LDAuMebG6qNEoTpRY=;
        b=RtiXRpEALese90tKLMsbAZojv7+oWL5yXcY0644yO0l7WOjrBBNggsKZk3eorB/mXJ
         km7bEzIlL1s1WGTuLpcaKxrN54TU/r5UsPAtyZ3mfipCgQfA5iH0ePrRc7FixFVQga9c
         nyDcFJEJcEo44XCO55TjkFWx387fjQt4nuNLEwvOUQCYNrSY6+Na2zEpnBDPd6im9QSX
         nxs3GsAgFbg6o0rIymPVt0v5GteYfB1Ukcl+2kqFb/X1widMN8v2LYHp9UBLJIRyGKa3
         F3FseuOWOIiZzD6xivcAAu54euvG168pV/gl/Q8Lj6oWDOPsdMXQrkRDWOVeVPtyGCY8
         zwCQ==
X-Gm-Message-State: AAQBX9flJY+qnhR4IsBjzf5ytprReUSU2BUku26+Z2QcjQ0txp3B3fzk
        eTxPNvMg9yP0HmFIf63kT5K8ces5d43yZeaW1FFlfQ==
X-Google-Smtp-Source: AKy350ZbgE2xQjValELoSFiuZnFVmfIp7QT4acNRE6hWSFRYyDRW3/gXIrh5e+I6QiP7V+sjEGqmoA==
X-Received: by 2002:a25:102:0:b0:b8f:6d76:5fe5 with SMTP id 2-20020a250102000000b00b8f6d765fe5mr1152306ybb.29.1682043398199;
        Thu, 20 Apr 2023 19:16:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p68-20020a254247000000b00b9570d01d27sm664194yba.56.2023.04.20.19.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:16:37 -0700 (PDT)
Date:   Thu, 20 Apr 2023 22:16:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: tb/ban-strtok (was: Re: What's cooking in git.git (Apr 2023, #06;
 Thu, 20))
Message-ID: <ZEHyBbKN5MuxqfQn@nand.local>
References: <xmqqwn26w5cd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn26w5cd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 03:34:26PM -0700, Junio C Hamano wrote:
> * tb/ban-strtok (2023-04-18) 6 commits
>  - banned.h: mark `strtok()` as banned
>  - t/helper/test-json-writer.c: avoid using `strtok()`
>  - t/helper/test-oidmap.c: avoid using `strtok()`
>  - t/helper/test-hashmap.c: avoid using `strtok()`
>  - string-list: introduce `string_list_setlen()`
>  - string-list: introduce `string_list_split_in_place_multi()`
>
>  Mark strtok() and strtok_r() to be banned.

The latest round bans only strtok(), so this description would need
updating (probably to something as simple as "Mark strtok() as banned").

>  Comments?

I would be curious to get Peff's (cc'd) thoughts on this series, since
it was something that he and I were talking about off-list. It was one
of those "let me see how hard this would be..." topics, that by the time
I finished investigating, I had the series ready to go.

Thanks,
Taylor
