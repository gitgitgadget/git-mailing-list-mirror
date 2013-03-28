From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] fast-import: Fix an gcc -Wuninitialized warning
Date: Thu, 28 Mar 2013 18:20:29 +0000
Message-ID: <515489ED.7070109@ramsay1.demon.co.uk>
References: <5151F278.2040109@ramsay1.demon.co.uk> <20130326192822.GA28244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHvk-0001oE-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab3C1Svk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:51:40 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:53230 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944Ab3C1Svj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:51:39 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id A1BC96F8141;
	Thu, 28 Mar 2013 18:51:37 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id D48F36F82C1;
	Thu, 28 Mar 2013 18:51:36 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 28 Mar 2013 18:51:35 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130326192822.GA28244@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219443>

Jeff King wrote:
> On Tue, Mar 26, 2013 at 07:09:44PM +0000, Ramsay Jones wrote:
> 
>> Commit cbfd5e1c ("drop some obsolete "x = x" compiler warning hacks",
>> 21-03-2013) removed a gcc hack that suppressed an "might be used
>> uninitialized" warning issued by older versions of gcc.
>>
>> However, commit 3aa99df8 ('fast-import: clarify "inline" logic in
>> file_change_m', 21-03-2013) addresses an (almost) identical issue
>> (with very similar code), but includes additional code in it's
>> resolution. The solution used by this commit, unlike that used by
>> commit cbfd5e1c, also suppresses the -Wuninitialized warning on
>> older versions of gcc.
>>
>> In order to suppress the warning (against the 'oe' symbol) in the
>> note_change_n() function, we adopt the same solution used by commit
>> 3aa99df8.
> 
> Yeah, they are essentially the same piece of code, so I don't mind this
> change.  It is odd to me that gcc gets it right in one case but not the
> other, but I think we are deep into the vagaries of the compiler's code
> flow analysis here, and we cannot make too many assumptions.
> 
> Were you actually triggering this warning, and if so, on what version of
> gcc? 

yes, with:
    gcc v3.4.4 (cygwin)
    gcc v4.1.2 (Linux)
    msvc v15.00.30729.01 (VC/C++ 2008 express edition)
no, with:
    gcc v4.4.0 (msysgit)
    clang 3.2 (Linux)
    tcc v0.9.26 (Linux)
[lcc can't compile git; I forget why exactly.]

>       Or did the asymmetry just offend your sensibilities?

My sensibilities were, indeed, very offended! ;-)

ATB,
Ramsay Jones
