From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 09:26:55 -0700
Message-ID: <482C644F.9090903@facebook.com>
References: <482B935D.20105@facebook.com> <482BE0EB.6040306@viscovery.net> <482BE238.5020309@facebook.com> <482BF69C.6020604@viscovery.net> <alpine.DEB.1.00.0805151004400.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 18:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwgJ8-0005dF-0x
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 18:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbYEOQ1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 12:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbYEOQ1B
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 12:27:01 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:36533 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584AbYEOQ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 12:27:00 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4FGQutl022809;
	Thu, 15 May 2008 09:26:56 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 09:24:05 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.DEB.1.00.0805151004400.30431@racer>
X-OriginalArrivalTime: 15 May 2008 16:24:05.0861 (UTC) FILETIME=[184E6150:01C8B6A8]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_04:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805150124
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82211>

The problem with this implementation is that it does not distinguish
between GIT_CEILING_DIRS being unset and GIT_CEILING_DIRS="/".  For
example...

cd /
sudo git init
cd /home
git rev-parse --show-prefix

That series of commands works with either version of my patch, but fails
with "fatal: Not a git repository" if I apply this change.  I am
certainly open to changing this code, but I think we will always
need two separate values of ceil_offset to represent "unset" and "/".
It's just a question of whether they should be -1 and 0 or 0 and 1.

--David


Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 15 May 2008, Johannes Sixt wrote:
> 
>> +             do { } while (offset > ceil_offset && cwd[--offset] != '/');
> 
> You probably meant to remove the "do { }", and have an own line
> 
>                         ; /* do nothing */
> 
> but for the rest, I agree that it is easier on the eye (particularly the
> off-by-one issue, which is always a problem for this developer to get
> right; avoiding it is therefore the better option).
> 
> Ciao,
> Dscho
> 
