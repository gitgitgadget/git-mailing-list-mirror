From: "Eivind LM" <eivliste@online.no>
Subject: Re: Split a subversion repo into several git repos
Date: Fri, 12 Oct 2007 16:14:01 +0200
Message-ID: <op.tz28hnd2jwclfx@ichi>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com> <470E9858.5050904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>,
	"Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLHr-0003lZ-9x
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbXJLOOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbXJLOOh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:14:37 -0400
Received: from mail-forward.uio.no ([129.240.10.42]:52642 "EHLO
	mail-forward.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbXJLOOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:14:36 -0400
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLHR-0000a9-7s; Fri, 12 Oct 2007 16:14:21 +0200
Received: from cma-eivindlm.uio.no ([129.240.223.140] helo=ichi)
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLHQ-0006Rr-Mn; Fri, 12 Oct 2007 16:14:21 +0200
In-Reply-To: <470E9858.5050904@vilain.net>
User-Agent: Opera Mail/9.23 (Linux)
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 04247CC3364452EA48DC4A30F902BAF7B2682456
X-UiO-SPAM-Test: remote_host: 129.240.223.140 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 1 total 15 max/h 2 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60691>

On Thu, 11 Oct 2007 23:40:40 +0200, Sam Vilain <sam@vilain.net> wrote:

> Jonathan del Strother wrote:
>>> For example, I want to convert one subversion repository which
>>> contains the folders:
>>> trunk/projectA
>>> trunk/projectB
>>>
>>> into two git repositories:
>>> projectA.git
>>> projectB.git
>>
>> I have a slightly different layout to you -
>>
>> projectA/trunk
>> projectA/branches
>> projectA/tags
>> projectB/trunk
>> projectB/branches
>> projectB/tags
>> etc
>>
>> - but I've been creating separate git repos from that with (for
>> example) :
>>
>> git-svn init -t tags -b branches -T trunk http://svn.host.com/projectA
>> git-svn fetch
>>
>>
>> Or will git-svn not work with your sort of layout?
>
> It does work.  Use:
>
> git-svn init -t projectA/tags -b projectA/branches \
>    -T trunk/projectA http://svn.host.com/
> git fetch

With my paths this translates into

   $ git-svn init -b eivindlm/branches \
                  -t eivindlm/tags \
                  -T eivindlm/trunk/src/probesimulator \
                  file:///svn-repo/
, which prints the happy message:
   Initialized empty Git repository in .git/

The next command is unfortunately not as happy:
   $ git fetch
   fatal: 'origin': unable to chdir or not a git archive
   fatal: The remote end hung up unexpectedly
   Cannot get the repository state from origin

I suppose this is due to my silly svn-repo layout... However, after some  
trial and error it seems like the following command gives me what I want  
(I don't need tags or other branches than main):

   $ git-svn clone file:///svn-repo/ --follow-parent \
                   -T eivindlm/trunk/src/probesimulator

It seems to realize that the probesimulator directory has moved around in  
my tree, and gives me history for files that belongs in this directory  
only (and not history for other directories). So the problem appears to be  
solved for my part, unless you see a reason for why I should not do it in  
this way.

> [...]

Thanks a lot for the help to everyone who replied!

Eivind
