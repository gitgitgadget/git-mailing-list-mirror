From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filtering out mode-change-only changes
Date: Tue, 28 Feb 2012 19:52:23 -0800
Message-ID: <7vipiqwb2g.fsf@alter.siamese.dyndns.org>
References: <jik2le$2lb$1@dough.gmane.org>
 <7vmx82wbmr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2aac-0007JU-QT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab2B2Dw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 22:52:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757537Ab2B2DwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:52:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D954B6BDB;
	Tue, 28 Feb 2012 22:52:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oEKUFs6NaO8R2kqBPPLEryKfkNY=; b=Mj7FFe
	2HFzdNFHBOK3VhNI/d4OoAEDZ7wR5CozOazIGf6RAYan+gNymjOVGfl86Xwe951+
	uogrUweb55IT6yBiM4eXsowwYSGvPGV/i/eXKWNGNYkyEA5x4Mlr5PDkxgNRBqyb
	8qFb+55fRKj8FvGbZ1Qj6Ok3FgErOzJpLcCXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AT52m5R6kDPYRilgVbzAXwpgR2+GVjgZ
	LpHhyQyCIiNEwYP1MBv37fS4fhOLHzGpkPqSzLmQHKjU8nMN50aKK+oI9BJhceaw
	4L3A8zCIJOZWk3hBVFL7i8eZjkwKej5E9HB6fTVzXngWhew0/bzaBKT/Ufzq8GIP
	oZAAI6b5Jew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D02FA6BDA;
	Tue, 28 Feb 2012 22:52:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 655526BD9; Tue, 28 Feb 2012
 22:52:24 -0500 (EST)
In-Reply-To: <7vmx82wbmr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Feb 2012 19:40:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA23F68E-6288-11E1-99A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191808>

Junio C Hamano <gitster@pobox.com> writes:

> "Neal Kreitzinger" <neal@rsss.com> writes:
>
>> What is the best way to filter out the "mode change only" entries from a 
>> "name-status diff result" listing of changed files?
>> ...
> I do not know about random scripts people write, but there is nothing
> built-in.

Having said that, if we _were_ to do this built-in, an obvious logical
place to do so is to define a new DIFF_OPT_IGNORE_EXECUTABLE_BIT, teach
"--ignore-executable-bit" command line option to diff_opt_parse(), and
then teach diff_resolve_rename_copy() to consider this bit when the code
originally set DIFF_STATUS_MODIFIED.  Instead, the updated code that is
working under --ignore-executable-bit option would drop such a filepair
from diff_queued_diff.

I do not know if such a change is worth doing, though.  It depends on the
real reason why do you have so many "mode change only" changes that would
make rebasing or cherry-picking too troublesome.
