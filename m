Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F2C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC4F2073C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hKZkAWsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBMOpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:45:19 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39839 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgBMOpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 09:45:19 -0500
Received: by mail-lj1-f174.google.com with SMTP id o15so6891372ljg.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Qxkf61rhTCqD5hSSEtMitQhOoSldfUqOna6CdDWmbt8=;
        b=hKZkAWsKjXx50TK7MLk5oq8luTA3awU7K5vr0TppVOI1CIRI/lkWi353P4u0V1mqdh
         cys78zgWvSHOS2GyjfIRG5jIzc2py1+kTnBE+mUxLGBDx8j6n4OWPO0VSxDLGZ9n21E6
         9v+mX1NCoj1nhV2YumlTeoVHWEIjccNjJrOec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Qxkf61rhTCqD5hSSEtMitQhOoSldfUqOna6CdDWmbt8=;
        b=NLXuIntKbhTLL5rImUOm9JlvLfy3wb4ccL8cyDHkLdAZ+nPZlFh8iW+wgPe/NWvHYo
         Mpt11B3ia7q3QRdvwGc67s58JBAFncYbvHaWXaSDfKFNfgyk+n6Mwk82uXB0bhz2ccNJ
         6K+fUUwjO1kwaUT2/VYzorzkD+4KJ2cRD1hHtffb8xbVm2abcqQwGXsNXt6dc8Qq/ATt
         vzkHs5ioqzYqrlTzhIEwjINiWqna7Ut/OxiuYZolaq+BJHmQ6BfZIPXs+BoLf0iO2HjG
         F1mXZ9pSAPYZxauEST0vlYV3xusFC1ETERMgEqlCAx3GTM+yGt9ZxORpoytvKxv4zQMW
         LI2A==
X-Gm-Message-State: APjAAAUrbr2RNqb5gCzf0qPrEHvx3BGPJ5M1PAPUs9FMsiNcZ64IpOiA
        2tMGp3k/8b97bLtUWYfDfN6Tkz/aNDkwAQX8
X-Google-Smtp-Source: APXvYqyy4JjlMHrb+pWzpsEF7NRVWut/NawS65Qny9vsH1E7GFtnUeb1LTnJAaEr45MvrIOYV6zPXw==
X-Received: by 2002:a2e:9748:: with SMTP id f8mr11852513ljj.178.1581605116264;
        Thu, 13 Feb 2020 06:45:16 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e12sm1382419lfc.70.2020.02.13.06.45.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 06:45:15 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: recursive cloning with --reference-if-able + --dissociate
To:     Git Mailing List <git@vger.kernel.org>
Message-ID: <83602548-c0a6-db37-ccdf-5c0f4b233b2e@rasmusvillemoes.dk>
Date:   Thu, 13 Feb 2020 15:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $dayjob, most of our projects are organized as a rather small
superproject, with a number of git submodules. Usually, one of those
submodules is a linux kernel git tree.

For CI testing, we create a fresh docker container which starts by doing
a "git clone --recursive $superproject", which takes quite a while due
to the linux repo. So we'd like to speed that up by having a reasonable
up-to-date linux repo on each build slave, mapping that into the docker
container, and then telling git "when you get to cloning the src/linux
submodule, look over here for objects", i.e. having some way to have
--reference-if-able and --disassociate in effect for submodules.

If this is already possible, I can't find it in the documentation. And
if it doesn't exist, I can't really think of a good way to define the UI
for giving those options (other than, perhaps, having a top-level
--reference-if-able pass down to the submodules with the meaning 'when
initializing the submodule at some/path, try to use the submodule, if
any, at some/path in the referenced top-level repo'".

Rasmus
