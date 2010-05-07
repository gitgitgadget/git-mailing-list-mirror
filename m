From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 15:14:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>  <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>
  <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 00:16:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVqX-0005V5-DR
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab0EGWQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 18:16:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab0EGWQc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:16:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47MGLf5031897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 15:16:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47MGL3h014896;
	Fri, 7 May 2010 15:16:21 -0700
In-Reply-To: <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146611>



On Fri, 7 May 2010, Linus Torvalds wrote:
> 
>      IOW, if you really want to say "do automatic crlf for this set of 
>      paths", the natural syntax for that would be
> 
> 	* crlf=auto

Btw, since we're discussing this, I do think that our current "crlf=input" 
syntax for .gitattributes is pretty dubious. 

I don't really see why it should be a path-dependent thing on whether you 
do crlf conversion on just input or on checkout too.  It smells odd. It 
makes more sense to me to have a global policy for what the output/input 
conversion should be, and then the path rules are just about whether that 
conversion gets done or not.

And like it or not, we called that global rule "autocrlf", and then mixed 
it up with the decision on whether we should do conversion at all. I do 
think that that was a mistake too, and that we could try to fix it, but I 
also think that's a fairly independent issue.

So we _could_ introduce a new "core.crlf" config option that talks purely 
about what kind of conversion gets done - not about _whether_ it gets 
done. So you could do

	[core]
		crlf=input

and it would imply that crlf conversion is only done on input, but it 
would differ from "autocrlf=input" in that it would _not_ imply that any 
paths not matched by gitattributes crlf rules would be automatically 
converted.

[ And in the above model, "core.autocrlf = input" would just be a 
  shorthand for saying "core.autocrlf=true" + "core.crlf=input")

So I think we could improve the config file syntax a bit.

But I think that's really a separate issue from the .gitattributes file, 
and whether the "crlf" attribute means anythin in the _absense_ of any 
config file rules about crlf.

			Linus
