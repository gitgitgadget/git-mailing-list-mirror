From: Roman Shaposhnik <rvs@sun.com>
Subject: Intricacies of submodules [was: Migrating svn to git with heavy	use of
 externals]
Date: Wed, 09 Apr 2008 20:43:34 -0700
Message-ID: <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; delsp=yes; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Avery Pennarun <apenwarr@gmail.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 05:44:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjni3-0001K5-DG
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 05:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYDJDnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 23:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbYDJDnj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 23:43:39 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:37292 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbYDJDni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 23:43:38 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3A3hbZU002116
	for <git@vger.kernel.org>; Wed, 9 Apr 2008 20:43:38 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ300F01BO5FS00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Wed, 09 Apr 2008 20:43:37 -0700 (PDT)
Received: from [192.168.0.100] ([129.150.17.164])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZ300DC2BOP5D40@fe-sfbay-09.sun.com>; Wed,
 09 Apr 2008 20:43:37 -0700 (PDT)
In-reply-to: <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79164>

Hi Junio!

On Apr 8, 2008, at 11:43 PM, Junio C Hamano wrote:

> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>> On Wed, Apr 9, 2008 at 12:39 AM, Roman Shaposhnik <rvs@sun.com>  
>> wrote:
>>> Agreed. But I guess I'd be less confused if "git submodule" didn't  
>>> muck
>>> with .git/config at all. Or are there any other consumers of the
>>> information
>>> that it puts there (except itself)?
>>
>> That I don't know.  If there aren't any others, then I agree, I'm not
>> sure what the whole .git/config messing is about.
>
> Its actually the other way around.

Got it. But if you don't mind, I still would like to ask you a few  
questions
to clarify some things.

> In-tree .gitmodules is used to give hints to prime what is placed in
> .git/config, which after initialized should serve as the authoritative
> information on managed submodules as far as your repository is  
> concerned.
> "git submodule init" may be a handy way to do this "priming", but  
> you do
> not necessarily have to use it but instead manually adjust .git/config
> yourself; this is so that you can configure remote url that is  
> different
> from what .gitmodules suggests to suite your local needs.

Ok. Now I understand that .git/config is supposed to be the  
authoritative
source of information on submodules. Yet we also have .gitmodules
to take care of. This leads to information duplication and makes me
believe that .git/config should be as much as sync with .gitmodules as
possible. Yet, even with the latest version of Git we don't have
"git submodule add" updating .git/config. So here comes the first  
question:
     * Do you consider this behavior to be a bug or do you a have a  
reasonable
         explanation for it?
Continuing in the same line of though as far as information  
duplication goes,
here's my second question:
     * Whenever .gitmodules and .git/config disagree on the URL for a  
particular
        submodule do you expect .git/config to always take precedence?
And finally, since from your explanation it appears that the only  
reason for
.gitmodules existence is to "prime" the .git/config it seems that what  
we're
trying to achieve is a way for Git settings that are usually part  
of .git/config
to be resident within the repository itself. That would give these  
setting
a benefit of percolating through clone/fetch/push operations, yet be
overridden by individual .git/config settings. And so I have my final  
question:
      * Has an idea of having a regular file (subject to having  
history, etc.)
        called something like .gitconfig at the top level of Git's  
repository ever
        been considered (implemented?). That way you a repository  
maintainer
        would be able to force a particular set of settings on all of  
its clones
        yet clones will be able to override then in .git/config if  
needed.

> Although putting everything in a single repository could work, that  
> does
> not have to be the only way to work with submodules.  In fact, the  
> basic
> submodule design is trying very hard not to force you to grab  
> objects that
> are needed for all submodules when you are cloning the superproject,  
> as
> not cloning nor checking out any submodule is the default.


Indeed. This is a very beneficial setup for large projects. In fact,  
what I'm working
on right now is a prototype of a build infrastructure that would be  
smart enough
to import "cached" binaries of the build of a particular submodule if  
the submodule
itself hasn't been checked out yet. SHA1 lets me do the versioning  
properly and
once developers do checkout sources of any submodule the build system
will stop importing "cached" binaries and start build it for real. All  
without developers
actually doing anything special.

Thanks,
Roman.
