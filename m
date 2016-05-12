From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 22/94] builtin/apply: move 'threeway' global into
 'struct apply_state'
Date: Thu, 12 May 2016 22:26:34 +0200
Message-ID: <CAP8UFD1VYW6+T_oTHJbemUhi8MPrMseaObWgoy0Xou=VCoKt-A@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-23-chriscool@tuxfamily.org>
	<xmqqoa8bdpym.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 22:26:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xBw-00041u-5H
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbcELU0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:26:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36536 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbcELU0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:26:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so17899398wmw.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=P0yGI/aTJQOfZmOHtmmxp9BA4uC+4hdn569TMsqrZw4=;
        b=F1FAmyuJ/t7pSC1TmtcZ402UNBgwL6BXKOD6QYjs1lC69f1E08nO6XuYCz78ujCYUz
         NjdWRBVPeCJoeP8+Yha0vlKmxkcILP3Me1ygQXyH8QTZBd7Uziq635XFWca+IxDBTlxt
         6p7K0RlPiwv8JvbiNgMgYvdfnKSD0PXdvceCLhg08Bhy9bYlsVypZYMiSgQDTfqgSrxB
         G1vR/gJ5DoxrmJlbV5I8QGxg8eGH7SjyeBDPbVkkYaNtRG+lgdnbbEv7DZRJS/J0RD3+
         w3JZ9F5eWjc0IIEpmyK/HnQcDoExlmlgCJ023skn4foqV5iwof4sa5gHxlGJrcPIU7rf
         9OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=P0yGI/aTJQOfZmOHtmmxp9BA4uC+4hdn569TMsqrZw4=;
        b=eQTrXryio2SvEbosvYAMhEan+zxx/x5hnZnaketg+HyzQ9d7B8IYWg2I4Gn2yuzbXi
         pG2EDtsOy3KXYdfKscZJp2T3kFydpYRuagCr6rr8xqrcFdk8rQoduc6y5EIb93W4tP9q
         5AcgSqRJK3dfijXJ1gAMraX6LOnel7HWqcbHrm3GX6qQe/M3qTIiqZmxXbHrUYF5/4N6
         4VXhBHB64bxFGKZ2hMjpLdd7B/fK0kkARZh0F3IEEMpBl8QUTgOM1VbsnYmMb0Th57VC
         qKP2nL6HjJnDZ4IrMEksIdJ2I/JnMmk3SvhH1yS2jsabT/NMRkBgVw4eUOAQRSfEWKbF
         6LUw==
X-Gm-Message-State: AOPr4FV9+OPs4fu0dY672koZwdrKhfzMsXcfs6DR3fG6I1R6JBJk+QYgGJFmqj8yMGMcBvUDsgAKF5q2vUJQcg==
X-Received: by 10.194.117.70 with SMTP id kc6mr13015586wjb.94.1463084794190;
 Thu, 12 May 2016 13:26:34 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 12 May 2016 13:26:34 -0700 (PDT)
In-Reply-To: <xmqqoa8bdpym.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294472>

On Thu, May 12, 2016 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> To libify the apply functionality the 'threeway' variable should
>> not be static and global to the file. Let's move it into
>> 'struct apply_state'.
>>
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 6216723..3650922 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -40,6 +40,7 @@ struct apply_state {
>>       int numstat;
>>
>>       int summary;
>> +     int threeway;
>
> This makes threeway look as if it is one of the cosmetic options
> like stat/numstat/summary, doesn't it?  If anything, the blank
> between numstat and summary should be moved below summary.

There is a blank because there is a comment on the line before
numstat. The result looks like this:

    /* --cached updates only the cache without ever touching the
working tree. */
    int cached;

    /* --stat does just a diffstat, and doesn't actually apply */
    int diffstat;

    /* --numstat does numeric diffstat, and doesn't actually apply */
    int numstat;

    int summary;
    int threeway;
    int no_add;


>  I'd
> group knobs that affect "what is affected (check, check_index,
> cached, etc.)", "how the application is done (allow-overlap,
> threeway, in-reverse, etc.)" and "cosmetics" and place the ones in
> the same group next to each other.

Ok, I will try to group knobs like that, but the comments tend to
break the groups.
