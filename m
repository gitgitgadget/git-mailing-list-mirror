Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A062C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14A520708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mcgwiz-com.20150623.gappssmtp.com header.i=@mcgwiz-com.20150623.gappssmtp.com header.b="0gme3I9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgA3VyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:54:09 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:40071 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgA3VyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 16:54:09 -0500
Received: by mail-lj1-f172.google.com with SMTP id n18so5007106ljo.7
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcgwiz-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=zP0zBD82uHnNOjPIuykExLuTGb8bGH8PzrPRJMwmW28=;
        b=0gme3I9zA8h+54NHmKVrY/RFFlWi7Ol+TCjP25EnHrfzVhPogHR0SHXuhUm3g/m8Xi
         FA0p68h3Cxbs0RSadicGEnX/gVivBfC1CH440PTcQHu203mTHq0UbNIu5LiGkkbvInjL
         +HY1dn53paNNlTp6oLrWHFuYC2UFutiXUooTqQ4Rs/SWcBy6UX49pC7rnU/qC+V2BoeY
         4NyS9aHKftb/SKu6H0l/IzdC1ftUJGH29G3rZnC022+OlR8zzHZleKiZfImEHh9pzIxA
         a1q7m9vyprVMql/5GjbJ0D24lGnT/QiVIipNEZWaBRotvcC0zdmrKePzJBKc7qeLM6kz
         HN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zP0zBD82uHnNOjPIuykExLuTGb8bGH8PzrPRJMwmW28=;
        b=ScGZjV7T36oVJMV8x2csvFBxDIoe3QIXGTZTsWZgqbQQ6rjacg7OyNWrbCKJ//BFu5
         k15jkA2+Hd2ljI0hey4ioTQDz4Lq7wWbQmHOLB/8LUN8hVzG0RYFbATcALmtZ6UgQXQA
         rThAlfkjn8pSl1UzVhlUqLhDZHbdhHCtyHLlFPvqa9s4DKowxKdu0exnAefn2blbOu7G
         rwt+Y53ayOYI/oxsS/5AgEGgWBm9OyqMYnfZknhxp4vyNZtNQuso9qneDv1UQHFyVhv6
         +jEqnopAXqJ2Q/cVz6UDH+Z3FtMrNcHs52etuPCp1yPvr66xb6wCw08puEPoeSD9PqMV
         t1FA==
X-Gm-Message-State: APjAAAWkXoh8rKy97vHTRymZN3cEmw00s5YSUI3UnUng4xbaWiNYzzGz
        3amxrZ9yS4aro9XxNItZThRFCCFuMwM=
X-Google-Smtp-Source: APXvYqx6l95sLS6g0Ap5OcEv1bTuzT8/grAszo+C1jn11bhul3JppvekSiF5V4YJfJBdhrokCRrsww==
X-Received: by 2002:a2e:b530:: with SMTP id z16mr3716436ljm.216.1580421245683;
        Thu, 30 Jan 2020 13:54:05 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m15sm3837255ljg.4.2020.01.30.13.54.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 13:54:05 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id r19so5052246ljg.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 13:54:05 -0800 (PST)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr3801314ljg.141.1580421244710;
 Thu, 30 Jan 2020 13:54:04 -0800 (PST)
MIME-Version: 1.0
From:   Mike McGranahan <mike@mcgwiz.com>
Date:   Thu, 30 Jan 2020 13:53:52 -0800
X-Gmail-Original-Message-ID: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
Message-ID: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
Subject: Patch text in git-add patch mode lacks whitespace highlighting
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm using version 2.25.0.windows.1. If I set config "wsErrorHighlight"
to "old", and run `git diff -p`, the resulting patch text highlights
whitespace differences in the old text.

If I then run git-add in interactive patch mode, I expect the diff to
include the whitespace highlights. But actually, it does not.

Is this a bug? Thanks for your help.

-Mike
