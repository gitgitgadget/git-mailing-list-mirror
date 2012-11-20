From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] git-send-email: don't return undefined value in
 extract_valid_address()
Date: Tue, 20 Nov 2012 21:47:36 +0100
Message-ID: <20121120204736.GA7039@shrek.podlesie.net>
References: <1353414053-25261-1-git-send-email-krzysiek@podlesie.net>
 <7v8v9wrpdz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taujb-0001k3-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 21:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab2KTUrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 15:47:41 -0500
Received: from [93.179.225.50] ([93.179.225.50]:43368 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab2KTUrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 15:47:40 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id E34514AE; Tue, 20 Nov 2012 21:47:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8v9wrpdz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210112>

On Tue, Nov 20, 2012 at 12:27:36PM -0800, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
> 
> > In the fallback check, when Email::Valid is not available, the
> > extract_valid_address() does not check for success of matching regex,
> > and $1, which can be undefined, is always returned. Now if match
> > fails an empty string is returned.

Maybe the last line of comment should be changed to:

fails an empty string is returned to indicate failure.

> 
> That much we can read from the code, but a bigger question is why
> would it be a good thing for the callers?  Wouldn't they want to
> be able to distinguish a failure from an empty string?

In this case returning empty string does not make sense, so it's
really used to indicate failure.

> 
> > Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
> > ---
> > This fixes following warnings:
> > Use of uninitialized value in string eq at ./git-send-email.perl line 1017.
> > Use of uninitialized value in quotemeta at ./git-send-email.perl line 1017.
> > W: unable to extract a valid address from: x a.patch
> >
> > when invalid email address was added by --cc-cmd,
> > ./git-send-email.perl --dry-run --to a@podlesie.net --cc-cmd=echo x a.patch
> 
> In other words, would we want to *hide* (not "fix") the warning?
> Shouldn't we be barfing loudly and possibly erroring it out until
> the user fixes her --cc-cmd?
> 

Yes, it's just to hide the warning, the error (warning in this case) it's
already correctly generated:

W: unable to extract a valid address from: x a.patch

Maybe we should change it to an error?

Krzysiek
