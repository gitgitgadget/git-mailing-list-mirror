From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Broken makefile check for curl version on el4 [Re: [ANNOUNCE] Git
 v2.3.0-rc2]
Date: Thu, 29 Jan 2015 13:58:44 +0100
Message-ID: <54CA2E84.6090604@statsbiblioteket.dk>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 14:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGoqF-0003I8-KX
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 14:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbbA2NIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 08:08:50 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:3216 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757053AbbA2NIt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2015 08:08:49 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jan 2015 08:08:49 EST
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Thu, 29 Jan 2015 13:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263145>

On 28/01/15 00:35, Junio C Hamano wrote:
> A release candidate Git v2.3.0-rc2 is now available for testing
> at the usual places.
>

Building is broken on RHEL4 which is a regression from 2.2.2.

The makefile check for curl >= 7.34.0 fails and enables 
USE_CURL_FOR_IMAP_SEND even though curl is 7.12.1.

# curl-config --vernum
70C01
# { echo 072200; curl-config --vernum 2>/dev/null ; } | sort -r | sed -ne 2p
072200
#

I checked the curl release tarballs and this problem seems to exist for 
curl 7.11.0 (0x70B00) through 7.12.2 (0x70C02). In both 7.10.7 
(0x070a07) and 7.12.3 (0x070c03) the version is correctly set using 6 
hex digits as documented.
I tried to verify this using the official curl repo on github but it 
does not seem to record this discrepancy and shows the correct 6 digit 
version numbers for the affected releases.

As a workaround I'm piping curl-config --vernum through sed -e 
'/^70[B-C]/ s/^7/07/'.

-tgc
