Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F55C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjCOU7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 16:59:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024072AD
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 13:59:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso3094792pjb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678913948;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwVjG+6qLWa+C7bX2+R8srTNNVi9yOj0oFNRmdt5axM=;
        b=Zc2KwF/28AU3UlJ8NrOlSQa36136EcVc9TcsGsC2/uFaDuO7UxMirsz8mMnDZcvvoh
         MKQG4ITQaKKgTikdlgfzmEdMEuEoiI/BCqWfl8P5d/tYBAlyX+3hVhTNME9yaw+tDNtZ
         AgAlHJdWp1xZZ/NHnkqX57bUBQiY6YtG9f/ijebi4pb0MoQ+McQE6wF7T4dtuoAn+6S+
         XthYhIhMv+i/TQ+6po8InO5xKorxWj34yvbw3R1kwYHEFGLLy2woC9LZp1dYqACDfCvV
         P7Qalcs/7Tn/fUdW2B1x/OsqyT0xmlcuLK+/uu0qEZyX4hYo1oHdbd1I1KclV8OJB/uf
         An9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913948;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FwVjG+6qLWa+C7bX2+R8srTNNVi9yOj0oFNRmdt5axM=;
        b=NzrCq5g84aRRl6Av15jAs+6aDSWcZYNGo+DH5eKODyLa7uGYJI8jlvRPEK+njuM8wY
         uFqlZmAmYHCBthYzqhEWTA5GedYS+VC5JVq8X7poocpwS11QNYojyswXcqszCBajdub4
         1GbQdEPnXNNDH/7wr3Y73h1S0h+cF9J6kgp8ll79a7S90zGwXSMoSn/MfqLozZ5M+2s7
         B8THmJg1KjuhBqfY9XJ8YC8BSJSPnQrjhjcqzp6a+zgo18AKpnQ9OUUz0oJLVYs3HEy+
         MYiaa3Q89lijSr2R+4Akl2yJmdwc448p9iL0bjZhrhvAB+f/cNA+6wwwPEbBQxO0vPgn
         l3+A==
X-Gm-Message-State: AO0yUKXL91nAUOMgbxCe3TvEDcphtVyVejVZaQ3aSnMf0VLGR5ziyRcs
        ETfRT3hctg3UXZ+TQvi78KA=
X-Google-Smtp-Source: AK7set8ti5Z+Aq8279f2EyLXZXvYKyzMM4jdNsWjuCa/qo/6p0xQYWavN6xlbGF2iFsKGf7j9I+SGA==
X-Received: by 2002:a17:902:f90f:b0:19f:1c64:c9d8 with SMTP id kw15-20020a170902f90f00b0019f1c64c9d8mr684368plb.14.1678913948362;
        Wed, 15 Mar 2023 13:59:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b0019e81c8fd01sm4041278pld.249.2023.03.15.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:59:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
References: <cover.1678878623.git.ps@pks.im>
        <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
Date:   Wed, 15 Mar 2023 13:59:07 -0700
In-Reply-To: <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 15 Mar 2023 12:21:09 +0100")
Message-ID: <xmqqedppohno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In order to print references in proper columns we need to calculate the
> width of the reference column before starting to print the references.
> This is done with the help of a global variable `refcol_width`.
>
> Refactor the code to instead use a new structure `display_state` that
> contains the computed width and plumb it through the stack as required.
> This is only the first step towards de-globalizing the state required to
> print references.

Nice.

Given that in the previous step, what used to be called display got
renamed to display_buffer (I think "buffer" ought to be sufficient
in this context, though), the variable of "struct display_state"
type should NOT be named "display", as it would be confusing when
two things are related to "display" and only one of them is called
as such.  Either "display_state" or "state" would be fine.

Thanks.


