From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 04/44] refs.c: add an err argument to repack_without_refs
Date: Thu, 15 May 2014 16:06:59 -0700
Message-ID: <CAL=YDWk5h48sS1A61nsBTFCBQ327nZ5mRcr3Jp4f-yA4Gqe4Gg@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-5-git-send-email-sahlberg@google.com>
	<20140515183836.GD26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:07:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4k0-0005Fw-Cf
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbaEOXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:07:01 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:45987 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbaEOXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:07:00 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so5223888vcb.22
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1aJ/7gowSXI61GspitbbqwLU3UPkRYpiPnos6ZAPIGA=;
        b=etylPiiHTpsOzurdJx+13/ICVvA2jdpZwUrG6ZPFnlUgXF08qtLXaEtPg5LX90U4TN
         ctXlcyNL2qNT3uSy8haEhptX4gM1imX5bWycM69bNRivw/a+bl3dkddLpyuNLFBcsXys
         XXHeDnurQOv4iA/1uzj18lYne2iiC00SLDunMTWza2ew3VjxVREOZ65EpzORL1b6lbtP
         8Sugl0OrLlCOPnIweObrqiFsncN5+V0wHZSJdgeo2GyvltqJRtlU4JbOPNc6N1QAbQX5
         hAht+d9VUW5qdj/EK+UIG491Hs9Eq6TQf72E6lvBGVIfrXIJOL5i/NHREncHNl7O2V0x
         DBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1aJ/7gowSXI61GspitbbqwLU3UPkRYpiPnos6ZAPIGA=;
        b=Of9PFmsjMWKokP79mTA1t/q+DVXHDHOp/en9fm1OckrtzAEciAjQ2wy9azWM7LwdWN
         EuMVk2ZlEgz2u/U+pcanMC7tYF3EfIfLeb+tGYprYqlwM4lbpeB5IWOlK7RsxPZr4Yut
         AlIPPkIdCebEAfGpPFHpB50gJB25oIZ+hulhNgJd056X5RVfd/yn0WWQo6hgp/+xuH/t
         GIYFzxWEXnhNIyVbilFQ5A0o+Ix1iIxi9ZxAv/35O2ufMbAL/gQ1XEORQ1IFKmkmWFs0
         JM1y8uIBOENoYC5tlTwT8ayzKnbHUUUf6Y/aBsULlNcgdOhV1AnftsRQIQKO6q4qw+Vp
         ujLw==
X-Gm-Message-State: ALoCoQm7qjeYj37x75zg5qyy3t1OI/xKUALVuffHpVxmToFY6HjOTk+BaM0OVKMkWjW0PiTttNhh
X-Received: by 10.52.255.98 with SMTP id ap2mr8990572vdd.3.1400195219610; Thu,
 15 May 2014 16:06:59 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 16:06:59 -0700 (PDT)
In-Reply-To: <20140515183836.GD26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249220>

On Thu, May 15, 2014 at 11:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2427,12 +2427,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>>       return 0;
>>  }
>>
>> -static int repack_without_refs(const char **refnames, int n)
>> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>
> Should this also get an onerr flag to suppress the message to stderr,
> or unconditionally suppress the message to stderr when err != NULL?

Unconditionally suppress the message I think.  And is what I did.

>
> [...]
>> @@ -2445,6 +2445,9 @@ static int repack_without_refs(const char **refnames, int n)
>>
>>       if (lock_packed_refs(0)) {
>>               unable_to_lock_error(git_path("packed-refs"), errno);
>> +             if (err)
>> +                     strbuf_addf(err, "cannot delete '%s' from packed refs",
>> +                                 refnames[i]);
>
> unable_to_lock_error is able to come up with a message with more
> detail (path so the sysadmin can hunt down the problem even if this
> was run e.g. from a cronjob where the path is not obvious, errno
> hinting at the nature of the problem).

I changed it so that if err is non-NULL we call a new function that updates the
strbuf with a nice message explaining the failure and then return 1
without writing anything to stderr.

For the NULL case I left it to continue logging two lines of errors
"Unable to create '%s.lock': %s.\n\n"
"cannot delete '%s' from packed refs"

That second line should probably go away since the error at this stage
is related to locking the packed
refs file itself and has nothing really to do with a particular ref
such as refnames[i]



>
> [...]
>> @@ -2470,12 +2473,15 @@ static int repack_without_refs(const char **refnames, int n)
>>       }
>>
>>       /* Write what remains */
>> -     return commit_packed_refs();
>> +     ret = commit_packed_refs();
>> +     if (ret && err)
>> +             strbuf_addf(err, "unable to overwrite old ref-pack file");
>
> After commit_lock_file sets errno, amazingly no one clobbers it
> until we get to this point.  The only calls in between are to
> free().
>
> It would be nice to make that more explicit in commit_packed_refs:
>
>         int save_errno;
>
>         ...
>         if (commit_lock_file(packed_ref_cache->lock)) {
>                 save_errno = errno;
>                 error = -1;
>         }
>
>         packed_ref_cache->lock = NULL;
>         release_packed_ref_cache(packed_ref_cache);
>
>         errno = save_errno;
>         return error;
>
> Even without that, this message could include strerror(errno).

Done and Done.

Thanks.
