From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/11] commit: avoid race when creating orphan commits
Date: Wed, 11 Feb 2015 16:47:52 +0100
Message-ID: <54DB79A8.9020409@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>	<1423412045-15616-8-git-send-email-mhagger@alum.mit.edu> <CAGZ79kYF2WWqSq71d5FZvP7PCKra-cmYHPAB0RVFed8Ag14ZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLZWR-0006zP-Fn
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 16:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbbBKPsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 10:48:11 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48311 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862AbbBKPsL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 10:48:11 -0500
X-AuditID: 1207440d-f79976d000005643-1f-54db79ab8f52
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id EA.28.22083.BA97BD45; Wed, 11 Feb 2015 10:47:55 -0500 (EST)
Received: from [192.168.69.130] (p4FC9687D.dip0.t-ipconnect.de [79.201.104.125])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1BFlqXV015348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Feb 2015 10:47:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kYF2WWqSq71d5FZvP7PCKra-cmYHPAB0RVFed8Ag14ZWA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqLu68naIwf5LbBZdV7qZLBp6rzBb
	vL25hNGie8pbRovevk+sFps3t7M4sHnsnHWX3WPBplKPi5eUPT5vkgtgieK2SUosKQvOTM/T
	t0vgzljV08JY0MJScerQJ6YGxpnMXYycHBICJhLH/y1mh7DFJC7cW8/WxcjFISRwmVHi2fTT
	zBDOBSaJwx1vwKp4BbQlLjx/wQZiswioSnTNnccEYrMJ6Eos6mkGs0UFgiQOnX7MAlEvKHFy
	5hMwW0RATWLmqtlgG5gF5jFJXGn/CTZIWMBL4tjT24wQ2w4xSnyYuwsswSkQKLHqyBawbmYB
	dYk/8y4xQ9jyEtvfzmGewCgwC8mSWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
	10gvN7NELzWldBMjJMx5dzD+XydziFGAg1GJh9dj660QIdbEsuLK3EOMkhxMSqK891Nuhwjx
	JeWnVGYkFmfEF5XmpBYDnczBrCTCy58FlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5N
	LUgtgsnKcHAoSfC2VwA1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNb4YGLEg
	KR6gvRdB2nmLCxJzgaIQracYdTkWtO+fySTEkpeflyolzisCTEtCAiBFGaV5cCtgSe0VozjQ
	x8K8D0BG8QATItykV0BLmICWFBTcAFlSkoiQkmpgVFuloSe3caJXiam2z8bdiw9o/bqpYx5h
	td/y6PnKVS4izCt2JpofiXvI/HpJl4jzvfsNfdXM1b57tOZt27L3c+7jTyduNT03 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263679>

On 02/09/2015 07:35 PM, Stefan Beller wrote:
> On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> If, during the initial check, HEAD doesn't point at anything, then we
> 
> Maybe
> "If HEAD doesn't point at anything during the initial check, then..." ?
> (Being a non native speaker is hard. These commas look so confusing,
> so the version without commas makes it way easier to read for me.)

Will change. Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
