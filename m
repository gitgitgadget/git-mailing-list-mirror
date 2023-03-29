Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC000C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 09:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjC2Jty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjC2Jtw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 05:49:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B444B2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 02:49:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so60852335edc.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680083390;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UF8VAlpojmTXdAO7T/kLuymqgZYj68cxShOjuGTZEp8=;
        b=BcoFlMLbNDXB2GMxmjBzOtpQuaSpKfhoQReM8hhucgyPO81cn68OiqceyMdXpHrzJd
         OhJ5FU56B0s2Fyoa3B2GT5PcO9S8DEyALjiiuNBa46DJhyTU0XC8p65d6wOvhSY6KG/e
         pD6xY7P5YpJdrOc3nUeAQDqhYmIvHWgLQOYSWCwByvVjujcTolugcQEEE0MrVu3T+2uI
         /wRINnKMO3FoPlnvTEBFeYXaOnAVn80AgxfMra3olM2AZ3+IBwXF1JFrwh0KZv7pMetT
         v6GAfs/BLOdJfJslMsg6HyvnPzBNhwPqqnMS4+FzFyr3OR1kAYBqouQVRzQzKuyVVv7b
         UOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083390;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF8VAlpojmTXdAO7T/kLuymqgZYj68cxShOjuGTZEp8=;
        b=mkbAQcfAn88ZwaaJcHSw18QwhXDCqZZ6uvtodhpFu1Tqs84lfn5KsjPMysyF4cLkwn
         T96pUUw3gFAXUIrEOdeVwUuwPqmEPzBD3WUMGoGRabOpTZ8oX2WCknhRDh4QvHk7gQkh
         Vnnmh33SlUpbShIy9r1ob+jMtsh6XicfKgb/RQ7DjS18yHCs/15kUKSPX7IAkxvA51zI
         tj8Qa5v7kuito4FrjSOaTM8Dhj80gavNwMIutEdxc1lmpDsNP80tJceBwMx8cl+zh7SH
         bwz9ei9cAXzDQfvddMhOd7urP1l2aMgKcVrb2lya3c9SL5AiD1pjlkeFLDgnGt/1IpgD
         T6TQ==
X-Gm-Message-State: AAQBX9fks0ia7drBXGjzMz66ybEDTdmMnPhab0eWHfRfvtzt/x7MSMqG
        72zczNn7fInCIQZk0zwoXE3m2bLLVNer2A==
X-Google-Smtp-Source: AKy350ar7xzag6SL4MwPUtXwcZRjfv2vOY//9rFaxpa4bhz4zKCJv+kEjt6daFyniOSInc3c+rB7jQ==
X-Received: by 2002:a17:907:20ee:b0:930:6e31:3c11 with SMTP id rh14-20020a17090720ee00b009306e313c11mr19996637ejb.70.1680083389661;
        Wed, 29 Mar 2023 02:49:49 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906c09100b009306ebc79d3sm16289963ejz.59.2023.03.29.02.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:49:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1phSRA-00563A-2S;
        Wed, 29 Mar 2023 11:49:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] test: avoid `stat` variable
Date:   Wed, 29 Mar 2023 11:48:42 +0200
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <20230328173932.3614601-3-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230328173932.3614601-3-felipe.contreras@gmail.com>
Message-ID: <230329.865yajx4xv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 28 2023, Felipe Contreras wrote:

> It has special meaning in zsh.

Nit: If we are going to rename these I'd prefer (just from grepping
existing examples) $exit_code, $code, $ret etc. a "$stat" at a glance
would seem to refer to stat() somehow, which is confusing.
