From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 02/44] refs.c: allow passing NULL to ref_transaction_free
Date: Thu, 15 May 2014 11:26:10 -0700
Message-ID: <CAL=YDW=5BjCkZ9A-En+mG9CcshC0tCP4j4ZWKSWK5NEfykWy8Q@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-3-git-send-email-sahlberg@google.com>
	<20140515181512.GC26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0MG-00019E-5p
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbaEOS0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:26:14 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:58777 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbaEOS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:26:11 -0400
Received: by mail-ve0-f176.google.com with SMTP id jz11so1789295veb.21
        for <git@vger.kernel.org>; Thu, 15 May 2014 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VFhdCmMxBJ+pkC531jruIZEuhjg9LK2uckUnxxK6KCg=;
        b=PpsWrxNUYASIsrNwR6uwRoYqE6xwwSwSldv/WNoTwRMh48MT7TkpUkBPDPX/tzaD9v
         C4J+5TsKwuS+2nd+Vq/fkDdKwCFY6pd+ULR7bXsvxL2yQJ33EiWgB3J9RHTTGeY4jKl9
         nm9J5kh9RDMsDKSTg8KLsptXyKWSKjZ/4O4+LnwhSh3elbIthRmgb852uQneubH99NeS
         dQt77kkEEKp7dwP75QdauKqrTG/27qYVPNm9BTbHJRGypy5mIIjHIubeh7qQec+aibO6
         674T1va7nqsSnzOn2IZlqpSYCOHfQpOogPkeQGenvF+ZoEiOCzZxnEg+NFH0N148Rt2m
         w40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VFhdCmMxBJ+pkC531jruIZEuhjg9LK2uckUnxxK6KCg=;
        b=DwefdIrS95vcUtSDkw5cSf3jPyLCKSfQw87DGt8utM5FJyPu/sGuIUeMzBu6NgtKho
         lgH9tevpgQc0bsgmaJ6fudjVA4dLheZe361HGDHzFZsEvH/1NfKeHYvh9txgE/xOrDIX
         qojZj1pVIOGLnb9j4RkBSk7aUmYMpAgalfQck6KX1Hud1qnRBCBiNa2xCe02CRjxbola
         x6MPYs5Cd7ZfXOX4cD/z6JtGmwbQiloKhTBbM4nfJXaaBV45RnV12vGVxKlyYnHVs0LV
         5AASBSIYOSumUjtLzq2PqiAGqsTUAmt/AP5aomxoliCxo6+0ZUaD6WczfxFhciwzIEX5
         QiSw==
X-Gm-Message-State: ALoCoQkQ0bh82NG5EHid7rVTAkmfFXvPVp9LnP85/2JRLGrLiCdVUjx7a8z9NHwpqiLZqPV/CtEL
X-Received: by 10.58.161.101 with SMTP id xr5mr2133090veb.36.1400178371054;
 Thu, 15 May 2014 11:26:11 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 11:26:10 -0700 (PDT)
In-Reply-To: <20140515181512.GC26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249176>

Thanks.

I used your improved text in the commit message.

On Thu, May 15, 2014 at 11:15 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Allow ref_transaction_free to be called with NULL and as a result allow
>> ref_transaction_rollback to be called for a NULL transaction.
>>
>> This allows us to write code that will
>>   if ( (!transaction ||
>>         ref_transaction_update(...))  ||
>>       (ref_transaction_commit(...) && !(transaction = NULL)) {
>>           ref_transaction_rollback(transaction);
>>           ...
>>   }
>>
>> In this case transaction is reset to NULL IFF ref_transaction_commit() was
>> invoked and thus the rollback becomes ref_transaction_rollback(NULL) which
>> is safe. IF the conditional triggered prior to ref_transaction_commit()
>> then transaction is untouched and then ref_transaction_rollback(transaction)
>> will rollback the failed transaction.
>
> I still think these last two paragraphs confuse more than enlighten
> here.  There's plenty of time to explain them in the patch that uses
> that code.
>
> I'd just say something like
>
>         Allow ref_transaction_free(NULL) and hence ref_transaction_rollback(NULL)
>         as no-ops.
>
>         This makes ref_transaction_rollback easier to use and more similar to
>         plain 'free'.
>
> And maybe:
>
>         In particular, it lets us rollback unconditionally as part of cleanup
>         code after setting 'transaction = NULL' if a transaction has been
>         committed or rolled back already.
>
> Thanks,
> Jonathan
