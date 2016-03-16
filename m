From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [RFC PATCH] hashmap API: introduce for_each_hashmap_entry()
 helper macro
Date: Thu, 17 Mar 2016 00:39:55 +0600
Message-ID: <CANCZXo4uePVvk8_h2KuZQe4UFcFS1C76JvOfugK2nH3oH7TOsw@mail.gmail.com>
References: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com> <xmqq37rq5m79.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:40:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGMq-0006LH-A9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935125AbcCPSkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:40:18 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33313 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934742AbcCPSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:40:16 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so53993150lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5mkNUgc9ou7H5QJGKnJRIatHCqbURmx0BTHtMh2ZR4A=;
        b=XGcEnZf8L7G5UWB9fS3bYiPNA6lKzd3d8eSuLYgdlG/3+OAXL3RuGC734ZTMZmI4wE
         ZEPYCui+42fVSl1UPdJZ4Paci9X1sD58c3MOQaI2HKwHSIP8CQ+ezPTPvD3+rp//MzuL
         fHiGlZ1czzz0MIDG/GxxFq9xvMVe4YJd6aNZ+Y6r92wNn5FfRoqNsttVmb0LJQ8v40Rx
         F78cEwN4P/M7fbQQw2xkWK0C1MOQi8p/6B2z1WcMmL63kpDY4V5yCIaKrGKcbIMraMfA
         5dPIobZRSsiQmOinCxlWZdK99XaH/AkmeKgEDLdpYLg7GDT1wsWyTy7kOBlYVf6GyKtf
         /8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5mkNUgc9ou7H5QJGKnJRIatHCqbURmx0BTHtMh2ZR4A=;
        b=TMTMyUP/4g0rV1B3YUWhRxAw7t/Ryl0XlK3ieNL5ZQHOK+YdAUhEza0UCrm67VbwaF
         vEwjtg3fyFQPLW7dtjBgvQA54dZce/ryeRJ8olwe+Uof7zSnxQ7AmN5ewTaINFit6e9T
         mhq1/SuJYyhCWwS56ZEU4128W2qo9E6/ffrMlfu3I+vUA+GhGvqwPRVOpbWoYJzVqWeo
         Q1+kVAEcAux/LDbxNr/aS1C9blHcVmvsg5medXTHpcToYoKXfE5ZCPrPrOVBrTT6/fF8
         wiQxZiP71vZRU28cXKiWGM3prz7f5iqJkRZFiqWWUvHEasGSL4lG40jduTetx1XIDb3L
         uW8w==
X-Gm-Message-State: AD7BkJJIN2d4yen8Jq9EhcOGRSJuwn+StR72PYtR1le9qujWPvYgTRpJ/YABFfdLNRBhhhtCAQQCkwwallVr9g==
X-Received: by 10.112.169.105 with SMTP id ad9mr2049477lbc.135.1458153614955;
 Wed, 16 Mar 2016 11:40:14 -0700 (PDT)
Received: by 10.112.77.65 with HTTP; Wed, 16 Mar 2016 11:39:55 -0700 (PDT)
In-Reply-To: <xmqq37rq5m79.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289015>

Hello Junio,

On Thu, Mar 17, 2016 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> diff --git a/hashmap.h b/hashmap.h
>> index ab7958a..b8b158c 100644
>> --- a/hashmap.h
>> +++ b/hashmap.h
>> @@ -95,4 +95,11 @@ static inline const char *strintern(const char *string)
>>       return memintern(string, strlen(string));
>>  }
>>
>> +#define for_each_hashmap_entry(map, type)            \
>> +     struct type *entry;                             \
>> +     struct hashmap_iter iter;                       \
>> +                                                     \
>> +     hashmap_iter_init(map, &iter);                  \
>> +     while ((entry = hashmap_iter_next(&iter)))
>> +
>
> This is an easy way to introduce decl-after-statement, i.e. needs an
> extra pair of {} around the thing.  It also forbids the callers from
> defining "entry" and "iter" as their own identifier outside the
> scope of this macro and use them inside the block that is iterated
> over by shadowing these two variables.
>
> Other than that, it looks like a good concept.  The syntax however
> needs more thought because of the above two issues, I think.

Thanks for feedback. Will fix first issue and think about second.
