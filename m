From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH] Close config file handle if the entry to unset is not
 found
Date: Fri, 14 Aug 2015 21:38:02 +0200
Message-ID: <55CE439A.6070601@cs-ware.de>
References: <55CE3F23.7040702@cs-ware.de>
 <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:38:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQKoC-0006w5-1i
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbHNTiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:38:23 -0400
Received: from srv1.79p.de ([213.239.234.118]:48225 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbHNTiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:38:20 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5] (p200300886B2B1300A5027B37AC722AD5.dip0.t-ipconnect.de [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 9BAFC223D7C;
	Fri, 14 Aug 2015 21:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015; t=1439581097;
	bh=ruF2RtAfDq6FHBRg1QnaDjcDYapPTGzboBaq5tPdY6Y=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To;
	b=WUXvs3DXOIkbggPCOEbPwJIPMIODc04YuSnE6NPYMuSnG8gjBa2hkN4dyGgS5B/0o
	 tCusYfpvRDIHvFrq7bAcqmZLxPNlqcttKnQ0h1KzaMvEj25G7SILaB4ZC5WL1ws5Z0
	 JjWFyXP6eEWkK8L2hoosGcvFoALiNbH4WrjiNieYM77vTupbttvf5P80kEJhyhNMKz
	 xeBtXCYUs2I5KokPyRwdMNG4RnMqseGLoT4k7Z6cCQIjpRYps/lRDboAJ3pjyHpObC
	 BjA19vTtAZjM/38aBmxPuCsRYFsvY3WJNWVDCCIvuyTkTOgphpBo0XKdaLjBaSn563
	 v4R5xj4rl3COw==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275927>

Am 14.08.2015 um 21:35 schrieb Eric Sunshine:
>> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
>> ---
>> diff --git a/config.c b/config.c
>> index 9fd275f..89b49e3 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2048,6 +2048,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>                 if ((store.seen == 0 && value == NULL) ||
>>                                 (store.seen > 1 && multi_replace == 0)) {
>>                         ret = CONFIG_NOTHING_SET;
>> +                       close(in_fd);
>>                         goto out_free;
> 
> From a cursory read of the code, it appears that there are several
> other places where the open 'in_fd' gets leaked which would deserve
> the same treatment. So, it's not clear why this patch handles only
> this one case. Am I missing something?

Good point.

I suppose only this place was adjusted, becasue this is the only case
which occurred so far.

Shall I re-create another patch?

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
