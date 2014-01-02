From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2] Speed up is_git_command() by checking early for internal
 commands
Date: Thu, 02 Jan 2014 13:46:22 +0100
Message-ID: <52C55F9E.5000609@gmail.com>
References: <52C1E028.8000004@gmail.com>	<52C1E09A.8040907@gmail.com> <CAP8UFD2uq5Q-2F4w2zwH582NTpo9JwiKyHPovQJW+7phbT-b-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 13:46:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyhfZ-0003un-G7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 13:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbaABMqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 07:46:33 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:56300 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaABMqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 07:46:32 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so4574606bkb.12
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 04:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=n/YLtWn/UXZlSQ3iMVI4LYf30UoSSl9cVVWPb1RuLbQ=;
        b=e6WobUeyO/p+iQPvcwMVzTlBeMtT8x4+5kGMs/1pqUcuoqvHhbwO7fdooiprPB7vZR
         iO4P8irOyXLz0M3m+eV8vOxCYGUbZG+ZnD0X3uhb5EbdVmEFhOy9NuObSmopUGaQC3Mt
         l7xsiAvLE2JIuxJ34igKFN1iIU7ONfXRFsrWYUwJGekx3En3Dv8MWN/u9MxvpToEY1DY
         dBHYy/yRLkLqOVlaZsFUBs1Fw5V+R/UiN82ZLmiSGAUxci8llsdf2puQgPlh5w5CrOgh
         lZF5ecwXlJ0pD/y0y71Q0abUAK8cTOF2TM8ejBSxdm+Bcc3Ndo09hyqkk3umIX66hxve
         YGfg==
X-Received: by 10.205.35.72 with SMTP id sv8mr1319512bkb.60.1388666790578;
        Thu, 02 Jan 2014 04:46:30 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id bk1sm34165981bkc.3.2014.01.02.04.46.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 04:46:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAP8UFD2uq5Q-2F4w2zwH582NTpo9JwiKyHPovQJW+7phbT-b-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239852>

On 02.01.2014 09:51, Christian Couder wrote:

>> diff --git a/builtin/help.c b/builtin/help.c
>> index b6fc15e..1f0261e 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -284,10 +284,15 @@ static int git_help_config(const char *var, const char *value, void *cb)
>>          return git_default_config(var, value, cb);
>>   }
>>
>> +extern int is_internal_command(const char *s);
>> +
>
> Starting the new year in keeping with the fine tradition of asking
> people who add stuff to clean up what others left behind, I would
> suggest moving all the code related to internal commands (or maybe all
> commands) in a new pair of files like "internal-cmds.{c,h}". This way
> git.c and builtin/help.c could include internal-cmds.h and you
> wouldn't need such extern declaration.

Wouldn't the existing builtin.h be a more appropriate for this? (And 
create a builtin.c for the implementations.)

Also, I start to realize that it's a bit unfortunate that we seem to use 
the terms "builtin" and "internal command" interchangeably. I'll 
probably add a patch to address this.

-- 
Sebastian Schuberth
