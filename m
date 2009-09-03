From: James Spencer <jss43@cam.ac.uk>
Subject: Re: diff-files inconsistency with touched files
Date: Thu, 03 Sep 2009 17:18:54 +0100
Message-ID: <4A9FEC6E.9030904@cam.ac.uk>
References: <4A9EAAF3.3000002@cam.ac.uk> <20090902192820.GE6900@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjFQf-0003yx-5M
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 18:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZICQoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 12:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbZICQoq
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 12:44:46 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:51614 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbZICQoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 12:44:46 -0400
X-Greylist: delayed 1554 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2009 12:44:46 EDT
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from tycpc18.cmth.ph.ic.ac.uk ([155.198.39.201]:32897)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
	with esmtpsa (PLAIN:jss43) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1MjF1S-0004Mr-NF (Exim 4.70)
	(return-path <jss43@cam.ac.uk>); Thu, 03 Sep 2009 17:18:54 +0100
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <20090902192820.GE6900@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127661>

Jeff King wrote:
> On Wed, Sep 02, 2009 at 06:27:15PM +0100, James Spencer wrote:
> 
>> $ git diff-files
>> $ touch test
>> $ git diff-files
>> :100644 100644 9daeafb9864cf43055ae93beb0afd6c7d144bfa4
>> 0000000000000000000000000000000000000000 M  test
>> $ git diff
>> $ git diff-files
>> $
>>
>> I don't understand why git diff-files reports a file is changed when
>> that file is touched nor why running git diff changes this to (what I
>> think is) the correct behaviour.
> 
> Git uses the stat information of a file to know whether what we have
> cached in the index is up-to-date or not. So in the first diff-files, we
> don't even have to look at the contents of "test"; we see that it hasn't
> changed since the last time we looked at the contents, and that its
> sha-1 matches what's in the index, so there is no diff.
> 
> By running "touch", you have changed the stat information, so we believe
> there may be a difference. But we don't actually know what's _in_ the
> new side, so we just print the null sha1 instead of the actual sha1
> contents.
> 
> Diff-files _could_ refresh the cache each time it runs, but we
> intentionally do not do that. Doing so is a little bit expensive, and
> because diff-files is intended as a low-level tool for scripts, we give
> the script the flexibility (and responsibility) of refreshing the cache
> when it wants to. So you could do:
> 
>   $ git update-index --refresh
>   $ git diff-files
> 
> and get clean output.
> 
> You see different behavior from "git diff" because it is meant for user
> consumption and therefore refreshes the cache automatically at the
> beginning of every run.
> 
> -Peff

Thanks for your help!

    --James
