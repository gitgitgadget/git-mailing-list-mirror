From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv12 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 15:12:21 -0800
Message-ID: <CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
	<xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:12:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXkJ-0002lf-BY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947616AbcBRXMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:12:23 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35165 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947224AbcBRXMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:12:22 -0500
Received: by mail-ig0-f178.google.com with SMTP id hb3so23794720igb.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h6veA+Ct2p9wihhMPlt0G3k2jaRaUAXgg4rZWCeFr+4=;
        b=g1UjWnSu3tc8le67aOA7+kfvP8e5Wm7qePgRh1xdAMa4ISjZbjw8mari4JrNAcT6Hw
         UOGP9a1vb8jQ3hxgD0U9szMMcKRhjsQvMvPHDgOsf9gvXDq4CPhTjC2YNZcfF6EQmCM7
         /q5QN4ruk56dvKed31/9RqhtLP/vKSwO8wl0jQmKhyv4weD1zvj9Va/usHAgTikH1bO9
         Tkcgpj4moOm5aFh68inKfVbbc6aGMDc2ChdiS+7/YlACXH2cS04+hAijjXQXFsulYkvK
         tubl+6Fq4zSTNiBwtb/XCCA+Yav4U19IPIY4lZDrqxwbJ+LpbcWGeuan5YLfoktQHEvO
         u8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h6veA+Ct2p9wihhMPlt0G3k2jaRaUAXgg4rZWCeFr+4=;
        b=P2kiqvk2LpS3KpBFGPE+QSSQWxztYLhOTDMFy1dE5f+7haQoUmUl4yoBNKmlXWbRmd
         D4oMNrDNh8E/oNH5JhC4cd9+1bGCP2M0QYc4SpSkKcU+6c54Vi43kE5wcBb1avQUEJuF
         phBS1o4nkC2OXZvIR+XUFcwLYsScqsiy8Nek/LVnZow5wlZyQLwysP/Pb02a1uCNwjQm
         GmmZV+ThxyiejWX26pez7jySZCNfxRSgmujwDPdt06W+XEWzrha4XBkg54KHFNwdhKlj
         6Ru1OvU8U187w3Ba7FU2NzzsgehHCAUGrvgifcNoL3cKsuNoYwlRAvbPDuto6IqbDd26
         xHug==
X-Gm-Message-State: AG10YOTTJHE53Fw4cblGCmjmU92v7rc9tzhwBeksOFsOkRujuJd1NWkSj99ouU0J4VJopAhyEbEhpIiZkUkq0Jmy
X-Received: by 10.50.176.195 with SMTP id ck3mr6319643igc.94.1455837141562;
 Thu, 18 Feb 2016 15:12:21 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 18 Feb 2016 15:12:21 -0800 (PST)
In-Reply-To: <xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286638>

On Thu, Feb 18, 2016 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Thanks Junio for a review of v11!
>>
>> I addressed the memory issue with the interdiff (in patch 1/7) as follows:
>> Interdiff to v11:
>>
>> diff --git a/submodule.c b/submodule.c
>> index 263cb2a..45d0967 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -219,6 +219,9 @@ void gitmodules_config(void)
>>  int parse_submodule_update_strategy(const char *value,
>>                 struct submodule_update_strategy *dst)
>>  {
>> +       const char *com;
>> +
>> +       free((void*)dst->command);
>>         dst->command = NULL;
>>         if (!strcmp(value, "none"))
>>                 dst->type = SM_UPDATE_NONE;
>> @@ -228,9 +231,10 @@ int parse_submodule_update_strategy(const char *value,
>>                 dst->type = SM_UPDATE_REBASE;
>>         else if (!strcmp(value, "merge"))
>>                 dst->type = SM_UPDATE_MERGE;
>> -       else if (skip_prefix(value, "!", &dst->command))
>> +       else if (skip_prefix(value, "!", &com)) {
>>                 dst->type = SM_UPDATE_COMMAND;
>> -       else
>> +               dst->command = xstrdup(com);
>> +       } else
>>                 return -1;
>>         return 0;
>>  }
>
> Unless you count "I want to write differently from what was
> suggested" is a desirable thing to do, I do not see a point in
> favouring the above that uses an extra variable and skip_prefix()
> over what I gave you as "how about" patch.  But whatever.

The skip_prefix was there before, so it stuck there.
Also it seems a bit more high level to me hence easier to read,
(though I am biased). I'll use your suggestion.

>
>  - Is dst->command always initialized to a NULL (otherwise the
>    unconditional upfront free() makes it unsafe)?

Yes, although just currently. It seems hard to maintain going forward as
the struct submodule_update_strategy is part of the struct submodule
(as defined in submodule.h) as well as the struct submodule_update_clone
(as defined in submodule--helper.c) and both places take care of initializing
it to null.

>
>  - Is there a global free_something() or something_clear() function
>    that are used to release the resource held by a structure that
>    has submodule_update_strategy structure embedded in it?  If so
>    dst->command needs to be freed there as well.

Sure, I'll just reroll the series now.

>
> Thanks.
>
>> Stefan Beller (7):
>>   submodule-config: keep update strategy around
>>   submodule-config: drop check against NULL
>>   fetching submodules: respect `submodule.fetchJobs` config option
>>   submodule update: direct error message to stderr
>>   git submodule update: have a dedicated helper for cloning
>>   submodule update: expose parallelism to the user
>>   clone: allow an explicit argument for parallel submodule clones
>>
>>  Documentation/config.txt        |   6 +
>>  Documentation/git-clone.txt     |   6 +-
>>  Documentation/git-submodule.txt |   7 +-
>>  builtin/clone.c                 |  19 +++-
>>  builtin/fetch.c                 |   2 +-
>>  builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh                |  54 ++++-----
>>  submodule-config.c              |  18 ++-
>>  submodule-config.h              |   2 +
>>  submodule.c                     |  39 ++++++-
>>  submodule.h                     |  18 +++
>>  t/t5526-fetch-submodules.sh     |  14 +++
>>  t/t7400-submodule-basic.sh      |   4 +-
>>  t/t7406-submodule-update.sh     |  27 +++++
>>  14 files changed, 406 insertions(+), 49 deletions(-)
