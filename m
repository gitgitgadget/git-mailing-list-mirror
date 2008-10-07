From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Tue, 07 Oct 2008 08:15:45 +0200
Message-ID: <vpqprmdlylq.fsf@bauges.imag.fr>
References: <20080928041040.GA24214@coredump.intra.peff.net>
	<vpqd4io1tla.fsf@bauges.imag.fr>
	<20080928161106.GA30199@coredump.intra.peff.net>
	<vpqk5ctfyp6.fsf@bauges.imag.fr>
	<20080930164545.GA20305@sigill.intra.peff.net>
	<20081005214114.GA21875@coredump.intra.peff.net>
	<48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr>
	<20081007012044.GA4217@coredump.intra.peff.net>
	<48EAF902.3040402@viscovery.net>
	<20081007060014.GA7965@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:22:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5xe-0002ZV-K5
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbYJGGVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYJGGVM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:21:12 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:32945 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbYJGGVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:21:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m976JDiG000297;
	Tue, 7 Oct 2008 08:19:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kn5rF-0001co-VY; Tue, 07 Oct 2008 08:15:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kn5rF-00069r-TI; Tue, 07 Oct 2008 08:15:45 +0200
In-Reply-To: <20081007060014.GA7965@coredump.intra.peff.net> (Jeff King's message of "Tue\, 7 Oct 2008 02\:00\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 07 Oct 2008 08:19:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97672>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 07, 2008 at 07:52:02AM +0200, Johannes Sixt wrote:
>
>> How about this: If I run 'git show -- foo.doc' (foo.doc resolves to a
>> single path, obviously), I want MS Word, but for other uses of 'git show'
>> I don't. I think that heuristics could be very effective: With a plain
>> 'git show' I get the overview of the change, and with 'git show --
>> foo.doc' I drill down into a single document.
>
> Hrm. I am not opposed to heuristics, but in this case, I don't like the
> one you have proposed. ;P
>
> My specific case that prompted this work is a repository full of
> pictures and videos, where I rarely (if ever) change the media content,
> but frequently change exif tags. So my "usual" case is to want to see
> "git log -p" with the textconv'd version. The commit diffs are otherwise
> totally meaningless.

So, you disagree about "git log" not showing the textconv, but you
still agree with half of the proposal :-P. When the user explicitely
requests a single file, he does want textconv (requesting a diff for a
single file and be happy with "binary files differ" would be
strange ...).

It seems quite clear to me that we won't get a heuristic right for
everybody (some diff driver are fast, some are slow, some require an
external GUI, some don't, ...). Better let the thing be nicely
configurable IMHO.

One proposal: have a diff.<driver>.activate with several values:

* "always": activate the diff driver in any porcelain
* "diff": activate it only for "git diff", as currently
* "singlefile": Johannes's heuristic proposal

That way, one could say easily "activate exiftags filter all the time,
but MS-Word only when I request a diff for a single file", and this
leaves room for other values if the need be. Well, there's no room for
"use MS-Word native diff tool in git-gui but antiword/catdoc +
textconv in 'git log -p'" here, but do we want it?

Or is all that just overkill?

-- 
Matthieu
