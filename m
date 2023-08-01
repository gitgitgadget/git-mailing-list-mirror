Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D8EC001DF
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjHARbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjHARbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:31:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A1E71
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:31:35 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-584243f84eeso68577477b3.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690911094; x=1691515894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtwtCERfXNqPiz237aEXV2mg6TFDaaH+mIxwjZ/AOOk=;
        b=TTrYYrEW5QRnmZucA2+gfJk+ZzPiqWNai1YWJh5rE8diMYwUIh8X1Q6R1KAoFlMhYS
         +rZr8ymratcjskgwsf/QdNj9Hp7HDw1J9j05FhsWOq5qUcGIIt5UijrBRDu2/ywdxnNL
         QsXCIGwzBX5aXpB9WoQ9yc4TPAICWZafuGIurOOX5FaqdfH8mqVHadqz4AFfel8jH2aM
         W+Bnwqoz71JCa+sudmFjtGu2aqvgb2M02ljVXvIdK5Avv36BZKje60NsqkFjXUF/L/Ey
         mso7aVALdn9ebf/HLGoFRAMy7/DQ4OP1U2+jFy4TZabRRHz0/fiOH3e8YmbcVW9OiNvh
         3WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911094; x=1691515894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtwtCERfXNqPiz237aEXV2mg6TFDaaH+mIxwjZ/AOOk=;
        b=SnqhxHV+10RRYoONcUvVcGjrZ2TCuLE8FObj5/IvqdvBTngzAgyJ2NUsjpGywjz5SB
         5epblCNZ0IigD2+H714JH+6A9qhSdQqCeDb3ZG8u7PI+6K52XwE1cjFlIFCuTLv8udVT
         rW6ebYTI+vIRyTxrBcDtM499R+mHJT17kYIDQENBkLFqSPSaAr1o/ODfCsNKy0fb8uNN
         2+Q6voDsyzcrTOcWRyLWWKmdMKGUhb/kJbKfBWmTKvkiBjk7ddX52dR4qptsQq1uEgO1
         5NMEC/pQP7B0DgPqmCZITJMMVjkUYiSIsqIzhuIX3na99U/8xthMM5fBzKe1BZYDJs/b
         gxYA==
X-Gm-Message-State: ABy/qLavKXFf3e7aJIepTCfFHfLJ2qC88e/Q71fKjd6TvuduIVYe5DXE
        AXeQYF77Pif7vZJ1Ye412vG2Eg==
X-Google-Smtp-Source: APBJJlEb1DXVY1DTIjWY3aSpFB/QAOFfvG75ociDD3jAp5CZFKHWxSDQ2Jn3PIc7KpPDR5o4j2zBwg==
X-Received: by 2002:a0d:cc17:0:b0:56c:f68f:d824 with SMTP id o23-20020a0dcc17000000b0056cf68fd824mr16034874ywd.45.1690911094580;
        Tue, 01 Aug 2023 10:31:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r64-20020a0dcf43000000b00583803487ccsm3914216ywd.122.2023.08.01.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:31:34 -0700 (PDT)
Date:   Tue, 1 Aug 2023 13:31:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring
 bitmaps?
Message-ID: <ZMlBdb5jEW3s7UWX@nand.local>
References: <858rfnb770.fsf@gmail.com>
 <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com>
 <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com>
 <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local>
 <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2023 at 01:26:19PM +0200, Han-Wen Nienhuys wrote:
> > One thing that I was able to do to produce slightly smaller Roaring+Run
>
> Just for my edification: what is "Roaring + Run" ?

Roaring+Run refers to a modified version of the Roaring bitset
compression scheme which has an additional container type to represent
runs of a single (set) bit.

The run container stores the lower 16-bits of bit position of the start
of the run, and then it uses another 16-bit value to store the length of
the run.

For more, this paper from David Lemire is a good start:

  https://arxiv.org/pdf/1402.6407.pdf

Thanks,
Taylor
