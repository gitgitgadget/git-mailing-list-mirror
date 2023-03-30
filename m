Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA6C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjC3RVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjC3RVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 13:21:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C1E19B
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:21:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c4so1882219pjs.4
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196880;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDaA9nvREksxQQIkto8+UBInY0+381IXdwckuyXy5mc=;
        b=kyd4+rjmhxCst9arK8ZHlp4pVW1/J6MRaMzuzopEoy8pOjyKBPey4P4f9C1KdPci7B
         ngnP9ipTmrp/rPlSkmLlLcqsCHNvjk6+cn8BR2zO9UIe4kGEoS6MfDg/qnPMEM8nxWFp
         gFgw+u4snsQ1Vb/tvc0oy0873qsdt0ZJBzkZBdFfbhAiGs7zaZwgUadZjHtzhj+SpjR3
         kyTdMFSe9JlxYpS7I6mNvEwSbkaWMFzi6JL8T8l44UzJjZPCAYYJfA2vFHxExqdVHZ+I
         uppbOrqGQL4pZKurvKLQpd04hQyIlbOTLr0uRghwvhuCHzpnn+OMwoVuYIupl8NcbQdf
         MJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196880;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDaA9nvREksxQQIkto8+UBInY0+381IXdwckuyXy5mc=;
        b=0vkjbwpR+g8pWdApyZ9pC7Tyo6gKsq9qF4Duc6643r/uotSblfPBblfuM73m9QZCFB
         PirF/MQzbRLgnjLB+zAUv/+BhUl/RB/UHpTNYkuwgdsdUgJ5HEThGzYXSkHvfglgY9fE
         DKuVOC6ZvtWia7KEnlPdK+oBceaZGWx403Fapufk5B0XeEYaz6RUlaeUFbWkCiPLogcV
         qtkzLaaJ7lI+HVy3I5F32wFSKlqgHbWPG7VNQnrs3/Dnco3li/ueYPydrHUqExzTXZ9J
         me/pai4cyjajiNDXgOZeQUWyzg9Ul4EHL9gtyqYwVXjwugw2CccpzJ5wbsbUNyNb3ktr
         maVA==
X-Gm-Message-State: AAQBX9d7shESInGs09Ch3kVEmOgc/HkIwFBLvaTAhvCPG26Q09FW5oEv
        b33IH8uSCZNxQ6IYOngZ0XSvAVDDP7Q=
X-Google-Smtp-Source: AKy350Z9L8B2u0rkpea/BfpsAyrvkZjR5LZmAHyQTvamJXRhTsdOfEQpuxy+qMY4mVTp/ZQsFy7HPQ==
X-Received: by 2002:a17:903:120b:b0:1a0:42d4:e38a with SMTP id l11-20020a170903120b00b001a042d4e38amr30700866plh.11.1680196880265;
        Thu, 30 Mar 2023 10:21:20 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b001a221d1417csm11366953plq.298.2023.03.30.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:21:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com>
Date:   Thu, 30 Mar 2023 10:21:19 -0700
Message-ID: <xmqq355m17g0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> The logic is more or less duplicated in branch.c and for-each-ref.c
> which I don't like. However I couldn't really find a "central" place to
> put it. Imo. it's definitely not a property of the format or the filter,
> so struct ref_format and struct ref_filter are no good.

I think the division of labor is very much in line with how the
ref-filter API is currently laid out.  Enumerating is done calling
filter_refs(), and result is returned in an array, which the caller
adds whatever frills around its elements to show them in the output.
The "adding frills" is aided by calling format_ref_array_item(), but
the API does not care how the formatting result is used.

