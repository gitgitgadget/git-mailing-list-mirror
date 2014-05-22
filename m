From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 36/44] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Thu, 22 May 2014 08:40:22 -0700
Message-ID: <CAL=YDWkFC=67KjNSLKWLGHs2M33uVLWgzBy-LAPaUuTVZDgAnQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-37-git-send-email-sahlberg@google.com>
	<20140521234717.GL12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 17:40:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnV6c-0000RL-8H
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 17:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbaEVPkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 11:40:24 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:32987 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaEVPkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 11:40:23 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so4592270veb.26
        for <git@vger.kernel.org>; Thu, 22 May 2014 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G9xmWtFdOu+55XcKqJ3cEP70/ACe6vxEJRkQ6O5RYp0=;
        b=oSnIPEFoDiqclPpzp/UvjXny8II0jP0azSvTyGQF0HKxCZfGb85kNVCvmikIKXK6i9
         lY+56SM6EQdED6g5uEn4yac5PRJbbiRzNOCP2YQZHNqQOankRNKvJTTwwePb2l73PFr/
         KqsDzMlbu5oJH9atcQ77/kif+uhjs7ovtltfXT+AmRGTKpOLS7uqQlnUWwwW3c5sajf4
         Efj2Ltic9y2vtA+s7dyz0o6N7vLhh1LFFyzmg8wNZ5ouO3Kvg/g73jrtl6PSA4eGa6SD
         32LJDVVRF9MIqWCqlc5bnS6lrxQ6cdaZA7JjPkC5qAqNx2Cb691l3bUwPQohl38dqner
         2t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=G9xmWtFdOu+55XcKqJ3cEP70/ACe6vxEJRkQ6O5RYp0=;
        b=Qhj4Fs2az2Y8KN8FZ8SW67hyBlKKPY+uBm08azXQ9aMCh0NVw5Bsv5csaYHI/zlovT
         Lojts3IyHuismXlVEwGinBag+FgaRW6bHOCETnto8HOR4zX0JQqxAiPPrzM0B+VdmgqG
         qetTyntPtR/wSZJSYnwaWvA6Aa4XpHeHUDEBx5CtPEyiYMMjvBsuaXUrGN2uM+tWwPcs
         kF2y1Wf82rftWkUEsOFikt2rH/jOlECWOV2YZgOXSXPQlClAJKHcVW4lGEunyYbMOMkK
         iwdd3KA30cr/ZVraSHJWUEfpNPgW+1kGKmS580eo83tA02CJT4LdivdOoun1K4btY8O0
         QeiQ==
X-Gm-Message-State: ALoCoQlF1KkAc5T/eDN0X2Xnkf1JV/PxesXI0iQDxPdSGCFt1t7u4t8fiRVcG2v84O2bgBYcG5YT
X-Received: by 10.52.163.98 with SMTP id yh2mr14023728vdb.5.1400773222228;
 Thu, 22 May 2014 08:40:22 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 08:40:22 -0700 (PDT)
In-Reply-To: <20140521234717.GL12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249910>

On Wed, May 21, 2014 at 4:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change the reference transactions so that we pass the reflog message
>> through to the create/delete/update function instead of the commit message.
>
> Nice.
>
> [...]
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -673,7 +673,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>                       }
>>               }
>>       }
>> -
>>       if (rc & STORE_REF_ERROR_DF_CONFLICT)
>>               error(_("some local refs could not be updated; try running\n"
>>                     " 'git remote prune %s' to remove any old, conflicting "
>
> Stray whitespace change?

Fixed.

>
> [...]
>> --- a/refs.c
>> +++ b/refs.c
> [...]
>> @@ -3264,6 +3264,7 @@ struct ref_update {
>>       int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>>       struct ref_lock *lock;
>>       int type;
>> +     const char *msg;
>>       const char refname[FLEX_ARRAY];
>
> Should be 'char *msg' since we own the memory (or perhaps a strbuf).

I changed it to char *msg, but it still might/should be const. We own
the memory but we are not supposed to modify the content
(after we have copied what the caller gave us).

Yes, we should change it into a strbuf at some stage.

>
> [...]
>> @@ -3297,9 +3298,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>       if (!transaction)
>>               return;
>>
>> -     for (i = 0; i < transaction->nr; i++)
>> +     for (i = 0; i < transaction->nr; i++) {
>> +       free((char *)transaction->updates[i]->msg);
>>               free(transaction->updates[i]);
>
> Whitespace?

Fixed.

>
> No need to cast.

Done.

Thanks!
ronnie sahlberg
