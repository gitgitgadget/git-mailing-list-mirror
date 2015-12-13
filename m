From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 18:36:39 -0600
Message-ID: <CAOc6etYAbT8Yc3NwB4Rh1dShjDQB_PR2K-HvXpx6dTcB=YaB8w@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
	<CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:36:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7ueb-0008Mv-7i
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbbLMAgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:36:40 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35332 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbLMAgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:36:40 -0500
Received: by padhk6 with SMTP id hk6so44340509pad.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qRox/Zx+88TQ2EJetcQUoNY1kCZ7p7MXbeeoj1BZFmE=;
        b=Mf/Fla2kEYbRT4KxVNcxXgLVs+BFuQp6OYgmivRWxb4yCDv7owdSoYPLzgCOnTg1fL
         t5XPjygQfij1ltFNpESBxxGK045oShqYKAZDiefniQUoO6pql2sjAS12iecAG/Wrw+SD
         exjlR6d8Gt8gGaSz+sB8wUImWTdZ5WbJoPy8RdbSNGCCFnoyLJZPu9jCPg6yiB76X86E
         Fg2ywbeNzw8BhGa/ck+WDXQULeq1xQpSL8TtgouB4wSIE0mG4XvFBUxUQx1MIZ0PMaF6
         xpIeVAf2EVUSQrmOqp5VTAUfzRzzXgXFLTngWPKQr07r2sWuZ+ewNuO+t6/5hugjxRlX
         6R5w==
X-Received: by 10.66.90.234 with SMTP id bz10mr35868379pab.115.1449966999734;
 Sat, 12 Dec 2015 16:36:39 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sat, 12 Dec 2015 16:36:39 -0800 (PST)
In-Reply-To: <CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282309>

On Sat, Dec 12, 2015 at 6:30 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>>
>> The 'show_progress = 0' seems unnecessary. What if you did something
>> like this instead?
>>
>>     if (show_progress > 0 && (incremental ||
>>             (output_option & OUTPUT_PORCELAIN)))
>>         die("--progress can't be used with...");
>>     else if (show_progress < 0)
>>         show_progress = isatty(2);
>>
>>>         if (0 < abbrev)
>>>                 /* one more abbrev length is needed for the boundary commit */
>>>                 abbrev++;
>
> Because, if the user didn't provide --[no-]progress option, then the
> value in show_progress will move forward being -1 and then in
> assign_blame, there will be progress output if you chose --incremental
> or porcelain. So, if you chose --incremental or porcelain, we better
> set the value to 0 to make sure there will be _no_ progress. Agree?


Hmmmm.... if the code in assign_blame changed to this, it would be
possible to allow the -1 to go through:

if (show_progress > 0)
    pi.progress = start_progress_delay(_("Blaming lines"),
sb->num_lines, 50, 1);

But then I think it would be more 'concise' if we had the value set to
0/1 instead of expecting to see a possible value of -1 there (or
anywhere else) after progressing if progress will be shown or not in
the piece of code we are chatting about.

Comments?
