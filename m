From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 16:07:53 -0500
Message-ID: <20101019210753.GB32029@burratino>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
 <20101019133236.GA804@sigill.intra.peff.net>
 <20101019134040.GA3956@sigill.intra.peff.net>
 <20101019191638.GI25139@burratino>
 <m3fww1lwqw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 23:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JT8-0006yT-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 23:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab0JSVLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 17:11:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56309 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab0JSVLd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 17:11:33 -0400
Received: by qyk9 with SMTP id 9so833314qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1LSeA4Ee0twJA69Ky7M8OFB3LeEccAdjIZZkcjm0iTw=;
        b=t1zE1yYEjCYOdBg8gHo4VMPGEYhMZazqmJpAiwYu2160jNZ53JUcAb6F/0M0bSoZ0e
         IVEM8bRka+lZzoMKwrVsJ6WonqaTQqFN61zV+ZXjA0Qy3aSGII3EEyEAdCjZ4ZqEKiiY
         gcKOGBYx6NZ+IM2EfTUsY2N+neOk0U7G1KhZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gXYX1RoG5+EwSLGf60Qp/PPC2CY/Jj9+nIYWjeZ1gyiLi4+DIGj3Osvi94tzjPpl9E
         r/XjLTzuTf6W/pUoTWGO4AQizPuFyuSfQlziOYBuL0VMXwTXfysrTVxBGDh3ht0nGnk2
         ANipshcFtPdR88M3hXVSj6zzWCxDQ9ryGCRsQ=
Received: by 10.229.102.11 with SMTP id e11mr5573662qco.276.1287522692943;
        Tue, 19 Oct 2010 14:11:32 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm14919269qcp.20.2010.10.19.14.11.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 14:11:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3fww1lwqw.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159368>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -	sigchain_push(SIGINT, SIG_IGN);
>> -	sigchain_push(SIGQUIT, SIG_IGN);
>> +	if (the_child)
>> +		die("What?  _Two_ children?");
>> +	the_child = cmd;
>> +	sigchain_push(SIGINT, interrupted_with_child);
>> +	sigchain_push(SIGQUIT, interrupted_with_child);
>
> Please, don't do this.  It is almost as bad as error message as 
> "You don't exist.  Go away".

Hopefully it was clear that the behavior (erroring out) is as
unacceptable as the message.
