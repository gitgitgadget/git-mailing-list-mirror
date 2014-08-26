From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 19/23] refs-be-files.c: add a backend method structure
 with transaction functions
Date: Tue, 26 Aug 2014 15:34:19 -0700
Message-ID: <CAL=YDWkfZV0CQRRQM_GxZ0+cuxTdFyH=u-sXLGab5kLtVf5fhQ@mail.gmail.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
	<1408465847-30384-20-git-send-email-sahlberg@google.com>
	<xmqq8umbgcd9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMPJo-0002A1-QP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 00:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbaHZWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 18:34:21 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:65338 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbaHZWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 18:34:20 -0400
Received: by mail-yk0-f171.google.com with SMTP id 19so12024432ykq.16
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2NFbQeLjMarAPtagm9LRKd6whUwTAALL4LQlMvRWNbs=;
        b=UQOVyWF6F+MlRd3u2EUhCADGTB03xBnW9teWvlo4mOK4GTT9e+yFcNodBDinhdZyRk
         z7w32kSDbWRj/51uysXxGc4prvmN7DK0nCvwDroomYncN5IYAYgjXvyEGatupKyLxk0r
         k5iov065dqaLRJ9lu1bfY50rECXGTKkpF178uwfCI6zbdqkpAaZ9H2C9artFvF4TIJ/+
         i2B/CkrcJZzRlpIQmKa504iGD5LTMbc2b7c/grA98xayCazPhZvwlHeU0TPCv5DQ2vsn
         AswEi/fHbyIBa68EhkyY+WlUUYtH4gf+qzAJZYg6ghK3XDeAgVevi+0+SL1CwU8v5rAv
         etjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2NFbQeLjMarAPtagm9LRKd6whUwTAALL4LQlMvRWNbs=;
        b=fE13UTuUFenINAcWJpod5HE/Oi+EeZEGcznUhPJqIBAsNs6NtO2jCy69/eQy+WQhl2
         LQG+lvJaqEYmHdcGLsp20AnuQCe7Mw0RuaywfP2zxdqzxWdZKSwFgWBJmMcN/ZvQCEGe
         sgRsXpJawYRqYPVYAyV0/zByO/L/4xRRxXjQczWAUUYvNKoGhRm8GVAVmfQMRFJMVymP
         UHdG83f2xgeUbEY/lzgxJSNNluEaCUrY1Q0khlUlUzI1xAw70igzZgcvB4DEsmP1jvE2
         BYMziM3T/u7KEcxjzawyeZyLXy8IU6K5KQZ0ldArJLzzk/4H9XqGTDQzl77RHw8RtH7s
         sbsA==
X-Gm-Message-State: ALoCoQnp74vTlWcWYfp5FdyKLQ0yH1L/JHucF1IKU+Y+JsLz6+oaRNeySH3rPdPgFqI7JqduskUV
X-Received: by 10.52.190.71 with SMTP id go7mr12179522vdc.28.1409092459582;
 Tue, 26 Aug 2014 15:34:19 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Tue, 26 Aug 2014 15:34:19 -0700 (PDT)
In-Reply-To: <xmqq8umbgcd9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255953>

On Tue, Aug 26, 2014 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> diff --git a/refs-be-files.c b/refs-be-files.c
>> index e58a7e1..27eafd0 100644
>> --- a/refs-be-files.c
>> +++ b/refs-be-files.c
>> ...
>> +struct ref_be refs_files = {
>> +     files_transaction_begin,
>> +     files_transaction_update_sha1,
>> +     files_transaction_create_sha1,
>> +     files_transaction_delete_sha1,
>> +     files_transaction_update_reflog,
>> +     files_transaction_commit,
>> +     files_transaction_free,
>> +};
>> +
>> +struct ref_be *refs = &refs_files;
>
>> diff --git a/refs.c b/refs.c
>> index 6b434ad..b8c942f 100644
>> --- a/refs.c
>> +++ b/refs.c
>> ...
>> +void transaction_free(struct ref_transaction *transaction)
>> +{
>> +     return refs->transaction_free(transaction);
>> +}
>> diff --git a/refs.h b/refs.h
>> index a14fc5d..4b669f5 100644
>> --- a/refs.h
>> +++ b/refs.h
>> ...
>> +struct ref_be {
>> +     transaction_begin_fn transaction_begin;
>> +     transaction_update_sha1_fn transaction_update_sha1;
>> +     transaction_create_sha1_fn transaction_create_sha1;
>> +     transaction_delete_sha1_fn transaction_delete_sha1;
>> +     transaction_update_reflog_fn transaction_update_reflog;
>> +     transaction_commit_fn transaction_commit;
>> +     transaction_free_fn transaction_free;
>> +};
>> +
>> +extern struct ref_be *refs;
>> +
>>  #endif /* REFS_H */
>
> The overall structure is certainly nice, but this means you only can
> LINK with one backend.  Is that what we really want?
>
> I would have expected something like this:
>
>   * In refs.c, there is a "static struct ref_be *the_refs_backend"
>     that points at the chosen singleton backend;

Done.
It is also initialized to default to the files backend :
refs.c:

  /* We always have a files backend and it is the default */
  struct ref_be *the_refs_backend = &refs_be_files;


This does make "refs_be_files" and later "refs_be_db" public symbols instead of
the singleton. But we probably want/need these structures to be public anyway
if we at some stage want to be able to switch between backends at runtime.
refs.h:

   extern struct ref_be refs_be_files;
   void set_refs_backend(struct ref_be *ref_be);

Thus allowing us to
   set_refs_backend(&refs_be_files) to switch back to the files backend.




>
>   * Upon start-up, set_refs_backend() function that is exported from
>     refs.c can be used to set the_refs_backend;
>
>   * Each refs-be-frotz.c will export "struct ref_be refs_frotz" (or
>     perhaps "struct refs_be refs_be_frotz") to the outside world, so
>     that the start-up code can call set_refs_backend() with it.

Yepp.
refs-be-db.c: does this.

>
>   * It is probably sensible to keep the_refs_backend default to
>     &refs_be_files.
>

Yepp.

https://github.com/rsahlberg/git/tree/backend-struct-db
https://github.com/rsahlberg/git/tree/backend-struct-db-2 (adds a db
backend and daemon)


Thanks. Good suggestions.
