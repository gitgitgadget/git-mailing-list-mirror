From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 13:52:01 +0200
Message-ID: <FEA805F3-A6BA-4C76-B2C7-E28C00FDD801@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITcNl-0004lT-GQ
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbXIGLwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 07:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbXIGLwM
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:52:12 -0400
Received: from wincent.com ([72.3.236.74]:48508 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965208AbXIGLwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 07:52:11 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l87Bq9cj031535;
	Fri, 7 Sep 2007 06:52:10 -0500
In-Reply-To: <fbr2iv$ugg$1@sea.gmane.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58030>

El 7/9/2007, a las 10:36, Walter Bright escribi=F3:

> Wincent Colaiuta wrote:
>> Git is all about speed, and C is the best choice for speed, =20
>> especially in context of Git's workload.
>
> I can appreciate that. I originally got into writing compilers =20
> because my game (Empire) ran too slowly and I thought the existing =20
> compilers could be dramatically improved.
>
> And technically, yes, you can write code in C that is >=3D the speed =
=20
> of any other language (other than asm). But practically, this isn't =20
> necessarily so, for the following reasons:
>
> 1) You wind up having to implement the complex, dirty details of =20
> things yourself. The consequences of this are:
>
>    a) you pick a simpler algorithm (which is likely less efficient =20
> - I run across bubble sorts all the time in code)
>
>    b) once you implement, tune, and squeeze all the bugs out of =20
> those complex, dirty details, you're reluctant to change it. You're =20
> reluctant to try a different algorithm to see if it's faster. I've =20
> seen this effect a lot in my own code. (I translated a large body =20
> of my own C++ code that I'd spent months tuning to D, and quickly =20
> managed to get significantly more speed out of it, because it was =20
> much simpler to try out different algorithms/data structures.)

While I accept that this is generally true, I think Git is somewhat =20
of a special case. From a design perspective the data structures and =20
algorithms are remarkably simple -- therein lies its elegance. I =20
think it's precisely the kind of problem that can be tackled well =20
with a close-to-the-metal language like C.

> 2) Garbage collection has an interesting and counterintuitive =20
> consequence. If you compare n malloc/free's with n gcnew/=20
> collections, the malloc/free will come out faster, and you conclude =20
> that gc is slow. But that misses one huge speed advantage of gc - =20
> you can do FAR fewer allocations! For example, I've done a lot of =20
> string manipulating programs in C. The basic problem is keeping =20
> track of who owns each string. This is done by, when in doubt, make =20
> a copy of the string.
>
> But if you have gc, you don't worry about who owns the string. You =20
> just make another pointer to it. D takes this a step further with =20
> the concept of array slicing, where one creates windows on existing =20
> arrays, or windows on windows on windows, and no allocations are =20
> ever done. It's just pointer fiddling.

This mirrors my experience in desktop application development. =20
Despite GC being "slower" the app actually runs faster and a lot of =20
nasty problems (shared resources, locking etc) just magically go =20
away. Development is easier too.

But once again I think Git falls into a special category where the =20
design makes the "hassle" of developing in C worth it.

Wincent
