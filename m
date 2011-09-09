From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 09 Sep 2011 18:03:31 +0200
Message-ID: <4E6A38D3.3010900@web.de>
References: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com> <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com> <1315511619144-6773496.post@n2.nabble.com> <4E6A19AD.80100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23YJ-0005zJ-AJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759333Ab1IIQDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:03:34 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36991 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759080Ab1IIQDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:03:33 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 492F61993845F;
	Fri,  9 Sep 2011 18:03:32 +0200 (CEST)
Received: from [79.247.248.31] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R23YC-0001k7-00; Fri, 09 Sep 2011 18:03:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <4E6A19AD.80100@alum.mit.edu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX184KDur3YcD6wkjpRDTkZekQAp2d7mmeTRywZKa
	F/CcQ/mPmTm4q0JGCR7V2lIYm6KPG4+5Ma/VOkzjjlIq//bqx+
	zihGuNAzgFXFl7f4pdMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181088>

Am 09.09.2011 15:50, schrieb Michael Haggerty:
> On 09/08/2011 09:53 PM, Martin Fick wrote:
>> Just thought that I should add some numbers to this thread as it seems that
>> the later versions of git are worse off by several orders of magnitude on
>> this one.  
>>
>> We have a Gerrit repo with just under 100K refs in refs/changes/*.  When I
>> fetch them all with git 1.7.6 it does not seem to complete.  Even after 5
>> days, it is just under half way through the ref #s! [...]
> 
> I recently reported very slow performance when doing a "git
> filter-branch" involving only about 1000 tags, with hints of O(N^3)
> scaling [1].  That could certainly explain enormous runtimes for 100k refs.
> 
> References are cached in git in a single linked list, so it is easy to
> imagine O(N^2) all over the place (which is bad enough for 100k
> references).  I am working on improving the situation by reorganizing
> how the reference cache is stored in memory, but progress is slow.
> 
> I'm not sure whether your problem is related.  For example, it is not
> obvious to me why the commit that you cite (88a21979) would make the
> reference problem so dramatically worse.

88a21979 is the reason, as since then a "git rev-list <sha1> --not --all" is
run for *every* updated ref to find out all new commits fetched for that ref.
And if you have 100K of them ...
