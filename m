From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 03:08:40 -0800
Message-ID: <CA+sFfMeB_PEgoykPj-RX6zZ-hOD1106aO_KwkWF7BBiJvG-1AA@mail.gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
	<1358757627-16682-2-git-send-email-drafnel@gmail.com>
	<20130122075413.GB6085@elie.Belkin>
	<CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
	<20130122094720.GA8908@elie.Belkin>
	<20130122094916.GB8908@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 12:09:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txbix-0005Ex-HS
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 12:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab3AVLIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 06:08:42 -0500
Received: from mail-vb0-f51.google.com ([209.85.212.51]:64132 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab3AVLIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 06:08:41 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so5310205vbb.24
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=p6BADpUD6YxHGKL6Ne5VLuswapBcjNiT0UJXl332mIo=;
        b=BaH3tOPcv2oyEIeKBoMrStaINmwFAkj3FztiFn+USjJB/zxrdRNxXhHMpdHzcW6PGV
         R9hvxl2IF7KScWu1ITqE1eRC4z5uhitpk1xPNqWC68QfN/ZE11mVxsbLuGrL6ayEwiJb
         ex6LMxXtl4irC4bslN/uO6FO+EaVkV8J3j6RMQfLGGi543czqLL1J3RmAi2gEguy34KL
         NIMafaQnfmmQ/Gm9ebk1FzcoRqax/B00ivRj1lbZsOLoauqzJYiFWhkeggXoHGNt1unN
         2CYJ+zw+5DYOpRdGyPFmOZe3Ea77D9yloSJrBXVCyXJMNJGRAxiU+poodbr+TIJZ657T
         tmZA==
X-Received: by 10.220.151.9 with SMTP id a9mr2383594vcw.7.1358852920188; Tue,
 22 Jan 2013 03:08:40 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Tue, 22 Jan 2013 03:08:40 -0800 (PST)
In-Reply-To: <20130122094916.GB8908@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214231>

On Tue, Jan 22, 2013 at 1:49 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>
>> Here is the loop in master:
>>
>>       int hit = 0;
>> [...]
>>
>>       for (i = len - 1; i > 0; i--) {
>>               if (hit && buf[i] == '\n')
>>                       break;
>>               hit = (buf[i] == '\n');
>>       }
>>
>> I don't see any adjacency check.
>
> Of course that's because I can't read. :)  Checking again.

Blame the code, not your eyes.  The use of the term 'hit' is what
makes this loop confusing.  It gives the impression that 'hit' gets
set once, after the first newline is /hit/.

It would be much easier to read if it was written like this:

   int last_char_was_nl = 0;
   for (i = len - 1; i > 0; i--) {
           this_char_is_nl = (buf[i] == '\n');
           if (last_char_was_nl && this_char_is_nl)
                   break;
           last_char_was_nl = this_char_is_nl;
   }

I'll slide this in when I resubmit this series with your suggestions.

-Brandon
