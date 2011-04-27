From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 16:52:00 +0200
Message-ID: <4DB82D90.6060200@op5.se>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>	<4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 16:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF66E-0001Ep-3z
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 16:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab1D0OwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 10:52:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64387 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1D0OwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 10:52:11 -0400
Received: by fxm17 with SMTP id 17so1174110fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 07:52:10 -0700 (PDT)
Received: by 10.223.76.129 with SMTP id c1mr1494177fak.107.1303915929824;
        Wed, 27 Apr 2011 07:52:09 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id 23sm271331fay.4.2011.04.27.07.52.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 07:52:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172238>

On 04/27/2011 02:50 PM, Jon Seymour wrote:
> On Wednesday, April 27, 2011, Andreas Ericsson  wrote:
>> On 04/27/2011 05:36 AM, Jon Seymour wrote:
>>> Has anyone ever given consideration to git supporting a plugin
>>> architecture for git extensions?
>>>
>>> The idea would be to provide a consistent way to install, and address
>>> extensions to the core git functionality in a manner that does not
>>> require the extension to actually be integrated into the git core.
>>>
>>
> 
>> Horrible idea. There are already as many package managers as there
>> are packages without us throwing another one into the mix.
>>
> 
> I agree that there are too many package managers. But do you know
> what? There isn't a single package manager that reliably works across
> platform. apt-get? great. Except you need something else for Mac,
> cywgin, or, um Fedora. Brew? Fine then you only need to worry about
> Linux and cygwin. Cygwin? ...
> 
> The platform for my extension is git. Not Mac. Not Debian. Not Fedora.
> Not cygwin. git.
> 
> The lowest common denominator across these environments is, um, git.
> 

You're utterly horribly wrong. It'll work well enough for scripted
languages but when you start mixing in compiler requirements and
whatnot the scheme falls apart. Quickly. Binary packages are popular
for (very good) reasons: They are simple, fast and there's a
reasonable chance they've been tested fairly well with the rest of
the system so nothing breaks horribly once you install it.

Perl, Ruby, Python and PHP all have their own extension installers.
That makes perfect sense since the same code runs unchanged on all
platforms (with some few exceptions).

> I challenge the sceptIcs to specify a one line command script that
> works across all possible environment that is more succinct than:
> 
>     git pm install gitwork
> 

That's not the point. Mac users supposedly already know about brew.
Fedora users already know about yum. Cygwin users... well, I have
no idea what they know about, but whatever it is, it's fairly safe
to assume they already know about it. That means they'll turn to
that familiar tool for managing packages when they want to install
something new. What you're proposing would force users on *all*
systems to have to learn a new one.

> It shouldn't be too hard. A tar command here, an enviroment  variable
> edit there. Perhaps a curl command or a browser download.
> 

And what you get in the end is a f*cking mess of spaghetti shell
code that works worse than the existing package managers.

And you're right. It's not too hard, so long as every extension
manager maintains some short list of requirements in the proper
format, which current package maintainers will have to learn if
they want some modules to be part of the "default" system install,
the way a whole bunch of Perl modules are.

> You have 4 words. Knock yourself out.
> 

make install

Made it in 2. What you described is what the user does to get
new extensions. What I described below is what developers have
to do to make their extensions easy to install *without* a
package manager even if the distro the user is on doesn't ship
that particular extension.

> 
>>> So, perhaps it won't be included in git. That's fine, I can build my
>>> own fork of git which includes the proposed extension [ indeed, this
>>> is how I originally developed it]. That's fine for
>>> me, but it isn't the most practical way to distribute it to others
>>> since I'll have to produce distribution packages for a variety of
>>> different distribution formats or fallback to tars and zips.
>>>
>>
>> What you can do is let your Makefile (or some other install-script)
>> take the destination path for "make install" (or equivalent) from
>> the output of "git --exec-path".
>>
>> That way, you can ship "git extadd" or whatever you want to call it
>> as a simple installer that installs executable and man-page in their
>> proper locations. If the commands you install require configuration
>> by default I'd say they're broken to begin with, but even that can
>> be remedied by running "git config --add key value" from the installer.
>>
>> So in a way, git is already its own pkg-config binary and anyone
>> clever enough to write useful scripts that enhances git will almost
>> certainly see that and use it from their favourite language quite
>> without having to learn some new magic format for package management.
>>
> 
> Those 3 paragraphs were substantially longer than 4 words. Again,
> there is a tar ball, let me know how I can install it across alll
> environments that got runs on. Make sure the man pages work.
> 

So the complete description would be

  git clone git://somerepo/gitworks
  cd gitworks
  make install

and the rest is in developer hands. If you make the extension
manager run *ONLY* those commands, you've made it fairly simple for
extension developers and users both, but then the gain is so
extremely small that it's hardly worth it anymore, although I agree
it would be nifty to keep a list of popular extensions on a wiki
somewhere so users can actually find them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
