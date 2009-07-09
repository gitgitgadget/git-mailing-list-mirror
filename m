From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 4/3] Avoid using 'lstat()' to figure out directories
Date: Fri, 10 Jul 2009 00:36:35 +0200
Message-ID: <4A5670F3.9020309@gnu.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP2ER-0006Pb-JF
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 00:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbZGIWgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbZGIWgj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 18:36:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:20963 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZGIWgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 18:36:38 -0400
Received: by fg-out-1718.google.com with SMTP id e21so146602fga.17
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=yZ2nOT1ZTYdTgQ88V9s2VtUHnz3QI2a/P5eLSwDPmeo=;
        b=cl9Cttuk+3C1H/DUX7UbBuuk/C2eltVEy5KZPy96IxXRgmmeUzfOsCoUzgx0Obp3tn
         6t2q4B8MfYAzyXUUy8e9YrgX59JiuieL5bwW0eaS7y18hgBukj6MX1iYVPfwxXepuCi2
         YcLGseo/O/QU94IsjcoDx1HHa9ZL2P3yFS6Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=n3WSMsnddltdlw4ICidvJV35a7iSiOmT72tNgtI5Y6Sq6a0MMvJjFXeU0uZvzkWpCg
         mZgHRgN6pfwmbnION9u6KZcyFdH/Ak0dR0vicflYx6Fh6d18jx4O9MTvVnCb9N72VeRA
         mXO4OWrKgeSwRiFwkPP2uAZuyskJ20tZ49ge8=
Received: by 10.86.3.16 with SMTP id 16mr542670fgc.4.1247178997018;
        Thu, 09 Jul 2009 15:36:37 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id 4sm623602fge.17.2009.07.09.15.36.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 15:36:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123016>

> +		if (ce->name[len]>  '/')
> +			break;
> +		if (ce->name[len]<  '/')
> +			continue;

What about

	if (ce->name[len] < '/') {
		if (strchr(ce->name + len + 1, '/'))
			break;
		else
			continue;
	}

to just punt if we'd go into a directory?  I'm not much worried about 
accessing foo-0001, foo-0002, foo-0003 while looking for foo/a (that 
would be O(number of files in a directory), which is bearable), but 
risking to go down a huge subtree is not very nice.

Paolo
