From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 61/83] builtin/apply: libify check_apply_state()
Date: Sun, 1 May 2016 18:58:54 +0200
Message-ID: <CAP8UFD3CPwDR_P23MvmBVEb24NSd93foDaNion57D7Qazf377g@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-62-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8AVVNOPfuAqSKKP-V2hTxHM-iYagXXa3j88GsEt3t7Ckw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 01 18:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awuhx-0003kY-2m
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 18:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcEAQ64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 12:58:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37873 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbcEAQ6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 12:58:55 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so109773242wme.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1PaBkC0jXMiPoqevMwecFhB8I2iUCTolfmf23RQHe9A=;
        b=lxCA0U/BcdOBdMGUm+fBE8fImK/EhkGCWd9RomVAfo9CxluR89iZfIC9Q8NTYQ/u3J
         WVwqqGjk8/dJvLXrIGC2s0RYGg3FfgSwUAEh/+nJCnylWW3itdQYVyemehFsIEsVt/Q9
         cPpgXxZTKoE94IaVaRMLTAvjs5PrxoqGRB+Sy0SIbpgMNjccRJDcrmiL1tIRU9N0xmfv
         Rv4fmDsskqDeWl+DsfSJ8Bwihxwe37FKITn9BWSZxRkxkpJhv1bxVh8lbHl/MqI5vJGs
         /uUmc4wV9SfrxVq7Exq8mVDbz1re3eBG75uRFOdJvHK35H0bNgTSvet8sr9zKTJEJG0x
         ZRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1PaBkC0jXMiPoqevMwecFhB8I2iUCTolfmf23RQHe9A=;
        b=bpFikkvorOzXvI/IfpXd+H1ijgYtVrAiu+IrKiwupzk/gFh+6CjTElzEnGe5ajVB9Z
         5VA3VilqyJ702qhynKK7CZII7LIFRhQcHEFsDCkYbjERtIGs7/HudmkR+HSDuLbVZVKu
         UAiTOL3k1dL6SQ5trM/JTE72G2STzn3OXQW2ng7ZwvIN0GGOMxaqQzhUhraKonzXlwus
         dK/nZYVISlRp/nMog2SnmD48HV/oJMOO4XcLkcNLn3Gy+cc84pxDkzN/itAf9aliW9fG
         kOgpNx2g+JnQXim1Jc6uMXlnxjkhppaIMnhZEaBTVa/GVr9ZE7pEe239zWd8UHsuCtah
         yHmQ==
X-Gm-Message-State: AOPr4FWeBEmkAbjikrdgHnvofu0x18qBe3y5kyjyQliBvFSW9zxn2fzkPBjIYGdfGbJjDzYQjmAakVMjtlEALQ==
X-Received: by 10.28.54.33 with SMTP id d33mr15394086wma.62.1462121934494;
 Sun, 01 May 2016 09:58:54 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 09:58:54 -0700 (PDT)
In-Reply-To: <CACsJy8AVVNOPfuAqSKKP-V2hTxHM-iYagXXa3j88GsEt3t7Ckw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293198>

On Mon, Apr 25, 2016 at 3:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index e3ee199..7576ec5 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -4534,17 +4534,17 @@ static int option_parse_directory(const struct option *opt,
>>         return 0;
>>  }
>>
>> -static void check_apply_state(struct apply_state *state, int force_apply)
>> +static int check_apply_state(struct apply_state *state, int force_apply)
>>  {
>>         int is_not_gitdir = !startup_info->have_repository;
>>
>>         if (state->apply_with_reject && state->threeway)
>> -               die("--reject and --3way cannot be used together.");
>> +               return error("--reject and --3way cannot be used together.");
>>         if (state->cached && state->threeway)
>> -               die("--cached and --3way cannot be used together.");
>> +               return error("--cached and --3way cannot be used together.");
>
> Sweet opportunity to _() these messages since it clear shows in this
> patch that other messages of the same category are _()'d in this
> function. Could be done as a separate patch. But I'm also ok if you
> say "no".

I have added it to my todo list of things that should be done after this series.
