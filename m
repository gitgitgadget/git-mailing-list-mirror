From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git slow over https
Date: Fri, 28 Oct 2011 20:28:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1110282019510.28338@tvnag.unkk.fr>
References: <CAOs=hR+K_YZcjdAUq_jaz0wc9k8BRQ2-ny7A=GFaNL4R-W0UBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJrM7-00033S-Da
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab1J1Skf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:40:35 -0400
Received: from giant.haxx.se ([80.67.6.50]:43689 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709Ab1J1Ske (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:40:34 -0400
X-Greylist: delayed 722 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2011 14:40:34 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p9SISTFl021278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Oct 2011 20:28:29 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id p9SISSCC021269;
	Fri, 28 Oct 2011 20:28:28 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CAOs=hR+K_YZcjdAUq_jaz0wc9k8BRQ2-ny7A=GFaNL4R-W0UBw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184426>

On Fri, 28 Oct 2011, Mika Fischer wrote:

> 1) What's the purpose of the select in http.c:673? Can it be removed?
> 2) If it serves a useful purpose, what can be the reason that it hurts
> performance so much in my case?

The purpose must be to avoid busy-looping in case there's nothing to read.

It should probably use curl_multi_fdset [1] to get a decent set to wait for 
instead so that it'll return fast if there is pending data. The timeout for 
select can in fact also get extended with the use of curl_multi_timeout [2].

1 = http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
2 = http://curl.haxx.se/libcurl/c/curl_multi_timeout.html

-- 

  / daniel.haxx.se
