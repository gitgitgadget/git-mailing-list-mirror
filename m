From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 02 Jul 2013 11:24:14 +0200
Message-ID: <51D29C3E.5070600@alum.mit.edu>
References: <201307012102.31384.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utwox-0004PX-P6
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab3GBJYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:24:19 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48727 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932521Ab3GBJYS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 05:24:18 -0400
X-AuditID: 12074411-b7f296d000001209-c9-51d29c4145a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DE.FB.04617.14C92D15; Tue,  2 Jul 2013 05:24:18 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r629OFOG025133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jul 2013 05:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <201307012102.31384.mfick@codeaurora.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqOs051KgQfsyZouuK91MFg29V5gt
	7r9fx2Txo6WH2YHF43JfL5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdMWHRffaC
	DuGKG+13mRsYv/N1MXJySAiYSBx6dZ8RwhaTuHBvPRuILSRwmVHizjaFLkYuIPsqk8T3JYfA
	ErwC2hLXP65iB7FZBFQl3vTPAouzCehKLOppZupi5OAQFQiTuPJbFaJcUOLkzCcsILaIgJrE
	jskbmEBsZoF4ia5l15hBbGEBa4mLW+8wQ+w1lTg/aw9YDaeAmcTt/7tZIep1JN71PWCGsOUl
	tr+dwzyBUWAWkhWzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrp
	JkZIMAvuYJxxUu4QowAHoxIP74nZFwOFWBPLiitzDzFKcjApifIemnkpUIgvKT+lMiOxOCO+
	qDQntfgQowQHs5II701voHLelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgSv62ygoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaO++WUDt
	vMUFiblAUYjWU4y6HAd+bHnPKMSSl5+XKiXOGwiyQwCkKKM0D24FLHW9YhQH+liY9w/IKB5g
	2oOb9ApoCRPQkuw6sCUliQgpqQbG5VyP4u0tZyzLqrDst11p9ygt8dQHqw9z5jTFtabdmafQ
	dfVTvpmHtlP2z9MKPt0b95ifi1wtlqFdvMXcVFXl/aGpfaEcH1/sEJ6/qyI55Gmn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229385>

On 07/02/2013 05:02 AM, Martin Fick wrote:
> I have often reported problems with git fetch when there are 
> many refs in a repo, and I have been pleasantly surprised 
> how many problems I reported were so quickly fixed. :) With 
> time, others have created various synthetic test cases to 
> ensure that git can handle many many refs.  A simple 
> synthetic test case with 1M refs all pointing to the same 
> sha1 seems to be easily handled by git these days.  However, 
> in our experience with our internal git repo, we still have 
> performance issues related to having too many refs, in our 
> kernel/msm instance we have around 400K.
> 
> When I tried the simple synthetic test case and could not 
> reproduce bad results, so I tried something just a little 
> more complex and was able to get atrocious results!!! 
> Basically, I generate a packed-refs files with many refs 
> which each point to a different sha1.  To get a list of 
> valid but unique sha1s for the repo, I simply used rev-list.  
> The result, a copy of linus' repo with a million unique 
> valid refs and a git fetch of a single updated ref taking a 
> very long time (55mins and it did not complete yet).  Note, 
> with 100K refs it completes in about 2m40s.  It is likely 
> not linear since 2m40s * 10 would be ~26m (but the 
> difference could also just be how the data in the sha1s are 
> ordered).
> 
> 
> Here is my small reproducible test case for this issue:
> 
> git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> cp -rp linux linux.1Mrefs-revlist
> 
> cd linux
> echo "Hello" > hello ; git add hello ; git ci -a -m 'hello'
> cd ..
> 
> cd linux.1Mrefs-revlist
> git rev-list HEAD | for nn in $(seq 0 100) ; do for c in 
> $(seq 0 10000) ; do  read sha ; echo $sha refs/c/$nn/$c$nn ; 
> done ; done > .git/packed-refs

I believe this generates a packed-refs file that is not sorted
lexicographically by refname, whereas all Git-generated packed-refs
files are sorted.  There are some optimizations in refs.c for adding
references in order that might therefore be circumvented by your
unsorted file.  Please try sorting the file by refname and see if that
helps.  (You can do so by deleting one of the packed references; then
git will sort the remainder while rewriting the file.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
