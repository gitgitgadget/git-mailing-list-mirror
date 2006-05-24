From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending
 line
Date: Wed, 24 May 2006 07:49:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605240745590.5623@g5.osdl.org>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
 <7vd5e4z2je.fsf@assigned-by-dhcp.cox.net> <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org> <7v8xosqaqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 16:50:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiugT-00055P-7d
	for gcvg-git@gmane.org; Wed, 24 May 2006 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWEXOt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 10:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWEXOt5
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 10:49:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbWEXOt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 10:49:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OEnltH005294
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 07:49:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OEnkGo019011;
	Wed, 24 May 2006 07:49:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xosqaqm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20689>



On Tue, 23 May 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Tue, 23 May 2006, Junio C Hamano wrote:
> >
> >> The issue is if we can reliably tell if there is such an EOF
> >> context by looking at the diff.  Not having the same number of
> >> lines that starts with ' ' in the hunk is not really a nice way
> >> of doing so (you could make a unified diff that does not have
> >> trailing context at all), and I do not offhand think of a good
> >> way to do so.
> >
> > We can. Something like this should do it.
> >
> > (The same thing could be done for "match_beginning", perhaps).
> 
> But this is exactly what I said I had trouble with in the above.

Well, not quite. You said "not the same number of lines", and I say "no 
ending context". Very different.

My patch actually is totally self-consistent: not having any context at 
the end of a unified diff really means that it is the end of the file (ie, 
the "end of file" there _is_ the context). And if you want to apply files 
without context, you should use "-Cx", and my patch does that too - if you 
asked for "relaxed context checking", it will re-try without the "only at 
end" check thanks to the

	if (match_end) {
		match_end = 0;
		continue;
	}

so it all should work.

Not that I _tested_ it, of course ;)

		Linus
