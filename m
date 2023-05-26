Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58531C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEZV2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 17:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEZV2D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 17:28:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35246A7
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:28:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb3528ce5so2586489276.1
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685136481; x=1687728481;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cyv5hOmqodY6KjqSc6t/TCG9ugYb9n81eT02p634aQY=;
        b=S7RpexxFPCmqk4Gc7WOoOZvWgpQZbOvn8oHTqTyJhAFsndnUC97rgti5t6mgVklKOL
         Ha0C7Kh5v1t0uU0gyouGDpcfNjOAJXoGZYYPpDxrgHqP/Aqc2aTQ38rsSXI3oDNJn5M4
         6BwGGu9YEIT7Tg3z5gtCfA4dCvWvbn1/WsI1iRoIDvpidsu1XdWOg+34x7iZmp5cUZDW
         RRW/fFt+XRAzafhnZZGBsdVHdvl8H5LNlCy34J6YKgMizo9p+3qDJPhmNgYmghHopFJk
         DRq01LvhxDuh0nAtDhcYDf/WnzxHUKCkg4mOOSBF+T4l6VcLStRSTLwwe4Rd9GZX9nJ6
         GcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685136481; x=1687728481;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyv5hOmqodY6KjqSc6t/TCG9ugYb9n81eT02p634aQY=;
        b=bxupXUmjQXV9FU65wAwUq8HqbakfXRVJm/3xnQpfHmiBS26tb7ETrmj1/+SuGDtb0O
         Gy95PTAcPSpwbrijZ2Eq+TcxrDZmbonhgilty7KzL8ABZLAywMMW1Hs4BKju5fAyogRa
         uO5lC0b9xuNwpfBSl5PLdKLWzUfXo3mDPDPFFvga7ZpN7LBorZoR5kKykkwxiq1cAI1D
         YM01fLVBXjVRSAnUv98zcSIcLnsqjaR1iL1YyYZYEXtNnKnRuw0jk63CcJi7E4dbgd24
         1hMhtsng6RfZgk6x/ML93PXeu7UYvqpeojuqKbfrJuZC3jefXK9OhEY20dwA6sM7Rwk3
         NyRg==
X-Gm-Message-State: AC+VfDzGi/11ref92jr9Qs/jzUwjAeT1m5G9iT5SGx0vrEuMuWvHLqnW
        bTBtNT5I+l+CI9q8JOZTkgFhYNlPRNFuw+0L9ZSK
X-Google-Smtp-Source: ACHHUZ5F/nlQA6UN1IOH3juodV/wQIxTspOu92CRT93qJjl/UF4u7iMPBPqCxMYGMaTdYOpJlM+t4TAE8Sw7S9RXD11H
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4ab8:70ac:b28a:a7ab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4046:0:b0:ba8:9afc:ed6f with
 SMTP id n67-20020a254046000000b00ba89afced6fmr1215368yba.7.1685136481469;
 Fri, 26 May 2023 14:28:01 -0700 (PDT)
Date:   Fri, 26 May 2023 14:27:59 -0700
In-Reply-To: <20230523192949.1271671-7-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526212759.2294075-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 7/7] common: move alloc macros to common.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> alloc_nr, ALLOC_GROW, and ALLOC_GROW_BY are commonly used macros for
> dynamic array allocation. Moving these macros to common.h focuses
> alloc.[ch] to allocation for Git objects and additionally allows us to
> remove inclusions to alloc.h from files that solely used the above
> macros.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Ah, indeed, "alloc.h" was used for 2 different allocation-related
things. This change makes sense, of course.
 
Thanks for this patch set. Overall, it looks good (except for some minor
comments that I've given in other emails).
