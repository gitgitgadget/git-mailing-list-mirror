From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass
 strbuf as base
Date: Tue, 2 Dec 2014 19:11:44 -0500
Message-ID: <CAPig+cS1OK6pv5A0vuJf=j6eFrNv70=AYgVz3zQny-md15_xKg@mail.gmail.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
	<1417338302-8208-2-git-send-email-pclouds@gmail.com>
	<xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
	<CACsJy8B7G9xQerZ+6GTPQuG2v1DuJLXfsKFobuz_vyFahnXuYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:11:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxXp-0006oG-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 01:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbaLCALq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 19:11:46 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:50121 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaLCALp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 19:11:45 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so7146910yhl.9
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 16:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5h3fLJWILMwoeO+NdQ4fHa8yEwFtmscawSKWVjQmk94=;
        b=uOZm9CN7lF4FNAUYyZiCKryJGWqNdwbbBrWf71xeEuDBgesjqzH4fKNypmOkl6HTXR
         E3cfsWIWg7DRv6oPhx1sm1q8oH/cRh3J3j3BijiFg1R6DbTtRBA2kAEbB5UsqNxDEJRB
         YZvJ1VSxC1c6nzUdtlUeUqjKLWB3nwfcxqpAIIVvMuOvqAvkYsU8D1p6mKAzMtRRatUq
         Dc0x1jJSiQaLmRzo9TsYHZV892NakbSVBHuHIw9VA5YdDFAvfQpMqO86TT51hQ9xZyTj
         +HC3uSS31xs7MR+EzGkwKghuFSR3SlkeugQIpwvsBKxccwcrnvb0NkUOHFDjIe4lxjU9
         bf2w==
X-Received: by 10.236.8.100 with SMTP id 64mr2843225yhq.112.1417565504720;
 Tue, 02 Dec 2014 16:11:44 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 2 Dec 2014 16:11:44 -0800 (PST)
In-Reply-To: <CACsJy8B7G9xQerZ+6GTPQuG2v1DuJLXfsKFobuz_vyFahnXuYQ@mail.gmail.com>
X-Google-Sender-Auth: WHJM4WGxAYzu3EB-37CHt6bmcak
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260607>

On Tue, Dec 2, 2014 at 7:11 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 2, 2014 at 2:32 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This allows the callback to use 'base' as a temporary buffer to
>>> quickly assemble full path "without" extra allocation. The callback
>>> has to restore it afterwards of course.
>>
>> Hmph, what's the quote around 'without' doing there?
>
> because it's only true if you haven't used up all preallocated space
> in strbuf. If someone passes an empty strbuf, then underneath strbuf
> may do a few realloc until the buffer is large enough.

Would it be easier to understand if written like this?

    This allows the callback to use 'base' as a temporary buffer to
    quickly assemble full path, thus avoiding allocation/deallocation
    for each iteration step.
