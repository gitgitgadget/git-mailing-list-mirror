From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: Re: [PATCH] fetch-pack: fix object_id of exact sha1
Date: Sat, 27 Feb 2016 19:23:22 -0300
Message-ID: <CABaesJJCfd6FzgEVCWMJH8-gKiv3pT8BGq4f-qFgprVde+ViQQ@mail.gmail.com>
References: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
 <1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com> <20160227221248.GB17475@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 23:23:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZnHA-0002Jl-0L
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 23:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992524AbcB0WXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 17:23:43 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34958 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbcB0WXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 17:23:42 -0500
Received: by mail-ig0-f176.google.com with SMTP id hb3so54693320igb.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 14:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F6fqKbvcJ5uYtT6VvVV1BLL7C46QiPeTyXzBxUhTCJQ=;
        b=jcSk2TJvcX0VsFdY5TgJn06uPvVYpMtE510GRWlDhaLG6BMHHEhO15I32b09FK4KVh
         VjgsLHKau9v6ajK2wRez49ytz9WjQOPLUqeFt5I0fkAT73uZmm78unTkUlNFa/GjsVLR
         5TKRWZqCalJkWoDWsUUcc2GSTQEwKpZBaklmDprFdotRu4QJjj2vHAoqIGyVwOvjJySK
         CVUjwnf/wWjnP++b6ONX1x3811VtfGiqwcl66TiuhfPzQO5sVYtWPD2X1vSh4Wk3YhVU
         RyQ7sHNvdd8fcTaE9lpk9yAYVtlo4IY/diVpsnc6kO4AsHAdt3vxaVSK/5cK4R1FDP87
         n/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F6fqKbvcJ5uYtT6VvVV1BLL7C46QiPeTyXzBxUhTCJQ=;
        b=JERm1Z+TLFTA/c1zDBLUt/KhqtpeyJqVHUkc4soXwrujYn784yH+e6wN1s4T2I957U
         arw1NuN/bEuxMHaRw99DT2Dsiihx25orHmtnJsWoJccTddKFsD23n8We2MrtWPFUxVLw
         JpffuqU8vuHtKuLK5uDtuNVwpsI3JpwXdauMC7Rr/K79ScZf1Gwd4IFZgFtIJnxPD2+H
         oqDNiITiWF2msKbaKuXGcwTm6vb00IOhl/CmXq0IPxwedm1l7vBeYliSGHO9+jEjfISL
         wEHT1mPyQBMfrj7Fs5EcPVQG/iStm1rC2ZiuRLqYAwZSenHGds3X0uPHHqnxHh/+58W2
         GZJw==
X-Gm-Message-State: AD7BkJKq5cvuOMS6vxbj3hi0vTGTXlu7VekFQ8FFxUgzu2Gu8VULOTWGPJqkVdXP3jilzH15LqqIZQadduaVJw==
X-Received: by 10.50.129.8 with SMTP id ns8mr3941184igb.95.1456611821710; Sat,
 27 Feb 2016 14:23:41 -0800 (PST)
Received: by 10.50.59.2 with HTTP; Sat, 27 Feb 2016 14:23:22 -0800 (PST)
In-Reply-To: <20160227221248.GB17475@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287733>

On Sat, Feb 27, 2016 at 7:12 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 27, 2016 at 05:32:54PM -0300, Gabriel Souza Franco wrote:
>
>> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
>> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
>> Add support for specifying just a SHA-1 and set the ref name to the same
>> value in this case.
>>
>> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
>> ---
>>  builtin/fetch-pack.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>> index 79a611f..d7e439a 100644
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -16,10 +16,10 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
>>       struct ref *ref;
>>       struct object_id oid;
>>
>> -     if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
>> -             name += GIT_SHA1_HEXSZ + 1;
>> -     else
>> +     if (get_oid_hex(name, &oid))
>>               oidclr(&oid);
>> +     else if (name[GIT_SHA1_HEXSZ] == ' ')
>> +             name += GIT_SHA1_HEXSZ + 1;
>
> This makes sense to me. I wonder if we should be more particular about
> the pure-sha1 case consuming the whole string, though. E.g., if we get:
>
>   1234567890123456789012345678901234567890-bananas
>
> that should probably not have sha1 1234...
>
> I don't think it should ever really happen in practice, but it might be
> worth noticing and complaining when name[GIT_SHA1_HEXSZ] is neither
> space nor '\0'.

Right. What kind of complaining? Is doing oidclr(&oid) and letting it
fail elsewhere enough?
Also, it already fails precisely because of that check I wanted to
remove earlier.

>
> -Peff
