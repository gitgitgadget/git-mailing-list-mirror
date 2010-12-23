From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Thu, 23 Dec 2010 16:35:57 -0700
Message-ID: <4D13DCDD.3050300@workspacewhiz.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com> <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 00:40:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVulM-0005nQ-LB
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 00:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0LWXf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 18:35:58 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:60364 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0LWXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 18:35:58 -0500
Received: (qmail 26393 invoked by uid 399); 23 Dec 2010 16:35:57 -0700
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 23 Dec 2010 16:35:57 -0700
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164140>

----- Original Message -----
From: Junio C Hamano
Date: 12/23/2010 10:17 AM
> Nguyen Thai Ngoc Duy<pclouds@gmail.com>  writes:
>
>> On Wed, Dec 22, 2010 at 8:59 AM, Junio C Hamano<gitster@pobox.com>  wrote:
>> With jj/icase-directory merged to master, match_pathspec() and
>> match_pathspec_depth() now diverse again.
>>
>> When I wrote match_pathspec_depth(), I assumed that match_pathspec()
>> would not change much and I would have more time for converting the
>> rest of git to use match_*_depth(). Looks like I need to add case
>> insensitive matching to struct pathspec and friends then remove
>> match_pathspec() in this series too. At least if somebody changes
>> match_pathspec() again, it would cause a conflict so I can catch it.
> While this topic is something I have long wanted to see, I have started
> feeling that this needs to cook a bit longer than be in the next release.
> So perhaps the best course of action might be to rebase the series once
> after the 1.7.4 feature freeze, cook it in 'next' for a while and make it
> part of the release after that.  I think at that point we may probably
> want to have other changes that are not strictly backward compatible but
> their incompatibilities do not matter in practice (e.g. cquoting pathspecs
> in the attributes file comes to mind, but I am sure there will be other
> changes that people wanted to have but we held them off due to worries on
> compatibility).
>
> What do you think?
Certainly, you know what's best overall for Git.

Having said that, I have had 100 people using the jj/icase-directory 
series on Windows daily for 4 months now without issue.  Prior to that, 
a majority of the series had been used for a full year by a dozen 
people.  In any case, the improvement on non-case sensitive file systems 
is the difference between night and day, and the series has helped 
prevent a number of messes that occurred without it (git add readme.txt 
and git add Readme.txt, for example... ugh...).

More than Windows, this series also affects Mac OS X in a positive 
manner, though the case sensitivity problems can be considered worse.  
When you change directories at the command line, the command line 
retains the case you used to change directory, and then Git uses that 
case as the relative path into the repository.  Ugh... this is different 
than on Windows where the file system's directory case is retained at 
the Command Prompt as you change directories.  (Cygwin actually appears 
to have the problem, too, but MinGW, what msysGit is built upon, does not.)

The Mac OS X issue listed above is not a reason not to publish the 
series, though, as the fixes necessary to make that work are in 
completely different areas in Git than the current jj/icase-directory 
series.

Finally, I'm sitting on a bunch of other case sensitivity refinements, 
but I'd like to get one series published before evolving this more.  I'd 
like to get the other ones out there for discussion, but they build on 
the current series.

In reference to above, where is match_pathspec_depth()?  I can only find 
match_pathspec().

Josh
