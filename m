From: Rick Moynihan <rick@calicojack.co.uk>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 15:57:27 +0100
Message-ID: <48F75657.6010308@calicojack.co.uk>
References: <48F730D0.9040008@calicojack.co.uk> <8663nsfxoq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 16:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUJh-0004S7-PS
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbYJPO5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbYJPO5r
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 10:57:47 -0400
Received: from storm.bpweb.net ([83.223.106.8]:49548 "EHLO storm.bpweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbYJPO5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 10:57:47 -0400
Received: from lechuck.local (host-77-100-223-163.static.telewest.net [77.100.223.163])
	(authenticated bits=0)
	by storm.bpweb.net (8.13.1/8.13.1) with ESMTP id m9GEvW40007304;
	Thu, 16 Oct 2008 15:57:37 +0100
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <8663nsfxoq.fsf@lola.quinscape.zz>
X-BpTo: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98387>

David Kastrup wrote:
> Rick Moynihan <rick@calicojack.co.uk> writes:
> 
>> Hi,
>>
>> I have a master branch, a dev branch and a number of feature branches
>> from dev.  And I was wondering if there was an easy way to rebase dev
>> and all of it's sub-branches onto master.
>>
>> I know I can run this as a series of commands, and use --onto to do
>> this, but was wondering if there was an easier way.  As running:
>>
>> git rebase master
>>
>> when on the dev branch only rebases dev and not it's dependent branches.
> 
> Rebasing has no relation to dependent branches.  It creates a new branch
> from the branch point.  After it finishes, it just reseats HEAD of the
> branch to the new one.  There is no operation that would work implicitly
> on originally dependent branches.

This appears to be true of the current implementation, but shouldn't it 
be possible to do this as a single operation?

e.g. when the situation is this with dev being the current branch.

o---o---o---o---o  master
      \
       o---o---o---o---o  dev (*)
                        \
                         o---o---o  topic

Running the hypothetical command:

git rebase master --all

Would produce this:

o---o---o---o---o  master
                  \
                   o---o---o---o---o  dev (*)
                                    \
                                     o---o---o  topic

I think this can be performed right now with a rebase followed by a 
rebase --onto

I can see how if there were conflicts in the rebase from dev, then you 
would need to resolve them all the way up your topic branches also.  Is 
there anything else that makes this a bad idea?

R.
