From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 0/4] pre-push hook support
Date: Sat, 29 Dec 2012 09:50:25 -0500
Message-ID: <20121229145025.GA3789@pug.qqx.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <7v1ue9hb06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 15:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToxkT-00088n-89
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 15:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab2L2Ou1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 09:50:27 -0500
Received: from pug.qqx.org ([50.116.43.67]:58253 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab2L2Ou0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 09:50:26 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 957611D0BE; Sat, 29 Dec 2012 09:50:25 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1ue9hb06.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212310>

At 18:01 -0800 28 Dec 2012, Junio C Hamano <gitster@pobox.com> wrote:
>One lesson we learned long time ago while doing hooks is to avoid
>unbound number of command line arguments and instead feed them from
>the standard input.  I think this should do the same.

Good point.  I had been trying to keep the interface for this hook as 
close as possible to the ones for other client-side hooks on the theory 
that less development effort may go into those than for server-side 
hooks.  But thinking on that more I certainly see that this could easily 
run into limits on argument length on some systems; especially when it's 
likely that each of those arguments is likely to be over 100 bytes long.

I'll work on an updated version which sends the variable length 
information over a pipe, using the command-line arguments only to pass 
the remote name and URL.

>How does the hook communicate its decision to the calling Git?
>
>Will it be "all-or-none", or "I'll allow these but not those"?

Currently it just uses the exit code to communicate that back, so it's 
all-or-none.  I think I'll keep that in the updated version as well.

A future enhancement could modify the protocol to support reading from 
the hook's stdout the names of remote refs which are to be rejected, I 
think that just having the option for all-or-nothing is a good starting 
point.
