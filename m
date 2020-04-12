Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41994C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12630206DA
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkGAgxXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDLGcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 02:32:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33874 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDLGcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 02:32:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so2269074plm.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ui1wcWIVs9jI0tbmHJtf7+kimZzW0oxaEL4u0krpZl8=;
        b=XkGAgxXcnvjh36ZjyuXvpAOYuFBL85EAruLg/8EK6wfxuUnOyJo/yfDrJ3EB0WWd6W
         rBHs07reztbPN3eUsJkHSSQxzOAQcBHPwS7HNsdd4aMEl61E9TUVmXU2ui+6b3iBHfcs
         E3h+8RqKx323J/Ce2IWimv1g7CI2RUvCs1VQTwLQZWBZ5rYOfZ3IpInNI4Xq8BRsHfbK
         mAY/Iue4dglP3bbZhPPg0q5vXYlPtGe1YbkVT5sNiHvv8GRleNmOhJJmlUIim2LtUEj4
         KMs3n/qMsrwV72Pv0B+Rra0Waou2HqsnPyIj6AqG67fq8rs7J5cEsOGmSjZT/lDxsKf9
         J2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ui1wcWIVs9jI0tbmHJtf7+kimZzW0oxaEL4u0krpZl8=;
        b=rL/9Wn/1UTjGmpF4rBCoY5h45igX3E7nm1krcrBRw5aAxs+qEFjkTJ1/ZcapEvU3Xd
         rCeYlqmfwziFacXiNn8jncPlxmmOzq0nS8CNUMCpMX7rmXu56eEa20KPefAo9YpfUXYd
         P4Gxae5hP3qgcW3edQVuZuyTr0BW9Cpo0AefCeGuyKN2HX7ElBNF3n2ZOegIDZmVG7Bp
         ykKSgr9JfrP3niBGV7Mw7twqUc8JwClkP6KArrrBFHzVzc66OcWRqh5XibL2zeTt/Hjl
         YxsoU5+70kfiQUaa7Cnmf7aD4xgzb97VGgzQfHY8MGhQAkkNSuKh/UoHbBIH4BVmaTqq
         7lXQ==
X-Gm-Message-State: AGi0PuY9izTXdX2tUw8KwUZC5tKCWHK/mrM2wXkvgo+fOXahsIv1q2Tk
        v/gz+x2IJMyudIy+mvirHk2AwELy
X-Google-Smtp-Source: APiQypLj5oF01f/nNdOB8ej6nhm//V+IxEkTApFg22lK9upFzQqg6UUrYkQ7fbmbhPVQaA6AO2eemA==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr12456695plo.189.1586673122223;
        Sat, 11 Apr 2020 23:32:02 -0700 (PDT)
Received: from gmail.com (48.57.197.35.bc.googleusercontent.com. [35.197.57.48])
        by smtp.gmail.com with ESMTPSA id g11sm5642526pjs.17.2020.04.11.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 23:32:01 -0700 (PDT)
Date:   Sat, 11 Apr 2020 23:31:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Vladimir Nikishkin <lockywolf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: When will this patch be merged?
Message-ID: <20200412063158.GA27852@gmail.com>
References: <1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com>
 <20200411120821.7675-1-lockywolf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411120821.7675-1-lockywolf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vladimir,

Vladimir Nikishkin wrote:

> [Subject: Re: When will this patch be merged?]

Please keep in mind that these mails appear in people's crowded
inboxes, where a subject line can provide valuable context.

Which patch do you mean?

> When will this patch be merged? It is 2020, and git submodule is
> barely usable with my internet provider, since outbound connections
> are randomly shaped to 10k/s. At the moment I set up updating
> submodules for the night, hoping that it works. If this patch was
> accepted I would just see at which attempt the stream is not shaped
> and reissue the command if it is.

From the In-Reply-To field, it looks like you're responding to [1]
("submodule: add verbose mode for add/update"), from 2014.  Have you
tested that patch?  Does it apply to current Git?  Has it been working
well for you?

For your application, it sounds like having a timeout (plus Git's
existing support for retries when fetching submodules) would help.  Am
I understanding correctly?

Thanks and hope that helps,
Jonathan

[1] https://lore.kernel.org/git/1394631731-4678-1-git-send-email-orgad.shaneh@audiocodes.com/
