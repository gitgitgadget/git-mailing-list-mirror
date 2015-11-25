From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for
 each atom in valid_atom
Date: Wed, 25 Nov 2015 17:40:30 +0530
Message-ID: <CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Yuk-0002NZ-IX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbbKYMLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:11:04 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36515 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbbKYMLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:11:00 -0500
Received: by vkay187 with SMTP id y187so32871493vka.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9QCgulcj3UuzkIToETw6OD0i6Sn27Olv3Shhh8JbEYU=;
        b=xpo0S6LquzGTOimNCO7Czw2oTObt8w2CYGZLBJ84f1Ed59GkD+q1GWO7wOnuALvi+t
         jpfEgf9sbGJZBpAJVxn2Gduh2oDJvgWgM0pD+ikBEsfUzEu7tno4bewJSpN37NYkJCev
         BYNX+U7M+3y5NxdzFJ/e3ORgBYuyi9TNIFROI4HQESub5f18aB6JAU8ku8vXZEHlv8hN
         9VAK5cm7+OpPqWzComPS8MuvY0UYi2YOLK061eZqgDXMIQQ+lSYUlco6DRzwBYKEnjVJ
         2obw9eQK2PDB6h6ZYXM1yXpKpabO0rPQCwG1VpEL2i6glMMNgN1mKSX0+me90X1qBPPR
         yrZQ==
X-Received: by 10.31.180.205 with SMTP id d196mr30563400vkf.146.1448453460090;
 Wed, 25 Nov 2015 04:11:00 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Wed, 25 Nov 2015 04:10:30 -0800 (PST)
In-Reply-To: <CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281703>

On Tue, Nov 24, 2015 at 5:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce a parsing function for each atom in valid_atom. Using this
>> we can define special parsing functions for each of the atoms. Since
>> we have a third field in valid_atom structure, we now fill out missing
>> cmp_type values.
>
> I don't get it. Why do you need to "fill out missing cmp_type values"
> considering that you're never assigning the third field in this patch?
> Are you planning on filling in the third field in a future patch?
>

I plan on filling that in upcoming patches. Probably, should mention that in
the commit message.

>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -19,42 +19,43 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>  static struct {
>>         const char *name;
>>         cmp_type cmp_type;
>> +       void (*parser)(struct used_atom *atom);
>
> Compiler diagnostic:
>
>     warning: declaration of 'struct used_atom' will not be
>         visible outside of this function [-Wvisibility]
>
> Indeed, it seems rather odd to introduce the new field in this patch
> but never actually do anything with it. It's difficult to understand
> the intention.
>

This is to make way for upcoming patches. But the compiler error is
accurate used_atom only becomes a structure in the next patch.
Should change that.

-- 
Regards,
Karthik Nayak
