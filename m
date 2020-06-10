Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BBC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3323C2070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qg6iA8J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFJSEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgFJSEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:04:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F3C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:04:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z16so3233765ybg.13
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JSEd35FDb8RCFBqmgWaomEPq4nEH0EziTZKB+5eKOvY=;
        b=qg6iA8J80KJppse0ougEFH8nlGx6q2rFHsaaC3+SMyd0htGI8CYdjvNIX0IzFx2pMV
         W3eSB2EGQZ0W2HF5YzLqVwIZW9KIfRz0TiYv6IMnrA4LDTFnzrr6ZOVMxVz/D0qbDR8L
         IgKQAaUbbcBVJe6BkRfDXqe4oUUV25BDNYLnmxv7JwwqO4AEEYRW2q+KCUVXFd9k4MiP
         +b9sgSzW7EOmXknVVVUwA/yrExffxqt5lW1ADV4JqjtCMAsYkVrPHLchLZ6y3f5zXplz
         NVYGl8+wmd5hz+3aEAKYiSfmo1HLCoMQQugmEmuOLf9v+tQnekAU6si6+j/Jf71kwrmb
         U7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JSEd35FDb8RCFBqmgWaomEPq4nEH0EziTZKB+5eKOvY=;
        b=XerHe605XSEGzW1WdIDWykRqwvdElXCudX3by8UuvzexvJhqJvt7dyLLCE29N5OCRy
         bPrpYPZ6ZZ/TT6HrmZcpoIrZ+7p7oYpSa+qqb7pbenCYdCOyFY6zLNryz3eilTyN5UU7
         iCKN2jkfdVNJgkmIk5Yr0epElGUc6pPSSFEhE84PYik33YOXa1Y+PpvrXmUYpPqcbHoX
         UdyelsATPepk1Ukk2RuDKgitwAq1y9WVvSMvzkllXupLr2sToB3rSDaeBjiMHEyqtIjO
         R/e4dFEKPK6qFbnF5yIX1zQ1EPCHM0bR1wfskisvIsYEBakXVUUPfK2rFUsEFxppCBb/
         MMWg==
X-Gm-Message-State: AOAM532lCb9I85904Whvg36wLrzdkbKR6HAs7O+YsxjgwVUAvt3aABsN
        dSVkt9cGWkMc6lguH1wrRR3eJPiu0hjyM6FHuIta
X-Google-Smtp-Source: ABdhPJwrZFaB457pAqJUrmd3q/RzCkKd9oEldyNi7857g2C3n+c9lEcEt50WeYh7Ddvi8MDzbDuq0+vG5csSGVXoo9ej
X-Received: by 2002:a25:bd47:: with SMTP id p7mr7187205ybm.39.1591812243999;
 Wed, 10 Jun 2020 11:04:03 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:04:01 -0700
In-Reply-To: <xmqqeeqmg7ty.fsf@gitster.c.googlers.com>
Message-Id: <20200610180401.71146-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqeeqmg7ty.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> > @@ -349,6 +362,9 @@ header. Most sections are sent only when the packfile is sent.
> >> >  		  *PKT-LINE(wanted-ref LF)
> >> >      wanted-ref = obj-id SP refname
> >> >  
> >> > +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> >> > +    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
> >> 
> >> 40* 
> >
> > I'm almost ready to send out an updated version, but have one question:
> > what do you mean by this? If you mean that I should use "obj-id"
> > instead, I didn't want to because it's not the hash of an object, but
> > the hash of a packfile.
> 
> It clearly is not an object name, but it is a run of hexdigits whose
> length is the same as (hexadecimal representation of) the object name.
> 
> How is "obj-id" we see above in the precontext of that hunk defined?
> Does it use 40*(HEXDIGIT), too?  

Yes, it's defined as such in protocol-common.txt:

  obj-id    =  40*(HEXDIGIT)

> Do we plan to support non SHA-1 hashes
> in this design in the future, and if so how?
> 
> "We are only focused on SHA-1 hashes for now" is a perfectly
> acceptable answer, and then 40* here makes 100% sense, but then we'd
> need to say "for now this design only assumes SHA-1 hash" upfront, I
> would think, to remind ourselves that we need to consider this part
> of the system when we upgrade to SHA-256.

This will be whatever is output by index-pack after "pack\t" or
"keep\t". I'll make a note in the version I'm about to send out. Yes,
we'll definitely need to remind ourselves about considering this part
when we upgrade.
