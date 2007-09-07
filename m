From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 12:03:24 -0700
Organization: Digital Mars
Message-ID: <fbs79k$tac$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 21:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITj7I-0003Lt-2h
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbXIGTDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXIGTDg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:03:36 -0400
Received: from main.gmane.org ([80.91.229.2]:53310 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXIGTDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:03:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITj74-0004pv-Er
	for git@vger.kernel.org; Fri, 07 Sep 2007 21:03:30 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:03:30 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:03:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070907094120.GA27754@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58056>

Pierre Habouzit wrote:
>   Well, to me D has two significant drawbacks to be "ready to use". The
> first one is that it doesn't has bit-fields. I often deal with bit-fields
> on structures that have a _lot_ of instances in my program, and the
> bit-field is chosen for code readability _and_ structure size efficiency.
> I know you pretend that using masks manually often generates better
> code. But in my case, speed does not matter _that_ much. I mean it does,
> but not that this micro-level as access to the bit-field is not my
> inner-loop.

I'm surprised this is such an important issue. Others have mentioned it, 
but regard it as a minor thing. Interestingly, the htod program (which 
converts C .h files to D import files) will convert bit fields to inline 
functions, giving equivalent functionality.

>   The other second issue I have, is that there is no way to do:
>   import (C) "foo.h"
> 
>   And this is a big no-go (maybe not for git, but as a general issue)
> because it impedes the use of external libraries with a C interface a
> _lot_. E.g. I'd really like to use it to use some GNU libc extensions,
> but I can't because it has too many dependencies (some async getaddrinfo
> interface, that need me to import all the signal events and so on
> extensions in the libc, with bitfields, wich send us back to the first
> point).

D does come with htod, which converts C .h files to D files. It's not 
possible to do a perfect job (because of macros), but it comes pretty 
darned close. The reason htod gets so close is because it is actually a 
real C compiler front end, not a perl or regex string processing hack.

Because it (may) require a little hand tweaking of the results (again, 
because C headers may include awful things like:
	#define BEGIN {
	#define print printf(
), it's a separate program rather than built-in.


>   I also have a third, but non critical issue, I absolutely don't like
> phobos :)

You're not the only one <g>. But I'll add that access to the standard C 
runtime library *is* a part of D, so at some level it can't be worse 
than C. There's also another runtime library available, Tango, which is 
very popular.

> Though I'm obviously free to chose another library. D has
> definitely many many many real advances over C (like the .init, .size,
> ... and so on fields, known types, and whatever portability nightmare
> the C impose us). In fact I like to use D like I code in C, using
> modules and functions, and very few classes, as few as I can. And even
> (under- ?) using D like this, it is a real pleasure to work with. I'm
> really eager to see gdc be more stable.

There are a lot of people hard at work on D to make it more stable and 
increase the breadth and depth of tools available. I am fully aware that 
there may be non-technical issues to using D in a project like git, like 
availability of other D programmers, tradition, etc., but in this thread 
I'm concerned mainly with technical issues.

P.S. I'm also NOT suggesting that git be converted to D. Translating a 
working, debugged, 80,000 line codebase from one language to another is 
usually a fool's errand.

Thanks for taking the time to post your thoughts.

-----------
Walter Bright
http://www.digitalmars.com  C, C++, D programming language compilers
http://www.astoriaseminar.com  Extraordinary C++
