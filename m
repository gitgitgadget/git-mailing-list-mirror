From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Thu, 20 Mar 2008 22:30:01 -0700
Message-ID: <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZqR-000810-Hs
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbYCUFaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYCUFaO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:30:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYCUFaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:30:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D0FB51054;
	Fri, 21 Mar 2008 01:30:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 23A9D1051; Fri, 21 Mar 2008 01:30:04 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803210014100.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 21 Mar 2008 01:09:24 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77716>

Daniel Barkalow <barkalow@iabervon.org> writes:

> So we should call the same code to parse the string, have that code do no 
> validation at all, and have the caller validate the return as appropriate. 
> The parsing doesn't depend at all on whether it's for fetching or pushing.

Obviously you did not read my patch before responding.

While I would agree that removing the check from parsing and add necessary
checks to all callers would be another way to catch the same kind of
breakages,

 (1) it would be more code to change, and I do not see a clear advantage,
     in that approach, especially given the discussion that lead to
     $gmane/77413;

 (2) the error reporting by the callers that use the parsed result will
     not be able to say "Invalid refspec '%s'" on the source string,
     simply because the source string is not available to them anymore;

 (3) worse yet, the older code even discarded part of the user input, so
     the error reporting that uses the parsed src/dst pair may not even be
     similar to the problematic input the user gave us to begin with,
     making it harder for the user to spot what we did not like and
     correct it.

In any case, don't you agree that the patch you responded to is much
easier to understand what we are (and we are not) checking than the
original code?
