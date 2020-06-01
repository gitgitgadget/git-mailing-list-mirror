Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32EFC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBBD2076B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryv8A/gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFAXKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgFAXKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:10:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F193C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 16:10:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h4so1618772qvr.21
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iknOBssxLgkks1IwoeQTPhH0ZrRJlR5f+dimqHmJ3zE=;
        b=ryv8A/gROP1mLY6MSeHIvSz4YnYmM2MLonu700NxZbplVxvvjwD4LQNCgR0V9nlb7i
         LQHDfbzzR9Ks8rWIcAVeiP7Jo2HeYdzAkAce3PpOfwjHdVRXQ3nf9oUxnUq2MzPbaTOy
         yuXhysKt+HL8VWRHEBPUJmzEq6xHiIImaiqBM/L+q5TkVEgaMEzm11n962RJYOIjfvAa
         WlZMIN0AAv7+cvHUYSJc/EfmaXFhIbw1i8x52mIBRSKxVrB1xE9JF1t6qtJ+KdZfucK3
         ZRJ05jVMZ8N0UaO1a11D8XZqUKBVz+ebJBF9CjSR9gdJ2ObTkombf55Ueap3RiVYLvCw
         bZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iknOBssxLgkks1IwoeQTPhH0ZrRJlR5f+dimqHmJ3zE=;
        b=j4YIENtwCgIm1QKdULGJtmFn9mLzYoaoqTivtj59X5jTceOsBWDx7T67dtlKkt/XZ+
         J4GnbQ6HQlGyUpWQJqgS+AN3k9r+rjy2nwry4S/ptq67N9i9vv2JqIWf2ceLoF7EkKeN
         J+bAegLvx7SMjZglBzobEf7PII0tyGhMKyltyfBg3XZzlaEh6W/yB1eeAzCjp4SL01de
         HzQyYm335QumD2xPxPwcWOZprvPd2dvGgRFF+ntWcnHD6kX49vVnfSdg6JWhL7+hvHtN
         hPimfm/UiXT270M9iDfcEG70JLBM9TMe7haeHCtSYScw1pDu0R6Oo05rbbcf/rjovHlq
         5a+Q==
X-Gm-Message-State: AOAM530eCNu67RlTjhPMEliP0Hf9VplsYKD/wV3Z8S3QqEMX+lDYkgVS
        jlDzU7salqFyDF5Ztv45Ak57+cPh5qx45qeOWPN+
X-Google-Smtp-Source: ABdhPJzKHIhU3DI6L5Dhq6x5rWOnZeOF6A9ZVLv7JIlyGYBZSVBM9dJGbvmEWS5Asd51ZFaxhfMLN9T8gVIdjkJhLgT7
X-Received: by 2002:a05:6214:15c3:: with SMTP id p3mr6797609qvz.192.1591053043059;
 Mon, 01 Jun 2020 16:10:43 -0700 (PDT)
Date:   Mon,  1 Jun 2020 16:10:40 -0700
In-Reply-To: <xmqq1rn2xoe8.fsf@gitster.c.googlers.com>
Message-Id: <20200601231040.258250-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1rn2xoe8.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In practice, I suspect that these fetches would go in parallel with
> > the processing of the in-protocol packfile, but spelling it out as
> > if these are done sequencially would help establishing the right
> > mental model.  
> >
> > "(1) Process in-protocol packfiles first, and then (2) fetch CDN
> > URIs, and after all is done, (3) update the tips of refs" would
> > serve as a base to establish a good mental model.  It would be even
> > better to throw in another step before all that: (0) record the
> > wanted-refs and CDN URIs to the safe place.  If you get disconnected
> > before finishing (1), you have to redo from the scratch, but once
> > you finished (0) and (1), then (2) and (3) can be done at your
> > leisure using the information you saved in step (0), and (1) can be
> > retried if your connection is lousy.
> 
> We need to be a bit careful here.  After finishing (0) and (1), the
> most recent history near the requested tips is not anchored by any
> ref.  We of course cannot point these "most recent" objects with
> refs because it is very likely that they are not connected to the
> parts of the history we already have in the receiving repository.
> The huge gap exists to be filled by the bulk download from CDN.
> 
> So a GC that happens before (3) completes can discard object data
> obtained in step (1).  One way to protect it may be to use a .keep
> file but then some procedure needs to be there to remove it once we
> are done.  Perhaps at the end of (1), the name of that .keep file is
> added to the set of information we keep until (3) happens (the
> remainder of the set of information was obtained in step (0)).

Yes, this is precisely what we're doing - the packs obtained through the
packfile URIs are all written with keep files, and the names of the keep
files are added to a list. They are then deleted at the same time that
the regular keep file (the one generated during an ordinary fetch) is
deleted.

I'll also add this information to the spec.
