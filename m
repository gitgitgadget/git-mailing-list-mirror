From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v10 3/4] add `config_set` API for caching config-like
 files
Date: Fri, 18 Jul 2014 15:22:49 +0530
Message-ID: <53C8EE71.5000703@gmail.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com> <1405675142-20300-4-git-send-email-tanayabh@gmail.com> <1849775492.2606791.1405676407530.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84qX-0002pE-78
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761066AbaGRJwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:52:54 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44246 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760999AbaGRJwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:52:53 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so5086788pad.23
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uOjabg1McdwoOvyCBKmoM08GMjxLJ+9Uqe1DI0jTH2c=;
        b=C8d4mhx0dfN6ja+jjQHsGkX06+yRaXHPhgTkpuKjUsdw4Yi4fAuXpO/DbD7ijruMXa
         lPSqOonGJXKsomC3nuXyNjCygy9hcn9ASBJWmdFt944+hqlgHsiQ67Xt/C88E5nBT2So
         k8YDlGXsiRCgIoSkx99J6QGgEftBU6y6UUbHslLjqJoc6rQjNmPbKB55JoPHchtuouPL
         E0RBGES9ItT4MjiesEBV8yTZ8gYHojCOCBaVwUddnSFNtIVLaInOR9FsD4yZogzASTG3
         yjBmlkAiyI9p0pR6euQs8DX9I/ByBGvMcaxnjqyV7sBhazpzI0hM7ll80pNO0D+Sg4X2
         TuTg==
X-Received: by 10.66.139.164 with SMTP id qz4mr1194836pab.151.1405677172778;
        Fri, 18 Jul 2014 02:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([106.203.84.80])
        by mx.google.com with ESMTPSA id fn2sm21128193pab.22.2014.07.18.02.52.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:52:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1849775492.2606791.1405676407530.JavaMail.zimbra@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253806>



On 7/18/2014 3:10 PM, Matthieu Moy wrote:
> ----- Original Message -----
>>  Documentation/technical/api-config.txt | 137 +++++++++++++++++
>>  cache.h                                |  30 ++++
>>  config.c                               | 263
>>  +++++++++++++++++++++++++++++++++
>>  3 files changed, 430 insertions(+)
> 
> I think the added call to git_config_clear() I proposed yesterday in setup_git_directory_gently_1 should be part of this patch (with the associated comment), just like this call:
>

Oh, my bad, I thought you meant that I incorporate it with the git_config_raw() patch.
I wanted to ask, can we call setup_git_directory_gently() earlier in execv_dashed_external()
in git.c, which calls check_pager_config() for the first time which causes the
incomplete cache to formed.
If we can do it, we won't have to clear the cache every time setup_git_directory_gently_1()
is called.

>> @@ -1707,6 +1967,9 @@ int git_config_set_multivar_in_file(const char
>> *config_filename,
>>  	lock = NULL;
>>  	ret = 0;
>>  
>> +	/* Invalidate the config cache */
>> +	git_config_clear();
>> +
>>  out_free:
>>  	if (lock)
>>  		rollback_lock_file(lock);
> 
> I have limited access to my email and no way to apply the patches today, so I can't do a detailed review. But other than the remark above, I guess the patch series is now all right and ready to cook in pu.
> 
