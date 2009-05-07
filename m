From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 7 May 2009 14:54:43 +0200
Message-ID: <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Benjamin Kramer <benny.kra@googlemail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu May 07 14:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M238V-0006eL-OG
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbZEGMyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761891AbZEGMyt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:54:49 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:37554 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761791AbZEGMyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:54:47 -0400
Received: by bwz22 with SMTP id 22so749587bwz.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=9NPckQjozS+7vWEWZyhGgm9T5BCCJMR3gnYhqSveDvw=;
        b=lSaMyUeHS1WKmU3oObJ2q7AdCrNADhRQxPgxD8upvy+tLT/afex2ViK1q9/6JLhmK3
         ijQFIXTRZQOlbI7QEaoDjh7LHr2hm+HjRH2NRiInrVP96iXjfZe8wMvBjNQeOwwrDyFF
         Bs1eTOQplYNiov4Obkx71CRafuq+qGWQONv3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=YwhLPE23m+c/DEtG2cqfOBTCWp2cx/ShkB30/pDJbGsDfrFqs2+P/U4aPR5Hd9vOLH
         t4JC2JOu/IckHYXqNnmWob354XdyLeY6/haN6adKB4bbVe4YP6AvZcTOCUOtpvSGhewh
         wgouC4Bfsn7JHFqQpaBzXNuAevjNulA3GeTXo=
Received: by 10.103.226.20 with SMTP id d20mr1614323mur.8.1241700886764;
        Thu, 07 May 2009 05:54:46 -0700 (PDT)
Received: from ?192.168.1.24? (p5B01CB42.dip.t-dialin.net [91.1.203.66])
        by mx.google.com with ESMTPS id n10sm65720mue.47.2009.05.07.05.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 05:54:46 -0700 (PDT)
In-Reply-To: <4A02D70B.6090305@op5.se>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118473>


Andreas Ericsson wrote:

> What per-IP directories are you talking about?

git daemon has a feature called interpolated paths

If git daemon is started like this:
     git daemon --interpolated-path=%IP/%D
(the machine has two IPs: 123.123.123.123 (v4) and 2001:db8::1 (v6))
and someone clones a repository:
     git clone git://123.123.123.123/frotz
git daemon will look for the repository in the directory  
`123.123.123.123/frotz'

But if git daemon listens on the IPv6 interface and someone clones a  
repository:
     git clone git://2001:db8::1/frotz
Then git daemon will look for the repository in `0.0.0.0/frotz'

My patch makes it converting IPv6 addresses properly and if you the  
clone
in my previous example it'll now look in `2001:db8::1/frotz' (with  
colons in the
directory name)

I hope my intentions are now a bit clearer ;)
