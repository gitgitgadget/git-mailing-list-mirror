From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Mon, 3 Nov 2008 16:30:10 +0000
Message-ID: <e2b179460811030830t429a469bs3200fade42fecc01@mail.gmail.com>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com>
	 <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
	 <20081031182456.GC3230@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Shawn O Pearce" <spearce@spearce.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:31:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2Kz-0003f7-U5
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYKCQaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYKCQaN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:30:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:15528 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYKCQaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:30:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1178584qwe.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qN4PpUVuMxnOx7nlTbno3GR1sABrmjDPb8pH/g+ZEk0=;
        b=FqcJbzYJcDErDCekMrBaNK/dm5EIe+e1LcxHLiStrvA0yt4QTCd3EF4SGHG0sawpCx
         pFWwSy2eCL5nqXeIhMfa8MkoiQv1LLMVgGrxGK8PhcBLoCsVS95yP3JgTAaap+ULyNJj
         U/IVqJ1+SSoxZkvgI2pQudEnOOOjh3kXFnLGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=x+g89cI6cDbBffyYU/mJ0yPG2VlqYLRHOCa/8RAHfSzOXmC6Sx0OzAxAGg9AnsLoVd
         iK98Fo0jm40Ih2RDjfkW58A3ohXfJ9zb9CEpDLtSrGLpt+LwResVhJSRV3nN/Vdguppo
         jOvhPsVPEM8o/eax8S+hzYZ13UgO5R/h4bp7E=
Received: by 10.214.26.12 with SMTP id 12mr376068qaz.197.1225729811026;
        Mon, 03 Nov 2008 08:30:11 -0800 (PST)
Received: by 10.214.215.10 with HTTP; Mon, 3 Nov 2008 08:30:10 -0800 (PST)
In-Reply-To: <20081031182456.GC3230@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99961>

2008/10/31 Jeff King <peff@peff.net>:
> On Fri, Oct 31, 2008 at 01:09:13AM -0400, Brian Gernhardt wrote:
>
>> Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
>> is far more portable.
>>
>> Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
>> the test scripts.
>
> Hmph. I think this is a good patch, and there is precedent in the past
> (20fa04ea, 2aad957, 9754563). But I am surprised this was not caught by
> our recent autobuilding project.
>
> However, it seems to work on FreeBSD (which makes it doubly weird that
> it is broken on OS X). On Solaris, the /bin/sh is so horribly broken
> that I have to use bash anyway. Commit 9754563 claims breakage on AIX,
> but it looks like Mike is doing the AIX builds with bash.

I've just retested with AIX's standard sh (ksh) instead of bash and
there were only two issues.

Oddly enough, one was with the (original) printfs in
t4030-diff-textconv.sh. AIX seems to ship with a perfectly good
printf, but if you install the GNU tools from the 'IBM toolbox for
AIX' (and prepend them to your PATH) it replaces that printf with one
which doesn't grok the "\\1\\n" syntax, but I think wants it to be
"\\01\\n".

The other problem is the 'trap exit' one discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/92748/focus=92944

Mike
