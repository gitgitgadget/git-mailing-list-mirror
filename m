From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 08:32:30 -0400
Message-ID: <51E7E05E.4000201@gmail.com>
References: <cover.1373618940.git.trast@inf.ethz.ch>	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>	<878v16kfqy.fsf@linux-k42r.v.cablecom.net> <7v38rd6l3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>,
	"Dale R. Worley" <worley@alum.mit.edu>, git@vger.kernel.org,
	Jonas Fonseca <fonseca@diku.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 14:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UznO1-0003om-9H
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 14:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3GRMcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 08:32:33 -0400
Received: from mail-gh0-f178.google.com ([209.85.160.178]:57725 "EHLO
	mail-gh0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3GRMcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 08:32:33 -0400
Received: by mail-gh0-f178.google.com with SMTP id g15so918265ghb.9
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AUpSjyZxguviJNhKH1PevkgkIXQbI7XT4EmWenYf7cU=;
        b=XFimuhra5OdIxkgDZnNdKm4vfff4Ajy2eFIEQvBaaUX4B46THxf+K+opRWHMO9M3RW
         qP5Kga3wvMPdMrV/Sdicc87zD/I/hs59p40qO8xp8+2ulNfet5m3CF5s19qHMa/zv+0r
         8ZbPC1tKTjDC+vK+3tjWcFcKiWG7hYE98MAatNjB5VG71uKTUY3yNl6aA8lBAh29zxK4
         jGjWAzgz4d+0kcAZqGWcKrUIj7Yxqz11Ou78PBcGwpKfR1//OT2g/Jbr4taGzhBKQNq6
         tHQd0nn25qSLVeCvVig9AobZZ2BEI0ebsxICMz1FjfHQ7v1/q5+Vgku3Jj2dTRcRzFXa
         QgEQ==
X-Received: by 10.236.57.3 with SMTP id n3mr5413701yhc.116.1374150752546;
        Thu, 18 Jul 2013 05:32:32 -0700 (PDT)
Received: from [192.168.0.37] (pool-70-16-105-6.port.east.myfairpoint.net. [70.16.105.6])
        by mx.google.com with ESMTPSA id x52sm14346422yhh.18.2013.07.18.05.32.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 05:32:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120314 Thunderbird/3.1.20
In-Reply-To: <7v38rd6l3j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230689>

I presume that I should apply this change to my porting of 
git_mkstemps_mode() to tig. If there are no complaints about this for a 
couple of days I will do so.

REF: $gmane/229961

On 07/17/2013 03:29 PM, Junio C Hamano wrote:
> Thomas Rast<trast@inf.ethz.ch>  writes:
>> Thomas Rast<trast@inf.ethz.ch>  writes:
>>> From: "Dale R. Worley"<worley@alum.mit.edu>
>>>
>>> open() returns -1 on failure, and indeed 0 is a possible success value
>>> if the user closed stdin in our process.  Fix the test.
>>>
>>> Signed-off-by: Thomas Rast<trast@inf.ethz.ch>

>>>   wrapper.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/wrapper.c b/wrapper.c
>>> index dd7ecbb..6a015de 100644
>>> --- a/wrapper.c
>>> +++ b/wrapper.c
>>> @@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>>>   		template[5] = letters[v % num_letters]; v /= num_letters;
>>>
>>>   		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>>> -		if (fd>  0)
>>> +		if (fd>= 0)
>>>   			return fd;
>>>   		/*
>>>   		 * Fatal error (EPERM, ENOSPC etc).


--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
