From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 07:56:04 +0200
Message-ID: <4A7A7074.1060506@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <4A7A5723.6070704@gmail.com> <alpine.LFD.2.01.0908052120330.3390@localhost.localdomain> <4A7A6DBC.9010107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYvxY-0005EP-OY
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 07:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZHFF4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 01:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbZHFF4K
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 01:56:10 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:38497 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbZHFF4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 01:56:07 -0400
Received: by ewy10 with SMTP id 10so532454ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=VcWPWYwVFyMW4y+PwGYDA1DQW5UV7KG6twclcJ2DeLY=;
        b=G1y2bxK1KY4E1BYhYOUknAUqiAa+l+wfgsZPsX7dnhxdHcFMALKY9cPn0ByW+JNkZJ
         03XxRTTegej9aNkKwSr6Sog56d8tyMnDoq8Ela48dL2LB2HpuH733lfAVWQGl5LGkBCa
         XxwK6d9u/lydmxr1t6E610f3GiXYX2jtx9Vnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=LEUJ7vvLeoBVKEq22d8mYNGrTNf5LLb7srI+Cr01rJritNinwXdfbjoA27ao72WART
         qmPP53v4ohJ8IMeNB2Ys04AqCA177/OMA8o73kIZeWeXaOHgl+/xIb9w9rF3dbAZ+1ah
         QU/fO8fJGP+xjdY1cJEZPCNTXmvX8eEfg+xPY=
Received: by 10.211.202.1 with SMTP id e1mr11481693ebq.85.1249538167082;
        Wed, 05 Aug 2009 22:56:07 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-126-135.multimo.pl [89.174.126.135])
        by mx.google.com with ESMTPS id 5sm4208596eyh.6.2009.08.05.22.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 22:56:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A7A6DBC.9010107@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125044>

Artur Skawina wrote:
> i did try (obvious patch below) and in fact the loops still win on p4:
> 
> #Initializing... Rounds: 1000000, size: 62500K, time: 1.428s, speed: 42.76MB/s
> #             TIME[s] SPEED[MB/s]
> rfc3174         1.437       42.47
> rfc3174         1.438       42.45
> linus          0.5791       105.4
> linusas        0.5052       120.8
> mozilla         1.525       40.01
> mozillaas       1.192       51.19

and my atom seems to like the compact loops too: 

#Initializing... Rounds: 1000000, size: 62500K, time: 4.379s, speed: 13.94MB/s
#             TIME[s] SPEED[MB/s]
rfc3174         4.429       13.78
rfc3174         4.414       13.83
linus           1.733       35.22
linusas           1.5        40.7
mozilla         2.818       21.66
mozillaas       2.539       24.04

artur
