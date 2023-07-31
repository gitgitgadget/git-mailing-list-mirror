Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EAC04A94
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 20:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGaUKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 16:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGaUKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 16:10:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1310E
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 13:10:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so720949276.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690834231; x=1691439031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LxraaYmxSZJACXKhF/y2OJk4aGwXn3IRzpjmLisst98=;
        b=MokYrZpAerFIe9VP9nsC+qVV7Vl852jPwt1I2M29A7N419b1tj3hcWvLwzG4ufwedx
         Ejos+wAvAik82dR+TjBtr1gWtfehQsgRssqSY1qPo87z5MTr+qKpRbf9ATd5ZlnyS1T5
         S3n1AWapHbaRTmyyFJLK7UXofxML3bMePJoID801CjvqqD/mrZ8HbS+p/2nMfNtjS5iE
         cAJo6g16ac12Isqhh2zTDhg9TNCgBViIqLZLOIxiVBsMhfULNtuiuMHe7tDcCmaAqCW+
         BUd8s5/Mw7L8TIOLmIEtwusxHhmhdT3eeBJI6gWT3re2/j2Cx70+eiW+3CNQYaKidA4B
         5Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834231; x=1691439031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxraaYmxSZJACXKhF/y2OJk4aGwXn3IRzpjmLisst98=;
        b=fVWLb7F1nDkSv+6VbGX7TvvB6s+BGm5LuRStd0lBPK7XbCELK3YFlWXcYiuXDUQvxx
         mqFn9KT+wYTRXJQN04mEPpj0OWzwwoWfzoBNuQDoArr9jbxWL5x666ticvjfuTDgifY7
         9/le7EPvoMfcM5SFA/cYVc0VOy9bws330vWlbDcBpMlVbl3PUoo5PMmtBtw8tAJPUs4A
         xn6ij6yR9HQw3uA4Cu8nb6BgJJSaP9WpRznek6UAADbvq+0mYB8ti/5pethO2dKcrgQd
         Xvvqwo4zyCpKukrk6l5bNYw5iLdvPi1IgUoPJzXzKY3piSEfr8gq40QcqO9qFZRbqGmd
         8H+w==
X-Gm-Message-State: ABy/qLYCIWgCcerpohUkV9xI8evXBc8Rqdt8nBKBoPc92LmxwyTtQOgO
        IDd62z77FDn1C5J/Tq2BnWnxNA==
X-Google-Smtp-Source: APBJJlFm81TmnQ7oXvsKovqlMZ+6f9FteBotZAbv0ad5X2e36anh8dQyzn4O8kdJmSOaD+L/sMEiwA==
X-Received: by 2002:a25:b986:0:b0:d13:5114:101d with SMTP id r6-20020a25b986000000b00d135114101dmr8009012ybg.56.1690834231156;
        Mon, 31 Jul 2023 13:10:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9-20020a255009000000b00d0dfab2e86csm2611754ybb.37.2023.07.31.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:10:30 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:10:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Xing Huang <xingkhuang@google.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2023
Message-ID: <ZMgVMYemepJCqXLs@nand.local>
References: <ZMATKIaU1A1D0wJg@nand.local>
 <ZMFfRiTSXcrkzdAJ@nand.local>
 <CAJoAoZkNRa+WREeXsr6fi-wxk_67mY+RL6WWsViwoPvyCbc5ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZkNRa+WREeXsr6fi-wxk_67mY+RL6WWsViwoPvyCbc5ZQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 10:56:35AM -0700, Emily Shaffer wrote:
> On Wed, Jul 26, 2023 at 11:00 AM Taylor Blau <me@ttaylorr.com> wrote:
> > >   http://bit.ly/git-contributors-summit-2023
>
> Since it's virtual this year, my team is considering hosting a "watch
> party" in Silicon Valley, to get at least a few folks to be able to
> meet face to face, even though we can't travel. Basically, we'd book a
> conference room at some Google office, invite local contributors to
> come along, and dial into the summit from that room - nothing fancy,
> no extra programming, maybe catering.

Sounds fun, thanks for organizing. I think my only request would be that
attendees sign up through the forms linked above, and that we limit
attendees to folks who meet the criteria (active Git contributor, or
planning on becoming one).

> Before we make any solid plans it would help to know how many people
> would be interested in such a thing. If you're already planning to
> attend the summit and would be interested in attending such a thing,
> could you direct-reply and let me know?

I wouldn't be able to make it, but I hope that others do.

Thanks,
Taylor
