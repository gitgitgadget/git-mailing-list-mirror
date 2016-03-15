From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule-config: use hashmap_iter_init()
Date: Tue, 15 Mar 2016 12:08:31 -0700
Message-ID: <CAGZ79kZH_xzfvo=cP_+BdsqpthwQUKkJjo7OawkpFN9y+jm_+w@mail.gmail.com>
References: <1458066330-5107-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cR6Cy2MHvoTxNa89gZx9qJZW1Rv93N+wcwK2JRGkUBzRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuKb-0000rB-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706AbcCOTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:08:34 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34639 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934145AbcCOTIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:08:32 -0400
Received: by mail-io0-f182.google.com with SMTP id m184so36190455iof.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xhjTPdrOrHqWsyhUE1WBQhMuTHTlEsvLRtcYFMVMUqQ=;
        b=Bs0YgBHccv57xEQC6jLgQdllsP4ghNZ6uEO7+08fs0W5q2IoPEgzPt9BzNuH0dLwGk
         9S9ewQFy3TWjgQZsBYtTLJCC1Y8AF+cT0OTxdU9c+tiiFuDlh3NU1mfTSJUdSZG3RBzW
         G7mKvQgzhuhqL7DmDFS5X/Z1GBjRpEJ80MH5aWTBbmGudjjc2raK3yHfu4bDHdQn/kMb
         Bqen/l4GJyyD0OmZpzX/rNe8U8ziMqTrJNImMT56fpNnG1n8LVLQr7AZbd9TA5/wcRkN
         HjAmYk1UFhrQOYh/Hd1+a7Atd6GEocMlB+MfSBjxpo+Ba2b7jbn3GtBmKtB5s+y0RNv7
         w0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xhjTPdrOrHqWsyhUE1WBQhMuTHTlEsvLRtcYFMVMUqQ=;
        b=dlCMNNcCTCPGwoXfQDzVUIeBiK9ySZInWIC1NmG9RVWy8qLFi6X4t81cOA0wmZ2fip
         r0ZvTnt+5zSHjuUmAGGpT1C5b29I9wBQE1N1vu00zqwZG5Lon6gLufOKPjFfFeiEqaMC
         ZoncpSTuoOqetMoqiw6RhVCvbIftQC/Wy+JgcmNWrhdBsxpuGm6xZV+sjIQXQnt8EXCu
         /vW3PCf6KoJ4R7F4WDfN96Wmj5FTqsMXot88//3Xfy59uwrkMqUisXIemoqOl4AwXkS0
         sFqXQypJEGCZRE5Lo6AvTvBEMZyhtsHn5Soap6N0UAa0ShiXin58M4StVoLxP7A5xodm
         p/Ww==
X-Gm-Message-State: AD7BkJKKlUEb1Adgk33g/KaNNPXKk4gYs+0EbhMG1lMk2hNFXxVCXTsxLO1U6/5M7T8ioXsX650LNt3+Ut+UbEGW
X-Received: by 10.107.135.96 with SMTP id j93mr339798iod.96.1458068911739;
 Tue, 15 Mar 2016 12:08:31 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 12:08:31 -0700 (PDT)
In-Reply-To: <CAPig+cR6Cy2MHvoTxNa89gZx9qJZW1Rv93N+wcwK2JRGkUBzRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288892>

On Tue, Mar 15, 2016 at 11:58 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 15, 2016 at 2:25 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> submodule-config: use hashmap_iter_init()
>
> Did you mean s/init/first/ ?
>
>> from the <hashmap.h> for simplification.
>
> Sentence fragment...
>
> Missing sign-off.
>
>> ---
>> diff --git a/submodule-config.c b/submodule-config.c
>> index b82d1fb..8ac5031 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>                 struct hashmap_iter iter;
>>                 struct submodule_entry *entry;
>>
>> -               hashmap_iter_init(&cache->for_name, &iter);
>> -               entry = hashmap_iter_next(&iter);
>> +               entry = hashmap_iter_first(&cache->for_name, &iter);

The change looks correct to me. But as Eric said, the commit message
needs work and a sign off. With that,
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
