From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 09/42] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Thu, 15 May 2014 09:23:45 -0700
Message-ID: <CAL=YDWn5+_jA55KGx74We=41ngxSDA6yKJbuZ=3zy8gZTYPYnQ@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-10-git-send-email-sahlberg@google.com>
	<20140515000409.GF9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyRi-00065M-RD
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbaEOQXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:23:47 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56782 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbaEOQXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:23:46 -0400
Received: by mail-vc0-f174.google.com with SMTP id lh14so4646557vcb.19
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p/Dmkq4awZofxKBh4Z3bW8dTlwcPL3Brhficnx87M/g=;
        b=HzAMqLN4nVSr2oyUvCW3qKJjh0kFQ38Vhw2behGj8kw7k9yi0tEgTyqwvIi8bFX9Ad
         iScTbavmumGslk1bvjSPR3xGeIFJ+HaLr56W4feDKWG+5g6rvz5SHReIW53py9rXbSgH
         aW0W3FDi69FgZnNljQZMo/Tp12HE7PFzh1gNz6KO2xF3zBaU+dBTuSWYNIHEidlCznpm
         ryMJwUet3h2d66K/rfQJyHaDYIiyzZ42IYwXqhGi45S6lp2y20SzQ3o/g3CIvWnO1ck4
         5RAFbc0Ln7RpfmqJQyDRWBFHIMHM93NU4c1iF1LCFddhL92GuP/Fl4zyjZiYmBE3h4hu
         nQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p/Dmkq4awZofxKBh4Z3bW8dTlwcPL3Brhficnx87M/g=;
        b=PJXVrqkBiuX1DB3Bd3UUlY1ebZwsLBePtgpVGKCrUmsrPrkhDwOM8wwTVv0JsUNV4q
         11OGTD1ucnoFHmIrwDC20FNdBRJX9Nj+xxm8zJNM5RMEBgEP9uWd1H1g9QwyVwMZqXuT
         YxwVifbmDEWdFGBikoh1QHeF4wO2nNw7C89qBZ2FbDNqwM5PNCx652m2TJqbCwKflz4u
         a5XjweM/LqDOCm90D9a+90n6B490RwVjttmEfyC6EYx0HEB7R3DpcqKjNom+kwNQSBXm
         HQR4GzPBxuwEumVCG9eo8RHkSnd1mCiXKcVzoQOUPCIlaq1XrcQIZMZKbLsfn+mFdJNi
         naPg==
X-Gm-Message-State: ALoCoQmVDxFdQRhMT1hw40o+8tczbnQOt4vaaaL7feAbnNree2aG7nH98K6rd0FoFZGkEN/V9Kp2
X-Received: by 10.52.228.134 with SMTP id si6mr7770369vdc.5.1400171025294;
 Thu, 15 May 2014 09:23:45 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:23:45 -0700 (PDT)
In-Reply-To: <20140515000409.GF9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249108>

On Wed, May 14, 2014 at 5:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Do basic error checking in ref_transaction_create() and make it return
>> status. Update all callers to check the result of ref_transaction_create()
>> There are currently no conditions in _create that will return error but there
>> will be in the future.
>
> Same concerns as with _update:

Done.

>
> [...]
>> +++ b/builtin/update-ref.c
>> @@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>>       if (*next != line_termination)
>>               die("create %s: extra input: %s", refname, next);
>>
>> -     ref_transaction_create(transaction, refname, new_sha1, update_flags);
>> +     if (ref_transaction_create(transaction, refname, new_sha1,
>> +                                update_flags))
>> +             die("failed transaction create for %s", refname);
>
> If it were ever triggered, the message
>
>         error: some bad thing
>         fatal: failed transaction create for refs/heads/master
>
> looks overly verbose and unclear.  Something like
>
>         fatal: cannot create ref refs/heads/master: some bad thing

I changed it to :
   die("cannot create ref '%s'", refname);

But it would still mean you would have
         error: some bad thing
         fatal: cannot create 'refs/heads/master'


To make it better we have to wait until the end of the second patch
series, ref-transactions-next
where we will have an err argument to _update/_create/_delete too and
thus we can do this from update-ref.c :

   if (transaction_create_sha1(transaction, refname, new_sha1,
       update_flags, msg, &err))
   die("%s", err.buf);


>
> might work better.  It's hard to tell without an example in mind.
>
> [...]
>> @@ -3353,18 +3353,23 @@ void ref_transaction_create(struct ref_transaction *transaction,
> [...]
>> -     assert(!is_null_sha1(new_sha1));
>> +     if (!new_sha1 || is_null_sha1(new_sha1))
>> +             die("create ref with null new_sha1");
>
> One less 'assert' is nice. :)
>
> As with _update, the message should start with "BUG:" to make it clear
> to users and translators that this should never happen, even with
> malformed user input.  That gets corrected in patch 28 but it's
> clearer to include it from the start.
