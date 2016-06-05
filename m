From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sun, 5 Jun 2016 10:15:01 +0700
Message-ID: <CACsJy8CmgqoWLdPzAWbWSu=65keywd0ni9mAdXUE7UDqxtJ3Vg@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <575199E7.7000503@xiplink.com>
 <20160604003126.GA10430@ash> <xmqqeg8czzl4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 05:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OXH-0006ua-9Z
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcFEDPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 23:15:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36245 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcFEDPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:15:31 -0400
Received: by mail-it0-f67.google.com with SMTP id i65so1840376ith.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bmTMwh5P25oaEmywRWk4xnMqF/KYsirD13awLiT0whw=;
        b=y8kprBS/yFSpc1VtWrUChlGteJ9lmkvMuzFosdjwju/VB6a4hv18/aGdFVd4h0lHym
         vncgqd6+cGD88cyFCxy+oqHpfm81Z5P/xMhMLebcuaQ4tQKyG/tt7i9W7OmCo1jqt1yT
         9/K3wohJnncOyR+CkPmeObSiBMk48x8OVO5Tm06nr4qUotDvIf9ekmquhfbVuHbtW7mt
         q5YFUiwVOChe1rxuKGaY+oAyoydCXbgM1Yc4jp+3/2IUDM8MRv6PWTpvRhjwSDHkaxFx
         z0HZXVfBFRqtUQl4uTsDdqn/d3xUPpqL4iCIsyvu4S869RIR/CDEuYeh13IfOw+8Ucsu
         7lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bmTMwh5P25oaEmywRWk4xnMqF/KYsirD13awLiT0whw=;
        b=feVCPNwESVhFgNal2Hcl4YNMsGyX8TMNbK9LsQcT3eagdadBHeJpJfhgAeoMnhRX3c
         q2sgLr3slHSD4zVx2KTSsRwgIMq/D9I+NOv2y3c+yTiXYG74F4cqEgBdu8YFze8VdZ8p
         kYGroy5JPsq8C5LbwnaZMntt+4Ebq5to96wWxBMcdmYVKwUOMqTIJylH4IEUB5KOXUTj
         qBk7SEpwM1rFCpTjrcvWETEMsDoYwK2wv12XYVDqWgv3rPhtDZH/v6BF1slt3CgZTQEc
         S+6wMJxhSyRcCKIVXW8ybFzzpz/OOadMslqAg0DV5yc0AzLAzY0bcFVob2ZlCVfXxZZv
         yeyw==
X-Gm-Message-State: ALyK8tKK366Sjn128cf+/IbO43hUoOSobsUf5MJ/4OLwDh+z53YNx04dysYEITgvmNv3WZ4uq8thUWbhCrrqrg==
X-Received: by 10.36.239.197 with SMTP id i188mr8644161ith.57.1465096530562;
 Sat, 04 Jun 2016 20:15:30 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sat, 4 Jun 2016 20:15:01 -0700 (PDT)
In-Reply-To: <xmqqeg8czzl4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296458>

On Sat, Jun 4, 2016 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The patch does not do fancy stuff like this yet, but it can because
>> lines exceeding terminal width is already excluded from column width
>> calculation. So far the output looks good on my terminal (192 chars,
>> can't overflow or refnames are insanely long)
>
> Sounds like a sensible approach....
>
>> -- 8< --
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index a7f152a..5e1e5c9 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -15,6 +15,7 @@
>>  #include "submodule.h"
>>  #include "connected.h"
>>  #include "argv-array.h"
>> +#include "utf8.h"
>>
>>  static const char * const builtin_fetch_usage[] = {
>>       N_("git fetch [<options>] [<repository> [<refspec>...]]"),
>> @@ -449,14 +450,26 @@ fail:
>>                          : STORE_REF_ERROR_OTHER;
>>  }
>>
>> -#define REFCOL_WIDTH  10
>> +static int refcol_width = 10;
>> +
>> +static void adjust_refcol_width(const char *remote, const char *local)
>> +{
>> +     int max = term_columns();
>> +     int rlen = utf8_strwidth(remote);
>> +     int llen = utf8_strwidth(local);
>> +
>> +     if (21 /* flag summary */ + rlen + 4 /* => */ + llen >= max)
>> +             return;
>> +     if (refcol_width < rlen)
>> +             refcol_width = rlen;
>> +}
>>
>>  static void format_display(struct strbuf *display, char code,
>>                          const char *summary, const char *error,
>>                          const char *remote, const char *local)
>>  {
>>       strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
>> -     strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
>> +     strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
>
> ... and if I understand correctly, this is the only place where you
> need to decide if you need to switch to two lines, right?  You would
> measure width of the remote and compare it with refcol_width or
> something like that.

Exactly.
-- 
Duy
