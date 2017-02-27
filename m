Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4822022D
	for <e@80x24.org>; Mon, 27 Feb 2017 04:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdB0ExO (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 23:53:14 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34532 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdB0ExM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 23:53:12 -0500
Received: by mail-wr0-f174.google.com with SMTP id l37so180404wrc.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 20:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RD7hq68BF82UEsHQZ9CRVlBLY2/K8WtwjC9VUvs9twY=;
        b=YL88xdPucbAucwKNQsSpXy7DEZKPj82pttIINH4sLgLncYiE//KR3bdHcX0C/5+yOw
         tiru00T9lXikExbNWuqXaVzqB9ErT1v17e0+wWtpej1rR+UTj5gTjfcgFWW+5zkMdBrk
         QnOcWXuXI+2weo+z6ejAEmExLTCSfNQjnjbQ8VvgA7yw855pp7ot1uKVCI2xQprtacPF
         3mhzYXGD2JH9wroTo3ABCw0sojrbTok2+XWTo6U3hmDhfWII3ikPo1kI6Jw4ER6wQ9r9
         CTBYBidk3f9rQJa1Zh1AZu6q4Juyp/XAVp4ItIQaYy6/9rjqxCY+fA1SIQxlvuPWcE57
         6XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RD7hq68BF82UEsHQZ9CRVlBLY2/K8WtwjC9VUvs9twY=;
        b=NOFeQvY0tf2exfG42b077OdFUDKQaQk/Iy8FzQKksN+yANr/HT+DWZCaZWvrPvD9HC
         wGuEgpcB+mIc/VuVYfg6nCyxjk8Jkxf9Iud5IAisLzenlnijB8ZUufDPE+Ux8aikzF8B
         Vinyyk2acfr8vPNXLQi2PLTz4hCK0D2c3d1fm0XqFUVkxeWV2N/jDS+Rt25JKg4FGZDN
         8G7OX4mzT7yjR9VFNRuBXYfY6gS+I1LJaqO5NyG3GEu8KvhlM/QBeYua3/Bi8go2FXxl
         SMU2nAIrJOk1WPAXIaUGqtX2MRoASu62jPagUwOk6nEls8Pyx/A5HO8nuZd0vRolXE/T
         p8Eg==
X-Gm-Message-State: AMke39lVyjh29/NJOi1GJz+fKuKQk/68F9xH0g7VIBqXbibXPudiptzIn1zHU+9OFe684Q==
X-Received: by 10.223.176.20 with SMTP id f20mr7045672wra.160.1488171179837;
        Sun, 26 Feb 2017 20:52:59 -0800 (PST)
Received: from macbook.local ([2a02:a03f:85e:d600:dc96:b6f1:625c:99f0])
        by smtp.gmail.com with ESMTPSA id d75sm12595737wmd.25.2017.02.26.20.52.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2017 20:52:59 -0800 (PST)
Date:   Mon, 27 Feb 2017 05:52:58 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227045257.yazqlrqlnggosi5t@macbook.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just discover something which very much seems a bug to me
while making an error in renaming a branch.
The scenario is the following:
- I have a branch named 'orig'
- I want to make some experimental changes on it:
	$ git checkout -b temp orig
	$ ... edit some files ...
	$ ... make some tests & commits ...
- I'm happy with my changes, so I want to have my original
  branch to now points to the head of this temp branch
  but did it wrongly:
	$ git branch -m -f orig @
- Now I discover that I don't have anymore a branch named 'orig'
  That's fine, I made an error.
- I'm searching what had happened and discover the name my branch 
  have been renamed to: 'HEAD'
  In others words I have now an entry .git/refs/heads/HEAD
  which points to where my original branch pointed.

In my opinion, it's a bug that '@' have been expanded/resolved
into a branch named 'HEAD'.


Luc Van Oostenryck
