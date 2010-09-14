From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Coping with the pull-before-you-push model
Date: Tue, 14 Sep 2010 08:12:13 -0400
Message-ID: <D4360EBB-7891-457E-A6AC-7159CADCAC6C@mit.edu>
References: <4C8866F9.1040705@workspacewhiz.com> <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com> <4C88F2A9.2080306@workspacewhiz.com> <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com> <20100910141527.GA6936@sigill.intra.peff.net> <4C8EFE62.7080908@workspacewhiz.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Jon Seymour <jon.seymour@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 14:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvURv-00006T-Tt
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 14:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab0INMRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 08:17:17 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:42447 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752060Ab0INMRQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 08:17:16 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2010 08:17:16 EDT
X-AuditID: 12074424-b7b2bae000005b3f-e4-4c8f66857ff8
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id E3.A2.23359.5866F8C4; Tue, 14 Sep 2010 08:11:49 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o8ECCDK4002414;
	Tue, 14 Sep 2010 08:12:13 -0400
Received: from [10.0.42.108] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o8ECCBYI016999
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 14 Sep 2010 08:12:12 -0400 (EDT)
In-Reply-To: <4C8EFE62.7080908@workspacewhiz.com>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAARX2XKo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156168>


On Sep 14, 2010, at 12:47 AM, Joshua Jensen wrote:

>>> management, this looks like a step-backwards.
>> Bear in mind that you can still shift to a maintainer model, but keep
>> the maintainer automated. That is, you can queue up "to-pull" heads, and
>> then have an automated process pull them one by one and do some basic QA
>> (does it merge, does it build, does it pass automated tests, etc). Which
>> is not that different from what many shops do in the non-maintainer
>> model, except that when you break the build, the maintainer process
>> notices _before_ publishing the merged tip, so everybody won't try to
>> build on your broken crap.
>> 
> Do you know of any existing software that does this?  This may be ideal in the short term.

Our workflow at $WORK involves pushing changes to gerrit to various "effort branches", and then once they are approved, we have a "Mergitator" script that will attempt to merge the effort branch with the merged master branch, and then attempt to do a build.  If the build succeeds, then the changes will get pushed back to the publically visible merged master branch, and then the Mergitator will move on to the next effort branch that requires merging.   If there is a merge conflict, the Mergitator will refuse the merge, and then give instructions on how to fix up the tree to avoid merge conflicts.

The Mergitator code hasn't been released, and I suspect the main reason is that there's relatively little code that could be used outside of our environment, and a large amount of code which contains lots of details about our internal build system that would have to be stripped out and generalized before it could be released --- and no one has time to do it.

So this probably doesn't help you since I suspect you meant to ask the question, "do you know of any existing publically available software", but I can tell you that it certainly can be done, and that software exists.  Making it be software which is useful and usable to you would definitely take more work...

-- Ted
