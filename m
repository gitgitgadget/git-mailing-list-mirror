From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 10:20:23 +0200
Message-ID: <48B50E47.3010402@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org> <48B4F5C4.9020404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGHi-0005T4-4F
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYH0IUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbYH0IUb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:20:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:30685 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbYH0IU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:20:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1499173fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=Jq9N8dLCUpquE2IXWtUGNpSqo1fR9zzoXF2zTo7tsLc=;
        b=aLe0rMXJrFTgpyfNn9c2OKIol7gXLPbJmn0kE/qNQ7miqaUIQ6XW6pm8XcQ1Pl2rUF
         FM6YUR+7eM88SFthrIvOcOVi+GfIUtkdVxE72DpBuSTEB1lszL8L1Fp02CAtlfkJRr2G
         p2WsW83Hj8y98hUNPSTaMlInq23VIpJZth1tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=AxE3qIRLYp24edNQVjiOwLZmTHSS6vyZaDkLW0RK8Y/zXC9KCsGqzbf5d4rap/Z5bO
         +O/AP+upOGR3O/K8SzfMEDse2A9MbIexQx+pTo0qwiqyFkQl3fvSSfJbn0USJHfqxMYH
         q9Qo7790NyFr3uVd09IXj2TpsZUdDv72JQmHc=
Received: by 10.86.82.16 with SMTP id f16mr5129805fgb.9.1219825226863;
        Wed, 27 Aug 2008 01:20:26 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 4sm3469165fgg.4.2008.08.27.01.20.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 01:20:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48B4F5C4.9020404@viscovery.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93871>


>> Busybox.  But it runs setuid, as Steven pointed out.
> 
> I straced tee (it was the only tool I found that opens files for writing
> without also opening some for reading). If one of 0,1,2 is closed, it
> *does* dup() the fd that it is going to write.

To be precise, it does a blind "dup2 (fd, 3)" and goes on with file
descriptor 3.

open("foo", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 0
fcntl64(0, F_DUPFD, 3)                  = 3
close(0)                                = 0

Paolo
