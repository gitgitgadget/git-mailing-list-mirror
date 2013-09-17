From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 09:26:13 -0700
Message-ID: <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
References: <20130831194425.GA14706@redhat.com>
	<xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
	<20130903210815.GB24480@redhat.com>
	<20130915074900.GA30438@redhat.com>
	<20130915080830.GA30465@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLy6W-0005br-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab3IQQ0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:26:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab3IQQ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:26:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF5640BC0;
	Tue, 17 Sep 2013 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AgQKRvo03yUASor1+rQXLrOei/I=; b=EfKf/x
	Bkty7P1RmalBAzq+E53I0mXf6IjDQ9stb2GNhFW5mbUDmFcZt+ZTUtA6UpYxUwvu
	kReLRkhshdaIvC6wFT8vhw3KxfimGs5aOpKQ9WkCtvexeIjGgiwYwWA/KXCZnCaU
	U5wzNc72FaOEWEK9f+TpOkVv+rbQiIK5SoCYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GcmrKkd0Y67+R78tR9aup/Z94rYdr+B9
	n+WOuCrNOgHibvrsTiPHlBDgkeaG7I3ztjrKSTlKcaw5QfqSwVcIjif6BWjlrFxd
	m/DLH9ty+Muc7FyDVFLIaE3KaR+Jmq6HsP11YHoiCqKnmc9ER8bLNEuc0x19Nrwa
	exyLCrsWlH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12FD940BBC;
	Tue, 17 Sep 2013 16:26:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76DFB40BB8;
	Tue, 17 Sep 2013 16:26:15 +0000 (UTC)
In-Reply-To: <20130915080830.GA30465@redhat.com> (Michael S. Tsirkin's message
	of "Sun, 15 Sep 2013 11:08:30 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFC43904-1FB5-11E3-A257-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234884>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Actually, after I've looked at the code,
> diffcore_order is already already called for patch-id.

That was a band-aid for an ill-thought-out orderfile misfeature to
hide the breakage.  You somehow make sure that you pass the same
orderfile to diff generating machinery used internal to patch-id
generation.  The standalone "git patch-id" would be reading the
patch in the order you give it when you are feeding a patch somebody
sent you via the mailing list using an order unknown to you, no?

Before making it _easier_ to use the orderfile to generate diffs, we
would need to prepare the parts that will be broken by wider use of
the feature.
