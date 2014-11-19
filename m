From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Tue, 18 Nov 2014 16:28:04 -0800
Message-ID: <CAGZ79kZgqRsiBFGZjmZtX3v37_DqNVqwwbhTmdHTYVGOv4=mbA@mail.gmail.com>
References: <1416350636-12934-1-git-send-email-sbeller@google.com>
	<20141118234500.GO6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 01:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqt81-000668-4R
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 01:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbaKSA2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 19:28:07 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39769 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbaKSA2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 19:28:06 -0500
Received: by mail-ie0-f172.google.com with SMTP id ar1so10571239iec.31
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 16:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2tbwlnTZSORj0dPE7N/By6H63q7pBRoksAu9Moc32U4=;
        b=Agwn0bT+ARDDfUJL9QrE8HtzmYU8H5Htdq7AlbfopSMrPVr5QrETXGJbSQQSgVhMqh
         r5sMP6WN4JpYB8tBpauY6BYFRV5PgWxjESRrDaAUt72/AkHRoTEVrrrAjFMwBUCO0RMu
         P7CegB0P1psdsILlse96JDqgoRLWvO6YHE7n6P9CugHUWqHIS+cPGphY5Yo1UtskJuX/
         SkMzTK+fFnAv7OTMEwAxqUvnIwP3gV0LW0aAjl6848VzhWbSbdgC4/Sb0bKb5hTpF/y9
         NjpOQognSIP9cLcXKVDQ3bQxB5n5RCGXh0vrnrEjCluhMVIY3Ewfd3cDOmQ0LR8aFadz
         7lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2tbwlnTZSORj0dPE7N/By6H63q7pBRoksAu9Moc32U4=;
        b=MPzS8m3kWfOX0/lryuY7JyBd78nVhCE23j8c3Iv7jPVKU2K40wTgYCmR9J5yMmPg7n
         hT7kYnPNh1no1Wurrno1CzABgOSq4qXZS2Osh65Mm0SVWtD4fpZyUabE8owbTbzZV6By
         1k1KLna9gn8YFG0b3TUMuTBLyiurByQrP3VzuRK0ozTPdH0ka1rREut1H1DPNDcAEydw
         /JpNANZU9lU06P4Al+v2+5QXC01fwLuGRfriWRKjxJOEEMVGdFs9JddJS+lWRtnHir0N
         XnruUoiodzIR3z/mErCUiEloalS9fD25h8mw2RZVOGtISlV2wyXdYw5XqCtGr7pJbSf9
         HeWw==
X-Gm-Message-State: ALoCoQnKofX76vDRvl/nIxNHG7lYGgw2qipr3athUxyJ4D2QEAp3QGNxgVPmgfTS0wWMfWlMO00V
X-Received: by 10.42.175.68 with SMTP id az4mr149711icb.92.1416356884502; Tue,
 18 Nov 2014 16:28:04 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Tue, 18 Nov 2014 16:28:04 -0800 (PST)
In-Reply-To: <20141118234500.GO6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 3:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> The above is a useful kind of comment to put below the three-dashes.  It
> doesn't explain what the intent behind the patch is, why I should want
> this patch when considering whether to upgrade git, or what is going to
> break when I consider reverting it as part of fixing something else, so
> it doesn't belong in the commit message.

Yes, I'll do a resend, removing this paragraph.

>
>> This patch doesn't intend any functional changes. It is just a refactoring,
>> which replaces a char** array by a stringlist in the function
>> repack_without_refs.
>
> Thanks.  Why, though?  Is it about having something simpler to pass
> from builtin/remote.c::remove_branches(), or something else?

Essentially it's simpler to read and maintain as we're having less
lines of code.
I'll add that to the commit message instead.

>
>> Idea-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Isn't the patch by Ronnie?

As it was part of the ref-transaction-rename series, it was authored by Ronnie.
Porting it back to the master branch brought up so many conflicts,
that I decided
to rewrite it from scratch while having an occasional look at the
original patch.

If you want we can retain Ronnies authorship, however I may have messed up
the rewriting, so I put my name as author and Ronnie as giving the idea.

>
> Sometimes I send a patch by someone else and make some change that I
> don't want them to be blamed for.  Then I keep their sign-off and put
> a note in the commit message about the change I made.  See output from

Sounds reasonable, I can do something similar.

>
>   git log origin/pu --grep='jc:'
>
> for more examples of that.
>
> Some nits below.

Because of the nits, I'd rather be blamed. :)

>
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
> [...]
>> @@ -1325,6 +1319,11 @@ static int prune_remote(const char *remote, int dry_run)
> [...]
>>       memset(&states, 0, sizeof(states));
>>       get_remote_ref_states(remote, &states, GET_REF_STATES);
>>
>> +     for (i = 0; i < states.stale.nr; i++)
>> +             string_list_insert(&delete_refs_list,
>> +                                states.stale.items[i].util);
>> +
>> +
>>       if (states.stale.nr) {
>
> (style) The double blank line looks odd here.

will fix

>
>>               printf_ln(_("Pruning %s"), remote);
>>               printf_ln(_("URL: %s"),
>> @@ -1332,24 +1331,17 @@ static int prune_remote(const char *remote, int dry_run)
>>                      ? states.remote->url[0]
>>                      : _("(no URL)"));
>>
>> -             delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
>
> Now that there's no delete_refs array duplicating the string list,
> would it make sense to rename delete_refs_list to delete_refs?
>
> As a nice side-effect, that would make the definition of
> delete_refs_list and other places it is used appear in the patch.
>
>>       for (i = 0; i < states.stale.nr; i++) {
>>               const char *refname = states.stale.items[i].util;
>
> (optional) this could be
>
>         for_each_string_list_item(ref, &delete_refs_list) {
>                 const char *refname = ref->string;
>                 ...
>
> which saves the reader from having to remember what states.stale.items
> means.

done

>
> [...]
>> +++ b/refs.c
> [...]
>> @@ -2639,23 +2639,23 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
> [...]
>> -     int i, ret, removed = 0;
>> +     int count, ret, removed = 0;
>>
>>       assert(err);
>>
>> -     /* Look for a packed ref */
>
> The old code has comments marking sections of the function:
>
>         /* Look for a packed ref */
>         /* Avoid processing if we have nothing to do */
>         /* Remove refnames from the cache */
>         /* Remove any other accumulated cruft */
>         /* Write what remains */
>
> Is dropping this comment intended?

no, dropped the dropping in the reroll.

>
>> -     for (i = 0; i < n; i++)
>> -             if (get_packed_ref(refnames[i]))
>> -                     break;
>> +     count = 0;
>> +     for_each_string_list_item(ref_to_delete, without)
>> +             if (get_packed_ref(ref_to_delete->string))
>> +                     count++;
>
> The old code breaks out early as soon as it finds a ref to delete.
> Can we do similar?

done

>
> E.g.
>
>         for (i = 0; i < without->nr; i++)
>                 if (get_packed_ref(without->items[i].string))
>                         break;
>
> (not about this patch) Is refs_to_delete leaked?
>
> [...]
>> @@ -3738,10 +3738,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>>  int ref_transaction_commit(struct ref_transaction *transaction,
>>                          struct strbuf *err)
>>  {
>> -     int ret = 0, delnum = 0, i;
>> -     const char **delnames;
>> +     int ret = 0, i;
>>       int n = transaction->nr;
>>       struct ref_update **updates = transaction->updates;
>> +     struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>
> The old code doesn't xstrdup the list items, so _NODUP should work
> fine (and be slightly more efficient).

ok

>
> [...]
>> @@ -3815,16 +3813,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                       }
>>
>>                       if (!(update->flags & REF_ISPRUNING))
>> -                             delnames[delnum++] = update->lock->ref_name;
>> +                             string_list_insert(&refs_to_delete,
>> +                                                update->lock->ref_name);
>
> string_list_append would be analagous to the old code.

ok

>
> [....]
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -163,8 +163,7 @@ extern void rollback_packed_refs(void);
>>   */
>>  int pack_refs(unsigned int flags);
>>
>> -extern int repack_without_refs(const char **refnames, int n,
>> -                            struct strbuf *err);
>> +extern int repack_without_refs(struct string_list *without, struct strbuf *err);
>
> A comment could mention whether the ref list needs to be sorted.  (It
> doesn't, right?)

ok, I tried adding comments.

>
> Thanks and hope that helps,
> Jonathan
