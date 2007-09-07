From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 13:22:53 -0700
Organization: Digital Mars
Message-ID: <fbsbul$dg0$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0709061839510.5?=
	=?ISO-8859-1?Q?626@evo.linux-fo?= =?ISO-8859-1?Q?undation.or=04g>?= <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?f=04br1a2$qm7$1@se?= =?ISO-8859-1?Q?a.gmane.org>?= <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 22:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkM7-00074s-Op
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXIGUXB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXIGUXB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:23:01 -0400
Received: from main.gmane.org ([80.91.229.2]:56386 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbXIGUXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:23:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITkLv-0006Oi-AE
	for git@vger.kernel.org; Fri, 07 Sep 2007 22:22:55 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:22:55 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:22:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85wsv26cv8.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58065>

David Kastrup wrote:
> Again, C won't keep you from shooting yourself in the foot.

Right, it won't. A good systems language should do what it can to 
prevent the programmer from *inadvertently* shooting himself in the 
foot, while allowing him to *deliberately* shoot himself in the foot.

In the example loop, the cases I pointed out were ones where, if one 
changes part of the code (such as the array dimension, or the array 
type, etc.), then there are multiple places in the source that must be 
updated to reflect it. The reality of human programmers is we update one 
or two places, and overlook the third place, and we now have a bug. 
Saying that one should just be a better programmer and not make such 
mistakes is a pipe dream.

Ideally, each facet of the design of the code should have a single point 
where it can be changed, and then all dependencies on that design should 
be automatically updated. That way, nothing gets overlooked. Doing this 
in C, such as using a #define for the array dimension, involves extra work.

It's a truism that if it involves extra work, then it often gets omitted.

Doesn't "A design is perfect not when there is no longer anything you 
can add to it, but if there is no longer anything you can take away." 
apply here? Going from:

  void foo(int array[10])
  {
     for (int i = 0; i < 10; i++)
     {   int value = array[i];
         ... do something ...
     }
  }

to:

  void foo(int[] array)
  {
    foreach (value; array)
    {
      ... do something ...
    }
  }

takes a lot of frankly unnecessary things away, each of which is a 
potential source of error when maintaining the code.


> No, because programmers get things wrong.

Exactly. That goes back to my point that a good language should help 
prevent inadvertent errors, while still allowing deliberate choices. D 
approaches this by making the correct approach essentially be the one 
with minimal typing effort. To deliberately shoot yourself in the foot 
usually requires extra typing. For our loop example, we can still write 
the C style loop (with all its potential problems) in D, but it requires 
extra effort to put in those potential problems. The easier, simpler way 
doesn't have the problems.

(The issue I have with C++'s fixes to various problems is they require 
extra typing (like the loop example), so guess what, people being people 
tend to not use them. This results in endless attempts to try and push 
C++ programmers into using the more verbose forms, a strategy I suspect 
will be ultimately futile.)


> You can tell C compilers to
> check all array accesses, but that is a performance issue.

Runtime checking of arrays in D is a performance issue too, so it is 
selectable via a command line switch. But more importantly,

1) Static type checking of fixed size arrays works, so errors can be 
caught at compile time.

2) For dynamically sized arrays, the dimension of the array is carried 
with the array, so loops automatically loop the correct number of times. 
No runtime check is necessary, and it's easier for the code reviewer to 
visually check the code for correctness.

------
Walter Bright
http://www.digitalmars.com  C, C++, D programming language compilers
http://www.astoriaseminar.com  Extraordinary C++
