From: Hannu Koivisto <azure@iki.fi>
Subject: Re: CRLF support bugs
Date: Tue, 04 Nov 2008 00:24:09 +0200
Organization: NOYB
Message-ID: <83mygga1o6.fsf@kalahari.s2.org>
References: <83od0yaxzk.fsf@kalahari.s2.org>
	<20081103090932.GA18424@coredump.intra.peff.net>
	<83y700alzf.fsf_-_@kalahari.s2.org>
	<20081103164626.GG21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 23:25:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7rw-0004T5-11
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYKCWYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYKCWYc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:24:32 -0500
Received: from main.gmane.org ([80.91.229.2]:60020 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYKCWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:24:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kx7qR-0005uy-1a
	for git@vger.kernel.org; Mon, 03 Nov 2008 22:24:23 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 22:24:23 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 22:24:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:kDRloRSDxgMsiRJcyZyzxvmU55o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100005>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Mon, Nov 03, 2008 at 05:05:24PM +0200, Hannu Koivisto wrote:
>
> core.autocrlf was exactly meant to be set globally. Basically,
> it says what end-of-line should be on your system. It is strange
> to have it different for different repositories.

Maybe so from the point of view of what it was intended for, but
since there is nothing else that could be used to control end of
line conversion on a repository basis, it certainly doesn't feel
strange to me to use it like that.

When you clone & checkout, say, the official git repository on
Windows, are you comfortable doing it with core.autocrlf globally
set to true?  Maybe you know it's fine to do that so you actually
are but I'm not.  How about some other random free software
mainly-Unix project you would like to develop / build under
Windows?  Even if text vs. binary autodetection worked perfectly
(and it doesn't), CRLF line ends may still be the wrong choice for
some project.  I recall one such project and while admittedly the
situation with it may have changed since I last used it, that
doesn't change the point.

I certainly wouldn't want to have core.autocrlf globally set to
true on Windows.  No automatic conversion is a much safer default.
I only want CRLF conversion to happen with projects that have
actually considered such checkouts and if necessary have been
carefully set up to support it by using .gitattributes.

>> I also observed this problem:
>> 
>> # Pretend someone does this on Unix
>> mkdir test1
>> cd test1
>> git init
>> echo "*.c crlf" > .gitattributes
>> echo -en "foo\r\nfoo\r\nfoo\r\n" > kala.c
>
> The 'crlf' attribute means that the file should be treated as 'text'
> without applying heuristic. The correct ending for text files on Unix
> is '\n', not '\r\n'.  So, you put a text file with incorrect ending,
> not surprisingly it causes problems for Windows users later.

It seems to me you are looking at this, too, from the technical
point of view.  Yes, given the way CRLF support is implemented, the
end result was expected.  But that doesn't mean it was ok from the
user's point of view.  Consider usability instead.  A user makes a
mistake and adds a file from a colleague who uses Windows without
first converting it.  Are you really saying "so he made a mistake,
who cares if repository users face problems"?  I think it's just
very bad usability that by making such a small mistake you cause
the system to end up in a state that doesn't make any sense,
i.e. git claims you have modifications right after clone & checkout
even though you haven't modified anything.

-- 
Hannu
