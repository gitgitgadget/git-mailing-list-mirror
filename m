From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Thu, 17 Sep 2009 09:27:01 +0200
Message-ID: <4AB1E4C5.80102@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net> <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com> <4AB1E118.70504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexey Borzenkov <snaury@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:27:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBOy-00039t-JE
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585AbZIQH11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758541AbZIQH11
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:27:27 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:60665 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202AbZIQH10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:27:26 -0400
Received: by ewy2 with SMTP id 2so132632ewy.17
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=F3HMGPDhBo8keVZoJfoCDMI1iQXdJj31weq1YvN5aA8=;
        b=dPnoik6nNP6VVUSyeLwUDIRc246oTaguwbgdy6bP9aA7r5a2PBPMekfmcccVB9tG7N
         g5y6xL8j3Uq5wzN68V03pzgxKs0FCuZGozCm5zuLK7kPQ76or9oYTMYxGcTjN962aMim
         ypeW259XWLSP/IUdn7odnG7h0mLUNLgE3i5Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oRPUbe3AKDoZQ14I2R4vx52GpOvPXzXgmpfV5TBgFHD1pU74zg7emBcRLQ8IzDpDUM
         CnWzpPJiwHE7F5TwkcjYC2D6ErBHPpjTRTKVX595ADa/3uT0hh8TX3k6Ss3b6WwzyM9o
         NV8tbh9fTZVKxHtRDIkeETIjXH3COf8vLhQww=
Received: by 10.210.206.12 with SMTP id d12mr194044ebg.32.1253172449516;
        Thu, 17 Sep 2009 00:27:29 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 28sm923528eyg.5.2009.09.17.00.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 00:27:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AB1E118.70504@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128724>

Johannes Sixt said the following on 17.09.2009 09:11:
> Alexey Borzenkov schrieb:
>> Searching which executables set _fmode and which don't I found the
>> culprit. test-genrandom.c didn't include git-compat-util.h, so mingw.h
>> was never included. This caused different random data to be generated,
>> and as it seems more importantly, of different sizes. Can be fixed
>> with this patch:
>>
>> diff --git a/test-genrandom.c b/test-genrandom.c
>> index 8ad276d..b3c28d9 100644
>> --- a/test-genrandom.c
>> +++ b/test-genrandom.c
>> @@ -4,8 +4,7 @@
>>   * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
>>   */
>>
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> +#include "git-compat-util.h"
>>
>>  int main(int argc, char *argv[])
>>  {
> 
> Thanks for digging this out. With this change, the t5302 passes again.

Yup, are you ok with squashing this hunk into the patch then?

--
.marius
