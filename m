From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Tue, 16 Jun 2015 01:20:17 +0800
Message-ID: <CACRoPnS9fkNQTB8bEKdOBqFgV1E1Mff7oE8rBFDUK+c-woxqZg@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
	<xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
	<CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
	<xmqqwpz4ao6l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Y3d-0001R2-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 19:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbbFORUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 13:20:21 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35698 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbbFORUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 13:20:19 -0400
Received: by lbbwc1 with SMTP id wc1so5936664lbb.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uli6cDtI4mrP2P5419/QkaEQOBsNa7iLPKe2inm37UU=;
        b=lLWQdfok2Fl8JFkLSdlEoHODf/oeEH+fSGGlUjiXJ6lTbjQY94cTKFGlFTgDQn7TyY
         FsoyXSLyROagmlT0EDnyh9l+K2TZTGBy0B3ZruUogoyjZTqCmztW6A5GnWC3oDWAY6cb
         FQL9YDWA1z7DbDKaHqWKZdVNrRsT6+rDvK8B2IOuwacIMV681qMFCPzp+kFQsironXp7
         Wk/6xWkcB8M9Xyn0KlJsMVyVvLQ9PKRBIEBlpITwh3tmdlp1Zf8ESCPpPW++FVSC2Bms
         t0wtofUdd0oG6XOU8tqx4kLZEUQMQSY/KpZ453m4GYbmg9no22gVBjvai2gT9aDI649S
         9tpw==
X-Received: by 10.112.93.230 with SMTP id cx6mr1212775lbb.65.1434388817650;
 Mon, 15 Jun 2015 10:20:17 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 15 Jun 2015 10:20:17 -0700 (PDT)
In-Reply-To: <xmqqwpz4ao6l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271691>

On Tue, Jun 16, 2015 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> On Mon, Jun 15, 2015 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Paul Tan <pyokagan@gmail.com> writes:
>>>> diff --git a/git.c b/git.c
>>>> index 44374b1..42328ed 100644
>>>> --- a/git.c
>>>> +++ b/git.c
>>>> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>>>
>>>>  static struct cmd_struct commands[] = {
>>>>       { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>>>> +     { "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
>>>
>>> Would this, especially having RUN_SETUP, keep the same behaviour
>>> when the command is run from a subdirectory of a working tree?
>>> e.g.
>>>
>>>         save messages to ./inbox
>>>         $ cd sub/dir
>>>         $ git am ../../inbox
>>>
>>
>> Yes, in 05/19, where the splitting of patches is implemented, we
>> prefix the mbox paths with the path to the working tree.
>
> I wasn't wondering about your new code.
>
> The scripted Porcelain is spawned after applying patches 1-3 from
> here, when you do not have _GIT_USE_BUILTIN_AM exported.  Haven't
> RUN_SETUP code did its thing by that time?

Ah right, the RUN_SETUP code would have chdir()-ed to the working
directory root, so git-am.sh will be unable to find the original
working directory. To aid it, we would have to chdir() back to the
original working directory, and unset GIT_DIR.

Thanks,
Paul
