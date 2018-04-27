Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09521F424
	for <e@80x24.org>; Fri, 27 Apr 2018 04:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeD0EP7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 00:15:59 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34306 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeD0EP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 00:15:59 -0400
Received: by mail-pf0-f173.google.com with SMTP id a14so510324pfi.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6a5SjiDERVFQMoeB+1HSMjhyuVtqkIA++tF0MFpDmk=;
        b=uaEgLc6osxfsVeFTB5z084MOWCyjzR8iAM0Nxu++H38HkrCpRpR/m8fBY/g2avdD9R
         cxgh4lP/ukcUibYUI2oCz63HnrKUieo81oJE827c/zcLMjArrZn91vSaKNdVbhoKfFXp
         p9VaBKS3rqOX4NOrnDPlvyM8YFb1VCgXvhmA0PZeUdImU/TjNifzLUFj9CnC4oZxutu8
         ovzD0AAvT7GPm9CqGTBEzYk2N7SJ7kXAgLX1gl7Ue0Jr0vX2oOlLToa05SwT4snxe1O5
         pMfsZSR+A5LAr3+svRF8pJ5pMqphOBBSAjnEC44I0atXUCtRVKZ/bnRaGFFwL8S/hB2A
         B2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6a5SjiDERVFQMoeB+1HSMjhyuVtqkIA++tF0MFpDmk=;
        b=UuvbX90rgX4gVqb/M7o8SxHXGwvoEEDr44PXbIJyoxLYT9fz0+B4dv6KFfa+y03unf
         vaq420o6QK/xZ8UUuvKsCgThC9HxB1Wrewzs8nKr0l/VlqHA1rx5EY5qy/X1B7RM8vSo
         VJhoEvrMazanR2TVPwtFxUZ7rvIueitNNm/GSozJal9QdkmQvm5H6ZtKIXgSZ2xRjg2e
         deKpr/erMk79jdlbOFY6XtESGou/R09zGoEO/YAiR+0PsTuXroXfZrIV9XCLhkCo1uMI
         ghN4ObH3FU3ZtDVKEPO9YyMq/pqNmEAyz4zKWWW+R18RcD+zi3xIEDLyLoyCXwrcgJdv
         B6FQ==
X-Gm-Message-State: ALQs6tBWR2fMB2H+mU7CAzIwm5imkA1pcFRuDdsgXE30pyJ7qf5YxiFF
        2mr4Q7DrT1ykkBfkSLEW3XZiOSsh
X-Google-Smtp-Source: AB8JxZqWPE5ahfj9Fv19V7vJHqifEo4Olnxzf/Z+ktzi22v6PEgCD9yrJZh/a2QxhY5YkeGdTTqLNw==
X-Received: by 10.98.0.194 with SMTP id 185mr755464pfa.238.1524802558292;
        Thu, 26 Apr 2018 21:15:58 -0700 (PDT)
Received: from [172.22.44.62] ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id m7-v6sm515868pgs.31.2018.04.26.21.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 21:15:57 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blame: prevent error if range ends past end of
 file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, szeder.dev@gmail.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
 <20180426074502.78318-1-istephens@atlassian.com>
 <20180426074502.78318-2-istephens@atlassian.com>
 <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
 <25cd86ff-a5c0-a968-62d2-4365e5e17a81@atlassian.com>
 <xmqq36zh1jtj.fsf@gitster-ct.c.googlers.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <dee9083d-0745-6b98-fe5e-fc19d2a5bb9a@atlassian.com>
Date:   Fri, 27 Apr 2018 14:15:53 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq36zh1jtj.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Maybe I misread the previous discussion and/or your cover letter,
> but I have been assuming that you are trying to avoid failing the
> command in a useless way (e.g. when the file has only ~800 lines but
> the user does not know exactly how many, instead of letting -L1,820 
> to fail with "the file only has 815 lines", pretend that the -L1,815
> was given) and instead give a reasonable fall-back behaviour.

That's correct. In doing so I picked up on a few extra cases where the
behaviour wasn't intuitive, so I've attempted to fix all of those with
this patch. 

> And to be consistent with that world view, I would have expected
> that the meaning of -L<something>,-20 to be updated from "fail if
> <something> is before line #20, or show 20 lines leading to
> <something>" to "show lines leading to <something>, up to 20 lines
> but it is OK if there aren't enough lines in the file to show that
> many".

This is the existing behaviour. -L10,-20 for example will blame the
first 10 lines of a file, it will not fail. My patch doesn't change
this. The case I am discussing is -L,-20 which at the moment blames
the first line of the file. Trying to go backwards from the start of
a file should be considered invalid, in my opinion, however I don't
feel strongly about it - I don't expect this case is common in 
practice.
