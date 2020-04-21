Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1BEC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C7206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew+LTKQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUUFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUUFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:05:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D4C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:05:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d184so2717513pfd.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K9OGT0N4+RaSncDJOtPo72qbFtxAAXoYb9oENRgw0U4=;
        b=Ew+LTKQ6EH72Cio9brj/5G9cXaWIMx7pY3LBsjD9kDztEf+tMzFsR7oiYkdmcHu7y3
         1GLlPEF8H6ZGgHuewK+bVADeLl3zb2Rofn5fYW/oDjVgZ+ZPHmXbtXIHGezYwdPk+JUq
         UROurF/QoK25QE8B6P4vWg3ZzVT5fdv6XdNNQbk7e4Bn8DdGSz/GOmcAmFGukzn0dJlQ
         PAsOLFRNu4sLgzrnOGZ15nNA1tgVPa33QlAZtwOwOumrmF++0VIsOBLFEvDmw9Vua9Gh
         5001jJDe/IG0fDciU+6Han0wp3yLG9rjpeQbK7UYCAAIXGC7KPsVe5um8isOlP3bQzkz
         Ldfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K9OGT0N4+RaSncDJOtPo72qbFtxAAXoYb9oENRgw0U4=;
        b=njfk7Hs3Rf6AtbjZXLalx5U2ZLpFZauESIQpfKEbHhd2g63Xa3IR8NNPqN90/AFXeJ
         YK2jQuo7eM84LP/3mYmIBUXXJ6rVGZ3op+ZCTPnkEF4eIcaH3ocb2gBQX47oHFxyTDMM
         rss9zaLhp+Xs91WruhQ+s3HLTh5cFaPh41/Quuxfi0wkk3ijLvHNkgTk2DGllp/LMzmN
         SMTI6JlyPuFYArcjEiCeNE+ovx9mscxo0bd88mnt0qCwQus1xJDJ6Rfj69vwWfOmbdM/
         JmwvmCclRiVaGKSjnrCQE5AN19bGhxQUvunCPJpHpa/P3gCIGs9djaR2Xc7WO4EYvUUm
         kueg==
X-Gm-Message-State: AGi0PuZ4wP90OXXnQVWZ+S4WwPLKHMJ4QBdPq+tLX9tfpw3v9I7ZYMLp
        O5IFzUxQ6HT9XDs9CY7LkxZwYBnx1MRD1fZ0MfwJSQ==
X-Google-Smtp-Source: APiQypLRof+RUHADT/SwzACkRdX/F+6k0FVlZ0TTWHhncN8hgeuvqzDE6YXSwOhyfGIGhIby7z89MkDWeTXecqtyIPA=
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr23283406pgk.310.1587499523229;
 Tue, 21 Apr 2020 13:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de10:0:0:0:0 with HTTP; Tue, 21 Apr 2020 13:05:22
 -0700 (PDT)
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Tue, 21 Apr 2020 13:05:22 -0700
Message-ID: <CA+jjjYTJdAVMXjGWKFuigviePfdP1bLLmme_NMTuK9ZEi1HP-g@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've been getting really annoying merge conflicts that aren't
logically merge conflicts but git can't resolve them of itself.

$ git merge origin/master
merge conflicts
src/data/record.type2.dat
src/data/record.type3.dat
src/data/localization.strings.dat
$

where it would be quite reasonable to make a merge tool that merged
localization.strings.dat only if it could also edit record.*.dat as
well.
However, if it picked up the result of an automatic merge of
record.*.dat it just won't work as it no longer has enough information
to do the merge.

The approach is specific to the structure of these dat files, and
would not be generally applicable.
