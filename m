Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8824CD6114
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377956AbjJIR0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbjJIR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:26:18 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75697FC
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:26:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so1936335241.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696872372; x=1697477172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v5dF0szkGzcUQTCUcJ1RtQDrFGbHp1rfGaj+ts7kqU=;
        b=IkPxyQ+GPJwPDL2BNeuwwIc8spscT+B4w15PPM8DHLZ+8w+4KKlGc9weRlmFhS4tDP
         PKbEoTnfqeSE5UHF4wkPi51Ae3thwp5D1qfom+AJNrPAkJZBeWbdxY4xgIYeZv9mfLvO
         DQmpzKZKEBgt/n+CM3UrPe/YGFBrGBw1CqKYfpi/r9tzw9k80zdpB949HD5JS4LHjEap
         H6lRTKLmWJmogkOlXkavxIynX+KRdPncF+xxwvPzVjvkXtRIyrhILWFA634rWgkjChXL
         I7q4Slprk8wj0/fcH/x47aX3vpu9NM76Zpvo53Us7UkKFdSy23I0nhUF/QVjkQzf1Czu
         o5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872372; x=1697477172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v5dF0szkGzcUQTCUcJ1RtQDrFGbHp1rfGaj+ts7kqU=;
        b=XLD0ZQtTIaGmGgL7eV2aQI6uK2qLMSgADOXwUhszpfu5FNtN0AU7v0/YZ+g/oufOAD
         /d+MQGQku1XJ/jF/CDsmQ1M8lYmBuovV/FjhxnYFmxPYhZluPYdxwNx/RvRgPL+PmOQt
         GuSSuTSwZynG6ZRivhOUE5wLdycHosnNnfMJefPPRBr7/P3Q0WRwzdJ6ZKHd7bn8zMKD
         EmrUlm66Ulv2e2oWjYmRSU+3CC9xge64r8xlLdweFlu+zqS0fFMUao9OqC9F4i+CBu7V
         KB8kZD0N3kpOPuVlEb2l373JPhRbPbTm0rvxvGnT2thKN6bpdG6IkzdaoK7N7iGnFxVk
         weAQ==
X-Gm-Message-State: AOJu0YyakRQiC7SI+SmVq2Aj9xavwAbEM3XS+7g04Eepq163xS3/BVCS
        rcMDbVU1bxkcxN+IoVbxStQ71A==
X-Google-Smtp-Source: AGHT+IGkrvJZO23JvMZqdGZC9DUpYbTqUp9YNeUTyg+yVDTM5d7pglouDwbTRVfC9VTk0RN6ppQQfA==
X-Received: by 2002:a05:6122:221a:b0:49a:88a9:cac6 with SMTP id bb26-20020a056122221a00b0049a88a9cac6mr14659405vkb.11.1696872372476;
        Mon, 09 Oct 2023 10:26:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a118e00b00773f008da40sm3663164qkk.125.2023.10.09.10.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:26:12 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:26:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <ZSQ3s3ZiRcvQIKOa@nand.local>
References: <ZQnmTXUO94/Qy8mq@nand.local>
 <20231002225546.409837-1-jonathantanmy@google.com>
 <ZSQ2XwbTM4DDLfJq@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSQ2XwbTM4DDLfJq@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 01:20:31PM -0400, Taylor Blau wrote:
> On Mon, Oct 02, 2023 at 03:55:46PM -0700, Jonathan Tan wrote:
> > As for the second issue, we can probably solve this by being defensive
> > in rev_same_tree_as_empty() by only using the Bloom filter when the
> > commit has no parents. Not sure if this is being overly defensive,
> > though.
>
> I am also unsure whether we are being overly defensive here or not. But
> I agree that it does feel safer to apply something like:

Never mind, we are being overly defensive there. The goal here is to
avoid using a commit's Bloom filter in cases where we are acting as if a
commit is at the root of history, but in fact has parents.

This only happens when we return REV_TREE_NEW from a call to
`rev_compare_tree(revs, p, commit, nth_parent)`. But we'll only get
REV_TREE_NEW back if

    repo_get_commit_tree(the_repository, p);

returns NULL. But when we call rev_same_tree_as_empty(revs, p) in the
REV_TREE_NEW case, we return early as follows:

    struct tree *t1 = repo_get_commit_tree(revs, p);
    if (!t1)
      return 0;

So we won't even consult the Bloom filter in that case, since t1 is NULL
for the same reason as what caused rev_compare_tree() to return
REV_TREE_NEW in the first place.

I am still dumbfounded by how we would ever get REV_TREE_NEW in the
first place, but if we did, I think we would be OK here.

Thanks,
Taylor
