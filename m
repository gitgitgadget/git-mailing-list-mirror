Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CFD1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfDWCpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:45:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36296 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfDWCpV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:45:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id b1so6705907wru.3
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=IlRhaFXjDZJu5Rf9ynvwsPdkyrorNk5rqKjsvX/XXBs=;
        b=dAnx/JXqEkqQrLH9v+wPfI36JaE02trRJN2nIDOwnUk09qgbsshjhin7bzXFA4IyHC
         lXHwQMU78KKARZhOPmfXTRXloWSFDIf3lpttPKkLPlmkmcAXSkmNB+Dk0bf+xELqAdF+
         daZHTA+IEvyNLgQCcQSLRtHpgURzYAwjFjGQ1dNxCgvIxu8apL4A722Zghkpc5bFOFyj
         MqobuG73VbID749//yEWK4HYcq1dm3mmEqRuTLFclLy7oqU9Y6tGFT6/WGrqBf7wSXWj
         geRzTpk4CttmJfrzZ4A9ULOUJz11Tijr2YgLVfNNfhWZAC21LKj4DASk3hzshruO5J4u
         90Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=IlRhaFXjDZJu5Rf9ynvwsPdkyrorNk5rqKjsvX/XXBs=;
        b=Pde2RqSTVYG/3D4PcahTXspLnvvEAUa4SrtE9fseB+zo4zdcXpSwMgbGGayM8/gdhG
         if5GjtrEr7xrSRnQ3cdRz83apGiz7x5ZQfUBvA/x6GmQb2qi+lQ8v9vaPq/wKkIZSaik
         9UYUktopasp+DINiIiXnHTOk+ME74kS7FE+mLjc4RkQB7DgydaGSD7bV4mjRVBKZfqgd
         uh6RFq/q54oQ744jMiX2iRvUbFrAHgun23yxs2P8BC93vF12l/CuwrH1E5bmHkcu978f
         MywVpZL/kDZcFaKBPOFPxssYoq9QQq9AyeoYNCBDLbXC/DAURZOAJQLwf6Xws38RyTz2
         MFqA==
X-Gm-Message-State: APjAAAVpZ0hPLqzaoD2JOd+DDitiZO1mNY+kLyqn9y6Iy7Rord870Nr0
        i44qD1/GkBDu1h+o3MvIgoaH5CPJ2T4=
X-Google-Smtp-Source: APXvYqyLf/b9De1tavG/QBhtxjb7gqArMj54Cwx1Tue7T7+YY1eisf1+0L364TpolQe0QZO++kExCA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr1330497wrw.68.1555987519008;
        Mon, 22 Apr 2019 19:45:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n6sm18059244wmn.48.2019.04.22.19.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 19:45:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: do people find t5504.8 flaky?
Date:   Tue, 23 Apr 2019 11:45:17 +0900
Message-ID: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been seeing occasional failures of t5504-fetch-receive-strict
test on the cc/replace-graft-peel-tags topic, but it seems that the
fork point of that topic from the mainline already fails the same
step #8, only less frequently.

The push is rejected as expected, but the remote side that receives
the "push" fails and the local side does not leave an expected
output we expect when the test fails.

