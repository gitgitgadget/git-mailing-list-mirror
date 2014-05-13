From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 02/42] refs.c: allow passing NULL to ref_transaction_free
Date: Tue, 13 May 2014 15:52:20 -0700
Message-ID: <CAL=YDWniCYby1BZSS5yjrormi93-bVJiF4RV2FXT44KMrJXpPA@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-3-git-send-email-sahlberg@google.com>
	<20140513224422.GX9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:52:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLYf-0001pY-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbaEMWwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:52:23 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:39421 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbaEMWwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:52:21 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so1373265veb.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vwr79ePI5niLQpwfq7cmOCCDw171Ce/I6b6bPA30S64=;
        b=lYTX8JlqqgR4L9379ZVZnErAVX/SpCECwxnBESMkR7JHfmWT/ESoeIonwb/Stj+U0c
         IdwAMPSps8R5e0mIhhOu1hJQ5hCuY8Iz+gEc356fI+KXTT+zezVGHbV5igvV3KS/f5Pm
         67TsmseMlg1HSWmyEcDY9sFrxsyi6dxajjIDoiT2WPLQdkGbsVGVoRA1gROHlGpmgoNI
         4tNHh1esNcqcFvkSmjpcuT0cnCOOVDRST52MdqwUaTFajVQJ1wkaTjdXG4MnqbKIqO5m
         3vd9alNOM0T1I54sdE9Ct801dnOrAbEaQ43cRFNP5Gp5LfmY79tJhm5rwSgFgPi/m1pU
         kyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Vwr79ePI5niLQpwfq7cmOCCDw171Ce/I6b6bPA30S64=;
        b=KvAVe/VEuzNXk5WZvuDsSgJvX+KwYf52skGMkeMqg2DZMdV2BXOwXL2UQL7LfQRbjE
         sHLdZBd5+za1qwbV0U16Q679lUfaGdGns47SYb/lMP8VSuXAWGDaxmOlWo5Fh5ws/8wz
         vYPpMM4t/gqAcF6r8oFm7jbGJlveRBtvD6HAnQogCHz5geeyiIuJI5Fv/Xe96HV6HhSa
         LjeEOhtTc+g7NSEoABAT9za+GW5Etp/BziC8glf5nijyazI4hWP35ZUn5ieOKwx+ht4i
         rpBfEOLtnENH85Zfkhh6oc0lfh1xJZvbiuq+KB2OQXClGFT3TyghyPFRHiC0ejHYaVeO
         hu5w==
X-Gm-Message-State: ALoCoQnAGyCPOvLTn0E3j93X6vSN3dow/C9cPOyFjPveeUcofyrM5LzJy+D69rCDhvtgil/oJlHc
X-Received: by 10.221.26.10 with SMTP id rk10mr31572892vcb.0.1400021540488;
 Tue, 13 May 2014 15:52:20 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 13 May 2014 15:52:20 -0700 (PDT)
In-Reply-To: <20140513224422.GX9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248880>

On Tue, May 13, 2014 at 3:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Allow ref_transaction_free to be called with NULL and in extension allow
>> ref_transaction_rollback to be called for a NULL transaction.
>
> In extension = as a result?
>
> Makes sense.  It lets someone do the usual
>
>         struct ref_transaction *transaction;
>         int ret = 0;
>
>         if (something_fails()) {
>                 ret = -1;
>                 goto cleanup;
>         }
>         ...
>
>  cleanup:
>         ref_transaction_free(transaction);
>         return ret;
>
> just like you can already do with free().
>
>> This allows us to write code that will
>>
>>   if ( (!transaction ||
>>         ref_transaction_update(...))  ||
>>       (ref_transaction_commit(...) && !(transaction = NULL)) {
>>           ref_transaction_rollback(transaction);
>>           ...
>>   }
>
> Somewhere in the whitespace and parentheses I'm lost.
>
> Is the idea that when ref_transaction_commit fails it will have
> freed the transaction so we need not to roll back to prevent a
> double free?

Yes. But also, this horribleness is also to illustrate a weak point in the API
in that ref_transaction_commit actually frees the transaction if
successful, so the
&& !(transaction = NULL) kludge is to avoid a double free in the
ref_transaction_rollback.

This is horrible,  but all this is going away later in the patch
series when _commit is fixed so that
it does not free the transaction anymore.
When that patch comes in later in this series, this horribleness will go away.


 I think it would be simpler for the caller to
> unconditionally set transaction to NULL after calling
> ref_transaction_commit in such a case to avoid use-after-free.

Yes. Later patches does that by having ref_transaction_commit not free
the transaction
and instead requiring the caller to explicitely free it by calling
ref_transaction_free.


Maybe see this as this is how ugly rollback is by the current _commit
semantics. Then see how beautiful it
all gets once _commit is repaired and the  && !(transaction = NULL)
kludge is removed. :-)


>
> Even better if it is the caller's responsibility to free
> the transaction.  At any rate, it doesn't seem related to this
> patch.
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3303,6 +3303,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
>>  {
>>       int i;
>>
>> +     if (!transaction)
>> +             return;
>
> Except for the unclear commit message,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
