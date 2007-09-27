From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Add --no-rename to git-apply
Date: Thu, 27 Sep 2007 21:12:29 +0200
Message-ID: <200709272112.29608.robin.rosenberg@dewire.com>
References: <11908420041596-git-send-email-robin.rosenberg@dewire.com> <7vbqbozo7t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaykq-0001mQ-E2
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064AbXI0TKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXI0TKY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:10:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19558 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755194AbXI0TKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:10:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 09672802872;
	Thu, 27 Sep 2007 21:02:05 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12113-09; Thu, 27 Sep 2007 21:02:04 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 967AE802665;
	Thu, 27 Sep 2007 21:02:04 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vbqbozo7t.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59313>

torsdag 27 september 2007 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > With this option git-apply can apply a patch with a rename
> > onto the original file(s).
> 
> This is troubling from both design and implementation point of
> view.
> 
>  * Why would this be useful?  What's the point of producing the
>    renaming patch if you know you would want to apply while
>    ignoring the rename?
The point of producing the rename info is to find out which renames
are in it. It's only that I don't want to perform them straight away.

>  * The change looks too special purpose to me.  If you are
>    giving the ability to deposit the result to somewhere other
>    than where the patch intendes to, why limit it only to the
>    preimage name?  Aren't there cases where A is renamed to B
>    sometime in the history, and you have a patch that talks
>    about the content change A->A but the tree you have has the
>    contents already in B, and you would want to apply that
>    patch?  It feels that this and your "ignore rename" could be
>    handled much more cleanly and flexibly by preprocessing the
>    patchfile.
Well it is special *purpose*, but not tied to a particuar tool. I'm
not sure whether it is necessary with other tools though. I'll
consider the preprocessing and will retry the rename-back that
Johannes suggested.

> 
>  * By disabling the parsing of rename header lines, you are
>    disabling the sanity checking of the input done in
>    gitdiff_verify_name() called from gitdiff_oldname() and
>    gitdiff_newname().  I think it is wrong for --no-rename
>    option to affect the parsing of the input.  If we were to do
>    this, perhaps write_out_results() or one of its callee would
>    be a better place to do so.

Hopefully git produces sane things so the checking shouldn't be that
important, but I also do a check before beginning with checkouts and
so on, much like git-cvsexportcommit. The check  is performed without
the switch.

-- robin
