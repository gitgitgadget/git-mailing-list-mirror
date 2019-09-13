Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409201F464
	for <e@80x24.org>; Fri, 13 Sep 2019 20:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbfIMUHk (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:07:40 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21567 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfIMUHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568405251; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=hy0KZXobuK95yH0Ogy4J+i8YsBWQ1qEaDWuG3r1qlFwqk3OHx7cmRRv3HIimoulEoRg48USHIr2D/4yZbJcW3mBMyoFbB2ICogffzi61V1aZMphe3Y0XLbYuYV7B3fLigNLvm5cwwk7vnhzHcfOpQwFJ7DshsW57ekZO6G/4Ng0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1568405251; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=H2p/aS2aVQeQuGmb5bmeObOZNHo4LIg81uKtNiT6770=; 
        b=PlI3tEEmmbbX3M9poCWmGKb5257Es1i9QWyZQLGRVZlhFKD6pdFFyplFqDZIi7zn9z7oR45ZjoQ9FCl+TcTKfcNpWc/gaHSMZT/dhfJJL0w89wN09gcLjdFRwwitKoAgINk1/FzoE4nYs+35M5mBJ37p6LeTtYtBfIEUs4gvfnI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=embedjournal.com;
        spf=pass  smtp.mailfrom=siddharth@embedjournal.com;
        dmarc=pass header.from=<siddharth@embedjournal.com> header.from=<siddharth@embedjournal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1568405251;
        s=zoho; d=embedjournal.com; i=siddharth@embedjournal.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=884; bh=H2p/aS2aVQeQuGmb5bmeObOZNHo4LIg81uKtNiT6770=;
        b=TlRWX+nOXm+X8eP0CGKpo3sQn7ZlaNDL6I35UlA9SHQCJGUTb9lwwlFhbBfBLQof
        Sl+PKApguGMx28v5cf8FMtho0ROITrxL2Gw0QfmaYMmAg9iQjWPbi7xVBo4eSF3JWxt
        YB7Lmet7TIRXleQ5bkkqWQni0bUFZJw7yIeK2cPk=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1568405244994854.8727355198589; Fri, 13 Sep 2019 13:07:24 -0700 (PDT)
Date:   Sat, 14 Sep 2019 01:37:24 +0530
From:   Siddharth Chandrasekaran <siddharth@embedjournal.com>
To:     "gitster" <gitster@pobox.com>
Cc:     "git" <git@vger.kernel.org>
Message-ID: <16d2c3ccc40.b3c71baf1200589.723645117669598677@embedjournal.com>
In-Reply-To: 
Subject: git-am fails for emails with UTF8 characters in email header
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

My email server (zoho) puts leading UTF-8 non-breaking spaces ("\xC2\xA0")
when folding long mail headers. Due to this, git-am is failing as it expects
only '\t' or ' ' characters.

RFC2822 [1] on page 7 states:

> The general rule is that wherever this standard allows for folding white
> space (not simply WSP characters), a CRLF may be inserted before any WSP.

It appears the RFC isn't too strict about ASCII only headers (correct me if I'm
wrong here); ergo, if the mail file is in UTF-8, isn't logical to expect UTF-8
whitespace characters also to be allowed in the fold/unfold of headers?

I was able to get git-am to work with modifications to read_one_header_line()
in mailinfo.c need your view on whether a patch is necessary for this. If so, I can
send a patch for this.

Thanks
Sid.

Footnotes:
[1]: https://www.ietf.org/rfc/rfc2822.txt





