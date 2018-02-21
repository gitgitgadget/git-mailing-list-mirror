Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEFC1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBUX2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:28:40 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:41995 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBUX2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:28:39 -0500
Received: by mail-ot0-f172.google.com with SMTP id a7so3021875otk.9
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarifai.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=IOl6/R55JQ32JM9V5En/iwCxkp973Od9sB77KhDqkY4=;
        b=lMYSFhOkLDGeOJusBebI+Svw0RZ17Dn8CG0bViamMljd/g1h+TvAVl3595QKY+8jVK
         mzfSOkQEq0KQMCDkblsXLp3rp7LwLfKBRFuUNnQe6pfYkEP+UAJBqBpCNTBDdn2AxVXc
         ztu6uwcsy9Ck+JXFAJY6caBXR35mrWesPaKT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IOl6/R55JQ32JM9V5En/iwCxkp973Od9sB77KhDqkY4=;
        b=DewaEY1xEahhkG+6mKI3UmpU1uRKXt6BhgwVwku5uG9jnTe4OTULpGDZkal1EfvJx2
         +B7xasxgEUHC08f0QEfMMSepalb5ANqR5RG8Z5sTyHhDurU68S6j8LRAMyLT1DIP+QYh
         lCL250UgRYVFIgVjjxGiksFNLCPSUe8lU1SQ6qnyn+vag0m0kq0sx3HEUU6DdTmxKBG0
         Bu/1qWNyu+NWqIgI+s9QBtBg1gIJ74eJYiIpJR3Fr6gJtyxhESUX/Em0PtWzSP/NvXa1
         wpnDhaqC03ARsnr8xrNIVuscht8rHducHq+qfOs42F6rKKXohMwF/BJbc/xPQFaZCVIA
         GElA==
X-Gm-Message-State: APf1xPBoYOkeECRPYoxpfDqyku1ImOWr+8aurASm3B9yr2v+Nvxc25w8
        xFOTEcdrU/UVxZ5w+PK44EtPUAPnx+c+/3PB1FzPIPoGA5k=
X-Google-Smtp-Source: AG47ELuMeVdsAp0YbLVNsIfhoj913vYVz64ynKb6VYQmV/bsa3Aj2HT5S7C1yY40648Umg9K6vWpQZupB+BGCF4UuKo=
X-Received: by 10.157.24.48 with SMTP id b45mr3074427ote.195.1519255718603;
 Wed, 21 Feb 2018 15:28:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.138.221 with HTTP; Wed, 21 Feb 2018 15:28:18 -0800 (PST)
From:   Josh Tepper <josh@clarifai.com>
Date:   Wed, 21 Feb 2018 18:28:18 -0500
Message-ID: <CAPFeJUA=7NyZZxkjpYjoRiXTb1WA1cQ-dYsn_XykMYt=iWGKOA@mail.gmail.com>
Subject: Bug: git log: boundary commits do not respect order (e.g. date-order, topo-order)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git log, boundary commits (ie, those commits added by
specifying --boundary) do not respect the order (e.g., --date-order,
--topo-order).  Consider the following commit history, where number
indicates the order of the commit timestamps:

<view with a fixed with font! 3's ancestor is 1, 6's ancestors are 4,5>
0----1----2----5  <--A
       \         \
         3----4----6  <--B


Executing the following command:

$ git log --boundary --date-order ^A B

Should produce the following order (boundary commits shown with dashes):
6 -5 4 3 -1

However, it in fact produces:
6 4 3 -7 -1

Please advise.

Best,
~Josh
