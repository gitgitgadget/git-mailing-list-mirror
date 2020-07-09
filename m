Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003DC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 03:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC0D206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 03:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="UKwYk9bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgGIDY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgGIDY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 23:24:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE66C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 20:24:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d4so348783pgk.4
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 20:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=qdvv4k5dRIANhERZmavVJ+SzCQpJmusv4/pfYI6WqMc=;
        b=UKwYk9bhEaC6Ibc79a6qnPSsBJqZOHqNwbiRqJ1rY/d+OvRiFKkiVMFRScjcf34nBR
         MXzOi5vHU4xaetq1Z+jQCSWcKuJNfER8erYce8ddmtn4ppViK8GlNRePvfeJLwo3u/OG
         MJM9AvAa7nmH/Oz600JtSAyjnDUEXo9noCtpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=qdvv4k5dRIANhERZmavVJ+SzCQpJmusv4/pfYI6WqMc=;
        b=l1K/mgTdDAHy6Hy34anyhkU1nsmY1dCGhblIToyoBJcnfh77Y7zSUFA1Nq1AClkwR9
         A78XO+mE1i9FCkL7ljuuGzrVeBt8dG/1ch0lYyKT1MVxZ/BWHOaJLjREoQwGNgSc9uNc
         sGNp1uw3HgVr4/6VfM3zjc3ukzPr6wVAi6viAnowpbV/aJvrZ9CS7xBXf7Xtk1ZJYMqw
         mr9YUSuuhErwDoKL0PbqrNNNxTmK/mchIJ791GdEZ6ws3Hj8dk2ze+h7dhT6iHVKvlzl
         yjled/vtldfNB5qpNMKQj10/m53mz022uFBPdhhT9USfALmp1ZOW5Y4PsWO/DJP91Uao
         ejiQ==
X-Gm-Message-State: AOAM531sDvO3bEzaVRaAeV8Wfy2dBxnSLE05Aupv0AAPNdj+eM/YUZ07
        I/07azNc1g2Nx5SNrXFaw+EG75n2jGKRC6SkadDthThxzVORcfvI2dS2CwJUkqKSZ2Wl7FkrzRq
        b9AMUlrGhlS2/cE+ofV9HFenpWQe3RQfQ5Mc1eYNWYyZwuXtg9junx8r3Uw==
X-Google-Smtp-Source: ABdhPJzmtdqH6embLbbOvXgOmVKunzlN3Z95eNl4bFMRvVB7dKwNdVtM46Zmr6CgBPoTDUQTvrBN2g==
X-Received: by 2002:aa7:8801:: with SMTP id c1mr55276559pfo.105.1594265066646;
        Wed, 08 Jul 2020 20:24:26 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id j70sm1027413pfd.208.2020.07.08.20.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 20:24:26 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com> <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com> <xmqqh7uhz98q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7uhz98q.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
Date:   Thu, 9 Jul 2020 11:24:20 +0800
Message-ID: <261a01d655a0$71077210$53165630$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGL+c9r+Sj3YnB8Xlh5VXkiFBL/EQG/MxNQAccWvdapdxe0oA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I'll add SP on both side of  '|', and remove the backslash, thank you.

This line assign value with `git config --bool...` is over 80 =
characters, so there is a break.=20

>> +			else
>> +				meld_use_auto_merge_option=3Dfalse
>Why? Shoudln't we loudly complain to let the user know of a misspelt =
value in the configuration?

The command line `git config --bool ...` without "2>&/dev/null" will =
print error message, just passthrough to user.
$ git config mergetool.meld.useAutoMerge hello=20
$ git mergetool --tool=3Dmeld=20
fatal: bad numeric config value 'hello' for =
'mergetool.meld.useautomerge' in .git/config: invalid unit

I'll upload the changes soon.

Regards
Lin

