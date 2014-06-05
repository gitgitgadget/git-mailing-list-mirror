From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Thu, 05 Jun 2014 14:30:17 +0200
Message-ID: <539062D9.60000@web.de>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>	 <1401853091-15535-2-git-send-email-dturner@twitter.com>	 <538ED2F1.9030003@web.de>	 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>	 <538F2C6B.2030004@web.de> <1401916560.18134.167.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXI=?= =?UTF-8?B?c2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:30:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsWoO-00063s-W6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 14:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaFEMaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 08:30:25 -0400
Received: from mout.web.de ([212.227.15.14]:53483 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaFEMaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 08:30:24 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M89fV-1WWtHn47WL-00vflZ; Thu, 05 Jun 2014 14:30:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401916560.18134.167.camel@stross>
X-Provags-ID: V03:K0:E/ubU5t/b7wQO3EJLFNnNsS0f7ZO5eBFYuE4pYdp7wSDALEGTjp
 XsTZ5S+6MCN8bYM9QlShzlpqCOGA+tfklqWWBivOqzQ0XNRbeY6qAcjOpoUHSCgwweGfOr2
 ZdiUtmcUqcZGkMk4CR19LaKg0hARbamyJet7tGXDCHP2GgnFZHU3gEmVDWlciRIqlmYD9xK
 iVwBhTtqzOWot2YvqZYOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250834>

On 2014-06-04 23.16, David Turner wrote:
> 
> Sure!  I actually went with > 120k to make measurement easier:
> https://github.com/dturner-tw/many-refs
Hm, I didn't get so man

git remote -v
origin  https://github.com/dturner-tw/many-refs 

 wc .git/packed-refs 
     750    1130   38868 .git/packed-refs



time git rev-parse HEAD
7ac416f789fd4f1e398449113f6e1ec1d699141a

real    0m0.008s
user    0m0.002s
sys     0m0.004s

where only patch 1/2 doesn't seem to speed up things on my system:

time ~/projects/git/tb.140604_DavidTurner_SSE4/git rev-parse HEAD
7ac416f789fd4f1e398449113f6e1ec1d699141a

real    0m0.010s
user    0m0.002s
sys     0m0.005s



Intel Core Duo @ 2.4 Ghz, Mac OS

(and I get similar values under an AMD Dual core running 2Ghz under Linux)
