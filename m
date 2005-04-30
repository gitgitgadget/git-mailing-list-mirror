From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: The criss-cross merge case
Date: Sat, 30 Apr 2005 05:32:11 -0700
Message-ID: <200504301232.j3UCWBO05174@adam.yggdrasil.com>
Cc: barkalow@iabervon.org, bram@bitconjurer.org,
	droundry@abridgegame.org, git@vger.kernel.org,
	ry102@rz.uni-karlsruhe.de, tupshin@tupshin.com
X-From: git-owner@vger.kernel.org Sat Apr 30 15:37:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRs9N-0000vU-TI
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 15:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVD3Nmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVD3Nmi
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 09:42:38 -0400
Received: from [61.149.23.245] ([61.149.23.245]:57329 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261218AbVD3Nmf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 09:42:35 -0400
Received: (from adam@localhost)
	by adam.yggdrasil.com (8.11.7/8.11.7) id j3UCWBO05174;
	Sat, 30 Apr 2005 05:32:11 -0700
To: wsc9tt@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005 07:19:18 -0500, Wayne Scott wrote:
>On 4/28/05, Adam J. Richter <adam@yggdrasil.com> wrote:
>> On 2005-04-28, Benedikt Schmidt wrote:
>> >AFAIK the paper mentioned in the GNU diff sources [1] is an improvement
>> >to an earlier paper by the same author titled
>> >"A File Comparison Program" - Miller, Myers - 1985.
>> [...]
>> >[1] http://citeseer.ist.psu.edu/myers86ond.html
>> 
>>         Monotone apparently uses a futher acceleration of that algorithm
>> from the 1989 paper, also co-authored by the Myers, "An O(NP) Sequence
>> Comparison Algorithm" by Sun Wu, Udi Manber, and Gene Myers.
>> http://www.eecs.berkeley.edu/~gene/Papers/np_diff.pdf .  The Monotone
>> implementation was apparently a port of an implementation originally
>> written in Scheme by Aubrey Jaffer.
>> 
>>         I don't fully understand the 1989 paper, but I get the
>> general impression that is a small change to the previous algorithm
>> (the one in GNU diff) that might be a 30 line patch if someone
>> got around to submitting it, and seems to make the code run more
>> than twice as fast in practice.  One of these days, I will probably get
>> around to coding up a patch to GNU diff if nobody beats me to it.
>> 
>>         Making diff run faster may have at least one potentially useful
>> benefit for merging.  A faster diff makes it more practical run diff
>> on smaller units of comparison.  I posted a note here before about
>> converting the input files to diff3 to have just one character per
>> line, and then undoing that transformation of the result to produce
>> a character based merge that seemed to work pretty well in the
>> couple of tests that I tried.

>I just read that paper and unless I am mistaken, it already describes
>the basis for how GNU diff works.  I don't think anything in that
>paper would make it faster.
>
>I also don't find anything to suggest the Monotone guys have rewritten
>diff.  Just some notes from graydon that notes python's difflib uses a
>non-optimal diff that is faster in some cases.

	In terminology that can only be understood by reading
the 1985 paper, the 1989 paper describes a possible reduction
in the number of diagonals in the edit graph that iterations of the
1989 algorithm have to consider.  I say "possible reduction" because
the reduction can be zero in the worse case, although I get the
impression that it should be a reduction of 50% or better
typically, and it makes the case where the changes is just
a bunch of inserts run in linear time.

	I believe that the longest common subsequence finder
at the core of GNU diff does not currently perform this optimization,
but the one in monotone-0.18/lcs.{cc,hh} does.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
