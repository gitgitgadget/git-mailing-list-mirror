From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 04/44] refs.c: add an err argument to repack_without_refs
Date: Tue, 27 May 2014 12:21:13 -0700
Message-ID: <CAL=YDWnfnzQhTW+QDd2DCx=79HbZfudqRo6Kt4G79hdhBTM1Ag@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-5-git-send-email-sahlberg@google.com>
	<537758A1.9080809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 27 21:21:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMw2-00075L-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaE0TVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:21:15 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:32965 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaE0TVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:21:14 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so11128337veb.26
        for <git@vger.kernel.org>; Tue, 27 May 2014 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3k52w+nNvfAcku37gucHvR5KXEp7HKNWp3P28SiY8pg=;
        b=An+dXeBLCoGhtiE46ZGKBIh0/1ktR2smNC53JtSQYExeYpQJACr3++38/MvT6Xiq73
         sOyrpEqBg6WfqsoLsfqLZ+2JwSqIB492CiUW1UMxSjZ6GpmVhY7R9MBDuQPRJlrxDEh3
         dx0Z38wHrHQpG9PkGs+8HOuUZBJaDFf5xAnx73dDGWjkJFBiuiKTou7q4Ram20coEmI1
         CVTFXsp47uFxxfy27ErQipCJDhepZ7lT1+weIXfIpERrxtaToVX2x5lG4ZM/G12xNYQq
         p6mk9kwqbQGSVpoyFCr4YwLnccTfVCU29sbzGynDTuxHczq/4g2PsJWZpWnA8y4gruWU
         wvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3k52w+nNvfAcku37gucHvR5KXEp7HKNWp3P28SiY8pg=;
        b=cInBLxboOmLgXBPCcc+vuStd6zTvgCzQktcjY7+Pzrm45de7NL+Mh7+gk/15KhgNAn
         gn8NMipSVooEI58E4ctf27Pl6Q05ecTBemdSlNp5BsxHict/WqSRYkoHd10Xi/slmwo1
         ktONXHadKiXReJTfh0onu0MPZN/K4lBLetyqku2TpwlnoqwE/20zsdidOhfbE1UJhC22
         AfKu1+SHm4AE79Xwnaglcd49rABB/NLJOKYvPIUTOFKdkoAVeFCYjjFif6C8q5cOu/zH
         9oKqjl5aHjFoJO1yWE/9xstbvf08PyDgh9OvnHEn8ZHy0UBedYBsp4cJ3hOHNHmrLkbh
         FR1Q==
X-Gm-Message-State: ALoCoQnZjR3dP0euiK4LYEIRCfROAvYlsmf5LhzpvuC3LSbfAg9LG2JsoEUMMXMPskAG6FOjGZwe
X-Received: by 10.58.66.195 with SMTP id h3mr3519020vet.57.1401218473900; Tue,
 27 May 2014 12:21:13 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 27 May 2014 12:21:13 -0700 (PDT)
In-Reply-To: <537758A1.9080809@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250192>

On Sat, May 17, 2014 at 5:40 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:36 PM, Ronnie Sahlberg wrote:
>> Update repack_without_refs to take an err argument and update it if there
>> is a failure. Pass the err variable from ref_transaction_commit to this
>> function so that callers can print a meaningful error message if _commit
>> fails due to a problem in repack_without_refs.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  cache.h    |  2 ++
>>  lockfile.c | 21 ++++++++++++---------
>>  refs.c     | 25 +++++++++++++++++++------
>>  3 files changed, 33 insertions(+), 15 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 8c6cdc2..48548d6 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -559,6 +559,8 @@ struct lock_file {
>>  #define LOCK_DIE_ON_ERROR 1
>>  #define LOCK_NODEREF 2
>>  extern int unable_to_lock_error(const char *path, int err);
>> +extern void unable_to_lock_strbuf(const char *path, int err,
>> +                               struct strbuf *buf);
>>  extern NORETURN void unable_to_lock_index_die(const char *path, int err);
>>  extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
>>  extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
>> diff --git a/lockfile.c b/lockfile.c
>> index 8fbcb6a..9e04b43 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -157,33 +157,36 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>>       return lk->fd;
>>  }
>>
>> -static char *unable_to_lock_message(const char *path, int err)
>> +void unable_to_lock_strbuf(const char *path, int err, struct strbuf *buf)
>>  {
>> -     struct strbuf buf = STRBUF_INIT;
>>
>>       if (err == EEXIST) {
>> -             strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
>> +             strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
>>                   "If no other git process is currently running, this probably means a\n"
>>                   "git process crashed in this repository earlier. Make sure no other git\n"
>>                   "process is running and remove the file manually to continue.",
>>                           absolute_path(path), strerror(err));
>>       } else
>> -             strbuf_addf(&buf, "Unable to create '%s.lock': %s",
>> +             strbuf_addf(buf, "Unable to create '%s.lock': %s",
>>                           absolute_path(path), strerror(err));
>> -     return strbuf_detach(&buf, NULL);
>>  }
>>
>>  int unable_to_lock_error(const char *path, int err)
>>  {
>> -     char *msg = unable_to_lock_message(path, err);
>> -     error("%s", msg);
>> -     free(msg);
>> +     struct strbuf buf = STRBUF_INIT;
>> +
>> +     unable_to_lock_strbuf(path, err, &buf);
>> +     error("%s", buf.buf);
>> +     strbuf_release(&buf);
>>       return -1;
>>  }
>>
>>  NORETURN void unable_to_lock_index_die(const char *path, int err)
>>  {
>> -     die("%s", unable_to_lock_message(path, err));
>> +     struct strbuf buf = STRBUF_INIT;
>> +
>> +     unable_to_lock_strbuf(path, err, &buf);
>> +     die("%s", buf.buf);
>>  }
>>
>>  int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
>> diff --git a/refs.c b/refs.c
>> index 686b802..a470e51 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
>>       struct packed_ref_cache *packed_ref_cache =
>>               get_packed_ref_cache(&ref_cache);
>>       int error = 0;
>> +     int save_errno;
>>
>>       if (!packed_ref_cache->lock)
>>               die("internal error: packed-refs not locked");
>> @@ -2217,10 +2218,13 @@ int commit_packed_refs(void)
>>       do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
>>                                0, write_packed_entry_fn,
>>                                &packed_ref_cache->lock->fd);
>> -     if (commit_lock_file(packed_ref_cache->lock))
>> +     if (commit_lock_file(packed_ref_cache->lock)) {
>> +             save_errno = errno;
>>               error = -1;
>> +     }
>>       packed_ref_cache->lock = NULL;
>>       release_packed_ref_cache(packed_ref_cache);
>> +     errno = save_errno;
>
> This code involving save_errno looks like a bug fix orthogonal to the
> rest of the patch.  It should at least be mentioned in the commit
> message if not broken into a separate patch.

Text updated.

>
>>       return error;
>>  }
>>
>> @@ -2427,12 +2431,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>>       return 0;
>>  }
>>
>> -static int repack_without_refs(const char **refnames, int n)
>> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>>  {
>>       struct ref_dir *packed;
>>       struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>>       struct string_list_item *ref_to_delete;
>> -     int i, removed = 0;
>> +     int i, ret, removed = 0;
>>
>>       /* Look for a packed ref */
>>       for (i = 0; i < n; i++)
>> @@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
>>               return 0; /* no refname exists in packed refs */
>>
>>       if (lock_packed_refs(0)) {
>> +             if (err) {
>> +                     unable_to_lock_strbuf(git_path("packed-refs"), errno,
>> +                                           err);
>> +                     return 1;
>
> error() returns -1, but here you have changed the return value to 1.  Is
> there a reason for the change?

Fixed.

>
>> +             }
>>               unable_to_lock_error(git_path("packed-refs"), errno);
>>               return error("cannot delete '%s' from packed refs", refnames[i]);
>>       }
>> @@ -2470,12 +2479,16 @@ static int repack_without_refs(const char **refnames, int n)
>>       }
>>
>>       /* Write what remains */
>> -     return commit_packed_refs();
>> +     ret = commit_packed_refs();
>> +     if (ret && err)
>> +             strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
>> +                         strerror(errno));
>> +     return ret;
>>  }
>>
>>  static int repack_without_ref(const char *refname)
>>  {
>> -     return repack_without_refs(&refname, 1);
>> +     return repack_without_refs(&refname, 1, NULL);
>>  }
>>
>>  static int delete_ref_loose(struct ref_lock *lock, int flag)
>> @@ -3481,7 +3494,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>               }
>>       }
>>
>> -     ret |= repack_without_refs(delnames, delnum);
>> +     ret |= repack_without_refs(delnames, delnum, err);
>>       for (i = 0; i < delnum; i++)
>>               unlink_or_warn(git_path("logs/%s", delnames[i]));
>>       clear_loose_ref_cache(&ref_cache);
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
