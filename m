From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: Re: pre-receive hook ; how to detect file and append code ?
Date: Mon, 25 Jun 2012 13:18:49 +0530
Message-ID: <20120625131849.1b1425b6@shiva.selfip.org>
References: <20120622183709.2f0beaa6@shiva.selfip.org>
	<7v395nql6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj42r-00067Y-5J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 09:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab2FYHtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 03:49:03 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:36132
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410Ab2FYHtB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 03:49:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 1887EDE3DCB;
	Mon, 25 Jun 2012 09:49:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t43T38Wzv9xF; Mon, 25 Jun 2012 09:48:56 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 23B75DE3DC8;
	Mon, 25 Jun 2012 09:48:54 +0200 (CEST)
In-Reply-To: <7v395nql6m.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200555>

On Fri, 22 Jun 2012 11:02:41 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> "J. Bakshi" <joydeep.bakshi@infoservices.in> writes:
> 
> > How can I detect a specific file during push, if it is modified or not ?
> > And how can I then append a block of code into that file; if modified
> > during push ? I think pre-receive hook is the best for this operation.
> 
> The purpose of the "pre-receive" hook is to either approve or reject
> a proposed change made by the push.  When it runs, the repository
> already has received all the objects necessary to inspect the
> proposed change locally (from the receiving repository's point of
> view).
> 
> A proposed change comes in the form of <old> <new> <refname> that
> says "The pusher saw <old> at <refname> when he started this push,
> and it wants to update the ref to <new>".  So any of the following
> standard techniques (note: not exhaustive) to inspect the changes
> between <old> and <new> can be used:
> 
>     # are log messages sane?
>     git log <old>..<new>
> 
>     # are the changes sane?
>     git diff <old>..<new>
> 
>     # does it leave forbidden paths intact
>     git diff --name-only <old>..<new>
> 
> If your script likes the proposed change, exit with 0.  If it does
> not, exit with non-zero.
> 
> That is all it can do.  It is not supposed to change <new> to some
> other value, and there is no interface to do so.
> 
> If you want to rewrite the history pushed into the repository after
> a push is accepted, you would want to run it from post-receive or
> something.  All the usual warning about rewriting published history
> will apply if you do so, however.  After all, the history is already
> published immediately before post-recieve (or post-update) runs.

Thanks a lot for the clarifications....
