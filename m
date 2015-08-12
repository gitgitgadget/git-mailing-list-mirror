From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 3/3] am: let --signoff override --no-signoff
Date: Wed, 12 Aug 2015 11:06:37 +0800
Message-ID: <CACRoPnSmeR9ETZ4M6GqkbtEZxM-_J-Dxgsx34ntPnojM1j0ZqQ@mail.gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697331-29948-1-git-send-email-pyokagan@gmail.com>
	<1438697331-29948-4-git-send-email-pyokagan@gmail.com>
	<16ad6c2da8f85b9f5fc26ee6ebad944b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 05:06:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPMNJ-0003aK-4m
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 05:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbbHLDGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 23:06:40 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33531 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbHLDGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 23:06:39 -0400
Received: by lbbsx3 with SMTP id sx3so2233498lbb.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 20:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v5/9mfV7kfuoK09IVu0GH1NSUDCsv756sHr+OpD2WzA=;
        b=KE/6QfV4lB9csMeMjd0jmckJXq2v7QbMa4zcthGf4HFi9rGoVL9Z37Dk1kjzwoCn/V
         Bm9h3Ap/Rzb7Dd1c+CyxxqbNQjp4nik21CHcAbr6uMSVwQkhw3BPKm44noVoTwVpuZsm
         p94EV7iDIG4FX2m0KOK4onWEAKm/H0ebgUBTeU+TdGYiHhmZ/tICrPNtQIipE+VNOc1l
         3DdOQm31hzoaQbdIG5Zd1t4M2hZXUo0ZihGTb766TBeFn2I83AaaQK48NiMXfdxil2Rk
         82H6Uc9FAeW9fim6cbrWYtwa8Ws14fIzRp9fKhFAu2knaoxBHHQfhWKAyiuatJmyagIi
         zOZg==
X-Received: by 10.152.18.232 with SMTP id z8mr30459112lad.66.1439348797791;
 Tue, 11 Aug 2015 20:06:37 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Tue, 11 Aug 2015 20:06:37 -0700 (PDT)
In-Reply-To: <16ad6c2da8f85b9f5fc26ee6ebad944b@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275753>

On Fri, Aug 7, 2015 at 5:29 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 0961304..8c95aec 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -2265,6 +2284,9 @@ int cmd_am(int argc, const char **argv, const
>> char *prefix)
>>
>>               if (resume == RESUME_FALSE)
>>                       resume = RESUME_APPLY;
>> +
>> +             if (state.signoff == SIGNOFF_EXPLICIT)
>> +                     am_append_signoff(&state);
>>       } else {
>
> This is clever, but I suspect there is now a chance for a double-signoff if we passed `--signoff` to the initial `git am` call and it went through without having to resume.

It's not present in this diff context, but this hunk modifies the code
path where in_progress is true. In other words, we only check for
SIGNOFF_EXPLICIT if
