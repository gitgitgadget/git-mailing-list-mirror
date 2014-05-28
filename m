From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 28 May 2014 10:15:22 -0700
Message-ID: <CAL=YDWnZQajozAcjLi85xKgkRazScv0Q_5XoVvV47u7AumL2gg@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-14-git-send-email-sahlberg@google.com>
	<20140528004200.GK12314@google.com>
	<CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
	<20140528170700.GM12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphRt-0005Su-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbaE1RP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:15:26 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:53420 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbaE1RPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:15:23 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so12845306vcb.1
        for <git@vger.kernel.org>; Wed, 28 May 2014 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I8hCfIhiRfDnmIw6kZEkeR8Bp9tjfaLjl1QOcJejXXU=;
        b=Wq3csO3dj77fKjBmsY5MtA88ye15/hqGFrsy2Z4NlXg1M0n8Zm49bvXBDFKWf2q6WY
         Yj4oXfUIlrhjPwgTsY3zFAxXU1jUh5crDeRlZuXqR3uGAsGikl/5/Kp0wjOo1AmEDl/d
         r72rd6/ogKwNl/E0J42mNO38OY7d1+ybG0+20q9P7HE9uU66FY1m90ACfD96kJrhC+dz
         ZpRCU2Loh3gIKoMgmFg+q9pXawDYltpOtqMkqiiqAun5BZpGVs4TiGj3ujz9AZ6CksnB
         d98zYngVSWEG9tf+vvxErUOZyLSRWoOJhU/uDcEpRnoP+Q3ZMrdR4dgZs8XAxdsB1X37
         5Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I8hCfIhiRfDnmIw6kZEkeR8Bp9tjfaLjl1QOcJejXXU=;
        b=IEjp6+OPWp/A4teUZ9kTPGPPFN2opC55NtXIvUsTF/Btd9kx2Z6sT7xuy+lo9Mdg6h
         37ybE6nuz7hfZv6ptQBYstgrCMZ67MBVFwRaWj2YQi+oV7zwXotCQrt2p9nCPc6A6sUt
         yaxYQwZLkKaFBUDhdSMCVpo9VacoEsPYR1lvNv6H+yELl22t3y9BtYSx1+P65d6dJNi5
         ixmoIEEOdzIaBLEhK92Ex4wcVulzWkH1x+zIJw/0CHaCZLnh6Xd7q8lrUTIwlNHZ+/8F
         Q2ZJFEEw0TrpHKp3LAJlGk86zJHPpSV27q+evBxRXzZvKG8HqJHgwpba8nvey85HPboA
         JIzQ==
X-Gm-Message-State: ALoCoQm63tIJVChDnLGkbfExIC1UyOygjUixnlocv6oRgoNm5y2MIvvR4miwYwPo/Z8iOtcNDi8J
X-Received: by 10.58.66.195 with SMTP id h3mr1058590vet.57.1401297322186; Wed,
 28 May 2014 10:15:22 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 10:15:22 -0700 (PDT)
In-Reply-To: <20140528170700.GM12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250298>

On Wed, May 28, 2014 at 10:07 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Updated the comment in refs.h
>
> Thanks.
>
>> +++ b/refs.h
>> @@ -215,6 +215,31 @@ enum action_on_err {
>>  };
>>
>>  /*
>> + * On error, transaction functions append a message about what
>> + * went wrong to the 'err' argument.  The message mentions what
>> + * ref was being updated (if any) when the error occurred so it
>> + * can be passed to 'die' or 'error' as-is:
>> + *
>> + *     if (ref_transaction_update(..., &err)) {
>> + *         ret = error("%s", err.buf);
>> + *         goto cleanup;
>> + *     }
>> + *
>> + * The message is appended to err without first clearing err.
>> + * This allow shte caller to prepare preamble text to the generated
>
> s/allow shte/allows the/
>
>> + * error message:
>> + *
>> + *     strbuf_addf(&err, "Error while doing foo-bar: ");
>> + *     if (ref_transaction_update(..., &err)) {
>> + *         ret = error("%s", err.buf);
>> + *         goto cleanup;
>> + *     }
>
> Nice.
>
>> + *
>> + * If the caller wants err to only contain the message for the current error
>> + * and nothing else caller will need to guarantee that err is empty or
>> + * call strbuf_reset before calling the transaction function.
>
> I don't think this paragraph is needed --- especially with the
> clarification about how to add a preamble, the contract is clear.
>
>> + */
>> +/*
>>   * Begin a reference transaction.  The reference transaction must
>>   * be freed by calling ref_transaction_free().
>>   */
>
> Now that the comment is longer, it's harder to miss, but it still is
> in an odd place for someone looking to understand what the 'err'
> argument to ref_transaction_update() means.
>
> How about this patch for squashing in?
>
> diff --git i/refs.h w/refs.h
> index c741a6c..913ca93 100644
> --- i/refs.h
> +++ w/refs.h
> @@ -10,6 +10,45 @@ struct ref_lock {
>         int force_write;
>  };
>
> +/*
> + * A ref_transaction represents a collection of ref updates
> + * that should succeed or fail together.
> + *
> + * Calling sequence
> + * ----------------
> + * - Allocate and initialize a `struct ref_transaction` by calling
> + *   `ref_transaction_begin()`.
> + *
> + * - List intended ref updates by calling functions like
> + *   `ref_transaction_update()` and `ref_transaction_create()`.
> + *
> + * - Call `ref_transaction_commit()` to execute the transaction.
> + *   If this succeeds, the ref updates will have taken place and
> + *   the transaction cannot be rolled back.
> + *
> + * - At any time call `ref_transaction_free()` to discard the
> + *   transaction and free associated resources.  In particular,
> + *   this rolls back the transaction if it has not been
> + *   successfully committed.
> + *
> + * Error handling
> + * --------------
> + *
> + * On error, transaction functions append a message about what
> + * went wrong to the 'err' argument.  The message mentions what
> + * ref was being updated (if any) when the error occurred so it
> + * can be passed to 'die' or 'error' as-is.
> + *
> + * The message is appended to err without first clearing err.
> + * This allows the caller to prepare preamble text to the generated
> + * error message:
> + *
> + *     strbuf_addf(&err, "Error while doing foo-bar: ");
> + *     if (ref_transaction_update(..., &err)) {
> + *         ret = error("%s", err.buf);
> + *         goto cleanup;
> + *     }
> + */
>  struct ref_transaction;
>
>  /*
> @@ -215,31 +254,6 @@ enum action_on_err {
>  };
>
>  /*
> - * On error, transaction functions append a message about what
> - * went wrong to the 'err' argument.  The message mentions what
> - * ref was being updated (if any) when the error occurred so it
> - * can be passed to 'die' or 'error' as-is:
> - *
> - *     if (ref_transaction_update(..., &err)) {
> - *         ret = error("%s", err.buf);
> - *         goto cleanup;
> - *     }
> - *
> - * The message is appended to err without first clearing err.
> - * This allow shte caller to prepare preamble text to the generated
> - * error message:
> - *
> - *     strbuf_addf(&err, "Error while doing foo-bar: ");
> - *     if (ref_transaction_update(..., &err)) {
> - *         ret = error("%s", err.buf);
> - *         goto cleanup;
> - *     }
> - *
> - * If the caller wants err to only contain the message for the current error
> - * and nothing else caller will need to guarantee that err is empty or
> - * call strbuf_reset before calling the transaction function.
> - */
> -/*
>   * Begin a reference transaction.  The reference transaction must
>   * be freed by calling ref_transaction_free().
>   */

Done.
Please re-review.
