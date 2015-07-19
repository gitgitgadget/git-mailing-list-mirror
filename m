From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Modify tr expression so that xpg4/tr handles it on Solaris
Date: Sat, 18 Jul 2015 23:45:11 -0400
Message-ID: <CAPig+cQ7E5+0aZ09Bhv+j_wmBkOq9kbqUyqxTn=qVV8+j7Mbrw@mail.gmail.com>
References: <1437232877-27897-1-git-send-email-bdwalton@gmail.com>
	<CAPig+cQYROsp4nsEj1cJ=W+BtxO5iQ0_UHUaJHScpN7iQBpi6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGfXU-0008CL-RL
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbbGSDpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:45:12 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35820 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbGSDpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:45:12 -0400
Received: by ykdu72 with SMTP id u72so117349173ykd.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=q9EIkvyzue4cuuvUaPoaWDxBXQgh+QqowAhCD7zDI3w=;
        b=IQU8YCYO7/WJV8349TJtWL+NmuaPMmCUJnV5SxSvWziP6c77KwxK2wsGubj3ay+6er
         5Jr9iVsVP4fUbWxgLXGdcraZpGGKLB/I+3mPBGq9PvfKVEV1J55JwEEnPf5efy3eXq1w
         SF9gjVU/sUaRCH4Oa1fZqdg0ZXOYBRzLbvEuYtDotdoJxOjEvEBdaWGfq9DCZ9+2Qn76
         tTOs8kAI9HzoC+mxv7BmiEqkwn6JGcklxwSJ0V4R66e7BNJ3jtLoAM6g8mPvBS92/brt
         3aHXM97II7hGDZTzAjqbREr0mJ20oQCeAkIiNClXAFrjgcD41PAR2kjKZucnuc9LwN0G
         zNUw==
X-Received: by 10.13.202.204 with SMTP id m195mr22184707ywd.48.1437277511465;
 Sat, 18 Jul 2015 20:45:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:45:11 -0700 (PDT)
In-Reply-To: <CAPig+cQYROsp4nsEj1cJ=W+BtxO5iQ0_UHUaJHScpN7iQBpi6A@mail.gmail.com>
X-Google-Sender-Auth: EY9rA5V2-z0QKuJgwllem99uXfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274201>

On Sat, Jul 18, 2015 at 11:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 18, 2015 at 11:21 AM, Ben Walton <bdwalton@gmail.com> wrote:
>> It seems that xpg4/tr mishandles some strings involving [ not followed
>> by a character class:
>> % echo '[::1]' | /usr/xpg4/bin/tr -d '[]'
>> [::1
>>
>> % echo '[::1]' | /usr/xpg4/bin/tr -d '['
>> usr/xpg4/bin/tr: Bad string.
>>
>> This was breaking two tests. To fix the issue, use the octal
>> representations of [ and ] instead.
>>
>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>> ---
>> -               ehost=$(echo $3 | tr -d "[]")
>> +               ehost=$(echo $3 | tr -d "\133\135")
>
> These octal values are somewhat opaque. To make this more
> self-documenting, would it make sense instead to define a global
> variable named 'brackets' or 'squarebrackets' (or something) and then
> reference that variable in each of the 'tr' commands?
>
>     brackets='\133\135'
>     ...
>     ehost=$(echo $3 | tr -d $brackets)

Quoted, of course:

    ehost=$(echo $3 | tr -d "$brackets")
