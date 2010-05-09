From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 0/2] clone: simplify progress message
Date: Sun, 09 May 2010 13:09:14 -0700
Message-ID: <4BE7166A.5030107@pcharlan.com>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 09 22:09:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBCoU-0002R9-MR
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854Ab0EIUJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:09:17 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:56677 "EHLO
	swarthymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750701Ab0EIUJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 16:09:16 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(Authenticated sender: pete@tento.net)
	by swarthymail-a5.g.dreamhost.com (Postfix) with ESMTPA id AED7E340001;
	Sun,  9 May 2010 13:09:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <20100509110221.GA16639@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146740>

On 05/09/2010 04:02 AM, Jeff King wrote:
> On Sat, May 08, 2010 at 06:23:21PM -0700, Pete Harlan wrote:
> 
>> "git clone foo bar" currently reports "Cloning into
>> /path/to/bar/.git".  Change this message to "Cloning into bar" to more
>> closely match the user's expectation.
> 
> I am a little torn on this. For most users, it is just another
> implementation detail that makes git's output more confusing. And it is
> likely to be the very first git message seen by many people. But at the
> same time, it is telling you where the repository actually is, which is
> something that can help users learn about how git works.
> 
> I guess it comes down to how much detail we want to show.

For me it isn't only a matter of detail; I find "Cloning into
bar/.git" misleading, since bar is getting more than a .git directory.

>> For a --bare clone the current message prints the top level dir
>> (because that is the git dir), so one could argue in favor of the
>> current message because it confirms for the user whether their
>> checkout was bare or not.  But that's only if the user is aware of how
>> it would appear in both cases; I doubt that the existing code intended
>> to make that distinction clear, and in practice I expect most users
>> (a) trust git to do what they asked and (b) wouldn't notice that
>> "Cloning into /path/to/bar" meant that it was a bare checkout.
> 
> I do think there is some value to this distinction. But we can make it a
> lot less ugly for new users with:
> 
>   $ git clone /tmp/foo
>   Cloning into /tmp/foo...
> 
>   $ git clone --bare /tmp/foo
>   Cloning into bare repository /tmp/foo...
> 
> or something like that.

Thank you for looking at this.  I agree with you, and have added a
second patch that implements that.

These two changes modify a progress message introduced a few weeks ago
in 28ba96ab2.  Unless there's a particular reason to report the .git
dir instead of the top level dir, seeing the top level dir feels more
natural to me.

For a --bare clone the current message prints the top level dir
(because that is the git dir), so one could argue in favor of the
current message because it confirms for the user whether their
checkout was bare or not.  The second patch modifies the message per
Jeff King's suggestion, to say "Cloning to bare repository bar..." to
convey that information more directly.

Pete Harlan (2):
  clone: have progress report mention top level dir, not git dir
  clone: add bare clone to the progress message

 builtin/clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
