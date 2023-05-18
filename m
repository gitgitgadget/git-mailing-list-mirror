Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B2C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 01:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjERBGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERBGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 21:06:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71D198A
        for <git@vger.kernel.org>; Wed, 17 May 2023 18:06:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae52ce3250so13020925ad.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684372010; x=1686964010;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H0tdLb9XA64PAe067B3MlIqlmB61KvX/3fnzbkYgSI=;
        b=fU3nSARj3s+0hAGS+EQuaf6ssWg5hRbt+rix+bf+iqLosrIYTNLJJRSHBFTXBy0q3F
         wi8zrhCV1uQ9lO0DeVcWgiO6645GeCeelbEJi+ZZP8tQdj+IpoVXh3WuiyO4gBEtqkXX
         jALGrSpxXByG4OG+cLbiN2DLINLoOcbl74/8vsRQd2KlsvzvvZlodOBArivcTjui0qwp
         d+lTnvt3/AMnC3rNrBXJ8k46L9dDW30QS4fecCOEPqVfSOfGTzOErdPwk3w+nH3pW/xl
         0EvOXfK1DVWtUYpbjAcwCVyRltqI/F1ZZ2NYXu+Ox8TfiH5OijEztfk5alq7gkPJrFNC
         roiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684372010; x=1686964010;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H0tdLb9XA64PAe067B3MlIqlmB61KvX/3fnzbkYgSI=;
        b=fVOhqWlCsLZbsJp8k2/JpyEUQ6eBjXC1YqO/5DCbKQxfEhUpmIfhAZ305WY2l7AJgy
         33UXT8uRLWURj+Q7CLyeC2QfRW9RCBm87F70MY31aePKUm00t37pQ65UyaO74DETG9YT
         xuN4B+j8Rp/bhlC0rMtDPA3Zz1t9blsDS4wAxnJXEbHVLMP4K6c8c4DWzMVjznm9ScEs
         yA2nbvMwxbhnjlkybfcb5yRzPqz0LrhUkPbSjFO/9TUvF0tUONIoUw3b0J3dBGhnoLce
         qWfi6Udp1MVygQwV4grcqYfGi3dcpTFlwHg6ftkziJDxA3omPyBtLV76hygRnaAKWgPa
         nRSA==
X-Gm-Message-State: AC+VfDx/GU0KMujRjhpV4QL+fQzVeneOom2g08LmdKP+mFYcM4UN3nh+
        d91fyq1Ab29ITzrGoatugek=
X-Google-Smtp-Source: ACHHUZ6U0cV1MFUIBsGfKAEGocUcRxHvdStfOJtG8xNcoqVVgMjMDIj3Pm/ftDj28KE5RwyWqKDUug==
X-Received: by 2002:a17:903:1c5:b0:1ae:5fe0:ddf3 with SMTP id e5-20020a17090301c500b001ae5fe0ddf3mr879085plh.22.1684372009655;
        Wed, 17 May 2023 18:06:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902b21000b001aaf2172418sm22839plr.95.2023.05.17.18.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 18:06:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, dianders@chromium.org
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
        <xmqqo7mipyt0.fsf@gitster.g> <xmqqjzx6pxuu.fsf@gitster.g>
        <05888c33-612e-3c93-55da-53b9f35cfc2a@amd.com>
Date:   Wed, 17 May 2023 18:06:48 -0700
In-Reply-To: <05888c33-612e-3c93-55da-53b9f35cfc2a@amd.com> (Michael
        Strawbridge's message of "Wed, 17 May 2023 20:51:06 -0400")
Message-ID: <xmqqjzx6v45z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> Sorry I missed clearing $message_id in my initial patch.  After going
> through the variables again I believe it is the only one that is not
> reset properly.

Excellent.  Thank you very much for quickly checking.
