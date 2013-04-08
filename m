From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: two minor tweaks to check-ignore to help git-annex
 assistant
Date: Mon, 08 Apr 2013 14:56:30 -0700
Message-ID: <7vhajgvg8h.fsf@alter.siamese.dyndns.org>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK3K-0001Hf-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936422Ab3DHV4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:56:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936362Ab3DHV4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:56:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9D61428E;
	Mon,  8 Apr 2013 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y2OpPpRaXOkzhB5O3ZZLpacj29M=; b=lBCms0
	NMQu7yfEJ4flxh6dQ0X1IVcCQBP7/65VwTFJXOGhxZozSxytVqg4n0cK9odMhuDe
	Z6+WnmYf6tzVTUw9jMrucLuY+Yt2NbLcP9MdNMlrOxsQFuU0zoWqDTJ4qXRbZqMD
	mdAHx7iW9JacqR7telHj0FU+l4ccLHTJ+oxes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rI88xzaEnIL8hZ7tslbWRrjKqlprO6M6
	YRXdPxWwFyCsJKUgd+De6zOj2XkwLch5j4hE7k0rIHmG/PPenbjj3OJJxyAjbLRi
	4ArBsxVlvdQXxlEc+Q4cC0gyRDn6s8NFK5joljir0yWMi4oHhKJ/hUnJIJ14+G9J
	Uoz3/x4Hlh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F0571428D;
	Mon,  8 Apr 2013 21:56:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD8511428B; Mon,  8 Apr
 2013 21:56:31 +0000 (UTC)
In-Reply-To: <20130408181311.GA14903@pacific.linksys.moosehall> (Adam
 Spiers's message of "Mon, 8 Apr 2013 19:13:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C3C41A8-A097-11E2-A66C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220528>

Adam Spiers <git@adamspiers.org> writes:

> I already have a rough fix for the second issue, but I wanted to
> solicit feedback on the appropriate UI changes before proceeding much
> further.  Does something like the below patch seem reasonable, modulo
> the lack of tests?  In case the UI changes I am proposing are not
> clear from the patch, here's some example output from running it
> inside a clone of the git source tree:
>
>     $ git check-ignore -v -n foo.tar.{gz,bz2}
>     .gitignore:203:*.tar.gz foo.tar.gz
>     ::      foo.tar.bz2
>
> So the number of output fields does not change depending on whether
> the pattern matches or not, and any caller can determine whether it
> does simply by checking whether the first field is non-empty.

Haven't looked at the proposed patch very carefully, but the design
looks sound.  The above output screams "empty! nothing!", and I do
not think there is any other way :: will show up in that position.

> Also, does it make sense to write a new test to accompany the fix to
> the first (streaming) issue?

Would it be tricky to write safely not to get stuck?  You feed one
line, stop feeding, while checking that the output has arrived, and
then kill the whole thing?  Feels somewhat yucky, but sounds doable.
