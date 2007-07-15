From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 14:04:36 +0200
Message-ID: <469A0D54.8010303@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com> <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Jul 15 14:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA2rB-00033l-CZ
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 14:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbXGOMFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 08:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759053AbXGOMFT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 08:05:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35233 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758834AbXGOMFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 08:05:18 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6FC4bQK028169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Jul 2007 14:04:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20070715013949.GA20850@thyrsus.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52546>

Eric S. Raymond wrote:
> Michael Haggerty <mhagger@alum.mit.edu>:
>>                                               The CVS history *does*
>> have to be deformed a bit to fit into SVN, and an svn2xxx converter
>> would have to undo the deformation.
> 
> Then perhaps the right thing to think about is this: how exactly does
> CVS history need to be deformed, and is there some way to express the
> lost information as conventional properties or tags?

Hmmm, perhaps "deformed" was not the best word.  "Reorganized" is a
better description.

For example, cvs2svn internally deduces which files should be added to a
given branch in a given commit.  But the information cannot be output to
SVN in that form.  Instead, cvs2svn has to figure out which
*directories* to copy to the branch directory, then which files to
remove from the copied directory (because they shouldn't have been
tagged), and which other files to copy from other sources.  This extra
work, which is quite time- and space-consuming, is worse than pointless
when converting to git, because git has to invert the process to figure
out which individual files have to be tagged!

>> My idea is not to built (for example) cvs2git; rather, I'd like cvs2svn
>> to be split conceptually into two tools:
> 
> Well, that makes more sense.  But how would whatever the first half outputs
> be different from an svn dump file? 

The interface between the two halves does not necessarily need to be a
serialized data stream; it could just as well be via the Python API that
is used internally by cvs2svn to access the reconstructed commits and
supporting databases.  This would require the second half to be written
in Python, but otherwise would be very flexible and would avoid the need
to find a be-all serialized format.

Michael
