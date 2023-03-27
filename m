Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C1CC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC0QHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjC0QHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:07:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4622688
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:07:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7so8091561pjg.5
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679933226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsXToviwPAcmflEK51a7ijcptjemgX4UwgROLWA9Oa4=;
        b=AWfQJfSr8aQ9HXCR7rVQe9gtw9x5vSlgqCfr6MFILi8UkZ9wx1ORn4giI7f/R6YmxG
         HHP8vnY/RrPtiJgJX0mjjVsNwgnNqwJjUJrhPdvdHMAcvD8Y9ZASrVFgibIrUFTNYpXe
         YEneclUnznXwBaBYeXWUbjjXysryODJPq+vc6z7mq9pnBd1TfKpEbBBUxGLhJSQXH6+A
         Y7tIAmpsc2YtguafRtv+4FyJ/kGC77jpDErgblXcV3+TS1Nu+9PX7FmsN4MZ66U68DEQ
         LxBH78BX/Xc1Z2Hkr8fVBDE0WUzFoYsNm0RuVYabNXevGNGUednFrFKq7h21DlLJ0XVr
         +wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CsXToviwPAcmflEK51a7ijcptjemgX4UwgROLWA9Oa4=;
        b=pRTdSqK5yoxwqN5kE/YWPGak0KtcomEowq3wdZvY0en1bmR4JYQnKhKg7BvIt3KB6r
         6H0ocAooR4GMH24t9wTWsb1P0Gam9FkFuSEkQuF8JiOO5mfpRX3lxoc9FvH1hwnth580
         Ndj4tExoEzb/A0lprZACkMl5NUJk3X3XA7p7a47Vg9csTmoDtGPO4vRFAO1yG+9PfCF8
         obzotfAvBvV6L3wcQRLlJJMJo5BuO8GSfx6CNgWOonBXfZehi4IERWERj8XOCQDaatu1
         fkMGUrVXnnYpNx5TU7eb1Yvsg/cP2xy1wstj1FpLqMBpTmf9D9CsBlLdL2oihcVZnk/O
         9qcQ==
X-Gm-Message-State: AAQBX9eTHjWn5lcm7Q9BvTYg5nl3rwSM6Fi2aS5CL+ldYphA9qkZR6hn
        bnDkEI+U9UXF/iTmrJDS7aI=
X-Google-Smtp-Source: AK7set9PcX1wQBYgcQZziKN4k3/aBOel+owJ6RB5FJHYvl5uXD+XrKIwdv1y3bASHxLhs1PWjTMe0g==
X-Received: by 2002:a17:90b:17c9:b0:23d:1143:1e3c with SMTP id me9-20020a17090b17c900b0023d11431e3cmr13088424pjb.44.1679933226053;
        Mon, 27 Mar 2023 09:07:06 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a0cc700b00231224439c1sm4437034pjt.27.2023.03.27.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:07:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
        <xmqq4jqa3xgj.fsf@gitster.g>
        <AS1PR02MB818545E563E40C5E31A02D1E948B9@AS1PR02MB8185.eurprd02.prod.outlook.com>
Date:   Mon, 27 Mar 2023 09:07:05 -0700
In-Reply-To: <AS1PR02MB818545E563E40C5E31A02D1E948B9@AS1PR02MB8185.eurprd02.prod.outlook.com>
        (Moritz Baumann's message of "Mon, 27 Mar 2023 07:02:54 +0000")
Message-ID: <xmqqzg7ych5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Baumann, Moritz" <moritz.baumann@sap.com> writes:

> The option would be called something like "--include-all-object-names" and
> belong to the category of options that only make sense in combination with
> "--objects". That name (hopefully) already explains the intended behavior:
>
>  * commits are not duplicated

Didn't the sentence above just say "all object names"?  Why not commits?

>  * as before, only changed blobs / subtrees are shown, however:

We are not showing "changed" things at all.  If you want that, you'd
need "git rev-list | git diff-tree --stdin" instead.

The difference matters if you are aiming for automation (i.e. not
casual browsing).  If you had a blob A, changed it in a commit to B,
and then put the original one A back in another commit, you should
see (in reverse history traversal) A and then B and then A again if
we were showing "changed" things.  But rev-list is not about showing
changes.  We show A in the latest commit, B in the previous commit,
and that is the end.  Original needs not to be shown, because rev-list
is enumerating the objects in the history and it knows that it showed
A already.

If you did not have a blob C, and added two instances of the same
blob C to different paths, you should see C twice if we were showing
"changed" things.  But rev-list is not about showing changes.  We
show C once for a path, and it is not shown again for the other
path.  The other one needs not to be shown, because rev-list is
enumerating the objects in the history and it knows that it showed C
already.

>  * blobs / subtrees are duplicated in the output if they were previously shown
>    with a different name

I suspect that adding "if they were ... with a DIFFERENT name" would
probably make it prohibitively more expensive.  The traversal done
by rev-list is fundamentally driven by "have we shown this object
(1-bit)?" to avoid duplicated work, and not "at which path did this
object appear (unbounded amount of information)?".

As I told you in the message you are responding to, I think I am OK
with the idea of showing a bit more from "rev-list --objects", but
such an enhancement may need to be designed a bit better, I am
afraid.

I suspect that "rev-list | diff-tree --stdin" without "--objects"
added to the upstream "rev-list" might be closer to what you are
looking for in this case, but I dunno.

Thanks.
