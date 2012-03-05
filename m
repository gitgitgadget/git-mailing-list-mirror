From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp)
 project search
Date: Mon, 05 Mar 2012 09:01:33 -0800
Message-ID: <7vd38r2d8y.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
 <201203041035.03133.jnareb@gmail.com>
 <7vfwdn631i.fsf@alter.siamese.dyndns.org>
 <201203050959.47966.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:01:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bI6-0006wk-MJ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2CERBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:01:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2CERBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:01:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ED0D6E00;
	Mon,  5 Mar 2012 12:01:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xrHDI9KoqcwJUfugaqetCmwrhg0=; b=r3KYJ7
	JYWvwkCCqpZLBTRodhFTxuiCmyKQGKCRY1UiwyRLtv65h2YpcGKhcIJE6NmrLEJI
	qNjkIRZgPbOoh0fvYV6XiS13+ttliQhbDIWKhwE4sBABvS8xValh8Z6crVbs5iPp
	kNWqzGDngWUrqaq7pWSN3av3oKlxGerKzOJcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvonASnPZQQ7fAo0mvS+RAYxKhttfUgO
	ug1B44YSW50Py7n3TcqmuexEG5Ktfrv206IMOSVAAp5tTBwBEoejO/RLZ9if4DcE
	fvnl90alv+14VT+1z26Y9slz4Kwgs1f+0aeJrRPQqVIGnUpK+Cp5IxXnDKg9lFk6
	CVQ8jqpFMVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46A046DFF;
	Mon,  5 Mar 2012 12:01:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5886DFE; Mon,  5 Mar 2012
 12:01:35 -0500 (EST)
In-Reply-To: <201203050959.47966.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 5 Mar 2012 09:59:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDDA5DD4-66E4-11E1-A448-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192253>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > And here is the patch for maint
>> ...
>> > +		if ($tagfilter || $search_regexp);
>> > +	# fill the rest
>> > +	@projects = fill_project_list_info(\@projects);
>> 
>> Hmph, didn't you already call fill_project_list_info(\@projects) before
>> search_projects_list() already?
>
> True.  Sorry about that. 
>
> Can you fix that, or should I resend?

Could you check the following two diffs?

$ git show debd1c2

This is jn/maint-do-not-match-with-unsanitized-searchtext that
should be merged to maintenance track that lack the lazy filling.

And then

$ git show --first-parent d4b52c2

This is how the above was merged to 'pu' and the conflict resolution
should be the same when we merge it to 'master'. As our @projects may
still be only sparsely filled when search_projects_list() returns,
we do call fill_project_list_info(\@projects) ourselves with the
lazy filling codebase.

There are a few places I noticed that check $searchtext to see if we
are running a search, and techinically $search_regexp might be a
more correct thing to use, but I do not think it matters that much.

Thanks.
