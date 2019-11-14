Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44231F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 04:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNEgA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 23:36:00 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:38502 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfKNEgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 23:36:00 -0500
Received: by mail-il1-f169.google.com with SMTP id u17so4089948ilq.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=hcpqvzRaXpGBA6Ews89mKf4k4AsLjwHUjv0zNUfa0u8=;
        b=tI9s+EiL+50AJpqrEir0WEHJHxQJ25pIIM5ir5mDTEEPo13uCUjNxGSKVl+Cbyrs0p
         +NpF07BkI4jLnKYT/Nkzd9H87vBkclijdweX8X9ukmMalG1XZe5MfCLYL9aTrfM9YOvs
         RoessDtNa632IZHmfidmmXZoThUgLpgtAZF2QBKGn6vMJJ64HfhbegtS/4NkXDdvHbx3
         3IwlsMNXdIGw26PrHttIloKCW7T/nl3H6b89mDtNkuIlPmMY2KxT1qvZ5Ex4GWY3hrDE
         LSrXRtu/Lrn5w99ac35+hJajbULqhxm/kEVkHMRnLfgTjWu9FIRE9xN/TXm+FT7l5GYe
         /3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hcpqvzRaXpGBA6Ews89mKf4k4AsLjwHUjv0zNUfa0u8=;
        b=l5sO2QhvRuvDz1iG7DsSvCjGuJIf21H5LS5WLUCQHCmUIiIEQvWKTmB+0PxmZKTUdu
         SsDdp7HCN68h5y5leUKjRkTIjB4pj2uArmj79vshirQN9u4TSftZQmVrBzWaMfgNs0Gj
         GNRO3YsphmwH4Olt/dNeAl8DF+AxS5bckfQP/ZTduQQ7c+zGKxxt0GA4FPkHHZs8pMtl
         XBUNRJ1HPhsFKKu1y4j+pRI9Xu1kRwy6xL3F0Qpu3AFXY8XeuF3lxQJTOzDSCP44VCG4
         ifS8gmplZQP9lcxPF6bObzE83XWlFtRKJ9UipnPugbMr5rXiZNIHVkdjBLjEVQZTiBmg
         IhoA==
X-Gm-Message-State: APjAAAXtmw+jbTGSSNtSYvhDCrlYvY6b+NGhCHZYnCdmtmjonnrmq310
        9rdbCoPFfCDlDoRULve0VxgJ2O7TTXzyMHa+v7enO45Agj0=
X-Google-Smtp-Source: APXvYqx8/XAeKchrMwm+N52RVsXZiaSYLvd9YVbWLilIbMEM8+2XZiHtZuu3JBaI5v06F/B7f0l1BPXxqEh7wQewRzs=
X-Received: by 2002:a92:1d52:: with SMTP id d79mr7703128ild.185.1573706158913;
 Wed, 13 Nov 2019 20:35:58 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 13 Nov 2019 20:35:47 -0800
Message-ID: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
Subject: rev-list and "ambiguous" IDs
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using a command like `git rev-list dc41e --`, it's possible to
get output like this: (from newer Git versions)
error: short SHA1 dc41e is ambiguous
hint: The candidates are:
hint:   dc41eeb01ba commit 2012-11-23 - Stuff from the commit message
hint:   dc41e0d508b tree
hint:   dc41e5bef41 tree
hint:   dc41e11ee18 blob
fatal: bad revision 'dc41e'

Is there any way to ask rev-list to be a little...pickier about what
it considers a candidate? Almost without question the two trees and
the blob aren't what I'm asking for, which means there's actually only
one real candidate.

Also, while considering this, I noticed that `git rev-list
dc41e11ee18` (the blob from the output above) doesn't fail. It
silently exits, nothing written to stdout or stderr, with 0 status. A
little surprising; I would have expected rev-list to complain that
dc41e11ee18 isn't a valid commit-ish value.

Bryan
