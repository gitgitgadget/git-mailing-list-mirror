From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] config: add options to list only variable names
Date: Fri, 29 May 2015 13:34:50 +0200
Message-ID: <CAP8UFD2Zhomk+ryRfZFWAVs0yZeXUfpBXTo51Cm=Lj1QbkRbmA@mail.gmail.com>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-2-git-send-email-szeder@ira.uka.de>
	<xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 13:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIYz-0005Yt-4B
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbbE2Lex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2015 07:34:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33070 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbE2Lew convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 07:34:52 -0400
Received: by wgez8 with SMTP id z8so60118875wge.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jZzgYO33HcEvr+pCXscIphIEvfgBobzJS/2Xsx3aKH0=;
        b=cV7FkVoHwWTeuYX2vTmIahtZKf28Ishxz+pfmUg23zkTFy/GbjyZBzy1MdncjDTDs1
         hHI2ULOQYEnZmDIsiriO0EosM4qNPdpnTK2sQadRbXekCST4bAc3h3jrJii0ZAIWtInl
         qaPtksl04LGby169IYD/qzqaS2KODq4IeLz/1Pr16bTPzp1ZUKQRV891r7ZS8zcPS9pJ
         VYYJ+85/PNtu8t62lNwrLX+OLjHV+6aWv60knegI4IyM/cbrQnekTNBYago61kXrnNh4
         Msl8FiUt1JfCHMp/SKNQkmVnWhsszgMvK/JkBaqXPgMtuABBo7e78mbPXQvyjqbSof8z
         3CPA==
X-Received: by 10.180.98.103 with SMTP id eh7mr4378276wib.75.1432899290779;
 Fri, 29 May 2015 04:34:50 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 29 May 2015 04:34:50 -0700 (PDT)
In-Reply-To: <xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270226>

On Thu, May 28, 2015 at 9:20 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> @@ -16,11 +16,12 @@ SYNOPSIS
>>  'git config' [<file-option>] [type] [-z|--null] --get-all name [val=
ue_regex]
>>  'git config' [<file-option>] [type] [-z|--null] --get-regexp name_r=
egex [value_regex]
>>  'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name=
 URL
>> +'git config' [<file-option>] [-z|--null] --get-name-regexp name_reg=
ex
>> ...
>
> At first I wondered why --get-name-regexp is needed, as (purely from
> the syntactic level) it appeared at the first glance the existing
> '--get-regexp' without 'value_regex' may be sufficient, until I read
> this:
>
>> +--get-name-regexp::
>> +     Like --get-regexp, but shows only matching variable names, not=
 its
>> +     values.
>
> which makes it clear why it is needed.  The distinction is purely
> about the output, i.e. the values are omitted.

If the distinction is purely about the output, then it seems logical
to add only an output related option, like the --name-only option I
suggested, and not 2 new modes (--get-name-regexp and --list-names).

Doesn't it look like git config already has too many modes?

> But then it makes me wonder why --get-name-regexp shouldn't
> optionally accept value_regex like --get-regexp does, allowing you
> to say "list the variables that match this pattern whose values
> match this other pattern".  I know it may be a feature that is
> unnecessary for your purpose, but from a cursory look of the patch
> text, you do not seem to be doing anything different between
> get-regexp and get-name-regexp codepaths other than flipping
> omit_values bit on, so it could be that the feature is already
> supported but forgot to document it, perhaps?

This also suggests that it might be more logical to only add an option
called --name-only or --omit-values that would map directly to the
omit_values bit in the code.
