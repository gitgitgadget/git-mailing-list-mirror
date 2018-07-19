Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957181F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbeGST5l convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Jul 2018 15:57:41 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:46281 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbeGST5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:57:41 -0400
Received: by mail-yw0-f171.google.com with SMTP id e23-v6so3477468ywe.13
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/j1Ietj841trKB2CIatPN6rBrGeDQPcM8BAfEaG3a8=;
        b=UvdJjeHwGz4GPwq2CuD6Sn80K47Zi/2LU10Z9AixBkwk9F+HcANV3NmQVJrn/gZd5S
         mPreprOfn5jxJooP3wyPGUeQo+kFpFCGx+QYJuIABPpgq/ftjXFIYfarxUps09txRlGt
         4x0lONbM9xOwmWqKLwpg93pOkcqTQwj44DEF/D01HuoNE1ZbDjtMCIWaIU9vLCHYKLzo
         fpPmjJRwyD5Os8Qrk8YE/UV4xxG9b+PsQQcqnPKCXNWV6jA3AlpzN18t+o2G7HHVRJOF
         TVvN0Qjf7yQYJ2+3MDPX1BTAqcoSM27sfyXe0ZfPglDUGmkOgC2xfCGEUz0MjLf1rjJe
         ZLxQ==
X-Gm-Message-State: AOUpUlERXzDdMfl1GIJ39wYLRNzPu6gRPse5mgUJIqSe+L5SXqLkjQei
        nFmB0aWpfnx6C2v4fFGMFLpVs0lUEgHJgRUCb2w=
X-Google-Smtp-Source: AAOMgpeZ7LdLe5U8p9xFBtTvDimPkGbHh8v1ipubRbioULNeINS9cSUPH4CaU7Vz8/l21XodqVZZu7N6cmm9ckyAkOo=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr6110558ywk.418.1532027590238;
 Thu, 19 Jul 2018 12:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com>
In-Reply-To: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Jul 2018 15:12:58 -0400
Message-ID: <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
Subject: Re: Gitk doesn't work on macOS Mojave
To:     cherpake@me.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 2:48 PM Evgeny Cherpak <cherpake@me.com> wrote:
> You have probably heard this by now already, but gitk doesn’t work on macOS 10.14 - because it uses Apple Events,
> And apps on 10.14 require user to give them permissions to control other apps with Apple Events.

This hasn't been reported, so thanks for bringing it up.

> Here is what I get when I try running it on my machine with beta 4 installed:
>
> Error in startup script: 58:102: execution error: Not authorized to send Apple events to System Events. (-1743)
>     while executing
> "exec osascript -e [format {
>         tell application "System Events"
>             set frontmost of processes whose unix id is %d to true
>         end te..."

Fortunately, this feature is merely a convenience, not otherwise
critical to gitk functioning. It would be ideal if someone running
Mojave could devise up a patch to work around the problem (either by
skipping this code on Mojave or discovering a different way to bring
the application to the foreground). An alternative would be to revert
76bf6ff93e (gitk: On OSX, bring the gitk window to front, 2013-04-24),
which introduced this code.

(Note, however, that the gitk project is dormant, so it's not clear if
such a patch will be picked up.)
