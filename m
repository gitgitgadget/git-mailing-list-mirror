From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/27] update_refs(): Fix constness
Date: Mon, 31 Mar 2014 15:38:50 -0700
Message-ID: <xmqq38hy2dtx.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-7-git-send-email-mhagger@alum.mit.edu>
	<xmqqha6e3v44.fsf@gitster.dls.corp.google.com>
	<5339E948.4090109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:39:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkr7-0004VY-P9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaCaWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:38:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbaCaWiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:38:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE20797A6;
	Mon, 31 Mar 2014 18:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6jC/n2RRzk5cH1kxGA3KHrc+OoU=; b=IxAgCz
	UsqhY5ah0cITZQGlC7qCmpeSiR4nxQ8ZeCpM7/mghwV9A+0CmMaXcXCuPuDZOHi4
	hhBY9HXDsvPSg3iKjWzT5QPJCS2PiiZPl5boMhK2ibfu+TxFhKBR5WKNP+Ahiwhk
	Wp2tfJ5kPOjsZWEij4joPFtTJTO86UO4KhyO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qmdbf5I6aSyh9wvE87tfHhA8tdMOFoDy
	i1cm1+oa4wl+ojgKFQqlSjriVVbJLj7VbmlVAftQMKPA8ITXe8ZJN3Lc9TPTllCk
	xLvuXl65xbTCSuEd22KMEz/DxwEXWaIBU8nbXERZ+/40w9VqTM50Yd7c0yEHmJq8
	vye0P4Q1JGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB7F797A5;
	Mon, 31 Mar 2014 18:38:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 502E5797A4;
	Mon, 31 Mar 2014 18:38:54 -0400 (EDT)
In-Reply-To: <5339E948.4090109@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 01 Apr 2014 00:16:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3D3A7D06-B925-11E3-A5B6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245563>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/31/2014 11:40 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Since full const correctness is beyond the ability of C's type system,
>>> just put the const where it doesn't do any harm.  A (struct ref_update
>>> **) can be passed to a (struct ref_update * const *) argument, but not
>>> to a (const struct ref_update **) argument.
>> 
>> Sounds good, but next time please try not to break lines inside a
>> single typename, which is somewhat unreadable ;-)
>> 
>> I'd suggest rewording "s/Fix/tighten/".  Because a patch that
>> changes constness can loosen constness to make things more correct,
>> "git shortlog" output that says if it is tightening or loosening
>> would be more informative than the one that says that it is "fixing".
>
> It is not a strict tightening, because I add a "const" in one place but
> remove it from another:
>
>     const struct ref_update **
>
> becomes
>
>     struct ref_update * const *
>
> in the update_refs() signature.  In fact, the old declaration was too
> strict for some changes later in the patch series, which is why I needed
> to loosen (one aspect) of it.

Interesting.  Then that _is_ a fix.  Thanks for explaining it to
me.  As always, I would prefer it be explained to the proposed
commit log, not to me over an e-mail ;-)
