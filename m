From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-fast-import: note 1M limit of mark number
Date: Wed, 16 Apr 2008 09:04:32 +0200
Message-ID: <4805A500.5070707@alum.mit.edu>
References: <20080415125222.C55C121CE8F@mail.utsl.gen.nz> <4804CECE.2040205@alum.mit.edu> <48051882.8000201@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 09:06:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm1hu-0005u7-I3
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 09:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYDPHEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 03:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYDPHEk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 03:04:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35518 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbYDPHEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 03:04:40 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m3G74bxa014681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Apr 2008 09:04:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <48051882.8000201@vilain.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79682>

Sam Vilain wrote:
> Michael Haggerty wrote:
>>> ++
>>> +Note that due to current internal limitations, you may not make marks
>>> +with a higher number than 1048575 (2^20-1).
>>>  
>>>  * A complete 40 byte or abbreviated commit SHA-1 in hex.
>>>  
>> Oh.  Um.  That is an awkwardly small number nowadays.
>>
>> cvs2svn has been used for repositories with O(2^20) distinct file
>> revisions (KDE, Mozilla, NetBSD, ...).  So this limit will likely be too
>> small for some users.
> 
> Right.  But, if you're not making the importer you write for a
> conversion of that size restartable, you're insane.  So, marking more
> than 1Mi *marks* in a single gfi session might not be so vital.

Well, call me insane then.  Because there *are* no bulletproof
incremental CVS importers, and it would be a lot of work to write one.
(git-cvsimport doesn't count because it is far from bulletproof.)  So it
is reasonable to choose a high-quality one-time conversion over a broken
restartable conversion.

>> While I'm at it, let me also renew my suggestion that git-fast-import
>> use separate namespaces ("markspaces", so to speak) for file content
>> marks and for commit marks.  There is no reason for these distinct types
>> of marks to be located in a shared space of integers.
> 
> There is a reason, it's because they're both just object IDs.  Is it
> really that much of a drag?  I know what you mean though, it meant for
> my code I had to keep track of which type each mark was.

That's exactly my point.  That's at least two of us then who have had
extra work to merge two separate ID concepts into a single integer
sequence.  It's not a big deal, but it would be convenient if
git-fast-import allowed the sequences to overlap.

Michael
