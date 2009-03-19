From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during
 checkout.
Date: Thu, 19 Mar 2009 14:06:53 -0700
Message-ID: <7v8wn18bo2.fsf@gitster.siamese.dyndns.org>
References: <49B8DD1D.3060908@viscovery.net> <49C267E3.1020205@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ext Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPTj-0007Yp-0R
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbZCSVHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbZCSVHE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:07:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbZCSVHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:07:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D9C4727B;
	Thu, 19 Mar 2009 17:06:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B228C727A; Thu,
 19 Mar 2009 17:06:55 -0400 (EDT)
In-Reply-To: <49C267E3.1020205@nokia.com> (Kristian Amlie's message of "Thu,
 19 Mar 2009 16:42:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2D6A628-14C9-11DE-B852-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113829>

Kristian Amlie <kristian.amlie@nokia.com> writes:

> ext Junio C Hamano wrote:
> ...
>> For example, you may notice that, after making a clean checkout, one path
>> has a wrong attribute assigned to it, and may try to correct it.  But how?
>> 
>>  $ edit .gitattributes ;# mark foo.dat as binary
>>  $ rm foo.dat
>>  $ git checkout foo.dat ;# make sure the new settings is correct???
>
> As far as I can see, this works without any modifications to the patch.
> Is that maybe because git_attr_set_direction() is not called if you use
> that form of checkout?

But that in itself can be seen as a bug, right?  In another use case,
suppose you botched your .gitattributes in HEAD version and noticed that
foo.dat is checked out with a wrong attribute.  You try to fix it like
this:

    $ git reset HEAD^ .gitattributes
    $ rm foo.dat
    $ git checkout foo.dat

If you do not flip the direction, the one from the work tree is used which
is not what you want.  If you do, then you break the other use case.

Either way, you cannot win.

In any case, I think I already queued the patch in 'pu' but without
documentation updates nor additional tests, so no need to include the
patch itself when you send in an update.
