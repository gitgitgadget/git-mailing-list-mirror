Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2D41F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeJOKWb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:22:31 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37538 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOKWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 06:22:31 -0400
Received: by mail-wm1-f54.google.com with SMTP id 185-v6so18038229wmt.2
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 19:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YelDbU9CNIzu1+LLvKKxnpDVcBiVIJpc32kYs7ihb7M=;
        b=ZLjq2q6Rz28xiUxLuGeQ74nwHt254PcqjyD3xlR7acfEp500BEIoaKh1RMgBXcqvnW
         +GGO75ij6L9NH4K+9tArfsmCYGHpd4hrb+uT9z6qILKCu8lqVW6oHnOnt0jpLAbKp+PG
         qkgPDHn3hGKr+3ts2DP3Th6venCSJZTW9TWPcjq+fbfVcSZam5ExLFBsPGZAYgI7kaTA
         hGv5XAmg1l5xq9YPPwHNzttFp3aP6H2Ve+1vKZR7TAgqNc6/wEXKhLElVujKrFn/Fv2o
         PO1RNfFIkj4+Box02/ITyBBXAwfWN8kcEX9YMgTRv6VsnLMk01l8LTLAicFm9PV0Qe4d
         ROoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YelDbU9CNIzu1+LLvKKxnpDVcBiVIJpc32kYs7ihb7M=;
        b=pLfWGtyVrz3bJsxVAlZxDn0XToEM6i094MLAw3+0oOn9eOatb72yR+AyvLakqh4qF0
         +4Iw3IKAIMv56hKglCopiiZqJjK8s1MxZnuHOSjf5ToeRGMbPz9XACeEsSx0hg73j7vm
         ZtqAYx68gfOHM7V5qnqjWxS+LkosLO4UjLcqD/IBg2R0bSBMJYoaJLvnhTcHwpVOJr4R
         WpWwZ3PI54lR0eS83jbh0VWPHUbEF1L8F7lgnk2To+rsuvvfKmxiibAX7NstL8RI4mqW
         7D4Rtmxvvx/UNS6NSNEc2w1CxUWfiecWA5g9y7INSUuDm7DKSl/bR7wqh5V2x6Yd8sLz
         Wg2g==
X-Gm-Message-State: ABuFfoinfV36GOBkAxwT+Kvo8WTCbVdLrdLPK5pqs8W9J5dTi3W9MllP
        gDfDRGvHM8Zc9uWzv4Sf9gk=
X-Google-Smtp-Source: ACcGV61FvITjo78QzReyT+BVWtpOPXiyJO42O6/hZoz7RDINl+Kb0IlBzkTJ1NqrcvS0NZMzmXvGQA==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15-v6mr11791648wmb.1.1539571158896;
        Sun, 14 Oct 2018 19:39:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12783936wrp.3.2018.10.14.19.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 19:39:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gpg-interface.c: detect and reject multiple signatures on commits
References: <20181012210928.18033-1-mgorny@gentoo.org>
Date:   Mon, 15 Oct 2018 11:39:17 +0900
In-Reply-To: <20181012210928.18033-1-mgorny@gentoo.org> (=?utf-8?Q?=22Mich?=
 =?utf-8?Q?a=C5=82_G=C3=B3rny=22's?=
        message of "Fri, 12 Oct 2018 23:09:28 +0200")
Message-ID: <xmqq8t306ii2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will take a look.
