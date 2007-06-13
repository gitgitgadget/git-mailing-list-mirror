From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 00:39:28 -0700
Message-ID: <7vhcpcfglr.fsf@assigned-by-dhcp.pobox.com>
References: <20070613054229.GM86872@void.codelabs.ru>
	<7v4plcgzer.fsf@assigned-by-dhcp.pobox.com>
	<20070613071514.GP86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sam@ravnborg.org, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Jun 13 09:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyNS2-0002kr-5d
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916AbXFMHjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756914AbXFMHja
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 03:39:30 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44367 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbXFMHja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 03:39:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613073928.ZYFW4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 03:39:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AvfU1X0031kojtg0000000; Wed, 13 Jun 2007 03:39:29 -0400
In-Reply-To: <20070613071514.GP86872@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Wed, 13 Jun 2007 11:15:14 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50027>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Junio, Sam, good day.
>
> Tue, Jun 12, 2007 at 11:07:56PM -0700, Junio C Hamano wrote:
>> I run "make CFLAGS=-O0 -g" all the time.  Also "make CC=echo"
>> seems to "work" as expected ;-).
>> 
>> Care to elaborate what problem you are trying to solve?
>
> As Sam Ravnborg kindly pointed out, you're using make variables
> and I am trying to give the respect to the environment variables.
>
> And the real problem is that one (for example, me) can try to
> build Git with the different compiler than CC (gccX or icc, for
> example).  And it is much better for lazy people to do 'export
> CC=whatever' once and then fire make any number of times ;))
>
> Answering Sam: yes, with my patch it is easier to inherit the
> variables from the environment.  But it is not clear if it is
> good or bad ;))
>
> But anyway, this patch is only my suggestion, and it can be
> thrown away :)

Oh, I will, very gladly ;-), as it is obviously inferior than
how we currently do our build.

I would personally hate environment affecting build (or anything
for that matter), as it makes it unnecessarily difficult to
diagnose when something goes wrong.  I consider that it is a
beautiful thing that make can take explicit override from the
command line.

Lazy people like me can always have a make wrapper.  E.g. I have
a checkout of my 'todo' branch at Meta in git.git repository, so
I would say

	$ Meta/Make -pedantic

to ask for specific set of CFLAGS.  If something goes wrong and
I need to ask for help from other people, it is crystal clear to
them that I am using something "customized" from the above
command line.

If you modify Makefile to allow the build procedure to be easily
contaminated with stray environment, and when your build breaks,
you would answer that your command line is:

	$ make

when asked how you tried to build things -- and leave people who
try to help you scratching their head, wasting their time.
