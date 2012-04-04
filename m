From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase -p loses amended changes
Date: Wed, 04 Apr 2012 08:30:55 +0200
Message-ID: <4F7BEA9F.3060805@viscovery.net>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com> <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com> <87fwcpun95.fsf@thomas.inf.ethz.ch> <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com> <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com> <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com> <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:31:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFJkI-0002z0-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 08:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab2DDGbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 02:31:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30337 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2DDGbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 02:31:00 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SFJkF-0006iW-R7; Wed, 04 Apr 2012 08:31:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 77AA81660F;
	Wed,  4 Apr 2012 08:30:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194680>

Am 4/4/2012 0:09, schrieb Phil Hord:
> On Tue, Apr 3, 2012 at 5:43 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> Suppose you have a merge of a A and B that produces M, which is then
>> amended as M'.
>>
>> During rebase, you redo the merge A and B. If there are no conflicts,
>> then compare M with M' to produce D. You now have enough information
>> to reproduce the amended commit M' during a rebase (merge Ar and,Br
>> then apply D).
> 
> How does M' know it is an amended version of M?  When you amended the
> commit M you threw away this linkage.
> 
> If you created M' as a new commit D instead, then I would agree that
> you have enough information to do what you seek.  In fact, I'm pretty
> sure git does this already.

IMO, it is a sub-optimal implementation of rebase -p that it attempts to
redo the merge. A better strategy is to just replay the changes between
the first parent and the merge commit, and then generate a new merge commit:

   git diff-tree -p M^ M | git apply --index &&
   git rev-parse M^2 > .git/MERGE_HEAD &&
   git commit -c M

This would side-step all the issues discussed here, no?

-- Hannes
