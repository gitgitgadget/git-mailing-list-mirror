Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2274C33C9E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 09:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B8D2082E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 09:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/5lmMzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgAKJqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:46:36 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35162 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgAKJqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 04:46:36 -0500
Received: by mail-qk1-f173.google.com with SMTP id z76so4319071qka.2
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 01:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=WrFcuDUSNJbCZrR2BFFHUVKIlyhDby7GxRrxdtAy8wk=;
        b=P/5lmMzDlxZWVvhHZbNa0Z3Ob5ftkrMcWLLPuEkAFqT2MopAfN1QgMYjosvuUfkZlH
         JWF+TEMBqoyZXoULQBJ6BWkO8rPFkZpqDaXHfKp+eUAsdegNccMyJwwKOOc9c9WvZwbj
         S7FZfnmx0at6JIE8UfNFP5kw/1WLUu5WRUyoWRs19v9GuY/FReM5FLvJGOJBLV21MPnI
         tLml7UFv1w0lbqDIret5jtUhL4I3Jp9/8EVgvAyN14nVh1Vb7iYDHfVmL/gFv2iaU0FJ
         xUFrb3FfE48dGBY65aGMISmdTddYGxsoxzhbjeXyoYJolMhJHqTX7xS6GL50hVfdQLex
         jUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=WrFcuDUSNJbCZrR2BFFHUVKIlyhDby7GxRrxdtAy8wk=;
        b=s7SfTzrlUBxiWQIeFqBNCgDLcIngOfBwgrX+TLJ2Qrcxk+VpMm3ZIFNMesIYXTpJM0
         cmt54rbvOde/UTWCh7oFvS1LfY5wqZpblEDKGlfTkLXTl565VWeGkoWEAQ6VYxxWmrM6
         SQ0+HXsFR7/8ix+31H9SofYmJQEqr5Ofs2/Dx+D6KNmceT5d8fAdOiQZirWoCcnOobb1
         dprkK6eAsW6zoNIgEAtT1x7SdZIXm3XbDLXNYiWYGYqTguU5MpCA/YXEu9rPXeZAt2El
         /oEKXJ75m0fpOiO53QCI09ELMMxNQr1SujK1Ssw3NTOObZxTD14KDQBS863Y5Sxf6LQW
         90tg==
X-Gm-Message-State: APjAAAWwwjtXy3Uymsr57M90sJk3pYOHdwG9nUz20SEmtAUGI1u+7Wxa
        N95AXxpF27GAb+WIWbgas2SooGy3edE=
X-Google-Smtp-Source: APXvYqypzKzPiRHIjZYDvkVvFcema5RIt91G3fiRmL5zIFq0110I3RcQRn6TuJNfTUkEDcT14l3M6w==
X-Received: by 2002:a37:a1c1:: with SMTP id k184mr7446672qke.66.1578735994811;
        Sat, 11 Jan 2020 01:46:34 -0800 (PST)
Received: from [192.168.1.157] ([152.208.5.91])
        by smtp.gmail.com with ESMTPSA id l184sm2119755qkc.107.2020.01.11.01.46.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jan 2020 01:46:34 -0800 (PST)
To:     git@vger.kernel.org
From:   Kevin Bowersox <kevin.m.bowersox@gmail.com>
Subject: Potential Issue with ls-tree documentation
Message-ID: <18b8b8fd-ee38-e1bf-8fae-b719b7b78a75@gmail.com>
Date:   Sat, 11 Jan 2020 04:46:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Within the ls-tree documentation for Git found here: 
https://git-scm.com/docs/git-ls-tree <https://git-scm.com/docs/git-ls-tree>

It mentions the following:

the behaviour is slightly different from that of "/bin/ls" in that the 
<path> denotes just a list of patterns to match, e.g. so specifying 
directory name (without |-r|) will behave differently, and order of the 
arguments does not matter.

I'm wondering if this statement is accurate.  Here is my reasoning:

When using this form of the command:

git ls-tree <tree-ish> [<path>]

the <tree-ish> (assuming this is typically a branch name) must be 
specified prior to the path, making the order of the arguments matter 
when issuing the command.

If my reasoning is correct I would be glad to submit the changes for 
review/merge.

Appreciate any insights.

Kevin Bowersox
