Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A9C2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59AF20797
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnvoOU73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59AF20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgKPRNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKPRNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 12:13:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4983C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 09:13:48 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id i12so13412581qtj.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=rhf8KftDyq8SGVlPKfqpdWMesKjwDq6bMvesrlMz5Io=;
        b=WnvoOU73FVupxCE/AeXXJqwx1FzOPVzb29WBaSj6/9x85VD2/dpZ9fwsCGz+5G+ksF
         /dO8qZ6aemZmQP2g1r22OrWYjPLECEZYdAz08Agd8ByCNvuGIAPHb6uJ/tH6HRvefYit
         gPrrt52fvbgwQXuwk9Rdiwcs+D91L+eKFQZaAbILQoUCItChoh8PMhx62gVlwY+45Z/q
         uKvXZwOipEJ5EnUZU0fcLsF7CoA+KukPKF5tqrVZqCHvrNJPhI6nWLItPeLoA4Tgw34E
         XccysU5u1OqCFJYMkYgt3lsimsu5okuSBLtLcDj2rXmLds4wHtEamBb21x06pwtYZT1l
         l8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=rhf8KftDyq8SGVlPKfqpdWMesKjwDq6bMvesrlMz5Io=;
        b=I3LeuJp9svM5GsIkhO3iJbfu3XCgu72BN70JBCK7IfGJ1ZhGQ6QQaF4jBR6VTToZg3
         FSINk0tWP/XsQBxAz8bBhu5GUvWcigMYCNwoYmKBrIenJKHMr0fFS6NVdGR4NIjKqByO
         L9JF7I0ibxQLDa1prcnmpw2mijo7h8L/2cE9ElQftNsUt94IlD1nqxfwvZCgdykZLj2i
         5I4Be1xQyt9WI19RMS6KI6JaU6vN6jNhatzyDe9H2k+jaPgD4dSjLcbAjFO1hYxPk6po
         5/dOcUyFXMQaRq6i20MYWcWm6Jlau4ByBDioqJbkkSmJ7bNFTKR2CK+D7CWrtDZBbzf0
         /3mg==
X-Gm-Message-State: AOAM531B3J8SYieq1e69dE+XkCuCuRznDvgEutcwRK/JBCpv1HgC4sIg
        k/AMdOAApMfCfp/30Cq6btKSiO5+EEQ=
X-Google-Smtp-Source: ABdhPJyrrZhheij3hSdqiU4L4g2EGH+NvcgLguQYZ0oTQbMBbVtZVVJk7zxZB1EhKMZlki1bYfMfNA==
X-Received: by 2002:ac8:580c:: with SMTP id g12mr15636208qtg.340.1605546827936;
        Mon, 16 Nov 2020 09:13:47 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i52sm13241489qtc.3.2020.11.16.09.13.46
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2020 09:13:47 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: FETCH_HEAD format is undocumented
Message-Id: <218FCFFA-1F4F-42DE-B32D-D7C731813206@gmail.com>
Date:   Mon, 16 Nov 2020 12:13:42 -0500
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While trying to use `git fmt-merge-msg`, I figured it only accepts
inputs in the format used in the 'FETCH_HEAD' file.

I then tried to find a description of the format of this file in the =
documentation,=20
but could not find any. For example, 'git grep not-for-merge' in =
/Documentation
returns a single hit, in the release notes for Git 2.5.0.

I think it could be good if we documented the FETCH_HEAD format.

Cheers,

Philippe.=
