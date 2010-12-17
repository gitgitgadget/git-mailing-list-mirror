From: Ken Brownfield <krb@irridia.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 18:36:36 -0800
Message-ID: <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com> <201012170254.13005.trast@student.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 03:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTQBe-0008QN-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 03:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab0LQCgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 21:36:37 -0500
Received: from endymion.irridia.com ([184.105.192.220]:16801 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0LQCgh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 21:36:37 -0500
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id 3D16614561D
	for <git@vger.kernel.org>; Thu, 16 Dec 2010 18:36:37 -0800 (PST)
In-Reply-To: <201012170254.13005.trast@student.ethz.ch>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163853>

I had considered this approach (and the one mentioned by Jonathan) but there are no git tools to actually perform the filter I wanted on the export in this form.  I could (and will) parse fast-export and make an attempt a filtering files/directories... my concern is that I won't do it right, and will introduce subtle corruption.  But if there's no existing tool, I'll take a crack at it. :-)

Thanks for your suggestions so far,

Ken

PS: This was my exact first thought, since I was previously used to performing "svnadmin dump/svndumpfilter/svnadmin load" on this repository when it was in SVN.

On Dec 16, 2010, at 5:54 PM, Thomas Rast wrote:

> Ken Brownfield wrote:
>> git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch -- bigdirtree stuff/a stuff/b stuff/c stuff/dir/{a,b,c}' --prune-empty --tag-name-filter cat -- --all
> [...]
>> Now that the same repository has grown, this same filter-branch
>> process now takes 6.5 *days* at 100% CPU on the same machine (2x4
>> Xeon, x86_64) on git-1.7.3.2.  There's no I/O, memory, or other
>> resource contention.
> 
> If all you do is an index-filter for deletion, I think it should be
> rather easy to achieve good results by filtering the fast-export
> stream to remove these files, and then piping that back to
> fast-import.
> 
> (It's just that AFAIK nobody has written that code yet.)
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
