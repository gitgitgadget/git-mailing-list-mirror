From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Convert "! git" to "test_must_fail" git.
Date: Tue, 20 Jul 2010 14:48:07 -0500
Message-ID: <20100720194807.GA2259@burratino>
References: <20100720181431.GA12857@localhost.localdomain>
 <fe4308a0ab1c3d7296efa986d5cfe63c6ff4014a.1279652856.git.jaredhance@gmail.com>
 <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 21:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIoV-0002sY-7X
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab0GTTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:49:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41033 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0GTTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:49:08 -0400
Received: by ewy23 with SMTP id 23so1918922ewy.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Btch4XRndG6Zq0DpklyiyavkKlyfigSCI1k0SWlnWU=;
        b=wVEMXR5EN6pjF6tz9Abh1z+cjYOkGIePm5n6hywy3nMEOURbckB7Gder4lOfII2ac5
         U30YPjukXrdEpHoGDB6HS0EG7KVnevG7y99Sd06TyXda9HL+hc/SF3VwwnuEA+pCS64+
         2YW2/5iM1WASsK1DUm2zIl1ChsbhkhAuAVOac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RdMc3Pq1viXsv0ZhqFJ/AAbzvGxiZX8aNywya7B25FVAu3Gwrcfe/i5519hqTpoiDR
         e2e6pT/dIGeZEO+av9J1QGUNcHKTDaogA+8o0R1VMmua5uZ1srO8/CyZ7c3nI8nOWa4i
         7s5f+vpO48fwaHbV12I3tpSOZp1zixUSPN238=
Received: by 10.213.35.6 with SMTP id n6mr5208196ebd.11.1279655346734;
        Tue, 20 Jul 2010 12:49:06 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x54sm52086654eeh.5.2010.07.20.12.49.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:49:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151359>

Brandon Casey wrote:

> I believe the '!' negates the
> result of the entire statement, but test_must_fail only
> operates on the arguments preceding the '|'.

Right.  For example:

> On 07/20/2010 02:09 PM, Jared Hance wrote:

[...]
>> +++ b/t/t7810-grep.sh
>> @@ -134,7 +134,7 @@ do
>>  	'
>>  
>>  	test_expect_success "grep -c $L (no /dev/null)" '
>> -		! git grep -c test $H | grep /dev/null
>> +		test_must_fail git grep -c test $H | grep /dev/null

should be

	git grep -c test $H | ! grep /dev/null

or if it is considered important to test the exit code of
git grep,

	git grep -c test $H >actual &&
	! grep /dev/null actual

Regards,
Jonathan
