From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: Re: [PATCH v2] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 23:08:07 -0300
Message-ID: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
References: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com> <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
 <20160229100030.GB2950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 03:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZjk-0003PN-0v
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcCACI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:08:28 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33245 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcCACI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:08:27 -0500
Received: by mail-ig0-f181.google.com with SMTP id y8so10039547igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4AsnYtt8EbUm6ynngTJzirARYEIvBv/FhFAcrTo7LYk=;
        b=MC4bkw6jQEhwwZTubjZLRVyH/gQ/1+zREEqq2dCQjF9dB8aJDdvLqyc9yc/ITfY9oo
         3laTe56dzf+4/NXmQeHjKyIyvAsccLBQVysjVn4BOpQdJ/N06J0XGhP7444blKr3GfRO
         BMC9c9oe3RJEUXccl0NnsAQw3KvLP5t+hPdqOEUgEV8iXFcN/IJd644IWdM8ceKY4RRL
         WjSSnVBh8iUd+Q87WIZAvzz39oZaJELlKjHzvLdxgakMe+rwCr/pYEAWvSl1QJpK4rV8
         5BTIvNk2Pk3rI15dAqAbFV91b2soTv7SAIt5qGNJDWhsGRe4tkCh0jT5YRhzJIVJyCUk
         8K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4AsnYtt8EbUm6ynngTJzirARYEIvBv/FhFAcrTo7LYk=;
        b=ZLWT0OdMrrIbZDLd/c/QrZX2r93i5lH2zEm/R2DYvV5B30duldAmtNM3mF3GvhTyWs
         GJTEsQJ+qxUOxebivuaf5UqgTthDliyZ54HQyFP9Y0IHkTy+2zN7VTPEq021tlSm1DkE
         McLkrhqt8zh8WDZJEOVUlR1Ka91oJKjSv4oBtsa7hQ1AenUjKmDxAB+6WFsmRwEFWlGh
         T+5lIPMvBt62dfQrKBIe7KObOWtKbgpy+57SOx9FrXj/gOmQtxapOezdIdRLznUf5gMl
         qGhB17MS+OOTXYgB7cs0iLYAbI166fpMNNq1zzII677BgJnl0TWPpPOl4VrtsdNEjZTV
         28oA==
X-Gm-Message-State: AD7BkJIIyYelYS1M8lRAr9QEeSO8ZolwPgiabsZbwZ2LNA3Od0+yMwZhRKD6Mb6Jia7jlzVImb8qI5cDw5zhzQ==
X-Received: by 10.50.112.71 with SMTP id io7mr1023729igb.50.1456798106623;
 Mon, 29 Feb 2016 18:08:26 -0800 (PST)
Received: by 10.50.79.233 with HTTP; Mon, 29 Feb 2016 18:08:07 -0800 (PST)
In-Reply-To: <20160229100030.GB2950@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287994>

On Mon, Feb 29, 2016 at 5:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Having said that, this *might* be a good opportunity to imitate the
> skip_prefix() function. If there are enough similar code constructs, we
> could simplify all of them by introducing the function
>
>         skip_oid_hex(const char *str, struct object_id *oid, const char **out)
>
> that returns 1 if and only if an oid was parsed, and stores the pointer
> after the oid in "out" (skipping an additional space if there is one)?

I don't think there's any other place that accepts all of "<sha1>",
"<sha1> <ref>" and "<ref>"
based on a quick grep for get_oid_hex.

On Mon, Feb 29, 2016 at 7:00 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 28, 2016 at 07:22:24PM -0300, Gabriel Souza Franco wrote:
>
>> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
>> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
>> Add support for specifying just a SHA-1 and set the ref name to the same
>> value in this case.
>>
>> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
>> ---
>>
>> Not the cleanest conditional I've ever written, but it should handle
>> all cases correctly.
>
> I think it does. But I wonder if it wouldn't be more readable to cover
> the three formats independently, like:
>
>   if (!get_oid_hex(name, &ref->old_oid) && name[GIT_SHA1_HEXSZ] == ' ') {
>         /* <sha1> <ref>, find refname */
>         name += GIT_SHA1_HEXSZ + 1;
>   } else if (!get_oid_hex(name, &ref->old_oid) && name[GIT_SHA1_HEXSZ] == '\0') {
>         /* <sha1>, leave sha1 as name */
>   } else {
>         /* <ref>, clear any cruft from get_oid_hex */
>         oidclr(&ref->old_oid);
>   }
>
> And as a bonus you get rid of the separate "oid".  That does call into
> get_oid_hex twice, but I doubt the performance impact is measurable.
>
> We could also do:
>
>   if (!get_oid_hex(name, &ref->old_oid)) {
>         if (name[GIT_SHA1_HEXSZ] == ' ') {
>                 /* <sha1> <ref>, find refname */
>                 name += GIT_SHA1_HEXSZ + 1;
>         } else if (name[GIT_SHA1_HEXSZ] == '\0') {
>                 /* <sha1>, leave sha1 as name */
>         } else {
>                 /* <ref>, clear cruft from oid */
>                 oidclr(&ref->old_oid);
>         }
>   } else {
>         /* <ref>, clear cruft from get_oid_hex */
>         oidclr(&ref->old_oid);
>   }
>
> if you want to minimize the calls at the expense of having to repeat the
> oidclr().

I think I like this version more, and is close to what I had initially
before I tried to be clever about it.
Besides, this isn't a performance critical function, so it shouldn't
matter much.
Will send a new (and hopefully final) version shortly.

>
> -Peff
