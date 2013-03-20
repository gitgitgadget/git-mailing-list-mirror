From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Wed, 20 Mar 2013 19:05:32 +0530
Message-ID: <CALkWK0miT-Gtku1VU0qpX6L2VnrwgHnmpYwuXCME55cSGscgTA@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-7-git-send-email-artagnon@gmail.com> <CALUzUxobybPOqsLgEFVOCK2OLOvyqHtAiuyi8wozOSYeWzkhNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 14:36:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIJBn-0006bd-6N
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 14:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab3CTNfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 09:35:55 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:44695 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab3CTNfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 09:35:54 -0400
Received: by mail-bk0-f54.google.com with SMTP id w5so856577bku.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5UwoORVnLFBVFuzGb8+eI/2LwhNRxIV/uGyicwE/7ts=;
        b=MNzxSZAq+ECqpD3GgFcVnwkS4i4518PTzZGW625mlpCUB4qILt6R6NpWLFUS4sDolO
         y7C7CigT/OaSw+zdjnq9/04jlVEuOjiwkBOxyKK9pSY4/65Quk2n5HJKLlaY5QdvUPQf
         eLx5y3t+LmoSw4uW4nza1y0G/r34sp5eQol7hF5LeE8Y1rdCpbJfvzHV1z9vFrRH9xlo
         gJDsrh6kcgk3/EIChxPfYrxIN4OfNNTJ6iI52hg9N9hLfqtfwosroWuoNOOExYjRH9UY
         SrI/YCBd+fgjkK3Xm+8kb/NPIX3XNRIqt+QxyFp5MDbLg53wlhzIE9VSBw/qQAg4+n6X
         aL6Q==
X-Received: by 10.205.40.202 with SMTP id tr10mr10934140bkb.24.1363786552544;
 Wed, 20 Mar 2013 06:35:52 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Wed, 20 Mar 2013 06:35:32 -0700 (PDT)
In-Reply-To: <CALUzUxobybPOqsLgEFVOCK2OLOvyqHtAiuyi8wozOSYeWzkhNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218607>

Tay Ray Chuan wrote:
> On Wed, Mar 20, 2013 at 8:45 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> This new configuration variable overrides `remote.pushdefault` and
>> `branch.<name>.remote` for pushes.  In a typical triangular-workflow
>> setup, you would want to set `remote.pushdefault` to specify the
>> remote to push to for all branches, and use this option to override it
>> for a specific branch.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Documentation/config.txt | 18 ++++++++++++++----
>>  remote.c                 |  3 +++
>>  t/t5516-fetch-push.sh    | 15 +++++++++++++++
>>  3 files changed, 32 insertions(+), 4 deletions(-)
>
> Shouldn't this patch be squashed into 5/6 because of...
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e813c33..4b9647a 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -726,9 +726,18 @@ branch.<name>.remote::
>>         When on branch <name>, it tells 'git fetch' and 'git push'
>>         which remote to fetch from/push to.  The remote to push to
>>         may be overridden with `remote.pushdefault` (for all branches).
>> -       If no remote is configured, or if you are not on any branch,
>> -       it defaults to `origin` for fetching and `remote.pushdefault`
>> -       for pushing.
>> +       The remote to push to, for the current branch, may be further
>> +       overridden by `branch.<name>.pushremote`.  If no remote is
>> +       configured, or if you are not on any branch, it defaults to
>> +       `origin` for fetching and `remote.pushdefault` for pushing.
>> +
>
> ...this? (Since this description was introduced in 5/6)

Huh?  This patch introduces branch.<name>.pushremote: the relevant
code and documentation changes.  5/6 introduces remote.pushdefault,
which is completely different.
