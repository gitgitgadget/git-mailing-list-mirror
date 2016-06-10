From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Fri, 10 Jun 2016 19:09:45 +0530
Message-ID: <CAFZEwPOhssmTt6TLPhxjzru+B3sWgXWh71yRt9BOvLqc0imq-g@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com> <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 15:39:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBMfE-0000A6-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 15:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbcFJNjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 09:39:48 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35981 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbcFJNjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 09:39:47 -0400
Received: by mail-yw0-f195.google.com with SMTP id l126so8518408ywe.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N191LFHCvyEu8Uq6pOl9P+rMdgoiT+rDf74gDmC4Q5c=;
        b=PRb4XUBCyk360WwRwFoPXWWQi6KfyCTEXLIleHnc3CPtVuHqkrr9C256vaES9bRk5m
         jloChqNUSW0JwzfDz4yKucPsy3GwZdObBAsy6aHO63PZ1kxOtXQx6KurI9RKWKeEh7ZZ
         eOPDV61NwAl+OpWng61dCU23q/8HYTYROrZ5DI/gcvetp+X1oz/IFjY9Dt5sFEO9z4bU
         loplWxBXEZUVPHxZonmrn8PYmvAYGSNIU70UET3jTl73tJvM9NsUnPWkyHPbjafjXX9n
         GEU8dhbj2nmPCHYI4Bj50JLwCsMkI9xn6kpTAektbNOcLjVsNjrOC748umWbiuWjQUyN
         b4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N191LFHCvyEu8Uq6pOl9P+rMdgoiT+rDf74gDmC4Q5c=;
        b=mFHfN265+DROhmHjYPsGLgkPlqYN19ztODHZaBA77UO/O2qWcjhWtwKDQSrCWdT85g
         uRRPKMkW3VK6pKhA2zdJ+BevyqkaszCcjiB2XyzSj2ygJqUKfW+r9tJBya9FLtA1Q7LW
         xmkHMFAPFuPBqhvFQaBRqpSc36g/3guHo9vLPEvHDmGkvUFvxho7ZinvsneEQtfyYthY
         uNbRgz57GDIMaklMXeZzHV2tlYjBPdqFt5S8uqmhRVWs2AYu2YmNZE5I1hZA2IJcI7la
         ulHojpN6yeElQWYA+nSLMympyaGzaJQKJh1Ec6vv0SVPGxfMqIsHToor+fHnO9GFSTf0
         FALg==
X-Gm-Message-State: ALyK8tIsCN3FrQs1deUFc23Btaw1avC9nhqJHxUnevXevrTnkMh4tYHdMjMnR4laI2Rg4gNBWlxTqrfb6oOdlg==
X-Received: by 10.129.81.144 with SMTP id f138mr980890ywb.154.1465565986240;
 Fri, 10 Jun 2016 06:39:46 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Fri, 10 Jun 2016 06:39:45 -0700 (PDT)
In-Reply-To: <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297004>

Hey Eric,

On Fri, Jun 10, 2016 at 3:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `is_expected_rev` shell function in C. This will further be
>> called from `check_expected_revs` function. This is a quite small
>> function thus subcommand facility is redundant.
>
> This patch should be squashed into patch 2/2, as it is otherwise
> pointless without that patch, and merely adds dead code.

Sure I will squash and will explain it in the commit message.

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -160,6 +160,20 @@ int bisect_reset(const char *commit)
>> +static int is_expected_rev(const char *expected_hex)
>> +{
>> +       struct strbuf actual_hex = STRBUF_INIT;
>> +
>> +       if (!file_exists(git_path_bisect_expected_rev()))
>> +               return 0;
>
> Invoking file_exists() seems unnecessarily redundant when you can
> discern effectively the same by checking the return value of
> strbuf_read_file() below. I'd drop the file_exists() check altogether.

I wanted to imitate the code. But I guess it would actually be better
if I drop this file_exists().

>> +       if (!strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0))
>> +               return 0;
>
> What exactly is this trying to do? Considering that strbuf_read_file()
> returns -1 upon error, otherwise the number of bytes read, if I'm
> reading this correctly, is_expected_rev() returns false if
> strbuf_read_file() encounters an error (which is fine) but also when
> it successfully reads the file and its content length is non-zero
> (which is very odd).
>
>> +       strbuf_trim(&actual_hex);
>> +       return !strcmp(actual_hex.buf, expected_hex);
>
> Thus, it only ever gets to this point if the file exists but is empty,
> which is very unlikely to match 'expected_hex'. I could understand it
> if you checked the result of strbuf_read_file() with <0 or even <=0,
> but the current code doesn't make sense to me.
>
> Am I misunderstanding?


Definitely not. Thanks for pointing it out. :) It went off my head
that strbuf_read_file returns the bytes it reads. Also the code
comment regarding strbuf_read_file does not mention it which probably
misguided me. I should also send a fixing patch so that someone else
does not fall into this like I did.

I will also release the 'actual_hex'.

Thanks for your comments!

Regards,
Pranit Bauva
