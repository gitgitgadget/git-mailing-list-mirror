From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 17:45:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihx33-0001uZ-Ec
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXJQAp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757873AbXJQAp6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:45:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35335 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752911AbXJQAp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 20:45:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9H0jqAP007768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 17:45:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9H0jqcP026130;
	Tue, 16 Oct 2007 17:45:52 -0700
In-Reply-To: <20071017015109.303760cc@localhost.localdomain>
X-Spam-Status: No, hits=-2.667 required=5 tests=AWL,BAYES_00,OSDL_NIGERIAN_GOLD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61293>



On Wed, 17 Oct 2007, Christer Weinigel wrote:
> 
> If you assume that everyone is sane and use a tab size of 8 you will
> get bitten, sooner or later.  Or actually, you, Linus, who are lucky
> enough to work mostly with Linux source, you might personally not get
> bitten all that often.  But us poor suckers that have to work with
> other people, often Windows programmers, we do.

One issue may well be that Windows programmers also probably don't work 
very much with patches, do they?

One reason for *really* wanting to use hard-tabs is that it makes patches 
look better, exactly because diffs contain that one extra (or two, in the 
case of old-style context diffs) character at the beginning of the line.

Which means that while all-space indents look fine, *mixing* styles 
definitely does not. In particular, a two-character indent (which 
hopefully nobody uses, but people are crazy) will be totally unreadable as 
a patch if you have the (fairly common, at least in UNIX projects) style 
of using spaces for less-than-eight-character-indents and tabs for the 
full 8 characters.

(In particular, a 3-level and 4-level indent will look *identical* in such 
a project, when using context diffs).

And sure, you can use all-spaces-everywhere, but that just isn't what any 
normal UNIX editors are set up for by default. In contrast, under UNIX, I 
can pretty much guarantee that hard-tab indents look at least reasonable 
in any editor.

And if you have an editor that shows hard-tabs as 4-character indents, 
generally you can work with it. You may have odd indentation, and people 
may complain about your patches not lining up, and yes, it would be up to 
*you* to understand that 8-wide tabs are the normal and default. But you 
can certainly work with a source base that uses a single hard-tab for 
indentation.

In contrast, if you use spaces (or worse - mixing), things really look 
ugly as sin, to the point of actually being unworkable.

In short:

 - if the project has the rule that an indentation is "one hard-tab", then 
   at least everybody can *work* with that project. Different people may 
   see things laid out slightly differently, but it's generally not a 
   horrible disaster, especially if you aim to use block comments indented 
   with the code (like we *mostly* do both in the kernel and in git)

 - all-space and all-tabs just leads to problems. Yes, I know about 
   python, but lets face it, python is different, since the spacing has 
   semantic rules there. Most non-python programmers will not use editors 
   where you can obviously see the difference between spaces and tabs, and 
   as a result an all-space model will *turn* into a mixed-space/tab 
   model, and you get horrible end results.

 - as per above, mixing spaces and tabs is a *horrid* idea. 

 - as a result, a "pure tab for indents" model tends to be workable in 
   most situations. It may not be ideal for you, but it's workable.

 - and at least in the UNIX world, default for pure tabs really is 8 
   characters. Even if you have an editor that shows them as four, you'll 
   see different results outside the editor (eg "grep -5 file.c"), so 
   people should just consider other tab sizes to be "secondary".

   And as long as 99% of all git developers are under Linux, and all the 
   core ones seem to have had no problem with the current tab rules, I 
   really don't see why that should change.

See? Hard-tabs are good. Maybe Windows people don't ever see patches 
(perhaps they only see them as side-by-side graphical things), and maybe 
windows projects are always done inside *one* environment where there is 
no "grep" and "terminal TAB size" and "fifty different editors with 
different defaults".

But even in DOS/Windows, hard-tabs seem to be quite common, judging by 
what little source code I've seen from Windows projects. 

And I just checked. The current git model seems to work fine if you have 
an editor that thinks tabs are 4 spaces:

	sed 's/	/    /g' < revision.c  | less -S

(that's a hard-tab in that first regex). No, things don't necessarily line 
up just like they should, but you actually have to *look* for problems to 
see them (ie stuff where people have added line-breaks).

And is it really so unreasonable to just say "8-character tabs are the 
gold standard"?

			Linus
