From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 65/83] builtin/apply: make gitdiff_verify_name() return -1
 on error
Date: Sun, 1 May 2016 21:31:12 +0200
Message-ID: <CAP8UFD38YhMkqYLxLrSA4oi2D=3mjo+grJ00K-5LPxpH3rNBdA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-66-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8ATSuijr9beSuJ7X51hsmFVCs7TKEYd3puoLPMtVjKZ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 21:32:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awx6e-0000bc-8f
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcEATbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:31:14 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36279 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbcEATbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:31:14 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so85348113wmn.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7T9XqjJGRNeB/OFRwfzNxJk202/wvM0BBwXW/SIWI9I=;
        b=V4ceLRjf4Wp9O1iHlE2DN/gn7h+SUpBbnO5QO9r7JWiHTvIpPpf7yHjz+hpXDQgWTi
         KsfcccuNl6F2v1zPaLlh+KA9nyXZIIDl+3oa6wU273/iWJniW8BRT3M5Zn6F2yhMfcRe
         9HT9W6EDRY28o98Ec/oj+3Mfp/W0kXBub3bpIjj1sRO1T2YfnzsEqp52G5AFKfMww/5z
         gXnnRr54LatuUFhYAes0k4qdRTwg+H4TzyOcCkgZRnCNeCFtu5+Fe4s4CfzXVF392vzV
         T0aPybSOqOY6fG69yfiJ96jxOyrI8l6jCkEikhPbNw49voj24bkAvquqoTm8LYdqY/Xw
         Al6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7T9XqjJGRNeB/OFRwfzNxJk202/wvM0BBwXW/SIWI9I=;
        b=W5GjMQfvSeAelwIAtJWQcWMOE8j5zAPSrQhUkLpWWn+JQJZYbgNRDh8UUD/KYxJmVS
         ohNRXEu2gJ70RKlBZPxgM5aQfUS4LQzzScPcATLNIPY5GgS3/5FNI6G5MYMSJmwmZGTZ
         UiAgUUOdXjNM+92D3JkS8XtCc6oIaoLvzmhonocBiyvIfgXIa/brPkx9t2gv7CrFOXti
         2RhtMi8mxbS4/ykUl7EP1gJqmzcrzO5RQuJF8U2nUoSGoGoYhNn9My+2DyCzXiavfqsB
         zmFcChjpyUvFNsK4limMp50VnWz8Jat2oo9l+u09ZzdMUlYFx73hY6sZ8DQQEDfx1MET
         wVdA==
X-Gm-Message-State: AOPr4FXSklkoeb/eRJ/jt2b284JqU+9DW5MhTGxubvTD3BurbnGhiqK5ctciheUASR+aGG2nnaqtrrQ34/iMxg==
X-Received: by 10.28.128.83 with SMTP id b80mr15840503wmd.89.1462131072454;
 Sun, 01 May 2016 12:31:12 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 12:31:12 -0700 (PDT)
In-Reply-To: <CACsJy8ATSuijr9beSuJ7X51hsmFVCs7TKEYd3puoLPMtVjKZ9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293209>

On Mon, Apr 25, 2016 at 3:36 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 52 ++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 30 insertions(+), 22 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 6b8ba2a..268356b 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -812,7 +812,7 @@ static int gitdiff_hdrend(struct apply_state *state,
>>                           const char *line,
>>                           struct patch *patch)
>>  {
>> -       return -1;
>> +       return 1;
>>  }
>
> These are in a function group that will be called as p->fn() in
> parse_git_header(). Is it possible to isolate them in a separate
> patch? This patch can follow after, which covers only
> gitdiff_verify_name() returning -1 and its call sites.

Yeah, I had planned to do something like that when developing the
series but I forgot.

Thanks,
Christian.
