From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 01/11] dir: free untracked cache when removing it
Date: Tue, 26 Jan 2016 07:48:43 +0100
Message-ID: <CAP8UFD2vkErMGpdBZU78PFGO71Jk8sq+TfBNAtOp0=REsv_N0g@mail.gmail.com>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
	<1453649304-18121-2-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYoQFWQCxpGxze=v36PTrC7+EgVOwtfm0kgE_kQoekq1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:48:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNxQn-0000OC-6l
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbcAZGsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:48:46 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36159 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcAZGso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:48:44 -0500
Received: by mail-lb0-f176.google.com with SMTP id oh2so86504511lbb.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 22:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+8bdCDLUnUtjJQXdcSnxXKuMjxyqOqOF99Nt9vSJ5p8=;
        b=UWfzH46tS/JHjW8vtyjzClT4j4HxKTiv41XYUkx+/OdjMB2J3PFGjOMAZtUhXKSBY1
         DaMTMgVgzofIrMEH6RiT/q28J8OlnHLpSiIRHlzjUcrGxvoihEZIRIF9pImn1nmaZ4Zp
         9OJMQGJCKGy7dbifo/vsqgPGJl6ZwR4TV+5uebcIM1b2rslcH2RsZq53SV+L/uiIxcM8
         ksWDYvbpzdajGAQRLAgY9E21VLpfbcgLX5vxMs4CS+HF1SbihaVbk5FjT5cu6u4iU9pQ
         gzTxkXowJkD18N4cxaP/emGBd1goGIURptfbRG1QCjn8CoIHRwYa69VFMHn2sEsK7vvP
         MN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+8bdCDLUnUtjJQXdcSnxXKuMjxyqOqOF99Nt9vSJ5p8=;
        b=c2F6JUgz8j8ZwJOZRxKaoLpiOCkELXgWisV3hXlPjJE5064FWF9aw1hLOM9jkiJw2/
         k7gCUZ0GtAf7uFEer7bb15n+4+/ABDCgwcmLrU0LbZjBp3gx2vJ7b6aSwkJTsWjuDGG8
         0mcFjZQCygxV7TDcVMbyYpLIGTcKAJj634solnD1ga5P8wCbGKNBXXiis84URU1kKdU2
         0WZzMLI7bChQIwDI/sT+Byvr8NJMzqDRn012lI8Vszo81ASFgRBmhtsMePFZcfg79d/U
         KFjrbtaUeVby0hk0Dq3rMaz4c6zj9Xpj7Dtn3VKQMavbD940G+OUkIOYjKljh50Figlo
         hxDw==
X-Gm-Message-State: AG10YORA48WALrZ3/SB+GY2qeD+kaSPQiQlFZicf6WaWj0+Bm5gIDYDMRc5xQ6Sr5lOKOj/pOFL0AXNxDgWZLQ==
X-Received: by 10.112.45.138 with SMTP id n10mr8017800lbm.100.1453790923378;
 Mon, 25 Jan 2016 22:48:43 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Mon, 25 Jan 2016 22:48:43 -0800 (PST)
In-Reply-To: <CAGZ79kYoQFWQCxpGxze=v36PTrC7+EgVOwtfm0kgE_kQoekq1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284781>

On Mon, Jan 25, 2016 at 8:16 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jan 24, 2016 at 7:28 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/update-index.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 7431938..a6fff87 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>                 add_untracked_ident(the_index.untracked);
>>                 the_index.cache_changed |= UNTRACKED_CHANGED;
>>         } else if (!untracked_cache && the_index.untracked) {
>> +               free_untracked_cache(the_index.untracked);
>
> Do we need to free its members, too? (Or is it empty enough here,
> that there are no memleaks in there? If this were the case a hint in
> the commit message would be helpful)

free_untracked_cache() takes care of freeing the members of the struct
it is passed. If it doesn't free them all it's probably a bug. Many
free_*() functions in the Git code base do the same thing. And yeah I
think it is safer to free everything.
