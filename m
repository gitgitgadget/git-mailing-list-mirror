From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 09:54:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com> 
 <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com> 
 <46F55E03.2040404@krose.org>  <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
  <20070923020951.GF24423@planck.djpig.de>  <20070923062527.GA8979@old.davidb.org>
 <851wcpsv4z.fsf@lola.goethe.zz>  <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
  <20070923104525.GC7118@artemis.corp>
 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 18:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZUk0-0000Zp-5W
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 18:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbXIWQzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 12:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXIWQzZ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 12:55:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37204 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100AbXIWQzY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 12:55:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8NGrnJC001492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Sep 2007 09:53:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8NGrmr4019569;
	Sun, 23 Sep 2007 09:53:48 -0700
In-Reply-To: <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
X-Spam-Status: No, hits=-3.24 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.39__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58969>



On Sun, 23 Sep 2007, Marco Costalba wrote:
> 
> Perhaps I have misunderstood, but the idea I got is that for Linus OO
> brings in more problems than what it tries to fix.

Not really.

I'm a huge believer in OO, and if you look at the kernel, for example, 
there's just a ton of interfaces that are basically object-oriented. All 
the VFS is, for example, is really just a object model around low-level 
filesystems. The same largely goes for virtual memory mappings, or indeed 
for things like the interrupt or DMA controller abstractions, the network 
packet filtering etc etc etc.

But I'm also a huge believer in *explicit*syntax*. People should see what 
is going on, and the abstraction should be explicit.

[ Honesty in advertising: we do end up often hiding *some* abstractions. 

  Sometimes it happens for historical reasons: if the code didn't have any 
  indirection/abstraction initially, we may end up using macros and inline 
  functions to hide the fact that it now is actually going through an 
  indirect object-oriented interface.

  And sometimes it happens because the thing is *so* common or *so* 
  obvious that making the indirection explicit is just syntactically too 
  intrusive. ]

And we do all of this in C. There is no need to go to C++ for any "object 
oriented principles". It really is just a syntactic issue, and in many 
ways the syntax "advantage" of C++ is actually a big *disadvantage*.

I'm one of those people who think that interactions should be *locally* 
visible. If you need to understand the "big picture" in order to 
understand what a line of code does, that's usually a bad idea. So 
syntactic tricks that hide what is actually going on are bad.

You can see some of my opinions on C in the extensions I did for sparse. I 
think the C type system is a bit too sloppy, and much of what sparse does 
is more totally static type checking. Things like being able to decorate 
types statically, and having to explicitly carry those decorations around 
is a *good* thing - because it does the opposite of hiding. Having to say

	struct somestruct __user *p

to explicitly say that it's a pointer to user space - and then having 
every function that takes that pointer have to have that "__user" there is 
a VERY GOOD THING.

That's very different from having "accessor functions" and making "p" an 
abstract type, and having the compiler automatically generate the right 
kind of access. That kind of stuff is TOTAL CRAP, and it's an example of 
how C++ has a horrible design, where you carry around _implicit_ knowledge 
instead of making the knowledge explicit and visible locally too.

(And no, C doesn't do it very well. The C type system makes it too hard to 
add explicit markers that get statically checked, and you generally have 
to do it by making the code unreadable by turning things into special 
structures, one for each use, or something like that).

The same goes for things like memory allocation. Memory allocation issues 
are often some of the *biggest* performance issues, and that means that 
they have to be explicit. I'm actually a big fan of GC, but most languages 
that implement GC do it exactly the wrong way in my opinion: they make it 
a fundamental thing that covers everything, and it all happens implicitly, 
instead of making it explicit.

I don't know how many people have noticed that git internally actually 
does do some garbage collection. It's just that we call it "caches", and 
we do it explicitly. I'd love to have a language that helps me with that, 
but I would *hate* to have a language that does it for everything. As it 
is, we *could* do garbage collection much more, but we don't, just because 
it's a bit too painful.

In practice, it means that I'm considering writing some helper routines in 
C, which actually would do exactly what I want them to do: make the 
(reasonably few) data structures that want to have a dynamic cache use 
that dynamic cache explicitly, the way we now do for delta caching etc.

There are a few features of C++ that I really really like. For example, I 
think the C preprocessor is absolutely horrid, and a preprocessor that is 
built into the language - and integrates with the syntax - would be 
wonderful. And while C++ doesn't improve on that, at least templates are 
an example of something like that. Not perfect, but that's the kind of 
feature that C really would like.

In the kernel, we (ab-)use the C preprocessor a lot for things like that. 
Some of our macros are really disgusting. I'm not proud, but it works 
well, and together with gcc extensions like "__typeof__" and thigns like 
"__builtin_constant_p()" you can do some rather powerful things.

But other parts of C++ are just nasty. The whole OO layer seems designed 
to do a lot of things implicitly and in the wrong way. I also disagree 
with exception handling, and the "new" keyword kind of exemplifies a lot 
of what is wrong in C++.

So in short:

 - the one big feature that I think really makes a huge difference to 
   people, C++ does not have: garbage collection. Yes, there are GC 
   modules, but let's face it, you can do that equally well in C too, it's 
   just slightly different syntax.

 - the stuff C++ *does* have is usually nasty. Implicit initializers and 
   destructors and the magic lifetime rules of objects etc are all just a 
   piece of incredible bogosity. And that all comes from the OO stuff that 
   is totally worthless, because it's really just syntactic fluff that can 
   be done easily in C.

 - the C preprocessor really is horrible, and every single language beats 
   C handily in this area. Except for C++, which didn't fix anything at 
   all in that area.

   Even assemblers have macro languages that allow conditionals, 
   repetition, nesting, etc etc.  C and C++? Not so much. (Some languages 
   don't need it, because the language itself is dynamic and you can do 
   everything from within the language - ie you just evaluate an 
   expression that you built up dynamically as in LISP etc).

   (And don't tell me about m4. It's a better preprocessor, but it's not 
   syntactically integrated, and it's too complex, imho)

There are other problems in C. The implicit type conversions should at 
least have some way to be disabled on a type-for-type basis.

		Linus
