From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 06/41] refs.c: add an err argument to repack_without_refs
Date: Wed, 28 May 2014 08:31:49 -0700
Message-ID: <CAL=YDWnSL2vb2NcpPJnfMaR=p4iQhihyhiowwKXuuA-OiUpmfA@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-7-git-send-email-sahlberg@google.com>
	<20140528001117.GH12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 17:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpfpb-0001QC-1o
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbaE1Pbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 11:31:51 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:40185 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaE1Pbu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 11:31:50 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so12612808vcb.29
        for <git@vger.kernel.org>; Wed, 28 May 2014 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7bmgqGzL/drZB/QPRO7ZpCBGAQL/p/j54g+0wfer/As=;
        b=atOHwCFF1YwWX1po5XT2l0ZGk3CUsP8mdFJjnUQz4zTC9ZBCjjvI6kNCLKiog/6MAg
         vi2X+C/Tgqx29d58ALH//xAACmJNapUUpPR+aWrm9aQCoL+iHWy/OLIK3ySDADCaYejh
         MtEvVmal4/Rv5Dc4C4ktNVzwpKP0+1QA9bmog6xQ8OAxe7vBP0XOa6e/RVR2UE/o/cAW
         JCDGj90mJ4+GLnLHCLyFPCyb5iRyIGbLYM7Ez2ndWKg8uL/UyEJTobV5YgdEV9wn4u2t
         YgrbNDvqRdqnSu2AGUNWx54eAl2uwF/HBmjjtLl1lM3+dzji0Vmmrmwyh1DLl6Zk64E4
         NmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7bmgqGzL/drZB/QPRO7ZpCBGAQL/p/j54g+0wfer/As=;
        b=NUy+kFPi/RhACPudcmQo3kcOt8UEhcj0dICqaMqwZyB3d/BCAD0QC7qgKhZP621+xQ
         gb89eM9HOCrsB6P7ntih0HKXjzkSLjE14htZk9LdCZxoW2zNOgV6jNxUyv8HxbmxBLAl
         Vgphfxn6zyXeKOS8+OPJfDvwvYyW/Xf1izqsfneYMTZ5F0p0UXAFZmr89IV/de0q6Eqw
         s0ykFvn8DG3E1brg6oE8PBKVL1ypeGP0Rm4fPAbLZgq1R6L27s6YdOBW0bxQBMhCNIVe
         IckHIKsbEoTJC7NA/9A0tHEcw4UYWEzf96mtbmowWViqpi21s2WVKxU9J6kKXnYfbpIt
         xlTQ==
X-Gm-Message-State: ALoCoQmYie0yBCeLMLt5wbzpACRIDYt+7POYTOjn+k5tjDZJmm55xw2tsewMg9nMMNAdbDNBNYRk
X-Received: by 10.58.46.83 with SMTP id t19mr439386vem.60.1401291109239; Wed,
 28 May 2014 08:31:49 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 08:31:49 -0700 (PDT)
In-Reply-To: <20140528001117.GH12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250289>

On Tue, May 27, 2014 at 5:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Comments from http://marc.info/?l=git&m=140079653930751&w=2:
>
> Ronnie Sahlberg wrote:
>
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -559,6 +559,8 @@ struct lock_file {
>>  #define LOCK_DIE_ON_ERROR 1
>>  #define LOCK_NODEREF 2
>>  extern int unable_to_lock_error(const char *path, int err);
>> +extern void unable_to_lock_strbuf(const char *path, int err,
>> +                               struct strbuf *buf);
>
> "unable_to_lock_strbuf" could be called "unable_to_lock_message" (which
> would make its behavior more obvious IMHO).

Renamed.  Thanks.

>
> [...]
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
>>       struct packed_ref_cache *packed_ref_cache =
>>               get_packed_ref_cache(&ref_cache);
>>       int error = 0;
>> +     int save_errno = 0;
>
> This is about making errno meaningful when commit_packed_refs returns
> an error.  Probably its API documentation should say so to make it
> obvious when people modify it in the future that they should preserve
> that property or audit callers.
>
> [...]
>> @@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
>>               return 0; /* no refname exists in packed refs */
>>
>>       if (lock_packed_refs(0)) {
>> +             if (err) {
>> +                     unable_to_lock_strbuf(git_path("packed-refs"), errno,
>> +                                           err);
>> +                     return -1;
>> +             }
>>               unable_to_lock_error(git_path("packed-refs"), errno);
>
> Via the new call to unable_to_lock_..., repack_without_refs cares
> about errno after a failed call to lock_packed_refs.  lock_packed_refs
> can only fail in hold_lock_file_for_update.  hold_lock_file_for_update
> is a thin wrapper around lockfile.c::lock_file.  lock_file can error
> out because
>
>         strlen(path) >= max_path_len
>         adjust_shared_perm failed [calls error(), clobbers errno]
>         open failed
>
> So lock_file needs a similar kind of fix, and it's probably worth
> updating API documentation for these calls to make it clear that their
> errno is used (though that's not a new problem since
> repack_without_refs already called unable_to_lock_error).  Could be a
> separate, earlier patch (or a TODO comment in this patch to be
> addressed with a later patch) since it's fixing an existing bug.

I will add it to my todo list.
I think passing of errno around is too fragile and that we should
avoid ad-hoc save_errno hacks and implement dedicated return codes to
replace errno.
We should only inspect errno immediately after a syscall has failed.

>
> Hope that helps,
> Jonathan
