From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to
 ~/.gitexcludes.
Date: Thu, 26 Nov 2009 10:18:57 -0800
Message-ID: <7vmy2987zi.fsf@alter.siamese.dyndns.org>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
 <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>
 <4B0E6DC9.3070105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 19:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDiw0-0002PB-8R
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 19:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbZKZSTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 13:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZKZSTD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 13:19:03 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZKZSTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 13:19:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 552C3838A0;
	Thu, 26 Nov 2009 13:19:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHpRNFqIMRBNXqPPs8popK3QsOQ=; b=REjyEK
	AcfsJVliHMdahZmT4ucUeBXQixDeFTXELJfe7bYh+SnE24eyJMFjzPFpD4Kvr0Zy
	ZyGuMFb55KKHC067wm6Ea4wUOJwJcfPgjPkPzH7orPnFxmaEdfexYxBe3F+EAsar
	plQW1yOqi4bVttp6SGdKXBMdc7cmbumn9GIxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GI14o3NfSUeDL8RBbJ9AZjSzv1oJmj6j
	dRuL3Keih0rqaM2enBvqPwc/V+1x5IzFZ6Qjx/FY7Gc8Ripkc+q8fHFcm4oRo+WY
	ZI9JYjFn13XTgiE1aq2mZH52EmZx3Oz4UjNCaaQxhRdIyJkB8HVkNJh1qcJMO68F
	mN6dbh6HLLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2953A8389F;
	Thu, 26 Nov 2009 13:19:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42AE38389C; Thu, 26 Nov
 2009 13:18:59 -0500 (EST)
In-Reply-To: <4B0E6DC9.3070105@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 26 Nov 2009 13\:00\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CFE7546-DAB8-11DE-B8A3-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133818>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm sorry to jump in so late, and this may sound like bike-shedding, but
> right now we have
>
> .git/info/exclude
> .gitignore

The current dir.c::setup_standard_excludes() implementation reads exclude
patterns from "$GIT_DIR/info/exclude".  

As to the way forward regarding "info/exclude", my preference is to teach
the codepath to check if "info/ignore" exists, and read that after it
reads from "info/exclude" (to give the new file a slightly higher
precedence if both exist).

Document that we read from both info/ignore and info/exclude immediately
when this change happens.  The updated documentation probably should say
that "info/exclude" is still read and will be read forever, and tell the
readers that there is no difference in functionality between the two,
other than that "info/ignore" is a name that is more consistent with the
".gitignore" (which is the name of in-tree exclude patterns file).

And stop there.

While there is no reason to encourage new repositories to use info/exclude
over info/ignore, we shouldn't stop mentioning info/exclude or declare
deprecation in the documentation, as doing so would:

 (1) scare existing users that their info/exclude file may become invalid
     some day; and

 (2) puzzle new users (who inherited an already initialized repository
     that has been maintained by somebody else from the era before this
     change) what the info/exclude file in the repository is doing.

> and this would add
>
> ~/.gitexcludes
>
> That is, three terms, or two, where one comes in two variations
> (exclude/exludes). I always wondered why we have two.
>
> The reason for .gitignore is most probably the similarity to
> .${othervcs}ignore, and that is a valid reason.

I try not to get involved in bike-shedding (I removed myself from Cc), but
the events happened in the opposite order.

Originally we had the concept of "exclude patterns", in 9ff768e ([PATCH]
Give show-files the ability to process exclusion pattern., 2005-04-28).
This origin is still visible in the names of command line options to
"ls-files".  It was just a flat text file that is not tied to any
particular directory in the work tree.

Then much later in f87f949 (git-ls-files: --exclude mechanism updates.,
2005-07-24) the mechanism was extended, so that we could add per-directory
exclude patterns.  But that was just the _ability_; its actual use in the
Porcelains had to wait until ba966b9 (Teach git-status-script about
git-ls-files --others, 2005-08-26), and the commit finally established the
name ".gitignore" that is an in-tree, per-directory file that has exclude
patterns.  The name was inconsistent with the established concept of
"excluding", but was chosen to be similar to .scmignore.

Hopefully that would clear your wondering.
