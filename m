From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 01:37:49 +0200
Message-ID: <46B26ACD.2080405@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>, git@vger.kernel.org,
        users@cvs2svn.tigris.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: users-return-1611-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 01:37:56 2007
Return-path: <users-return-1611-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGkEt-0001VW-5G
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 01:37:55 +0200
Received: (qmail 32255 invoked by uid 5000); 2 Aug 2007 23:37:53 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 32245 invoked from network); 2 Aug 2007 23:37:53 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAPIHskbAbSoIh2dsb2JhbACOEgEBCQoH
X-IronPort-AV: i="4.19,215,1183359600"; 
   d="scan'208"; a="63480883:sNHT19680374"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54644>

Steffen Prohaska wrote:
> On Aug 2, 2007, at 7:35 PM, Simon 'corecode' Schubert wrote:
>> Steffen Prohaska wrote:
>>>   fromcvs's togit surrendered during the import.
>>>   fromcvs's tohg accepted more of the history, but finally
>>>     surrendered as well.
>>
>> Which repo is it you are converting?  Is this available somewhere?
> 
> Unfortunately not, the content is a proprietary software package.
> 
>> I'd appreciate any reports concerning "surrenders" of fromcvs. 
>> [...]
> 
> Some time passed since I did the tests. I had no time to do a
> detailed investigation then. I'll have more time now and will
> prepare a bug report, which is not easy because I can't sent you
> the cvs repo, sorry.

I wrote a couple of scripts for dealing with just this situation for
cvs2svn bug reports, but they should also work for you, and I highly
recommend them.  Both scripts are included in the cvs2svn source tree:

1. contrib/destroy_repository.py [1] -- strips almost all of the
information out of a CVS repository, including author names, log
messages, and file contents (but not file names, commit dates, or
branch/tag names).  Most bugs are not affected by the omission of such
data.  Use of this script has the effect of deleting most information
that might be considered proprietary and also shrinking the size of the
test case considerably.  Use of this script is described in the script
comments itself and also in [2].

2. contrib/shrink_test_case.py [2] -- you provide the script with a
command that should "exit 0" if the bug you are looking for still
exists.  It does a kind of "binary search" through CVS repository space,
iteratively attempting to delete a chunk of the CVS repository, running
the test command, then (depending on whether the test succeeded) either
reverting or making permanent the deletion.  It can boil most test cases
down to just 1-3 files (though presumably not if the "problem" is a
23-way merge).  The things that it will try to delete are:

  - Entire directories and groups of directories
  - Entire files and groups of files
  - Branches within individual files
  - Tags within individual files

It does this in a somewhat optimal way, trying to minimize the number of
times that the test has to be run.  This script is documented in its own
comments and also in [4].

Michael

[1]
http://cvs2svn.tigris.org/svn/cvs2svn/trunk/contrib/destroy_repository.py
[2] http://cvs2svn.tigris.org/faq.html#reportingbugs
[3] http://cvs2svn.tigris.org/svn/cvs2svn/trunk/contrib/shrink_test_case.py
[4] http://cvs2svn.tigris.org/faq.html#testcase
