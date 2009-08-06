From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 09:45:01 +0200
Message-ID: <4A7A89FD.4040800@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <4A7A5723.6070704@gmail.com> <alpine.LFD.2.01.0908052120330.3390@localhost.localdomain> <4A7A6DBC.9010107@gmail.com> <4A7A7074.1060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYxf5-0007Ep-3m
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 09:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZHFHpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 03:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbZHFHpH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 03:45:07 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:60692 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZHFHpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 03:45:06 -0400
Received: by fxm28 with SMTP id 28so572509fxm.17
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=+JACJk91mYKeQVNspJcLihYCwYs40OO2u0fHkR6x8tM=;
        b=P3I3cDPTOxnYyQ5P395+GQ2ajUT1h3a3xEo87HpWSolCIsjqpLeIzKeycgdDqKiUoa
         J4ydSjdg3wA0cKjFOqfNsRlqxmRQ0KhxDNoOATJlnQ95A6eFchsdua28jbO58QIcuxyJ
         XFSUxIh/eAqpk+CxLft0RdX7asyVqlnvC9Nto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=C+ntp9kRpCfG7NyZ+tMUJlsVqU4W2pGz2UYP44MEDKpv2IV+aP1tOKrNp1+lcQokzX
         ddNt23vQkMDNqJlDmvRXZIDqH6RHhEEe4Ii+DBmA/YOVkYFT6YmBLr++Ab3qh+qXG4Dv
         CBUaNbanvxvVK2CfZJ6GtG8AJktTLbsNjIdUo=
Received: by 10.103.239.2 with SMTP id q2mr708112mur.83.1249544704361;
        Thu, 06 Aug 2009 00:45:04 -0700 (PDT)
Received: from ?172.19.43.221? (ip-94-42-19-54.multimo.pl [94.42.19.54])
        by mx.google.com with ESMTPS id y6sm57798506mug.40.2009.08.06.00.45.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 00:45:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A7A7074.1060506@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125049>

Artur Skawina wrote:
> 
> and my atom seems to like the compact loops too: 

no, that was wrong, i forgot to turn off the ondemand governor...

the unrolled loops are in fact much faster and the numbers
look more reasonable, after a few tweaks even on a P4.
Now i just need to check how well it does compared to the
asm implementations...

artur

#             TIME[s] SPEED[MB/s]
# ATOM
rfc3174         2.199       27.75
linus          0.8642       70.62
linusas         1.606       38.01
linusas2       0.8763       69.65
mozilla         2.813        21.7
mozillaas       2.539       24.04
# P4
rfc3174         1.402       43.53
linus          0.5835       104.6
linusas        0.4625         132
linusas2       0.4456         137
mozilla         1.529       39.91
mozillaas       1.131       53.96
# P3
rfc3174         5.019       12.16
linus            1.86       32.81
linusas         3.108       19.64
linusas2        1.812       33.68
mozilla         6.431        9.49
mozillaas       5.868        10.4
