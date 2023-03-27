Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39CC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjC0QnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjC0Qmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:42:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC61272A
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:42:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so12370031pjt.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679935357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p79ZCUrhEN9om2ZS61+PgrWCH64RSzH2wSHgj3Kx818=;
        b=PTN+RpZ2OUrHNqloZeuDQXDbtP37YM2Hf9ok8U2vLPK7R6QMCy5xqM3gcbhVz3hFk+
         ZeIAWlYmtdKhMgFsOXHhyfWzei1rVU15XMwQkO8L9GFJtQsXwOEBPoF+utO53BHBmpSA
         vZT2FFpTVckyudX/J3j7ywDVqTi7HITuystpx++sSEApjomwuuXgIEAPjPFNe3m7ZUzi
         E2D8AWBJT2qzuTuSPiM0FpcR+fGp/gGlpX/ShHS5ZmQUHGi8Ptse9qlPZhkePLLo5J/W
         FCGg7HSbGNWQO5BWQcpIxVDEN9YKP0qZM/HtTO+s755srFWG28OiUG9/Omx1+fhOnCIh
         klhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935357;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p79ZCUrhEN9om2ZS61+PgrWCH64RSzH2wSHgj3Kx818=;
        b=niQuuqqVg1zzqWgabmZgaphXQeuJWueuGsDqsMKIp3rPsx1W+VHAEl98jEzkdGbdFV
         AXfK5WQtKgX+l1LElV7T4K6zNc5eVQBdzS4GvkgZiyDd+lKVcGtxpsbpaPMSYHY/jdrs
         QqRy2mvSYLyof4Noax+xJJ+Fwrv2LvihCRslCx4lVyd5q6J2n4fvgEwAb/ZhZ3yAx+nB
         +0mU25qm6UEhPNrQ/sy6WeW3jUFVWxlF0f2s0UGkGtfm2FsdmDQneirlGiAVneoRH1qY
         t9uTUy7CKme/HIND/lO9V0860LHEuXBlqYKAFeFRJ6e5C16mbVgHOlwufs/RTrBTLmNk
         3hTQ==
X-Gm-Message-State: AO0yUKVSUwXVGvo3Qmwln76Kpw1jvGrFm3VhsTfugS+ccfdL0c13DBw5
        1FQKBQ6hPPrXlGMKfcZbUvNKWwxGyGQ=
X-Google-Smtp-Source: AK7set+vypOZPd90my6MMvz58uvX836elhCEcodTg3yxcvTiQrilz1dM2+bN0frFW/+shTHeHjDzRg==
X-Received: by 2002:a17:90a:9485:b0:23c:feb9:2cea with SMTP id s5-20020a17090a948500b0023cfeb92ceamr13573981pjo.42.1679935357274;
        Mon, 27 Mar 2023 09:42:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b0019c8ef78d52sm19310644pld.21.2023.03.27.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:42:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] Fix a few split-index bugs
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
        <42b9b692-88a2-5ff7-e857-20bd1f9bb0f2@jeffhostetler.com>
Date:   Mon, 27 Mar 2023 09:42:36 -0700
In-Reply-To: <42b9b692-88a2-5ff7-e857-20bd1f9bb0f2@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 27 Mar 2023 10:48:32 -0400")
Message-ID: <xmqq4jq6cfib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/26/23 6:45 PM, Johannes Schindelin via GitGitGadget wrote:
>> I received an internal bug report that after upgrading from v2.39.2 to
>> v2.40.0, some users ran into the following error message:
>> 
> ...
>
> Very nice. I like the new bit mask and getting rid of the double
> negative strip/write logic.

Yup, it indeed made the logic easier to see to split them into
individual bits per extensions even though an initial "gut" reaction
may have been "you ain't gonna need such a flexibility" ;-).

Thanks, both.  Will replace.
