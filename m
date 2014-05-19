From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 13/44] tag.c: use ref transactions when doing updates
Date: Mon, 19 May 2014 10:16:00 -0700
Message-ID: <CAL=YDWmZEQMWV1wF_ztBMszznUX-a1Q4YTo_w+ui7c_xuNPDWw@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-14-git-send-email-sahlberg@google.com>
	<53775F77.2070004@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 19:16:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRAX-00084v-IB
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbaESRQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:16:04 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:35743 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaESRQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:16:01 -0400
Received: by mail-vc0-f179.google.com with SMTP id im17so9792131vcb.24
        for <git@vger.kernel.org>; Mon, 19 May 2014 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bRK+RODEaIjFNnVVWeibZAYsw6JZJW03BYVxfp/SLlE=;
        b=CFaKWtl9Rumyd7ro23UXlino/auYjFqvQA8oo9y7Ead7dAnTSk4kKOqUIeVorkC2ly
         KvBEwjVEN31hur1tnSp1zVPqfKAfYbHih9YYSEeiZFRJOw9EOdgbLkBS/accpPiUS5EE
         KoNqcXWW3O6dml6pqMROr9MohTb0xrpd41P2k+xJQaEsJ9n7sPO0wG6+f2GiO5NrQVQg
         8spi2ySG3U+ohvsroyKQxggxKsXGXIaPU9yAwCxDES639XGT0n006s1m3CJyNzIPSb7z
         XVVCUPUppVSWdWsF0cAkj+TW549JuQ2tFGjjNNwiwXx636qNOo5RFaFlDmLgX/7m7IJz
         VqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bRK+RODEaIjFNnVVWeibZAYsw6JZJW03BYVxfp/SLlE=;
        b=PK+a53lVxGrEn27hYV1h0hsm9cwC3oP7TBwGs5dloEJidZr33RqC0P47Wc+l8+HmGb
         AO9ikdLaOWjGjUkvAq/yRfFRI6Uh0Z8FNEuqOIEMmECBK3M9+d4T1ZLy5pQm+gcP4w5o
         SS0rXdusghd6Xg2oBtg45Djcj545bDxJaka/ZLPmyqLDkoHu67s8KV5VyLhhL+qOg9Ii
         VEu4DO3zTPY2mJQJutIAFJOxx8KK3SFT+hd0mXKhBksCMHr0Ox/e+foRUdCpBjiVDS0m
         B6mq5hoazrkhFGFx0wAlf24DMUE7dw5zH58//RYnKTMDIVgpl5B93DiZ5bokFRExLDNf
         SBQQ==
X-Gm-Message-State: ALoCoQly3X36rJGApXhyV2WPvBj+itPQALU+QON66yqfZ0YXVKJ74ylXMdsSLKf0S/HEx+RroFqo
X-Received: by 10.220.116.136 with SMTP id m8mr71000vcq.77.1400519760549; Mon,
 19 May 2014 10:16:00 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 10:16:00 -0700 (PDT)
In-Reply-To: <53775F77.2070004@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249603>

On Sat, May 17, 2014 at 6:09 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> Change tag.c to use ref transactions for all ref updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/tag.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index c6e8a71..b05f9a5 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       struct strbuf ref = STRBUF_INIT;
>>       unsigned char object[20], prev[20];
>>       const char *object_ref, *tag;
>> -     struct ref_lock *lock;
>>       struct create_tag_options opt;
>>       char *cleanup_arg = NULL;
>>       int annotate = 0, force = 0, lines = -1;
>> @@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       const char *msgfile = NULL, *keyid = NULL;
>>       struct msg_arg msg = { 0, STRBUF_INIT };
>>       struct commit_list *with_commit = NULL;
>> +     struct ref_transaction *transaction;
>> +     struct strbuf err = STRBUF_INIT;
>>       struct option options[] = {
>>               OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>>               { OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
>> @@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       if (annotate)
>>               create_tag(object, tag, &buf, &opt, prev, object);
>>
>> -     lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
>> -     if (!lock)
>> -             die(_("%s: cannot lock the ref"), ref.buf);
>> -     if (write_ref_sha1(lock, object, NULL) < 0)
>> -             die(_("%s: cannot update the ref"), ref.buf);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref.buf, object, prev,
>> +                                0, !is_null_sha1(prev), &err) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die("%s", err.buf);
>
> If ref_transaction_begin() fails, then won't err still be empty?  (I
> know it can't happen, and you know it can't happen, but should the
> caller have to know that?)  It almost seems like ref_transaction_begin()
> should have an err parameter, too.

I add an err argument in the next series. I would prefer we let that
patch remain in the next series to
avoid unbounded growth of the current one.

Ok ?



>
> It's kindof late for this question to pop into my head, but: have you
> thought about embedding the err strbuf in the transaction object?  I
> admit it would make the problem with ref_transaction_begin() even worse,
> but maybe it would be a net win in terms of boilerplate?

I think it is more flexible to allow the caller to manage the lifetime
of the error buffer independently of the transaction.
It would allow a caller to free the transaction early but delay
printing the error message until later.

Or it could be used for a multi transaction caller to use a single err
buffer for all transactions and finally print
all errors in a single error() call at the end.

struct strbuf err = STRBUF_INIT;
... first transaction (... &err)...
... second transaction (... &err)...
... third transaction (... &err)...
error("%s", err.buf);



Similar to how rsync handles errors:
sahlberg@sahlberg1:~$ mkdir foo
sahlberg@sahlberg1:~$ touch foo/foo.1
sahlberg@sahlberg1:~$ touch foo/foo.2
sahlberg@sahlberg1:~$ mkdir bar
sahlberg@sahlberg1:~$ chmod 0500 bar
sahlberg@sahlberg1:~$ rsync -Pav foo/* bar
sending incremental file list
foo.1
           0 100%    0.00kB/s    0:00:00 (xfer#1, to-check=1/2)
foo.2
           0 100%    0.00kB/s    0:00:00 (xfer#2, to-check=0/2)
rsync: mkstemp "/usr/local/google/home/sahlberg/bar/.foo.1.K7dFIP"
failed: Permission denied (13)
rsync: mkstemp "/usr/local/google/home/sahlberg/bar/.foo.2.4WdRsW"
failed: Permission denied (13)

sent 136 bytes  received 50 bytes  372.00 bytes/sec
total size is 0  speedup is 0.00
rsync error: some files/attrs were not transferred (see previous
errors) (code 23) at main.c(1070) [sender=3.0.9]



>
>>       if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>>               printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>>
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
