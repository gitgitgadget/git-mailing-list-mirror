From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 07/11] commit.c: use ref transactions for updates
Date: Mon, 21 Apr 2014 11:45:06 -0700
Message-ID: <CAL=YDW=5Xf4rq11uxA67zbrK0gGPFhs24SL0NCnny3UObtZAfw@mail.gmail.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
	<1397763987-4453-8-git-send-email-sahlberg@google.com>
	<5352CD14.4060808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJDO-0002aw-1r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 20:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbaDUSpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 14:45:09 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:54000 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbaDUSpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 14:45:07 -0400
Received: by mail-vc0-f175.google.com with SMTP id lh14so1381578vcb.20
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=72ObvUEhoGoWb4HtN5IGBaeC7yBxYSydKQGhYovj+w4=;
        b=nXNlkDF1JCOnGpsx2/wwt/4G+25DPQQfLe42UK1Rkt+RbMwM2kpnPxAzdcr2u4SD56
         SRRoF5+wODG7uZSlDPatEuYaEEOKXp/3WavuoZXskt9r//F4p10EWMHpev+UttnBfHvw
         yRtAtJoE5Bq9Qyv3+A4NLeuDPuJXniQ5BD+RyxWkr2ZkTcTVDg++7P2dlkQTIKV4RHiF
         qQIXctTAeaQDpDYgIkt3IrylvjQ0ApUJXh7tKdSEkUU0BfBiv87yQmDFGDUgLHHo8hZZ
         V+2j3UsvpX4jg17GPTCKo/PT9rxUD1Rj5RSHfOPnH/drLB4kgEE9tasSNLRAg8nux0QY
         uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=72ObvUEhoGoWb4HtN5IGBaeC7yBxYSydKQGhYovj+w4=;
        b=KzOhQOKDFX+bEy37mtom6p41nEU1j5Mc2XjHiFHBLPfNCQn/EqE7NyMa87hW5uT0H7
         9dKCQnl4m+LDL+B7oW93jDVX7Rc+Pfry3oHryrziWaT/RK6dkPye6raep/c0RH0IoGvR
         FLP/NyBlb9vGsd9gljOBvYp4c/MEju3SKOK+b4IE40WYZrhyco1rFNaIx7qk1nHoBZse
         ojT0krGYWzh/VdaS2XITs9+7MiI/jSF0wRdJtP42vVkCsi21seYnY3E03bKWfW4yhnz+
         f6W524jY/kidGr1gpKanAy3wFssP2r+OhjocnbQrzaeXdlsM4kyrYgbXN1AHsG+jKuqt
         3PJg==
X-Gm-Message-State: ALoCoQkGxGSVook2DGITTF0NeZJc8j+3X/P5e6bf5Kc8J3CD9CcMNUvJrYuTvGnTjPxI/zlUxAPVNAft8HterhVkUCsICdZpAXDxEgFu/9aXIYFN6QLXaMI3NAjONQPTdSJHFvZRQUVW0jP2OCXOY7QeYppFnktNEOpcSeztwIV5mviwsm7mC7EMrikSv95yS2G5T54Bk95X
X-Received: by 10.52.116.101 with SMTP id jv5mr12692322vdb.11.1398105906201;
 Mon, 21 Apr 2014 11:45:06 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 21 Apr 2014 11:45:06 -0700 (PDT)
In-Reply-To: <5352CD14.4060808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246618>

On Sat, Apr 19, 2014 at 12:23 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
>> Change commit.c to use ref transactions for all ref updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/commit.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index d9550c5..b8e4389 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1541,11 +1541,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       const char *index_file, *reflog_msg;
>>       char *nl;
>>       unsigned char sha1[20];
>> -     struct ref_lock *ref_lock;
>>       struct commit_list *parents = NULL, **pptr = &parents;
>>       struct stat statbuf;
>>       struct commit *current_head = NULL;
>>       struct commit_extra_header *extra = NULL;
>> +     struct ref_transaction *transaction;
>>
>>       if (argc == 2 && !strcmp(argv[1], "-h"))
>>               usage_with_options(builtin_commit_usage, builtin_commit_options);
>> @@ -1667,12 +1667,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       strbuf_release(&author_ident);
>>       free_commit_extra_headers(extra);
>>
>> -     ref_lock = lock_any_ref_for_update("HEAD",
>> -                                        !current_head
>> -                                        ? NULL
>> -                                        : current_head->object.sha1,
>> -                                        0, NULL);
>
> The old version, above, contemplates that current_head might be NULL...
>
>> -
>>       nl = strchr(sb.buf, '\n');
>>       if (nl)
>>               strbuf_setlen(&sb, nl + 1 - sb.buf);
>> @@ -1681,14 +1675,22 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>>       strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>>
>> -     if (!ref_lock) {
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction) {
>>               rollback_index_files();
>> -             die(_("cannot lock HEAD ref"));
>> +             die(_("HEAD: cannot start transaction"));
>>       }
>> -     if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
>> +     if (ref_transaction_update(transaction, "HEAD", sha1,
>> +                                current_head->object.sha1,
>> +                                0, !!current_head)) {
>
> ...but here you dereference current_head without checking it first.
>
> It upsets me that the test suite didn't catch this NULL pointer
> dereference.  Either
>
> 1. current_head cannot in fact be NULL, in which case the commit message
> should explain that fact and the code should be simplified
>
> or
>
> 2. the test suite is incomplete.  If so, it would be great if you would
> add a test that exercises this branch of the code (and catches your
> error), and then fix the error.



Current_head can in fact be NULL here but we never actually
dereference any pointer in this case since !!current_head is 0.


current_head->object.sha1 just computes current_head +
offsetof(commit, object) + offsetof(object, sha1)
so we compute and pass a non-NULL garbage pointer into ref_transaction_update()

But since !!current_head is 0 this mean we never actually dereference
this pointer.
Way to subtle for its own good.


I will change ref_transaction_update and friends to use an additional
test to detect some subset of this kind of bug :

if (!have_old && old_sha1)
   die("have_old is false but old_sha1 is not NULL");

regards
ronnie sahlberg
