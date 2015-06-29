From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 38/44] builtin-am: support and auto-detect StGit patches
Date: Mon, 29 Jun 2015 14:39:55 -0700
Message-ID: <xmqqtwtq8a8k.fsf@gitster.dls.corp.google.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-39-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbzb4E8D87nQi+dat6szOdnp56ta3bEwsUwieX=3SiJqw@mail.gmail.com>
	<CAPig+cRWno4RkemOFJj01rhx_0oFSJ-x2TMKTNxwhF1YSBxjzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Paul Tan <pyokagan@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:40:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9gma-0002qW-NQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 23:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbbF2Vj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 17:39:59 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37640 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbF2Vj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 17:39:57 -0400
Received: by igblr2 with SMTP id lr2so62115370igb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pV4XpmXuRXW61SU5YO/3404rhKDNL+dVmrXGPNDNJS4=;
        b=tpNhukU7OUZ7UaQsJVZfaZ4s4NadAUo9QYF+TfthNwHN3pkSWbCsbNST1kjwiYTi4n
         g1V9oXnn7TZkLbsPLqRw7H3C1I9QxkMIIoaRSSS3O8Z31MMGOuu5ykn8Etbaw+M3Lakd
         vB7lprQ5IFqyi2HUyl7y8zK4464zwNILABTyYBjoRBAw/wEpKxCBsNLVXT7NraUr95/T
         PezgOzmchWAundG5yDnKSoFzaLvf5yLUCTbJ+0ww/ViZwkl8xhdiesPoFf6LkKPwgamr
         z7GkEP+uZbfHrFkAoXLy6sqVkOrFqHZT8xz7zjub3Gk2iZfQlqIDYrrnyoRMdcs96rKw
         WlGQ==
X-Received: by 10.42.83.212 with SMTP id i20mr22095664icl.91.1435613997393;
        Mon, 29 Jun 2015 14:39:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id j4sm6345066igo.0.2015.06.29.14.39.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 14:39:56 -0700 (PDT)
In-Reply-To: <CAPig+cRWno4RkemOFJj01rhx_0oFSJ-x2TMKTNxwhF1YSBxjzQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 29 Jun 2015 16:51:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273025>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jun 29, 2015 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>> +/**
>>> + * Returns true if `str` consists of only whitespace, false otherwise.
>>> + */
>>> +static int str_isspace(const char *str)
>>> +{
>>> +       while (*str)
>>> +               if (!isspace(*(str)++))
>>> +                       return 0;
>> ...
>>     while (*str && !isspace(*(str)++))
>>         return 0;
> ...
> Ugh. Please don't break the logic with this strange and bogus transformation.
>
> If you really want it to read more idiomatically, try:
>
>     for (; *s; s++)
>         if (!isspace(*s))
>             return 0;

;-).

Regardless of the loop structure, I find

	*(str)++

especially ugly and confusing.  I'd understand if it were

	*(str++)

but the parentheses pair is unnecessary.

Not using any increment inside isspace(), like you showed, is the
most readable.

Thanks.
