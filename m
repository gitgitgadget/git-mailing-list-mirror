From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 14:54:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>  <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>
  <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 23:57:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVXc-0007xk-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab0EGV45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:56:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57475 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753903Ab0EGV44 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 17:56:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47LubPB030318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 14:56:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47Lubgq014057;
	Fri, 7 May 2010 14:56:37 -0700
In-Reply-To: <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146605>



On Fri, 7 May 2010, Avery Pennarun wrote:
>
> > I think "* auto-eol=true" is just crazy. We would _never_ want to do that.
> > Any project that does that should be shot in the head.
>
> Just to clarify, is it crazy because that line would convert all
> files, even binary ones, where core.autocrlf auto-detects whether
> files are binary or text?

No, presumably 'auto-eol' does the same auto-detection. Otherwise the name 
wouldn't make sense.

I just think that it's crazy because

 (a) you should try to avoid do things like that in the first place. For 
     something like an attribute file, you should just list the files you 
     want to convert. That's the _point_ of an attribute. So it's much 
     nicer if you instead actually are explicit about it, ie

	*.[ch] crlf
	*.txt crlf
	*.jpg -crlf

     should be the _primary_ way you do it, since the autocrlf thing is a 
     bit dangerous in theory.

 (b) But let's say that you want to do it anyway (because you're lazy 
     and because autocrlf works pretty damn well in practice), isn't that 
     a really ugly and crazy thing to add _another_ attribute name for 
     that?

     IOW, if you really want to say "do automatic crlf for this set of 
     paths", the natural syntax for that would be

	* crlf=auto

     No? Not some totally new attribute name.

And in the end, you always do want to have a config variable for the 
actual type of conversion. And like it or not, we already do end up having 
this mix-up between .gitattributes and git "core.autocrlf" config entry, 
so my suggested rule was kind of a "minimally invasive" suggestion to just 
turn that mixing of attributes and config entries into something more 
practically useful.

		Linus
