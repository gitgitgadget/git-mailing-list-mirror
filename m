Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F240C77B61
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKAAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDKAAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 20:00:08 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE081980
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 17:00:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5491fa028adso452275137b3.10
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681171207; x=1683763207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT97SUEDy37SUEIRBv7cttc3kekhJkd9JykrSRc9Skk=;
        b=UpHKZcrCHrAhEfd2S5rks2YqBsy5bQeqD8jNeRnqakmF9eo8OMv8pdKBz8HJzyd5R8
         CqrrrzAJ8424wuYOCzAHW81kYgKRyK6i4t5n3XwFqH+30fCXwgCLrIGkJBbrCDmjdHMj
         6i23UWVfAGxilIohQ32Vhn4NkeFawY5vNeujgwxHtqDhzYnX+A7ILOkgrvRMEzc58pG5
         fLJc5rZAYTQLZNO/ziLwoTGT34iYaOjdYAW8mBlLdmV7iiqW6U/nxbGOu8c5JGesJras
         bsN1hq/6qLEGj/9PqVWJK55qfWVjzoLxUsjd5zfNB9Gv13QuDpsU1TPcDkJouZMuFzRn
         bTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681171207; x=1683763207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT97SUEDy37SUEIRBv7cttc3kekhJkd9JykrSRc9Skk=;
        b=UlFiU7lzZ1qmJ8j+oNhMvAiOEfXQBRtmXOfXmg+F/j4q00xFQKU2B9lsi/hi2uHodU
         wmx8B1ouvN1D+BGCMA2YyS58XIBkYEsIKFp8hJ0tHIRKk0rah/HgkEtQUGjceN19FPIN
         blSy0RiX/W9qLLGNrG85ABVNvfnDEKgc1178xywxsRuzGVPK/Z7UCq0cax5Jy1AdhnYu
         3wn09wd3pNU6muZZxEZ6mpSzeH82YRh3oCKcNXRO+PhRFLClLvTeakUc0fhf1dBKuixA
         hF1QV+Uv9xdHttf4A99TE5tauYfe6WX9ilH7TtuViKKE7BS9VeMKxuVLPec/Y096TKnB
         cxSA==
X-Gm-Message-State: AAQBX9fZ5hScETXn80twga6EbSUqfuzzFfXWNWite/S+I/G+dWN/d7sE
        YXh7/LdkAsQ6f7f2CvI34h9CtbIvsjhNzF1JCHAOgQ==
X-Google-Smtp-Source: AKy350a1dOGzt6BBRRC45FIQHDZBC0cHVRR/OQk/0fe1JSZ53naNyjNrLvBcYp1XBvsBKO9qlNxJcw==
X-Received: by 2002:a0d:efc7:0:b0:544:f952:2184 with SMTP id y190-20020a0defc7000000b00544f9522184mr5569924ywe.44.1681171206832;
        Mon, 10 Apr 2023 17:00:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 79-20020a811452000000b00545a0818470sm3153261ywu.0.2023.04.10.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 17:00:06 -0700 (PDT)
Date:   Mon, 10 Apr 2023 20:00:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Rohit Ner <rohitner1@gmail.com>
Cc:     Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: git log causing hang while browsing upstream linux
Message-ID: <ZDSjBQhyDBGi9wBN@nand.local>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
 <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
 <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 10:37:15PM +0530, Rohit Ner wrote:
> I have not given the command more than 10 seconds, shouldn't the
> intended behaviour be to render the visible subgraph first?

This is possible with Git's "commit-graph" feature, which you can read
about starting here:

		https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph/

TL;DR: if you run "git commit-graph write" once before running "git log
--oneline --graph", you'll get near-instantaneous results.

Thanks,
Taylor
