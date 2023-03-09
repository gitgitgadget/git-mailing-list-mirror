Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAFC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCIRHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCIRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:07:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865E64212
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:03:36 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v11so2663643plz.8
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381416;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX981tudHfT3TIxj8uQ4ZYpLx2DQa13zBOt2HxNXHI8=;
        b=YUi1IZcU7/E4eGdMfZ06TLNvVAOXTXNSvfpxCzDSc1OGufNw1XHZ7gkfOcyTm7pnwj
         ACsgOp0wuNJgvaiG3l4thF3V28XuHwQFR4wlGwflrlHgyxOSBEjnTEVTBn2FIaW5Oc2l
         UCMrm31W+5hGKE77A0QDTP0YjLcETQ00/BO3Z8XZ+cpL6xEwxvmz5Y7GvJ8WiHD2dTTd
         qWE0HdRXCEXu5VdIRrX4Y9RSZ17E3B2HY9621muhq+Hh+j1u80EMRy8NT7dtdCzGNtHQ
         kkGi6OOzBv/zmdVZiFTr/znPnAjKCq2Yqe2CbAwYyrFf+KwvhY4T3WeWxcuLjqfb6spi
         rLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381416;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX981tudHfT3TIxj8uQ4ZYpLx2DQa13zBOt2HxNXHI8=;
        b=AWzM6PtsiT/IvDvRjlWrJgYNbGZDaSafwN/ShwcsfBO2acXzdyTQbQ+Fs500MZRNf3
         f9HFsn2YGFYgyaxPEGyRWP3EphMy5bU9TsDqyZC7cyf/KpaOQfDw94YTR9EbfknsO5iR
         mw7IWyv4ia+gQ8M0p+8I2+ShyHaIwI4OcCF2b7VW6fAkzOJEwxZ7x84y42C8dg6AWtkG
         XleqOb9e5JB+lZLFRWMc6aLUvgCr+aHvsohJJo52A1UwwkHxKM0VoykXfc1JygJ6shb0
         Q81O9a6MWeFnjX+OQIoaZxmND+knm18X8ANqMdXb8m2nXjL6bEBAz3qVZlsuRkGz90ry
         gCYw==
X-Gm-Message-State: AO0yUKVqnQG8rQaqtU2tP09Xzj64XmKGTm5BFSLyFS1N0fmGx1jKxy+V
        Cg4YbQ45QVooaQf/tPXJd9Y=
X-Google-Smtp-Source: AK7set9jAOUFXuBamlBHWrxhtOK9Yqf6S1R+mmNm3ak+QddFxb3jZ6jgpc+g3FxamKJa2nsjQwWEwg==
X-Received: by 2002:a17:902:e80a:b0:19d:243:d5d3 with SMTP id u10-20020a170902e80a00b0019d0243d5d3mr23415200plg.33.1678381416296;
        Thu, 09 Mar 2023 09:03:36 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170902f94c00b0019ede2dd547sm4874829plb.67.2023.03.09.09.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:03:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g> <xmqqh6vwrpce.fsf@gitster.g>
        <xmqqlel7rj9z.fsf_-_@gitster.g>
        <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
        <xmqqwn4qokug.fsf@gitster.g> <xmqqpmaimvtd.fsf_-_@gitster.g>
        <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
        <230308.86fsafzllu.gmgdl@evledraar.gmail.com>
        <ZAlSUYlDn7/9d2LQ@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 09:03:35 -0800
In-Reply-To: <ZAlSUYlDn7/9d2LQ@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Mar 2023 22:28:17 -0500")
Message-ID: <xmqq1qlxdfh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 08, 2023 at 09:34:15AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> As added review: This is the same patch diff as I sent on February 9th:
>> https://lore.kernel.org/git/patch-1.2-d93c160dcbc-20230209T142225Z-avarab@gmail.com/;
>> my local range-diff to my previously submitted topic & next being:
>> [...]
>> So this LGTM.
>
> Thanks, and sorry for stealing your patch. I forgot that yours existed
> in that thread (and obviously I'm happy if either is applied).

I am not Ævar but the last time this happened what he said was that
he did so not because he wanted to complain that somebody else stole
his thunder but because he wanted to show his agreement to the patch
by pointing at an indenendent invention of the same thing.

I personally do not appreciate that tactics, exactly because it can
easily be misinterpreted as a complaint.  Saying "I read the patch
and I think it is exactly how I would solve the problem, too.
Looking good" would have been much safer in that regard and conveyed
the same agreement.

Thanks.

