From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 25 Nov 2015 11:39:30 +0100
Message-ID: <CAP8UFD18KkH25S3RmyuBQrvGYELSTR1FfZAYKzr-Yzd6OJvmxQ@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.1.00.1511251121390.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:39:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XUB-00066W-0V
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbKYKjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:39:32 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:33611 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbKYKja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:39:30 -0500
Received: by iouu10 with SMTP id u10so50312977iou.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z8TzEyTzJK1bNFYEwTuQJch42v45FRLsgz//jJFTn1o=;
        b=zIWXF453N4umr3YnSL7zSi3+UP6xAwAhfTM0nnihVC9Kyu+EuOecihTWa65ljt5itg
         9jEQ7Qz8Ayin02eBGLcPUv9XxdZ6VQ+H9lxRUGiIy4Ib680OHIPOp8hNHoP/IdE/4Ql3
         e2JzS66nN8YSWteFe5MTh1OGog5yGyFGQFT/7T49OgJHU6MXVQYDqKLp8SseO1TetxAR
         igNkc9UwQ2cekBlXti8EAXac73QAdWU4ISPyWEQ5GO1WF7RRbsId21oqnMhM1fLAeTAl
         9r6FTBWR9IDbDQR/BbrteoJC+c1hiFzcznoMTH+A7hDsrhqyV3jzCQP0zYOIuAENucg1
         zJhQ==
X-Received: by 10.107.170.142 with SMTP id g14mr3871182ioj.178.1448447970070;
 Wed, 25 Nov 2015 02:39:30 -0800 (PST)
Received: by 10.36.146.68 with HTTP; Wed, 25 Nov 2015 02:39:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1511251121390.1686@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281700>

Hi Johannes,

On Wed, Nov 25, 2015 at 11:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Wed, 25 Nov 2015, Christian Couder wrote:
>
>> diff --git a/config.c b/config.c
>> index 248a21a..d720b1f 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -691,6 +691,13 @@ static int git_default_core_config(const char *var, const char *value)
>>               trust_ctime = git_config_bool(var, value);
>>               return 0;
>>       }
>> +     if (!strcmp(var, "core.trustmtime")) {
>> +             if (!strcasecmp(value, "default") || !strcasecmp(value, "check"))
>> +                     trust_mtime = -1;
>> +             else
>> +                     trust_mtime = git_config_maybe_bool(var, value);
>
> If `core.trustmtime` is set to `OMG, never!`, `git_config_maybe_bool()`
> will set trust_mtime to -1, i.e. the exact same value as if you had set
> the variable to `default` or `check`...

Yeah, I think returning -1 is the safe thing to do in this case.

> Maybe you want to be a bit stricter here and either test the return value
> of `git_config_maybe_bool()` for -1 (and warn in that case), or just
> delete the `maybe_`?

I thought that if we ever add more options in the future then people
might be annoyed by older git versions warning about the new options.
But I am ok to add a warning.

Thanks,
Christian.
