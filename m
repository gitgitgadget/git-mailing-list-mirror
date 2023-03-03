Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499CEC7EE2F
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjCCUOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjCCUO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 15:14:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0FE17CF7
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 12:14:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n6so3937932plf.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOeSLqqgj25jjij7Jv77SqO/uUDl700LTdAcqU5UvrU=;
        b=PPKAdtZqb57USLYKDJxPqM8CO35FatHr7mCB9te2YJr/8EFk3yA9ynj4QVQ4Ci7efo
         ukzttQsS6jG2SZo0AyOvtAUvvzhbNR+xGLLfGOmnDv0Z9SK6Bevgvk+u2y4wsLTiGS0s
         LbXbuAnsxJ8wo1KFf9b7KlagCoRpNYwfTIxwqZoVoPuXGZYmk+Zrw+qSf0X8qphDl/1c
         ZpVrIQ/FJXsoTn2R4YyrWGiQNetxYyXMJXhUspyU+IAaBFmIRqovx2XxzzAsbw0KiyA/
         JnamCAQE6BTpI3gbvosbJXluTpjqeHapFThAp/Uj9vNG9vPGXdtGjp10Jy2XkCAirXVd
         3YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOeSLqqgj25jjij7Jv77SqO/uUDl700LTdAcqU5UvrU=;
        b=pdhQj4Aug9U4muZvzG7Gwsr0j0Fsiqn3HlCDCradKRIHjhgvDGWvp54ttZ3Fa7hOYu
         3z7moFdL7+WIx/5YhV65fMcaN6PEN2wB1fE19hrjkorj6pIo2HtqbwbTwijlqCwzKOQG
         23ALy+CeDwocNN5EBflBP6Z00NC5issWQq0UHt9CYj6prdp/ZGU02E3u89bNEVUBYpRM
         nE/aBM5oIZ1PHrQo7shHeeFBPOdTozjKVo0zBMUFD2HK2DAKiigY4bZeoFsAa3JHR985
         ptEPEBuWvETKLsMorY+C3UqbbVP5obxsx/zwk5BjHpOEJpL0u2d/BeRA3pgh/JQnIdUQ
         Kntw==
X-Gm-Message-State: AO0yUKWi818iK709I6WiAH5EFTI6M/yIFv9K3YVX4jYXFk1TyBLKITyQ
        PmUhQAd+2CGqjoVokKP29YXGgdoEn10=
X-Google-Smtp-Source: AK7set9RRcBRNnLdRYLbVWg8IzLv0+RSWdZl1w7xKhKPq2ljqH0BjFHu+r0TzeGcs6tzOqrKeterew==
X-Received: by 2002:a17:903:41c4:b0:19c:c184:d208 with SMTP id u4-20020a17090341c400b0019cc184d208mr3222385ple.66.1677874467230;
        Fri, 03 Mar 2023 12:14:27 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f11-20020a63100b000000b005023496e339sm1893606pgl.63.2023.03.03.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:14:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/2] cat-file: quote-format name in error when using -z
References: <20230116190749.4141516-1-toon@iotcl.com>
        <20230303191708.77894-1-toon@iotcl.com>
Date:   Fri, 03 Mar 2023 12:14:26 -0800
In-Reply-To: <20230303191708.77894-1-toon@iotcl.com> (Toon Claes's message of
        "Fri, 3 Mar 2023 20:17:06 +0100")
Message-ID: <xmqqv8jhegnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> I was asked to provide test coverage for both code paths that produce this kind
> of error message. Instead I've decided to ...

Is code refactoring a substitute for making sure we have adequate
test coverage?  If not, "Instead I've decided to" is a strange thing
to say at this point in the cover letter.

Relative to the previous round, you cleaned up the code by
introducing a helper function to show error messages, which gave us
reduced duplication of the code.  This is a very good thing and is
worth mentioning.

You however didn't get around to add adequate test coverage to the
resulting code, which was one thing that the previous round was
found lacking, and you can use help to improve these patches in this
area, to help them get merged.  Some of the error cases happen only
in a corrupt repository that lacks objects that are expected to be
there (e.g. a tree points at a blob in a non-lazy clone and blob is
missing), so such a test may have to deliberately corrupt the test
repository by removing .git/object/??/* files.  

Hopefully we'll hear from those who are willing to help.  Thanks for
working on this topic.





