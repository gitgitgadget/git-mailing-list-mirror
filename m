From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 5/7] t5520: test --rebase with multiple branches
Date: Wed, 6 May 2015 00:00:27 +0800
Message-ID: <CACRoPnSeJT8MK5esRManC7a7v4D2jA4d8YOSvW90+rnoDxuhTQ@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbSMbhW2FLK05CaQjJjSTqEurB8iyeEBgyA1wbWJ4g2vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:39:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgok-0005vi-8j
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993857AbbEEQGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:06:37 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34330 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993491AbbEEQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 12:00:29 -0400
Received: by lbcga7 with SMTP id ga7so132303130lbc.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YjHuK+GZLIR5I/n+JSrECJBCbiMo0+jcFzYzsZQ0b98=;
        b=Op/4mqipAlwHaYbs63Q7Wy+LLQlgg761ZrGvU4x07Y3ZGqnlIuSXQ67JMqRR9kRweM
         uWYU+EO7IPXtoaPHuaRtLN9C2HsnbbHCsP8Sg1XwBoY92GUJs35ayE+sURS5Xg52AXRC
         ++6NcUbAxJQLqfDxteSkTUzvnfVW17R4ukpQByXOtkOmR5JBeWugvlJZr+Q4Xiaw48pW
         hBAExqk0KikOt41KQ/6wM5cy2ecA/ulxfUS/e3LiGXWGT4uUyq0Qt3hnht47Fog6+r81
         s7+HBLV4kZrBRzyGUPMVIJ0ibfvunWGFW8XCI8k/8QCooNpBiIYjzm86z+ji9K9U4AaS
         +tHA==
X-Received: by 10.152.4.72 with SMTP id i8mr25349814lai.32.1430841627746; Tue,
 05 May 2015 09:00:27 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 09:00:27 -0700 (PDT)
In-Reply-To: <CAGZ79kbSMbhW2FLK05CaQjJjSTqEurB8iyeEBgyA1wbWJ4g2vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268402>

Hi,

On Tue, May 5, 2015 at 1:09 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, May 2, 2015 at 8:37 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 25d519d..17c63ff 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -223,6 +223,14 @@ test_expect_success '--rebase' '
>>         test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
>>         test new = $(git show HEAD:file2)
>>  '
>> +
>> +test_expect_success '--rebase fails with multiple branches' '
>> +       git reset --hard before-rebase &&
>> +       test_must_fail git pull --rebase . copy master 2>out &&
>> +       test_when_finished "rm -f out" &&
>
> I think it would make sense to switch the previous 2 lines, because the
> test_when_finished should also be run if the test actually fails.
> The actual tested part may segfault, which would interrupt the && chain
> from reaching the test_when_finished line. And here, the line to test
> is meant to be the "git pull --rebase" line, so we'd assume it may be
> stopping there due to failures in the tested program.
>
> If you grep through the code base, you'll find lots of test_when_finished
> commands as the very first command (or the earliest spot where it makes
> sense).

Hmm, thinking about it again, I actually don't really think there's
that much of a need to "rm -f out" in this case ;-)

But yes, I should go review the placements of the test_when_finished calls :-).

Thanks.
