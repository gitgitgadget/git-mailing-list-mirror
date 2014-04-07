From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/22] rollback_lock_file(): set fd to -1
Date: Mon, 07 Apr 2014 09:37:19 -0700
Message-ID: <xmqqfvlpnlj4.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>
	<20140401195930.GC21715@sigill.intra.peff.net>
	<xmqqtxabwtw8.fsf@gitster.dls.corp.google.com>
	<5341CAE2.8040600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 18:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXCYA-00059A-Rv
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 18:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaDGQha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 12:37:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbaDGQh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 12:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8420778DB9;
	Mon,  7 Apr 2014 12:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d9iXT5Bygg1WmNvtfdoOQ8IfWNE=; b=I0IQJe
	V07EDxNUPXXQdFCmzOvYVXS61yn054uyjhbW6670Df1DU4lO8hSc8OqIKjwG5a8p
	Y4UayZsIQpII8l4D3rMjkQl8IUTEDvyAhaZBdrlr9bV6059daEouE2ygLVb8QiBK
	rxi3eZ7Jbh86D3O/N6JHXKONuUiiC3rFVQoBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUNw0GdtZVOkDQ/h0HGUGWgGbjGgIpck
	hPQRFLZoHZW1RABFgL9AoknwLK+Hcu7dQeYjWNf216cfyOyMr1lLxksc7PvE6q68
	htRFWVqtGxeDFkt8mksEBkm6rvU5WsjYJOJ0h3oMAoVj/biE1sz5a6mGnAOU3Vtk
	3wvLRQ3pfy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 700A478DB8;
	Mon,  7 Apr 2014 12:37:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BE4A78DAC;
	Mon,  7 Apr 2014 12:37:21 -0400 (EDT)
In-Reply-To: <5341CAE2.8040600@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 06 Apr 2014 23:45:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E430C00A-BE72-11E3-800C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245864>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The first use of a lock_file object necessarily passes through
> lock_file().  The only precondition for that function is that the
> on_list field is zero, which is satisfied by a xcalloc()ed object.
>
> Subsequent uses of a lock_file object must *not* zero the object.
> lock_file objects are added to the lock_file_list and never removed.  So
> zeroing a lock_file object would discard the rest of the linked list.
> But subsequent uses must also pass through lock_file(), which sees that
> on_list is set, and assumes that the object is in a self-consistent
> state as left by commit_lock_file() or rollback_lock_file().
>
> At least that's how it is supposed to work.  But lock_file objects are
> in fact not cleaned up correctly in all circumstances.  The next version
> of this patch series will work to fix that.

Thanks; I see the next round already posted to the list.
