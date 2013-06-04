From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 23:18:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306042305300.2878@tvnag.unkk.fr>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com> <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com> <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr> <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com> <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
 <CEC3E2C7A86A477DAC658432461A60BC@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Janusz Harkot <janusz.harkot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujycy-0007tE-6C
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab3FDVSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:18:40 -0400
Received: from giant.haxx.se ([80.67.6.50]:50642 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab3FDVSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:18:38 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r54LISXc022269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jun 2013 23:18:28 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r54LIRX5022265;
	Tue, 4 Jun 2013 23:18:28 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CEC3E2C7A86A477DAC658432461A60BC@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226408>

On Tue, 4 Jun 2013, Janusz Harkot wrote:

>> What makes you suggest that's what's happening? Sure, if it would've sent no
>> or the wrong host name it would probably have that effect.
>
> line:
>
> [36] * Re-using existing connection! (#0) with host (nil)

Ah that. Yes, that's a stupid line to show (that bug has been fixed since). 
But if you look further down your log you see that the connection which is 
re-used according to that log line gets closed anyway.

> it looks like it is working

Awesome!

> So, the question is still why it is not working with openssl 0.9.8r - this 
> version supports SNI by default. This looks like an error in openssl (maybe: 
> Only allow one SGC handshake restart for SSL/TLS.)

Right. As you can see in the libcurl code it activates SNI for OpenSSL the 
exact same way independently of what version that's used.

> Now is the question, shall this be handled by curl or left alone? (handling 
> older version of openssl, and force new ssl session?)

I'm not even completely convinced this is "just" an old-OpenSSL-problem. If 
that version you're using is the one Apple has provided, there's the risk that 
the problem is rather caused by their changes!

I'm reluctant to globally switch off session-id caching for OpenSSL 0.9.8 
users since that feature has been used for over 8 years in the code and you're 
the first to have a problem with it! =-/

-- 

  / daniel.haxx.se
