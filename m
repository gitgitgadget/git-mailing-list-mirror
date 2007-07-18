From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 10:01:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
References: <20070718153614.GA28815@hartlich.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Hartlich <wwsgj@hartlich.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 19:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCuJ-0002WB-0S
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 19:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbXGRRBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 13:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbXGRRBn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 13:01:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49365 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754005AbXGRRBm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 13:01:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IH1adJ026801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 10:01:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IH1Vqa019490;
	Wed, 18 Jul 2007 10:01:31 -0700
In-Reply-To: <20070718153614.GA28815@hartlich.com>
X-Spam-Status: No, hits=-2.669 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52881>



On Wed, 18 Jul 2007, Peter Hartlich wrote:
> 
> My timezone is set to right/Europe/Berlin. git-log 1.5.2.2 gives me 
> output such as:
> 
> | Date:   Wed Jul 18 16:17:31 2007 +0159
> 
> Note the timezone, which should be +0200.

Wow. I just tried:

	git show --raw --date=local

with TZ=CET and TZ=right/Europe/Berlin respectively.

Trippy.

I get:

	commit 9dfdf14b3805e89aa2782458bda15b3dfae24c09
	Author: Junio C Hamano <gitster@pobox.com>
	Date:   Mon Jul 16 01:41:17 2007

for the CET case, but for right/Europe/Berlin I get:

	commit 9dfdf14b3805e89aa2782458bda15b3dfae24c09
	Author: Junio C Hamano <gitster@pobox.com>
	Date:   Mon Jul 16 01:39:54 2007

ie apparently Berlin is in a timezone of its own that is roughly one 
minute and 23 seconds away from CET.

What the *heck*?

I really don't think this is git that is confused: I get the exact same 
thing with "date" too:

	[torvalds@woody git]$ TZ=right/Europe/Berlin date ; TZ=CET date
	Wed Jul 18 18:52:25 CEST 2007
	Wed Jul 18 18:52:48 CEST 2007

so it really *is* the tzdata that says that Berlin is not +0200, and it's 
not even +0159, it's something really strange with fractional minutes away 
from UTC.

What can I say? "Those wacky Germans - they have a wonderful sense of 
humor"?

			Linus
