From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Mon, 15 Jun 2015 10:14:58 -0700
Message-ID: <xmqqwpz4ao6l.fsf@gitster.dls.corp.google.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
	<xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
	<CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:15:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4XyV-0005af-7s
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 19:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbbFORPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 13:15:01 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34943 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbbFORPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 13:15:00 -0400
Received: by iesa3 with SMTP id a3so66948567ies.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FEXoTbrO6nYXjuZN+pGuWR4mo2d40Ll2Du+9anC0tog=;
        b=gwCzazYNuWjBemzUFb14nhcu7JmWcx6GbakEjNVyRBWoe7K3xR0HKVaXt+zJIJd9kR
         dMuU/OekO2djvw5hns2ErAbKjkm3maYh4WJG38NYjBs/Gt6T0JU3RSyQ2oNJFvN29Mms
         b31oMjOnVa3IFdtNQbRX24f3YrRBjlnLWkiVzJWsCnbMVhrM449odgzB8J8/UYwI8RRO
         PMfK0yv1xSV6JjVc/QGDXpbWI+yjB3bXit6PTdtCApSh4P2vIVEWFqZsVrcNqka6y9r8
         DhiBmgghnmUcdN9Y+1f2T8Ei10ccIFDC09dIaWP50lSZF0kawmWv1CloLgYPMiQQuXUU
         FgNA==
X-Received: by 10.107.16.216 with SMTP id 85mr23480096ioq.69.1434388500055;
        Mon, 15 Jun 2015 10:15:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id k81sm9239777iod.31.2015.06.15.10.14.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 10:14:59 -0700 (PDT)
In-Reply-To: <CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
	(Paul Tan's message of "Mon, 15 Jun 2015 17:49:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271690>

Paul Tan <pyokagan@gmail.com> writes:

> On Mon, Jun 15, 2015 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>>> diff --git a/git.c b/git.c
>>> index 44374b1..42328ed 100644
>>> --- a/git.c
>>> +++ b/git.c
>>> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>>
>>>  static struct cmd_struct commands[] = {
>>>       { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>>> +     { "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
>>
>> Would this, especially having RUN_SETUP, keep the same behaviour
>> when the command is run from a subdirectory of a working tree?
>> e.g.
>>
>>         save messages to ./inbox
>>         $ cd sub/dir
>>         $ git am ../../inbox
>>
>
> Yes, in 05/19, where the splitting of patches is implemented, we
> prefix the mbox paths with the path to the working tree.

I wasn't wondering about your new code.

The scripted Porcelain is spawned after applying patches 1-3 from
here, when you do not have _GIT_USE_BUILTIN_AM exported.  Haven't
RUN_SETUP code did its thing by that time?
