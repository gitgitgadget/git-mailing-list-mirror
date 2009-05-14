From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: [PATCH v2 3/7] Fix tests to work with core.autocrlf=true --	new
 functions
Date: Thu, 14 May 2009 10:39:41 -0400
Message-ID: <4A0C2D2D.9080707@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com> <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com> <20090514074303.GA8713@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu May 14 16:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4c7a-0007p4-CA
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbZENOkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbZENOkL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:40:11 -0400
Received: from mail200.messagelabs.com ([216.82.254.195]:49530 "HELO
	mail200.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754791AbZENOkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 10:40:08 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-4.tower-200.messagelabs.com!1242311991!28887774!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 23253 invoked from network); 14 May 2009 14:40:02 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-4.tower-200.messagelabs.com with SMTP; 14 May 2009 14:40:02 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 07:39:45 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 10:39:44 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090514074303.GA8713@hashpling.org>
X-OriginalArrivalTime: 14 May 2009 14:39:44.0423 (UTC) FILETIME=[D28FC370:01C9D4A1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119195>

On 5/14/2009 3:43 AM, Charles Bailey wrote,

> On Wed, May 13, 2009 at 03:35:44PM -0400, Don Slutz wrote:
>   
>> Have I missed some previous recent discussion about this patch series?
>> I know that you referenced that long Aug 2007 thread about autocrlf,
>> but is there some more recent discussion about how the test suite
>> works / should work?
>>
>>     
Not that I have seen.  I did forget to send the previous reply, should 
now be there.
>> mergetool isn't the prime implementor of autocrlf, but it does have
>> some checks to make sure that it works with autocrlf. My impression -
>> probably incorrect - has been that autocrlf is off for the purposes of
>> building and testing git on all platforms, but that some packages
>> switch it on by default on install for user convenience on platforms
>> where this is appropriate.
>>
>> Your patch seems to be about allowing the entire test suite to run
>> correctly with the autocrlf in any setting. If this is the case,
>> shouldn't the correct fix be to remove tests that are testing that
>> things work with different settings of autocrlf, because these tests
>> are effectively run by a full test suite run with autocrlf
>> alternatively set anyway?
>>
>>     
Well my take is that most of the tests do not care about autocrlf, they 
are checking that the right file or error is happening.  For example:


   git commit -m "c1"
  echo foo >file2
  git checkout -- file2

just wants to know that file2 is correctly reverted to before the 
change.  The fact that file2 can have LF -> CRLF if autocrlf=true is not 
what is being checked for here.  There are several tests like 
t0020-crlf.sh that are checking that the right thing happens.

I am assuming that t7610-mergetool.sh add the test for autocrlf=true 
because of some issue (bug?) that was fixed.  However I have not done a 
full look into way the test is there.  I was focused on getting the 
tests to pass.

Also I do expect that most people will run the tests in the default mode 
only.  I have no plans on add the "run the tests in all possible 
settings of autocrlf".

This set seems like a subset (but still big) change on the path of 
getting git to work and pass the tests under CYGWIN on a text mount.  
That change is still in progress and not yet ready for the list.

   -Don


__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
