From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 03/42] refs.c: add a strbuf argument to
 ref_transaction_commit for error logging
Date: Wed, 14 May 2014 08:20:48 -0700
Message-ID: <CAL=YDWmvqC-Yz-nM0DEQUi_FkBESVWMwEh7oNfUqtGRiNg1EPA@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-4-git-send-email-sahlberg@google.com>
	<20140513231012.GY9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkazH-0002bZ-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 17:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbaENPUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 11:20:50 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:50951 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbaENPUt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 11:20:49 -0400
Received: by mail-ve0-f182.google.com with SMTP id sa20so2556267veb.41
        for <git@vger.kernel.org>; Wed, 14 May 2014 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1ZPWLrziBA9i7fkLOWGf7Xa9CRSqDOeOMVI3EHj+jLo=;
        b=UdQvkvlfnAzclRIeFKaaxjNATOhFcJlG/s9hQAHNOk9vfoxpbq+19S+ofyDHZoAa48
         Y1Hd4neBWDDVkd9PJcyVDLFvAYh/WkGnT0/cynAASjfQZKfme7KysN0ep4oNYt+gzCa/
         J7ejf13p9BKBUy3qeMeO0yLxIq3htM8lVnwftO4O33p/zfIGUr0W/oyK4/421xptu/42
         /Hgewg+X2D7MkYGiink2XpsL05kZGwDkOMpHkEWI/4GLMfIOnQOHz7ooEAE8qYsJ+TDB
         bfx/YUjXt19/gP2SQoK+oVIQ8ZdKuncoMmXS2U5Hz+dridR3SY+bntX+3xCiJBTjDG1j
         PfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1ZPWLrziBA9i7fkLOWGf7Xa9CRSqDOeOMVI3EHj+jLo=;
        b=OiNedj7yZfgYoW55QnC4pUYonB95u405jj7DDx4mndDp25QLdkwjod1jw8zeWAZz8C
         YclE8WiBj6WQoKrGK32Z5LgAPBe04UsSOUgqRkoOVxovNMpJ4fSeCFM/F4fcAwo7ux/6
         ERfWdKqsW3Pj/UZp3BF41Xh7kMXQnPLW/U5NiZ0uOTMWqop2d5FcU+wzSWTyAB2LSLYE
         CVdy+OHbjgyW8hIX678r6kHYZkWSns/Fi7PG5Joe8pw925loT5JHe2AZxOqS0dcR9no6
         OaDNrKlVUKYro/MC4ElW8NGefmRtNV4OlpnhBJlSZ++QL2T2VBD4btLFApE9CFO4g2dg
         H2rw==
X-Gm-Message-State: ALoCoQmhH/x490F7zmaphbOP7i87Vyva6LarlDqkqRNXmjjAD7algq6Gbd9xgIMZVVOVJQ58J+P/
X-Received: by 10.52.37.135 with SMTP id y7mr1719454vdj.38.1400080849003; Wed,
 14 May 2014 08:20:49 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 14 May 2014 08:20:48 -0700 (PDT)
In-Reply-To: <20140513231012.GY9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248918>

Thanks.
Comment added and whitespace fixed.

On Tue, May 13, 2014 at 4:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Add a strbuf argument to _commit so that we can pass an error string back to
>> the caller. So that we can do error logging from the caller instead of from
>> _commit.
>>
>> Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
>> and craft any log messages from the callers themselves and finally remove the
>> onerr argument completely.
>
> Very nice.
>
> [...]
>> +++ b/refs.c
> [...]
>> @@ -3443,6 +3444,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                              update->flags,
>>                                              &update->type, onerr);
>>               if (!update->lock) {
>> +                     if (err)
>> +                             strbuf_addf(err ,"Cannot lock the ref '%s'.",
>> +                                         update->refname);
>
> Tiny nit: whitespace.
>
> [...]
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
>>   * Commit all of the changes that have been queued in transaction, as
>>   * atomically as possible.  Return a nonzero value if there is a
>>   * problem.  The ref_transaction is freed by this function.
>> + * If err is non-NULL we will add an error string to it to explain why
>> + * the transaction failed.
>
> Probably worth mentioning the error string doesn't end with a newline
> so the caller knows how to use it.
>
> With the whitespace fix and with or without the comment tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git i/refs.c w/refs.c
> index 64e8feb..2ca3169 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -3445,7 +3445,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>                                                &update->type, onerr);
>                 if (!update->lock) {
>                         if (err)
> -                               strbuf_addf(err ,"Cannot lock the ref '%s'.",
> +                               strbuf_addf(err, "Cannot lock the ref '%s'.",
>                                             update->refname);
>                         ret = 1;
>                         goto cleanup;
> diff --git i/refs.h w/refs.h
> index ff87e14..d45212f 100644
> --- i/refs.h
> +++ w/refs.h
> @@ -268,8 +268,8 @@ void ref_transaction_delete(struct ref_transaction *transaction,
>   * Commit all of the changes that have been queued in transaction, as
>   * atomically as possible.  Return a nonzero value if there is a
>   * problem.  The ref_transaction is freed by this function.
> - * If err is non-NULL we will add an error string to it to explain why
> - * the transaction failed.
> + * If err is non-NULL we will append an error string (with no trailing
> + * newline) to it to explain why the transaction failed.
>   */
>  int ref_transaction_commit(struct ref_transaction *transaction,
>                            const char *msg, struct strbuf *err,
