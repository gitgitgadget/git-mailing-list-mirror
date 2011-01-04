From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: [PATCH] gitattributes.txt: mention exceptions to gitignore
 rules
Date: Tue, 4 Jan 2011 21:17:26 +0000 (UTC)
Message-ID: <ig02p5$kh3$1@dough.gmane.org>
References: <iftvu6@dough.gmane.org>
	<1294147915-1475-1-git-send-email-pclouds@gmail.com>
	<7vwrmkfphh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 22:17:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaEGM-0007Je-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 22:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab1ADVRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 16:17:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:56715 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab1ADVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 16:17:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PaEGE-0007EY-F8
	for git@vger.kernel.org; Tue, 04 Jan 2011 22:17:42 +0100
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 22:17:42 +0100
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 22:17:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.133 (House of Butterflies; GIT 3b0ee7d master)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164519>

On Tue, 04 Jan 2011 11:17:14 -0800, Junio C Hamano wrote:

>> Patterns that do not match but should:
>>   d2/*
> 
> This shouldn't match unless it appears in d1/.gitattributes.
> 
> The presense of '/' makes the pattern anchored to the directory it
> appear in, and .git/info/attributes is taken as being at the top level.
> 

After more carefully re-reading gitignore(5) I think that now I get it.

I presume that is is not possible to match certain pattern occurring 
*anywhere* in the path.

Would it be possible to extend pattern format to include double-star 
wildcard that matches anything including slashes ?

Like: **/whatever/**

Many tools (in java at least) and libraries support such extension to 
globs. Unfortunately standard fnmatch(3) that's used by git is not one of 
them, but glibc's implementation looks portable and self-contained so it 
could be included and modified.


>>   d2/
>>   d2
> 
> These shouldn't for the same reason.
> 
>>   d1/d2
>>   /d1/d2
> 
> We somehow don't do leading path match like we do for gitignore, but I
> do not think this was intended.  My gut feeling is that these should
> match.
> 
> The thinking back, when we wrote the code, could have been that, unlike
> gitignore that maintains only one bit (either "ignored" or "not"),
> attributes are richer and giving the same attribute (say "whitespace
> checking criteria") to files inside a directory and the containing
> directory itself was nonsensical.  But if that was the reason, it is
> faulty, as we do not track directories anyway.
> 
> Wouldn't it be sufficient to teach attr.c:path_matches() that a pattern
> could also match with leading path?  That would automatically cover the
> case where a pattern is terminated with a slash, as pattern "d/e/" would
> never match path "d/e" but does match "d/e/f"?
