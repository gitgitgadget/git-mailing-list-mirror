Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F5A2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 19:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934646AbcJZT7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 15:59:34 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36552 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933693AbcJZT7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 15:59:33 -0400
Received: by mail-qt0-f172.google.com with SMTP id 12so9106252qtm.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=92yf3poQum/lorbOYQd9n03u/jrFDq0P33uyyt0afGE=;
        b=bRex40211ZzRgkzskFK6y3NWUwjSIZ8iK2KlYGhYDqC7JA6iDrWeO0MtFLVVPi7WP/
         /E23pGwmRg0Fpc9nsM7FUXVmt2znBXNCVl+sC5pJ79GRg99heHwDmEdyiydEOdT2Fu2Q
         RvMu4FbdfF4puSQhmdWWln8wRn5vj2N43Tq2DXtc1q65+mlSZQHlGa6DOPu1E4aUQMlc
         +ai7Sny+JX+FFG/dDRsgyjA4f273aW2SA0mLNoJ/kNzovN2iyfuzR8aMHomsB9XIQ102
         bcmEY16HA8ahx60g+qHDJJ2S67TBZcPAwvwF+Y6AlGkeGL4MMpWRiT2lyBCALlpaEN4B
         sUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=92yf3poQum/lorbOYQd9n03u/jrFDq0P33uyyt0afGE=;
        b=LQn3KPtvmYRtKBNOuLVAGAFQgN7b/Itst+dMfY5LyfSFVuvU1tQ6JIP9fZPF162LmU
         hHQaH0wvtNev5Nq0vR2x8PXe1rGM4IEHOoXyKMM14v3GfUTTnlj/Z4GW3yOY/C9ihs1N
         NNFpvFzPMC6REYV+tz8MjwpiTD/TwDOmhmO8aQwstoIABfBeLkMDG2b4OFTfZN3Zs3RD
         eSLyw50NrgSzdcY9y+WAa73vopRUAMxHC3vXXvnBnovXrOUXkx+5afNHJONfefexKI6M
         2vymsl6kcuhTAQfaIEVteFFiqosKl8yV+G4NcS5tOJIuASBeheMc5TsHSjnIMmehJ+QR
         FHxw==
X-Gm-Message-State: ABUngvc7dp5fGimKhBqh2G3/fibeDB6m6WmYngKqUgdTQtoCdq1uaTzi+MEOalBeBx8FM+FfBvQY3hUqKH3WE+36
X-Received: by 10.237.47.194 with SMTP id m60mr3221042qtd.55.1477511464110;
 Wed, 26 Oct 2016 12:51:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 12:51:02 -0700 (PDT)
In-Reply-To: <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox> <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 12:51:02 -0700
Message-ID: <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 5:15 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 26, 2016 at 11:35:58AM +0200, Simon Ruderich wrote:
>
>> >  static pthread_mutex_t attr_mutex;
>> > -#define attr_lock()pthread_mutex_lock(&attr_mutex)
>> > +static inline void attr_lock(void)
>> > +{
>> > +   static int initialized;
>> > +
>> > +   if (!initialized) {
>> > +           pthread_mutex_init(&attr_mutex, NULL);
>> > +           initialized = 1;
>> > +   }
>> > +   pthread_mutex_lock(&attr_mutex);
>> > +}
>>
>> This may initialize the mutex multiple times during the first
>> lock (which may happen in parallel).
>>
>> pthread provides static initializers. To quote the man page:
>>
>>     Variables of type pthread_mutex_t can also be initialized
>>     statically, using the constants PTHREAD_MUTEX_INITIALIZER
>>     (for fast mutexes), PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
>>     (for recursive mutexes), and
>>     PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (for error checking
>>     mutexes).
>
> I seem to recall this does not work on Windows, where the pthread
> functions are thin wrappers over CRITICAL_SECTION. Other threaded code
> in git does an explicit setup step before entering threaded sections.
> E.g., see start_threads() in builtin/grep.c.
>

I wonder if we can have a similar thing as
http://stackoverflow.com/a/9490113 in compat/win32/pthread.{h.c} as it is
very convenient to not have to explicitly initialize mutexes?
