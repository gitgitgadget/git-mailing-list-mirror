From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 06/24] read-cache: Don't compare uid, gid and ino on cygwin
Date: Tue, 20 Aug 2013 10:36:50 +0200
Message-ID: <87li3wiwrh.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-7-git-send-email-t.gummerer@gmail.com> <52114C0E.4030502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 20 10:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBhQz-0002U1-FW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 10:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab3HTIg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 04:36:57 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:52278 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3HTIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 04:36:55 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so63799eek.17
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=5y1WGLP5c3e+AvBRRWRU6glQQCKW89OKLLOXkqggsgw=;
        b=cEBApoYnRDxQpmvpukpTyv2elrNvKi5ZYejjfAJVZhZ81kEHUvM26fRu1ZiWhle2hA
         liGUX7nzVXXZr3lY5x2/nEO8nk1Z/6U9KH8uolGa1mkE+nZZtnSi3VAFlFMi5BNC+0m+
         Fq2YrGK0Oh9h/qB7M4f91FCV/XJ1PSrvfIPgzdR/kJrZsdp4WgLE2TnBHB9qgGqyqeXy
         YZv+PdM/2c3JYsUEtGKexZu+Qf4FCHFRlRhMgsf+EjGiJUnvAEee3/Mz9lbemEF3nCJy
         wKjp7DOlopaNVBqzHZlGH9sH3Luworw/0yGjz2dpMUgqmg71eXw2y4Sv8Xjae2vBZjlb
         iWAA==
X-Received: by 10.15.100.198 with SMTP id bn46mr650828eeb.11.1376987814113;
        Tue, 20 Aug 2013 01:36:54 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id p5sm713813eeg.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 01:36:52 -0700 (PDT)
In-Reply-To: <52114C0E.4030502@ramsay1.demon.co.uk>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232588>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 18/08/2013 08:41 PM, Thomas Gummerer wrote:
>> Cygwin doesn't have uid, gid and ino stats fields.  Therefore we should
>> never check them in the match_stat_data when working on the CYGWIN
>> platform.
>
> Hmm, this is simply not true ... ;-)
>
> The need to omit the uid, gid and ino fields from the stat checks in
> your original code was caused by the "schizophrenic stat" implementation
> in cygwin. (This was also before "core.checkstat" was implemented; note
> the 'check_stat' conditional below ...)
>
> However, since commit f66450ae ("cygwin: Remove the Win32 l/stat()
> implementation", 22-06-2013), this patch is no longer necessary and
> can simply be dropped from this series.
>
> [I have not had time to read your new patches yet, but I seem to remember
> being concerned about those platforms which have UNRELIABLE_FSTAT set.
> (ie cygwin, MinGW and Windows.)]

Ah ok, thanks for the clarification.  I misinterpreted your message in
the previous thread, thinking it would still be necessary.  I'll drop
this patch.

I can't recall anything about UNRELIABLE_FSTAT though.

> ATB,
> Ramsay Jones
>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>
>> This patch was not tested on Cygwin yet.  I think it's needed though,
>> because the re-reading of the index if it changed will no longer use
>> it's own index_changed function, but use the stat_validity_check
>> function instead.  Would be great if someone running Cygwin could test
>> this.
>>
>>  read-cache.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 1f827de..aa17ce7 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -82,6 +82,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>>  		changed |= CTIME_CHANGED;
>>  #endif
>>
>> +#if !defined (__CYGWIN__)
>>  	if (check_stat) {
>>  		if (sd->sd_uid != (unsigned int) st->st_uid ||
>>  			sd->sd_gid != (unsigned int) st->st_gid)
>> @@ -89,6 +90,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>>  		if (sd->sd_ino != (unsigned int) st->st_ino)
>>  			changed |= INODE_CHANGED;
>>  	}
>> +#endif
>>
>>  #ifdef USE_STDEV
>>  	/*
>>
