From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Fri, 15 Apr 2011 10:31:15 +0200
Message-ID: <4DA80253.6010204@alum.mit.edu>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>	<BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>	<4DA710FB.7060808@alum.mit.edu> <BANLkTimeiH_ohJ6yGTU0Ei3t2xvUz0zCUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAeRS-0003QQ-CM
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1DOIbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 04:31:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45440 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab1DOIbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 04:31:41 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3F8VG3N012129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Apr 2011 10:31:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
In-Reply-To: <BANLkTimeiH_ohJ6yGTU0Ei3t2xvUz0zCUA@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171594>

On 04/15/2011 08:24 AM, Piotr Krukowiecki wrote:
> On Thu, Apr 14, 2011 at 5:21 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 04/14/2011 03:38 PM, Piotr Krukowiecki wrote:
>>> On Wed, Apr 13, 2011 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> * mh/git-svn-automkdirs (2011-04-01) 1 commit
>>>>  (merged to 'next' on 2011-04-03 at 7fa4978)
>>>>  + git-svn: add an option to skip the creation of empty directories
>>>>
>>>> Should be safe, but I'd like an Ack from git-svn folks.
>>>
>>> I wanted to test performance of this change - what's the best way to do it?
>>>
>>> I tried some ideas, but rebase was too fast for performance measurements.
>>> I did not have new commits, but just some old, already in trunk changes, which
>>> I tried to rebase - probably it was just fast forward?
>>
>> The unhandled.log.gz file for trunk of our main project is 14 Mb and
>> uncompresses to 233 Mb.  About 90% of it consists of svn:mergeinfo
>> properties for file that were copied or renamed within the repository;
>> most of the rest is other random SVN file properties.
>>
>> With such a huge unhandled.log file, "git svn mkdirs" took about 10s for
>> me.  I believe that "git svn rebase" should take at least as long, even
>> if it is a fast-forward.
> 
> That might be the reason - my unhandled.log is 17MB (unpacked) and mkdirs
> takes 0.5s

Yes, it is also my assumption that parsing so much text in Perl is what
causes the slowdown.  But as long as git-svn insists on plonking so much
information in unhandled.log but then handling it anyway, it seems like
a good policy to prevent it from reading this file any more than
necessary.  And for me, the creation of empty directories is not worth
10s.  (Even your 0.5s is pretty slow by git standards :-) ).

An alternative might be to move the emptydir information from
unhandled.log to a separate file.  The "empty_dir" lines in my unhandled
log are only about 0.1% of the file contents, and should be parseable in
a negligible amount of time.  But moving the data would presumably have
implications for backwards compatibility.

[Are there any design documents for git-svn?  I have had a hard time
deciphering the code and understanding what data it stores and where.]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
