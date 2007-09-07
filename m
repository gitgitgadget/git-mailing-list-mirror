From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 11:31:07 +0200
Organization: Organization?!?
Message-ID: <85wsv26cv8.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0709061839510.5?=
	=?ISO-8859-1?Q?626@evo.linux-fo?= =?ISO-8859-1?Q?undation.or=04g>?= <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?f=04br1a2$qm7$1@se?= =?ISO-8859-1?Q?a.gmane.org>?= <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 11:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITaBj-000320-Q6
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbXIGJbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 05:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbXIGJbf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:31:35 -0400
Received: from main.gmane.org ([80.91.229.2]:53213 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965024AbXIGJbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 05:31:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITaBQ-00018J-BL
	for git@vger.kernel.org; Fri, 07 Sep 2007 11:31:24 +0200
Received: from dslb-084-061-044-151.pools.arcor-ip.net ([84.61.44.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 11:31:24 +0200
Received: from dak by dslb-084-061-044-151.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 11:31:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-044-151.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:RxMZLiP0mYYKV73+Bq+p8Jk+EuQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58010>

Walter Bright <boost@digitalmars.com> writes:

> David Kastrup wrote:
>> Walter Bright <boost@digitalmars.com> writes:
>>
>>> A canonical example is that of a loop. Consider a simple C loop over
>>> an array:
>>>
>>> void foo(int array[10])
>>> {
>>>     for (int i = 0; i < 10; i++)
>>>     {   int value = array[i];
>>>         ... do something ...
>>>     }
>>> }
>>>
>>> It's simple, but it has a lot of problems:
>>>
>>> 1) i should be size_t, not int
>>
>> Wrong.  size_t is for holding the size of memory objects in bytes, not
>> in terms of indices.  For indices, the best variable is of the same
>> type as the declared index maximum size, so here it is typeof(10),
>> namely int.
>
> The easiest way to show the error is consider the code being ported to
> a typical 64 bit C compiler. int's are still 32 bits, yet the array
> can be larger than 32 bits.

Not if it is an array declared of size 10.  And if it isn't, you have
no business stating so in the function prototype.

Willfully obfuscate programming does not prove anything.

>>> 2) array is not checked for overflow
>>
>> Why should it?
>
> Because the 10 array dimension is not statically checked in C. I
> could pass it a pointer to 3 ints without the compiler
> complaining. This makes it a potential maintenance problem.

Nonsense.  Again, C won't keep you from shooting yourself in the foot.

>>> 3) 10 may not be the actual array dimension
>>
>> Your point is?
>
> Array buffer overflow errors are commonplace in C, because array
> dimensions are not automatically checked at either compile or run
> time.

No, because programmers get things wrong.  You can tell C compilers to
check all array accesses, but that is a performance issue.  For gcc,
we have

`-fmudflap -fmudflapth -fmudflapir'
     For front-ends that support it (C and C++), instrument all risky
     pointer/array dereferencing operations, some standard library
     string/heap functions, and some other associated constructs with
     range/validity tests.  Modules so instrumented should be immune to
     buffer overflows, invalid heap use, and some other classes of C/C++
     programming errors.  The instrumentation relies on a separate
     runtime library (`libmudflap'), which will be linked into a
     program if `-fmudflap' is given at link time.  Run-time behavior
     of the instrumented program is controlled by the `MUDFLAP_OPTIONS'
     environment variable.  See `env MUDFLAP_OPTIONS=-help a.out' for
     its options.

Why isn't it the default?  Because it is a performance issue.

>>> 5) type of array may change, but the type of value may not get
>>> updated
>>
>> Huh?
>
> Let's say our fearless maintenance programmer decides to make it an
> array of longs, not an array of ints. He overlooks changing the type
> of value in the loop.

Again: C does not prevent you from shooting yourself in the foot.

>>> 6) crashes if array is NULL
>>
>> Certainly.  Your point being?
>
> I consider an array that is NULL to have no members,

Nobody else does that.

> so instead of crashing the loop should execute 0 times.

If the loop count is zero, this is what will happen.

>>> 7) only works with arrays and pointers
>>
>> Since there are only arrays and pointers in C, not really a
>> restriction.
>
> C has structs, too, as well as more complicated user defined
> collections. Essentially, you cannot (simply) write generic
> algorithms in C, because you cannot (simply) generically express
> iteration.

Of course you can.  Macros exist.

>> Most of those are toy concerns.  They prevent problems that don't
>> actually occur much in practice.
>
> I beg to differ - buffer overflow bugs are common and expensive.

Then compile your program with appropriate options.  The key word is
"option".  You don't have to take the performance hit if you don't
want or need it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
