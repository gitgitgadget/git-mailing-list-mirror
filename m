From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date  with -f
Date: Thu, 12 Feb 2009 17:32:47 -0800
Message-ID: <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 02:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXmxC-00071M-Tl
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 02:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbZBMBdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 20:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbZBMBdA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 20:33:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZBMBdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 20:33:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D61EF2B02D;
	Thu, 12 Feb 2009 20:32:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 986A72B025; Thu,
 12 Feb 2009 20:32:49 -0500 (EST)
In-Reply-To: <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri, 13 Feb 2009 00:24:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D25FEA2-F96E-11DD-8281-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109699>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Feb 13, 2009 at 00:22, Junio C Hamano <gitster@pobox.com> wrote:
>> No, because I didn't read the patch text; I don't read patches that are
>> larger than 20 lines during the day-job hours.
>
> Hehe, that sounds like a fair policy.
>
>> I was only commenting on your "rebase does not work if I am up to date
>> with respect to origin and here is my workaround".
>
> Ok, thanks for the comment then, I'll wait for more comment and maybe
> write some tests tomorrow.

Ok, now it is past 5pm, I've read the patch.

I wonder if we can (and if so should) make this a bit more automatic
without having to say "rebase -f --whitespace=fix".

When you say "git rebase --whitespace=fix origin" from the command line,
you are explicitly saying "I want to *fix* breakages in the commits since
'origin'", and at that point, it stops mattering if origin stayed dormant
since you forked from it.  I'd say that the current behaviour is a bug
introduced by the commit that added --whitespace=fix option.

The logic is the same as "git rebase --interactive origin" that does not
refuse to work even if you are already ahead of the origin.

So my suggestion would be to add --force (or -f) like your patch does, and
also detect --whitespace=$option given from the command line, and if it is
fix (or its synonym "strip"), automatically enable --force, perhaps as a
follow up patch, or in the same patch.
