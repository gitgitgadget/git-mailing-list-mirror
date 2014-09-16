From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 05/35] rollback_lock_file(): set fd to -1
Date: Tue, 16 Sep 2014 13:39:57 -0700
Message-ID: <20140916203957.GF29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-6-git-send-email-mhagger@alum.mit.edu>
 <20140916203852.GE29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:40:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzXp-0006p9-R1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbaIPUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:40:05 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:49845 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbaIPUkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:40:00 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so543962pdi.7
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UB/krhW9Xrx15vYWyBNVT+xPu1bPrgC2jXeyliXjjTE=;
        b=OIa3SKMwGe0vlh92qsECUKbxhK8AkUUyi7cubie+C6tPpbZK07kABtjIuh6NWHtBec
         7qFcpvl4yG48VDjTC44vhutTRM7PYCZZTnUNFZ5CI9J4kDPMgKpoRF/Nwp2ZlkLs4r6F
         n2H/+ycqzU65bmu9DHJzr6tskmPJxUlPkveJIUY63V7acjljz75Gjed+r2ofBOcf4y2V
         tJagt9HqT4GwAwy1qaadV8xeTtCHgqn4pX6Jz2jV12qWpwLJU/AD4K7v9JoW/LqsZ00s
         ldYRlcRq64zjj4I8UE7T6ZitslQxIFDwd4p/KC9q5inpwzOAx5Z7uwjCYhtkEwTEjz7+
         Vjbg==
X-Received: by 10.66.189.131 with SMTP id gi3mr26429019pac.114.1410900000205;
        Tue, 16 Sep 2014 13:40:00 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id j13sm14927567pbq.42.2014.09.16.13.39.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:39:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140916203852.GE29050@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257189>

Jonathan Nieder wrote:
> Michael Haggerty wrote:

>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -276,7 +276,7 @@ void rollback_lock_file(struct lock_file *lk)
>>  		return;
>>  
>>  	if (lk->fd >= 0)
>> -		close(lk->fd);
>> +		close_lock_file(lk);
>
> Doesn't need to be guarded by the 'if'.

Err, yes it does.

Why doesn't close_lock_file bail out early when fd < 0?

In any case,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
