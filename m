From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Patchset NTLM-Authentication
Date: Tue, 21 Feb 2012 20:02:34 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1202211954160.5167@tvnag.unkk.fr>
References: <4CDEC141B5583D408E79F2931DB7708301802B70@GSX300A.mxchg.m.corp> <87vcn0h77a.fsf@thomas.inf.ethz.ch> <4CDEC141B5583D408E79F2931DB7708301802BE7@GSX300A.mxchg.m.corp> <8762f05n9q.fsf_-_@thomas.inf.ethz.ch> <7vfwe4gj4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 20:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzuzh-0007aY-Fi
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 20:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab2BUTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 14:03:15 -0500
Received: from giant.haxx.se ([80.67.6.50]:35767 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706Ab2BUTDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 14:03:15 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q1LJ2ZmN018482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Feb 2012 20:02:35 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q1LJ2YUU018477;
	Tue, 21 Feb 2012 20:02:34 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7vfwe4gj4n.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191176>

On Tue, 21 Feb 2012, Junio C Hamano wrote:

> If it turns out that we can set CURLOPT_PROXYAUTH always to CURLAUTH_ANY 
> without compromising security, then an explanation why this does not have to 
> be optional, similar to what justified 525ecd2, needs to be there instead, 
> and the patch needs to be tweaked to drop the configuration bits.

Allow me to provide some libcurl info on this!

Setting it to ANY will unconditionally cause an extra roundtrip which you can 
avoid if you know what auth type the proxy wants and you set it at once. With 
ANY set, libcurl will first "probe" the proxy to figure out which type to use 
and then go on and actually do it in a second request (and possibly even a 
third request in some cases).

It can actually be seen as a security _improvement_ in some cases where for 
example Basic auth (user+password sent as plain text) can be avoided in 
preference to a more secure mechanism, but I think that's a rather rare case 
for git.

IMO, if ANY is considered fine for normal host authentication I think it could 
be considered fine for proxy authentication as well.

-- 

  / daniel.haxx.se
