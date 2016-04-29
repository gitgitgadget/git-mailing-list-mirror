From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/15] submodule init: redirect stdout to stderr
Date: Fri, 29 Apr 2016 11:38:32 -0700
Message-ID: <CAGZ79kawUMng_hPju3MDW2xFmKkhqOQMVihFTA+7Wt0EaNdpug@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-7-git-send-email-sbeller@google.com>
	<xmqqy47wxocr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:38:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awDJF-00009H-F7
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcD2Sif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:38:35 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36240 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbcD2Sid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:38:33 -0400
Received: by mail-io0-f172.google.com with SMTP id u185so134551411iod.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dEz7SL7fyRb4849xl/Y/cFxSuGOM7r0t3AvF/Fv/FYQ=;
        b=obHxozqwz4Gnh/NDG1QOQlVHBTomtUpSXJHTD97IgaP7FliQWXxpLPJ5FCvgv30A+y
         8VzMnsOCzbkszJ/NZdIpxkfFvv1y+YBsQD3Fm1UlXQ5whf7ly0tNVeiqemFcLPkZw7Jb
         pq2e04/1SQnGs4WjiTU1oukVWGGcjOjSF4nNh7bo1L7IwBrLaiVc5eDuNObb/E1cocu1
         E+q7Ucyq321hb5VAmZl4S/lbymjHCkx3RAzB19z6jPDM6Wuq+k8e4ZD65u31tOLGDX9b
         2GKbdHRh3bSBTrC7ja4rFwxd68760fChbycTZrT1td78Q7g2++2EDEN5oRlFFH/ewV/8
         3d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dEz7SL7fyRb4849xl/Y/cFxSuGOM7r0t3AvF/Fv/FYQ=;
        b=HlfFtdaN5jo76X1xx/iNJkvBo8TZ8KVOb4I+OfIRY08UQrDfGk5Z1SawkAbBA+lapM
         RgCI0AN/CShvvwTnhFQ0ASJh1R/TBJVzk1mjfJVi9EyDUhiCV+KPmoTDsTFgTCCo9bLr
         GKF91Ndbkc5q5OCFj1dfGiq230P5tgUgtOAhhwMBWYlKIup6hMe88lkabvbBcBtm3/mk
         nKlkHHG6VcmymB3jOFDJBKB8+PRPA6wh8WlVZuu+pjiy+6ydZvZ+RYYkE1dz5cd82TJh
         GusjmuPobP6tp9GUpg0mv0Raa8phvR75/qXm28QmfmZ2ujqHx08ng0mL9xxET8R6xzZB
         IG0A==
X-Gm-Message-State: AOPr4FWjCAmnWbWwrAysosH8z0OsYPXb/c98AM/ViSWin2vLjEurAzNHTU/kcjPxwBlm2MLt5wlFecTh8p+IZ3dM
X-Received: by 10.107.174.205 with SMTP id n74mr26054782ioo.96.1461955112629;
 Fri, 29 Apr 2016 11:38:32 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 11:38:32 -0700 (PDT)
In-Reply-To: <xmqqy47wxocr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293044>

On Fri, Apr 29, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Reroute the output of stdout to stderr as it is just informative
>> messages, not to be consumed by machines.
>>
>> We want to init submodules from the helper for `submodule update`
>> in a later patch and the stdout output of said helper is consumed
>> by the parts of `submodule update` which are still written in shell.
>> So we have to be careful which messages are on stdout.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> I do not mind if this step is split out and queued as a separate
> follow-up to sb/submodule-init.  The grouping and labelling is a
> bigger and more important change that deserves attention without
> distraction than this single step, and making as many such things
> graduate and allowing us to forget about them is better ;-)

Care to apply this onto the sb/submodule-init then?

(It applies cleanly for me on top of "submodule--helper update-clone:
abort gracefully on missing .gitmodules")

I'll drop this patch in the groups series.

Thanks,
Stefan

>
>>  builtin/submodule--helper.c |  3 ++-
>>  t/t7406-submodule-update.sh | 24 ++++++++++++++++++------
>>  2 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 23d7224..7b9a4d7 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -362,7 +362,8 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>>                       die(_("Failed to register url for submodule path '%s'"),
>>                           displaypath);
>>               if (!quiet)
>> -                     printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
>> +                     fprintf(stderr,
>> +                             _("Submodule '%s' (%s) registered for path '%s'\n"),
>>                               sub->name, url, displaypath);
>>       }
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index fd741f5..5f27879 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -108,24 +108,36 @@ pwd=$(pwd)
>>
>>  cat <<EOF >expect
>>  Submodule path '../super': checked out '$supersha1'
>> -Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
>> -Submodule 'none' ($pwd/none) registered for path '../super/none'
>> -Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
>> -Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
>>  Submodule path '../super/merging': checked out '$mergingsha1'
>>  Submodule path '../super/none': checked out '$nonesha1'
>>  Submodule path '../super/rebasing': checked out '$rebasingsha1'
>>  Submodule path '../super/submodule': checked out '$submodulesha1'
>>  EOF
>>
>> +cat <<EOF >expect2
>> +Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
>> +Submodule 'none' ($pwd/none) registered for path '../super/none'
>> +Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
>> +Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
>> +Cloning into '$pwd/recursivesuper/super/merging'...
>> +done.
>> +Cloning into '$pwd/recursivesuper/super/none'...
>> +done.
>> +Cloning into '$pwd/recursivesuper/super/rebasing'...
>> +done.
>> +Cloning into '$pwd/recursivesuper/super/submodule'...
>> +done.
>> +EOF
>> +
>>  test_expect_success 'submodule update --init --recursive from subdirectory' '
>>       git -C recursivesuper/super reset --hard HEAD^ &&
>>       (cd recursivesuper &&
>>        mkdir tmp &&
>>        cd tmp &&
>> -      git submodule update --init --recursive ../super >../../actual
>> +      git submodule update --init --recursive ../super >../../actual 2>../../actual2
>>       ) &&
>> -     test_cmp expect actual
>> +     test_cmp expect actual &&
>> +     test_cmp expect2 actual2
>>  '
>>
>>  apos="'";
