From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH, maint] setup: make sure git_dir path is in a permanent
	buffer, getenv(3) case
Date: Fri, 12 Nov 2010 20:20:28 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20101112172028.GA3941@tugrik.mns.mnsspb.ru>
References: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru> <20101111181728.GF16972@burratino> <20101112140329.GA29604@tugrik.mns.mnsspb.ru> <20101112160332.GB15141@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 18:19:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGxHB-0000UU-I9
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 18:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab0KLRSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 12:18:55 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:48823 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab0KLRSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 12:18:55 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PGxH4-00088D-Hz; Fri, 12 Nov 2010 20:18:54 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PGxIa-0001Gu-T6; Fri, 12 Nov 2010 20:20:28 +0300
Content-Disposition: inline
In-Reply-To: <20101112160332.GB15141@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161354>

On Fri, Nov 12, 2010 at 10:03:32AM -0600, Jonathan Nieder wrote:
> Kirill Smelkov wrote:
> 
> >     static void run_service(const char **argv)
> >     {
> >             const char *encoding = getenv("HTTP_CONTENT_ENCODING");
> >             const char *user = getenv("REMOTE_USER");
> >             const char *host = getenv("REMOTE_ADDR");
> > 
> > 
> > etc...
> > 
> > 
> > To me, it's very unfortunate that subsequent getenv() could overwrite
> > previous getenv() result, but according to `man 3 getenv` all these
> > places are buggy.
> 
> Right, but do we know of any platforms that work that way currently?

I don't. Actually I was really surprised after reading getenv manual
about that.

> We could make getenv() rotate between a few buffers on such platforms
> (probably 10 or so would take care of the longest runs).

I think it would be hard to get right (is 10 enough? on which platform?
this rarely happens after all...), and also why introduce special case?

> > Maybe we'll need something like our own xgetenv() which will keep vars
> > in some kind of hash tab so that get/put on other vars do not interfere
> > with what was originally returned by xgetenv().
> 
> For examples that store the result like you pointed out (which store the
> result from getenv), something like that would be needed if we want
> them to work on platforms where putenv shifts everything.
> 
> > Unfortunately I can't afford myself to dive into all this, so please
> > choose what you like more.
> 
> I think we ought to fix this properly in the end.  But if you want a
> quick workaround, maybe the vcs-svn/string_pool lib could help you.

No, I'm not in a hurry - better to fix this properly. Though personally,
I've already scratched my itch here.


Thanks,
Kirill
