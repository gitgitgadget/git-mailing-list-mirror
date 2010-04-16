From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: A bug in git 1.6.5.2 with git log --stat: shows a negative number
 as a size
Date: Fri, 16 Apr 2010 17:02:01 +0200
Message-ID: <4BC87BE9.9040704@dbservice.com>
References: <20100416135948.GA26918@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Fri Apr 16 17:02:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2n3g-0004r8-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 17:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0DPPCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 11:02:09 -0400
Received: from office.neopsis.com ([78.46.209.98]:34216 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0DPPCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 11:02:08 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 16 Apr 2010 17:02:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100416135948.GA26918@zakalwe.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145065>

On 4/16/10 3:59 PM, Heikki Orsila wrote:
> I'm running git version 1.6.5.2. git log --stat shows a negative
> diffstat size for two files that are each 2049MiB in size.
>
> Steps to reproduce:
>
> $ for f in 0 1 ; do dd bs=$((1024*1024)) if=/dev/zero of=$f count=2049 ; done
> $ git add 0 1
> $ git commit -m "test commit"
> $ git log --stat
> commit 6afe3d3c889daa92bd79956c4bb733eb5cb408dc
> Author: Heikki Orsila<heikki.orsila@iki.fi>
> Date:   2010-04-16 16:54:52 +0300
>
>      test commit
>
>   0 |  Bin 0 ->  -2146435072 bytes
>   1 |  Bin 0 ->  -2146435072 bytes
>   2 files changed, 0 insertions(+), 0 deletions(-)

Yep, bug is also in the latest version (1.7.0.5). The code uses 'int' 
instead of something big enough to hold the size of your files.

http://git.kernel.org/?p=git/git.git;a=blob;f=diff.c;h=a1bf1e9cb37104cda8168c5118769ce5bbcfcbb2;hb=HEAD#l1105

and a couple lines below (1124) you see that the stat is printed out.

tom
