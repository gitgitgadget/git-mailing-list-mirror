Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED6C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6860EE9
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhJTObc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJTObH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:31:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47CC0613E6
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:28:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 75so22703341pga.3
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iz/4bQYuWy8M4HSVRyZVLZd+mK2NuxpRlZmqPuW3hkg=;
        b=UDmKJ7t2CkAbJY5nX0IV3sdmg2Sjax8iobdt7QTHx5zDw9kwC+pV2v2RVvXe4j8Ysk
         c0p4xnO0hAb2wQfuo4na0kCT6VTIOGbewFzGuECovX2fu+zhgn4jQHgwF8KiuRYze0qR
         au439qR+n979gLFRCIVDBKTjL8tQG4Bt6HNsu7XEBCCzwZzsA03tYgdrX0WwKZF58wkb
         jekf2+uVT22lrTHw33Y+9gFHF+TXyAOJjyrOh1sb5RhE62BHXikuSqN/VPzb5AQ2iFcf
         Ks1LUuDXXbMU8ZW2gaIChfvYik0cZWM0Rkw/FBXrKmJBaO/v8kZrXrmoEIPWLbIJJ+AQ
         Dcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iz/4bQYuWy8M4HSVRyZVLZd+mK2NuxpRlZmqPuW3hkg=;
        b=Mu5UNu0LXJsYX1T6LEp6/VQV2xz/GOdwzxjtoonYn4nVhQ0YuukCqXM9WsozkyaB3w
         2zZt9a++2TdZweQT2KcMdsGbeoCYVUOvCBey58gqZnFJM1DEFMqneEDjfhgI63GjFUeb
         OWKC5YwZGa3RVzw1lpCa87zyKrCZ4HvLIjAXsR4slPoQM0oAZw+TW8VY+a16GBzLqEZ7
         JjqP6+OEQRpLIGAzkAreKbCi+IShPr4HHxjQhqaZQFRGEM36WasotSpaS5RpiPHSQD7p
         ChtaDl/EvlQbJ49blAl9s0kFubBCz3LoPFR+WAL8hBmv24HKrGZ4xtOSmik8229BL6pg
         Pkyg==
X-Gm-Message-State: AOAM531ie8z7NVNgaeiqTyw9TvU90EaBZ5T0V/+WgjZS/ofITDesrrIE
        k2Iym2ldjLL+BkmaR+tU/O3L2A==
X-Google-Smtp-Source: ABdhPJzuyOC5SsIaTSuvg5Cz0LJYNTRrykX+EiT6XYGIp7aVKG8nTD+b3Z8eG3HX1q5hipQTW4KOPQ==
X-Received: by 2002:a05:6a00:15c9:b0:44c:a998:b50d with SMTP id o9-20020a056a0015c900b0044ca998b50dmr318178pfu.49.1634740128275;
        Wed, 20 Oct 2021 07:28:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y17sm2992348pfi.206.2021.10.20.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:28:47 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:28:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm',
 and 'git add' behavior
Message-ID: <YXAnnHfH8sv2ZJqF@google.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <YW3nAKAUj/HF15OR@google.com>
 <00188c99-386f-8d4f-08f6-11a49d31184c@gmail.com>
 <YW73QD7a+NzHd8dq@google.com>
 <xmqqa6j3su57.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6j3su57.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021, Junio C Hamano wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >> Are you using v2.33.0? This change is not in that version.
> >
> > Hrm, it's an internal build that says v2.33.0 is the bsae, but the --sparse option
> > is available so who knows what's actually underneath the hood.  I can try vanilla
> > upstream builds if that would help narrow down the issue.
> 
> $ git version
> 
> Guessing from the e-mail address, perhaps you are using something
> derived from the next branch of the day, maintained by Jonathan
> Nieder's group, for internal consumption at Google.

That's more than likely the case.  2.33.0.1079.g6e70778dc9-goog
