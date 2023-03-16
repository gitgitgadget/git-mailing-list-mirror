Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229DDC6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCPQax (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCPQav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:30:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0BCD676
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:30:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p20so2319706plw.13
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678984247;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZbsmm/451MKQHLMZwjKMHS3vplBCqX5H11jX8pVVOE=;
        b=MVPKNW4za/YQZMmZqfT1Z2xQ3Nm2UE7gL7dl0mGy7eGegypJcP6KZFIP3m3qL7EOLC
         LTXQAhOsYhKn23pi9LCSCYu49baNKAjCTZAEb3ACiIegOLusRH/gUya37gRqvtvQR0b3
         NLZHQw7IxNPYJqbCczpSOpsCrVrPTNOddmncCQENnHQoa3PoMSm1Hmbiz6+F5G3Jkkqb
         e4jTK2Wn48lUvxBXBwcEbRoGN9RyQnx/eU9iAgQeC5Ea9bnBDdkaPEsw/LigqzToPE2r
         RDG53Fae8YO6fIHmbxdy0+3/l7xicYf1mwrjOyFAYnNrOWfdET6HmmU8lAl2veIaB+vb
         6XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984247;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZbsmm/451MKQHLMZwjKMHS3vplBCqX5H11jX8pVVOE=;
        b=MNn14HfgjG+LpbhuCr6nXzml/OCY/f55tRqtBvXBCf0MjGVQnNL5MhvDeFTzcNgCQC
         Qak4YkRaUTccdb3jzte5n0CDEnzkNJKkpH2TmJzrXQp1ARBjB3c8iP+Wk2dKShVPGld0
         vdjBaTYUS9NlK+mbTjhDPOx0F1A4Xq9A3qJXTTQDbO577PCNIVWJRWdfUwfGyzmZ3QlG
         NEfg5SXkRJNKBkFwPp8PR1OsSebA+1t9V7JYeUzZscVz2O5Ax0uRjqgORzJgGC8ZX6UR
         JvY/Qw19/ru0PcU2VNH8YEt16u7eWjvpW8c6x0mGXUl/GY7t7yDHU3ILXR2/9bm2Qn/0
         Mpkw==
X-Gm-Message-State: AO0yUKWCp7obAIGvaWtjI9+T9zWVGeMgF/hjO1ABmTePbA1BkenE2YDD
        CnEGGHeHqLBNZcHShkCTFFxZW7aQ5SA=
X-Google-Smtp-Source: AK7set+vWgyG+U7V32h3CGHKC9ChcBrnaIN05ImjyvbIOuDiCo3zpZncJL27GakTdFiDOqxrtMPLTA==
X-Received: by 2002:a17:902:d1d5:b0:19e:2631:7c01 with SMTP id g21-20020a170902d1d500b0019e26317c01mr3247755plb.37.1678984246967;
        Thu, 16 Mar 2023 09:30:46 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902934400b001a198422025sm1244996plp.125.2023.03.16.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:30:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] fetch: fix inconsistent summary width for pruned
 and updated refs
References: <cover.1678878623.git.ps@pks.im>
        <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
        <xmqqttylmww4.fsf@gitster.g> <ZBMwhLgGeUhtd5Zb@ncase>
Date:   Thu, 16 Mar 2023 09:30:46 -0700
In-Reply-To: <ZBMwhLgGeUhtd5Zb@ncase> (Patrick Steinhardt's message of "Thu,
        16 Mar 2023 16:06:44 +0100")
Message-ID: <xmqqh6ukmzex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Practically speaking we could go even further than the current version,
> as I now compute the width across _all_ reference updates, even those
> which are deletions. But theoretically speaking, we could just skip over
> any deletions completely as they won't ever contribute to the column
> width anyway.

OK.  It's good to see that you have thought it through.

> Fair, having a test for this would be great. But what kept me from
> adding one here is that the column width depends on the length of the
> longest shared prefix of two object IDs that are about to be updated.

You do not have to prepare "this is the correct expected output",
when you need to make sure that two kinds of lines use the same
width settings, no?  Extract such lines from the two camps, measure
them and see if they are of the same length, or something?

Thanks.
