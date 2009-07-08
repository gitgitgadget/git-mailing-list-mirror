From: Jeff King <peff@peff.net>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 17:12:01 -0400
Message-ID: <20090708211201.GA21600@coredump.intra.peff.net>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
 <7vd48b6md8.fsf@alter.siamese.dyndns.org>
 <200907082242.51495.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 23:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOeRT-0002XV-3j
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 23:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbZGHVMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756097AbZGHVMG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 17:12:06 -0400
Received: from peff.net ([208.65.91.99]:43197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844AbZGHVMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 17:12:05 -0400
Received: (qmail 11316 invoked by uid 107); 8 Jul 2009 21:13:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 08 Jul 2009 17:13:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2009 17:12:01 -0400
Content-Disposition: inline
In-Reply-To: <200907082242.51495.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122920>

On Wed, Jul 08, 2009 at 10:42:51PM +0200, Johannes Sixt wrote:

> At this point PATH is "/usr/local/libexec/git-core:/bin:/usr/bin". There is 
> no /usr/local/bin.
> 
> > trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' ...
> > trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' ...
> 
> The PATH doesn't have 'git'; this must fail.
> 
> > trace: exec failed: No such file or directory
> > trace: exec 'index-pack' failed: No such file or directory
> > fatal: index-pack failed

I think there are two possible improvements here:

  1. Hardlinking "git" into exec-path. That means we will always be able
     to find the wrapper, even if the PATH has been munged. Admittedly,
     it sounds far fetched to me that something would exec from the PATH
     and then munge the PATH afterwards, but that seems to be what sudo
     is doing (and it is pretty commonly used).

  2. Better error messages. This would have been much more obvious to
     diagnose if it had said:

        trace: exec("git") failed: No such file or directory

     Johannes, I saw you just posted some related improvements to
     run_command; do they improve this?

-Peff
