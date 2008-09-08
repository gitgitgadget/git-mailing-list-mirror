From: Eric Gerlach <egerlach@feds.uwaterloo.ca>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Mon, 08 Sep 2008 09:24:39 -0400
Message-ID: <48C52797.3030500@feds.uwaterloo.ca>
References: <48C1D2AE.3010001@feds.uwaterloo.ca> <20080906012941.GA2009@coredump.intra.peff.net> <48C3E35C.2050903@feds.uwaterloo.ca> <20080907155033.GA25031@coredump.intra.peff.net> <7vprnfn9pz.fsf@gitster.siamese.dyndns.org> <20080907173434.GA26182@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcgkW-0002H5-T4
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 15:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYIHNYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 09:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYIHNYl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 09:24:41 -0400
Received: from mail.feds.uwaterloo.ca ([129.97.194.182]:3844 "EHLO
	mail.feds.uwaterloo.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYIHNYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 09:24:41 -0400
Received: from [192.168.0.13] (76-10-152-64.dsl.teksavvy.com [76.10.152.64])
	by mail.feds.uwaterloo.ca (Postfix) with ESMTP id 179EB9F42;
	Mon,  8 Sep 2008 09:24:40 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20080907173434.GA26182@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95247>

Jeff King wrote:
> On Sun, Sep 07, 2008 at 10:31:52AM -0700, Junio C Hamano wrote:
> 
>> All depends on how "an empty repository" is defined.  My definition of an
>> empty repository would have been:
>>
>>  - No objects in it;
>>  - No index;
>>  - No refs except symrefs.
> 
> Agreed. In the original message, he used the phrase "no existing
> commits" which I latched onto (to mean "no existing commits on this
> branch"). But the subject does say "empty repository". :)
> 
> Eric, maybe you can tell us more about what you're trying to accomplish?

Sure, I'm writing a patch for the debcommit script for the Debian 
project.  It's a script which parses the Debian changelog for a package, 
generates a commit message, and commits to an SCM system.

The case I'm looking to protect against is the following:

$ mkdir -p new-repo/debian
$ cd new-repo
$ git init
$ vi debian/changelog (add a few lines)
$ git add debian/changelog
$ debcommit

(which runs
$ git diff --cached debian/changelog)

If I can test before the git-diff, then I can run "diff debian/changelog 
/dev/null" instead of the git-diff and all is well.

I don't want to test failure of the git-diff itself, because I want 
debcommit to fail if there's something wrong *other* than a new repo. 
Also, I want to use a git command to do it, because I don't have any 
guarantees about how things are setup, other than "we're using git."

I'm okay with debcommit proceeding if the repo has a commit but is 
borked from manually editing the HEAD ref, but I'm not sure how the 
maintainers of the script feel about that.  So if it's possible to 
differentiate between the two cases, bonus, but not necessary.

So that's where I'm sitting.  Jeff and Junio, thanks for the help and 
discussion.  This is great :-)

(BTW, I'm leaning to the rev-parse right now; looking at the source it 
seems to be more precise, i.e. has fewer ways to fail)

Cheers,

Eric
