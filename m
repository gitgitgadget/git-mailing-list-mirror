From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 12:45:43 -0700
Message-ID: <xmqqk363t060.fsf@gitster.dls.corp.google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu> <20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKBpY-0000RS-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 21:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaHTTp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 15:45:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaHTTp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 15:45:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0E4031250;
	Wed, 20 Aug 2014 15:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G6JhUSur8MoKtCO8dUlu0bCarhs=; b=Dl88Rl
	+8OMnhfWLOENfNg+lfc3jJwc06LjKYxAkzQjLkKtDnvTvJCOvdbt9gUzyFcJW/Je
	reOpQALMzOwWEugPx/TnTqkLqtOG/2k1mJ0XV8YN/e6N9ZzocCPkW2h4LO/UEO4V
	l7DFJ8zpKGJqlSkORtHTcciaC+v5D8zH8RSq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rn/IfDCweo1o+kZx0teJbxXgWBrBSG8J
	VIv3k5T8+Z8BfQLfk9Cbswgsh21JHvgbQpmwYKt58lLsqqLdEagi2KgVuipUBUuW
	oSsaD43RvTBSzWUIKCxZu+dmkTtmYphLgKccy1oJTjAbQ1lIjxQWFpt229LJ/gQ+
	0IEqG39COT4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C68913124F;
	Wed, 20 Aug 2014 15:45:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E04173122B;
	Wed, 20 Aug 2014 15:45:44 -0400 (EDT)
In-Reply-To: <53F4B642.7020002@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 20 Aug 2014 16:52:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9350D3B0-28A2-11E4-B8A1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255583>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think we can get away with not including broken refnames when
> iterating.  After all, the main goal of tolerating them is to let them
> be deleted, right?

Or read from a ref whose name has retroactively made invalid, in
order to create a similar but validly named ref to serve as its
replacement?  So at least we need to give the users some way of
reading from them, in addition to deleting them, no?
