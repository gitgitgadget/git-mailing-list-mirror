From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Possible timestamp problems with diff-files?
Date: Sat, 24 Sep 2011 16:30:56 +0200
Message-ID: <4E7DE9A0.8070209@dewire.com>
References: <4E786B5D.40601@syntevo.com> <20110920175458.GA3776@sigill.intra.peff.net> <4E79DF81.8090605@syntevo.com> <7vboud1sz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:52:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Tau-0001nW-Vz
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab1IXOwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 10:52:39 -0400
Received: from mail.dewire.com ([83.140.172.130]:15337 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab1IXOwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 10:52:39 -0400
X-Greylist: delayed 1299 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Sep 2011 10:52:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 86AE38006A7;
	Sat, 24 Sep 2011 16:30:57 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2yKSSA9piNa4; Sat, 24 Sep 2011 16:30:57 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D6E56800391;
	Sat, 24 Sep 2011 16:30:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0) Gecko/20110905 Thunderbird/7.0
In-Reply-To: <7vboud1sz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182028>

Junio C Hamano skrev 2011-09-21 23.33:
> Marc Strapetz<marc.strapetz@syntevo.com>  writes:
>
>> On 20.09.2011 19:54, Jeff King wrote:
>>> On Tue, Sep 20, 2011 at 12:30:53PM +0200, Marc Strapetz wrote:
>>>
>>>> For our Git client, we are invoking
>>>>
>>>> git diff-files--quiet --ignore-submodules
>>>>
>>>> immediately after a commit of *all* changes. Hence, the expected exit
>>>> code would be 0 (because there are no changes). A user has now reported
>>>> that for commits with many changes, exit code is sometimes 1. For the
>>>> last incident, the commit was started at 15:24:11,820 and finished at
>>>> 15:24:12,329, diff-files was invoked at 15:24:12,455 and failed with
>>>> exit code 1 at 15:24:21,394. A subsequent diff-files succeeded, so I'm
>>>> wondering now, if that could be a timestamp problem (maybe related to
>>>> the Index)?
>
> What peff said already.
>
> If you do not refresh the cached stat information, diff-files may report
> "they differ" for a path that is otherwise unchanged without looking at
> the contents of such a path to notice that the only difference is the
> cached stat information (the whole and only point of having the cached
> stat information is to avoid looking at the contents). Also, it may look
> at the contents of such a path if it has a reason to suspect that the file
> might have changed if it cannot tell from the cached stat information
> (look for "racy-git" if you are really interested).
>
> Update the cached stat information before you use plumbing commands in
> your script.

Using git diff instead of git diff-files would do just that, unless I am
missing something.

-- robin
