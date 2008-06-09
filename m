From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 09 Jun 2008 02:05:46 +0200
Message-ID: <484C73DA.10804@gmail.com>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com> <alpine.DEB.1.00.0806090033030.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 02:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5UuK-0006dO-MC
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbYFIAFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 20:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbYFIAFw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:05:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37489 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYFIAFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:05:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1336125fgg.17
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=p0talQOsfrZx6qDVDoyzJ+bkLIaK+ur/G5c2kNX2mSs=;
        b=hghGZDUjkpiRvSuwkldL8j+k1ue5SY82dO7krRdRJqktmunjkUM+1j/Y58dqSGQyHb
         UKD/lRQwD7+Q8rGo1Ahk4CPvzLMOPFl/aFPq854P2z0jfk5mm4ln7WrF8mPEPG98T/mq
         BSCRcJ2MF5AArBU46Es+riObfQPRNnYdEvNV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=hB4ufYjwYUd+8vVpCbW3hD5zVywipnfwKEHx9MgNtkhlAaAVeR9l5ZK7nn6J2vg9dP
         RMTmYJoNJpDH3lZIQ1cLoG3Qm3yOqYtQya41wYDkUxw++6pifIDc2jQrY+5OQZuHlAY8
         BKei6f+Mr9uGIOGaByHCnBl2sQDUNG55Sg7zk=
Received: by 10.86.60.14 with SMTP id i14mr3483783fga.75.1212969948625;
        Sun, 08 Jun 2008 17:05:48 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.232.240])
        by mx.google.com with ESMTPS id e11sm10141649fga.4.2008.06.08.17.05.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 17:05:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0806090033030.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84349>

Johannes Schindelin wrote:
> Lea Wiemann wrote:
>> -	if (type <= 0)
>> -		return 1;
>> +	if (type <= 0) {
>> +		printf("%s missing\n", obj_name);
>> +		fflush(stdout);
>> +		return 0;
>> +	}
> 
> Is it really intended that it returns 0 now?

Yes, return 0 causes it to not exit (which is the desired effect, as in 
documented).

> Further, should it not be an error("%s missin...  instead?  It is an 
> error, isn't it?

No, it's not an error.  I suggest you read git-cat-file.1 -- getting a 
response of "<object> missing" (rather than cat-file terminating) if you 
pass in a non-existent object is the desired behavior, and it happened 
before for named objects, like "HEAD", but not for full hashes.  Now it 
also happens for full hashes.

-- Lea
