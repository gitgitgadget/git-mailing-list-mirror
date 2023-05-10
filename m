Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D63C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjEJXmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjEJXmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:42:00 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6E10F4
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:41:59 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19619af9a02so2638016fac.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683762119; x=1686354119;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgfzpqiupGTwmDgifpzglBHPmW5T7+vweAnP7gc/P7c=;
        b=b6oOk7o5FL1h5sSYsE2fGEx1D5zlOSbsdsjLDudnGFLndJLnwpn+ljrMbITHTHfHLL
         6CcDz639zNJcsE6aIyHugKHYgBiqpUKHZ6wpDfSoajl8fJWXBzz2clDorfE26ov9MJG8
         N1TdM+s1eo6WwZxnlxjFTSF6ReqeAYYtjwIuMSj1LkikWgNNh/ia3CFuET3+MXgYcpnr
         yv3jBFl2K3zsuoejeEhEA0RJRW0PD5MZt1Ymq4cxgMgpJ7WPvKkb34gXwgfQF7RjswiO
         ZrVJDnLoJbiw3f2zYcOh5bT6V6uWC/Gt1PM14/NJl3t0FS94f+nhldgCVtuASubgmcF0
         3Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683762119; x=1686354119;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CgfzpqiupGTwmDgifpzglBHPmW5T7+vweAnP7gc/P7c=;
        b=Iw9SxA7z+i/MemU7+NjBYLzYsW/TebK6rT7tqnE7INPimipc8+JC+u7LGn1x5uHQuW
         Ffm0Zn4M+0NLRIZgLmdNwjrSEiLe4MUNEhfOvohdubFaSP6RVvevsV9I42L8VOjozaxk
         cw1ZttnxG5husSFkjcGaZ9s+JOE6gARjkmiDw4LTvcBajoyJClINS9faH/c25gP0TF0b
         D0KUJqM1U5OihHzGFmUf4S2Q1TJa9UdeQx8r3XHzbbWxxSmFBi6gVeWLuoUEv8ma0FSZ
         RD+7036AS20Rk2oEpMrvY00OtFVmuQ/kSeIjLo2ljIMTVoszvfOma6ZeGRAJLlvLmh7/
         QI/A==
X-Gm-Message-State: AC+VfDww4vrV3ErlVRCgZI54Xmy5n21vX/ak4DCNQHiJw/owf6eNprSX
        q6nCYksZ1xqV5nl5XUlnBUNinDBBZzQ=
X-Google-Smtp-Source: ACHHUZ7iNko9Mze7tBVTFuN8VHGuyqTyanJTi1eXue2Pvvj7i+mmD/SDpf9TsIX4AdCmzj9/T5RD1Q==
X-Received: by 2002:a05:6870:733:b0:18e:cf21:b570 with SMTP id ea51-20020a056870073300b0018ecf21b570mr6729251oab.5.1683762118908;
        Wed, 10 May 2023 16:41:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o5-20020a05687072c500b00183f77dcdadsm7514754oak.33.2023.05.10.16.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:41:58 -0700 (PDT)
Date:   Wed, 10 May 2023 17:41:57 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <645c2bc57fdd0_7c6152945e@chronos.notmuch>
In-Reply-To: <645c25dcb590b_7b63e294ea@chronos.notmuch>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
 <6459c31038e81_7c68294ee@chronos.notmuch>
 <xmqqjzxgzua0.fsf@gitster.g>
 <645c25dcb590b_7b63e294ea@chronos.notmuch>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Junio C Hamano wrote:

> > And it led to unproductive and irritating waste of time number of times, and
> > eventually you were asked to leave the development community for at least a
> > few times.
> 
> That is blatantly false. As a member of Git's Project Leadership Committee, you
> should know precisely how many times the committee has excercised this power,
> and it hasn't been "a few times", it has been one time.

And for the record: that one time I was asked by the committee to not interact
with certain members of the community for a few months.

The amount of times I was asked to "leave the development community" is *zero*.

-- 
Felipe Contreras
