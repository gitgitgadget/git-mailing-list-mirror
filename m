From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/3] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 24 Apr 2014 08:22:29 -0700
Message-ID: <CAL=YDWm5NqkBSCkxabCO3_tDqPyuugD8K9FHZ5dsw9dAEXf5Eg@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-3-git-send-email-sahlberg@google.com>
	<CAPig+cQUAVK7O7yRJGjvRmuPg06C1ZEi876gMsihFpGLgVa=Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:22:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdLTz-0005cH-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 17:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbaDXPWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 11:22:32 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:48656 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbaDXPWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 11:22:30 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so3117168veb.31
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w50QUmn+OYORG0utHo/nCqnFcbUzR49SArLq1s5uxqE=;
        b=maSUT0zmT1OqMUHu48rzBJzj6L0gHVEUvu6rgowwjfMRbeNTRI0RU/F4VyOfoe7LnO
         Wkh/ZmnBAWWULNTSvRc/7KGYKef0IG7XG2V+KpvU/s35ICyTF5mTyyUKDBW6O4FmHaHr
         mtQl8F/3v2j9VFj2KJ/ihGgA31+8GBHliZ2eJfK4u0413MInRT9oQkxENX5ElWMsAhHI
         pAbzx0LYHJUs8ivev5ZLMyQoe6oWBlz2Jw/GR/mbJcp7nHxAk5a8Jxi3hhddJJJuTgWZ
         Y3TaA5fWh3CcofT//bKCgtvkMW6l95TU2opgZyM+7LoJDW9ySS4ejXQRWkz7gF8YITsd
         /bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w50QUmn+OYORG0utHo/nCqnFcbUzR49SArLq1s5uxqE=;
        b=Sx44o1aEsi8AJYhfJEH/y9g5Bl3yJIDNnRNrmy7ZRAyKZLdNXG4+wRpHzXsUqg5+JD
         IkYnftjBRTJm/PFeUfP+0/gaC738j1gIcg5kTPkqepRWv5Aj9SrRWzj8B2LV/jUdtw6n
         gCZTAwqNBTVEl6AH1dJ65JhXI0gYUDjLVcxWQWXA50TPUr/184/u1NR/U5h8E3umragS
         pi2PvqasX68GPraPFLqFPNo5YP9etj56bZEkj1yf3y3vR+vMhTDw28oMgeg3e6AbfGje
         se9KmFs+Lpwj3KaKRD8B2is9MfBUCYMGDd9AX0ccz62MDg6EeIN0MQjlddR9P/8LXalR
         fhWA==
X-Gm-Message-State: ALoCoQmVqo0O+STdQCCyiDgLGi/z8YHDFpbXaUzr88nM26f6Ul6OnAQSkY9BipCcY2Er31q8pBWhvNC0Drs6KPiOeBaX96aVu9bnTD37my11840PbCD4Vy2AvfDbKZeHR9rE9dvoyS0IYzRxK8xuX2PDxaj0K/ON1t1Splk4kDeetuHedhV8UNo6nJBFdpC4+Dev0KcjhQiN
X-Received: by 10.58.110.74 with SMTP id hy10mr783340veb.52.1398352949716;
 Thu, 24 Apr 2014 08:22:29 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Thu, 24 Apr 2014 08:22:29 -0700 (PDT)
In-Reply-To: <CAPig+cQUAVK7O7yRJGjvRmuPg06C1ZEi876gMsihFpGLgVa=Mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246972>

Fixed. Thanks.

On Wed, Apr 23, 2014 at 1:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> Change s_update_ref to use a ref transaction for the ref update.
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>
> Doubled sign-off.
>
>> ---
>>  builtin/fetch.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index a93c893..5c15584 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
>>  {
>>         char msg[1024];
>>         char *rla = getenv("GIT_REFLOG_ACTION");
>> -       static struct ref_lock *lock;
>> +       struct ref_transaction *transaction;
>>
>>         if (dry_run)
>>                 return 0;
>> @@ -384,15 +384,14 @@ static int s_update_ref(const char *action,
>>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>>
>>         errno = 0;
>> -       lock = lock_any_ref_for_update(ref->name,
>> -                                      check_old ? ref->old_sha1 : NULL,
>> -                                      0, NULL);
>> -       if (!lock)
>> -               return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>> -                                         STORE_REF_ERROR_OTHER;
>> -       if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
>> +       transaction = ref_transaction_begin();
>> +       if (!transaction ||
>> +           ref_transaction_update(transaction, ref->name, ref->new_sha1,
>> +                                  ref->old_sha1, 0, check_old) ||
>> +           ref_transaction_commit(transaction, msg, UPDATE_REFS_QUIET_ON_ERR))
>>                 return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>>                                           STORE_REF_ERROR_OTHER;
>> +
>>         return 0;
>>  }
>>
>> --
>> 1.9.1.518.g16976cb.dirty
