Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4C1C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbjELTer (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbjELTen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:34:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3FE8A5E
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:34:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso9315774a91.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920083; x=1686512083;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuXq+fr8DYi9pmFqrjTUYHpC+1fGpAh6+rvZ6afMx2M=;
        b=csqEgclVwUNl/OpCYXxTQ6Jf1p+2tDN04WTPazWvEP2kStWtv2o5j+xbu1mMHWqkez
         fX6IDTH77eqCEMJ1pjKEpMV22YvnOPoW5xO6aKpIuJ0lLVy/0paUCqqaToi/fCr6ndw/
         VUH68DOC0WCUf2BMTAP70/EXFrvxcNlBVkKx1hBBHiIDJL1YRO9pCmPH1anNXbtkAi1n
         /8W6TfVoswy9OJGeR4By3Gtvzl5ZiM+4Zw4ymNlhILLAtwmt34QNmO3EYufQOKv5OLr8
         xYv61QiACKQ2AF9V/ANS9vViZfRraIylfwq4Xi52gwO8oFaA40lGxEADWOojFpL3ppav
         xyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920083; x=1686512083;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VuXq+fr8DYi9pmFqrjTUYHpC+1fGpAh6+rvZ6afMx2M=;
        b=UldLQqkD6Q6djFWjaAj3+Bw3mskZnQfoJPiqIf+3MHAEW628SGPhr2Qu/4uVVPrM0M
         vjAlgULrakhQw0AcBHvK2W1eHrF+u2VchW1jq9cq9gWabK7xs+Ae0+pgjpuUvuTbUi6u
         qDekJ2YXSkY5PyF22Cbi2pcwVQO3ghQReE7YapscgimVda5zoSdCe4JutiN+xSSPHF1e
         6poPVU4agrp+Ve8xZqCMr89iM5XXqBMzadZpBKa62wv6psXyrH2OOX0NwpkImVwfXWKY
         QbXj/vR2bvt6KGyAi0ZkO5uxPV9RmQvK7cYsXM5IdLrFBt/Uce8TG+MR6iMOJbZJ5I72
         dlcQ==
X-Gm-Message-State: AC+VfDx/CM34oFr+Fn4pGvzywE1krXcf9IfUBt09M0hEw1+18nH5Nasf
        F8/A/KP61pRacSYhruDpiWVIX71zspU=
X-Google-Smtp-Source: ACHHUZ6r1yrbPe2eezjRpg13de3VFtAjHCF/Bqda44CLq5JhlCadmhvU1HoJTnaJsCTNE+7oakNTNQ==
X-Received: by 2002:a17:90a:1fca:b0:250:d293:5d9d with SMTP id z10-20020a17090a1fca00b00250d2935d9dmr10726247pjz.43.1683920082581;
        Fri, 12 May 2023 12:34:42 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k13-20020a635a4d000000b0052c562bd942sm6996609pgm.19.2023.05.12.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:34:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
Date:   Fri, 12 May 2023 12:34:42 -0700
In-Reply-To: <xmqqv8gxpd8r.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 May 2023 12:21:24 -0700")
Message-ID: <xmqqilcxpcml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> --patch. Thus, making --no-patch a synonym for -s was a mistake in the
>> first place that leaked through review process at that time, and
>>
>>    git show --format="%ad" --no-patch
>>
>> will still work the same way even if we fix --no-patch to disable
>> --patch only.
>
> Not so fast.  I have a show.outputFormat configuration variable to

Sorry, but please insert "patch cooking" before that "to" or I'd
waste your time going through the configuration variable
documentation.
