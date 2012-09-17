From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Mon, 17 Sep 2012 13:39:36 -0700
Message-ID: <7vr4q0tmd3.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
 <20120909130532.GA27754@sigill.intra.peff.net>
 <7vhar7qd07.fsf@alter.siamese.dyndns.org> <504E62DF.5030408@alum.mit.edu>
 <7vhar5leal.fsf@alter.siamese.dyndns.org> <50571DC9.2030602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDi6g-0004ew-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab2IQUjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:39:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab2IQUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:39:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44B782C0;
	Mon, 17 Sep 2012 16:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fZl0Tx7hyrTzMtHjuwwsN6Zwp+o=; b=ZHx6Dj
	J9i0crmzPXavUmCFKuUsuer67G/Rb3WJm13K0udZ+3sIMRaganlzkfSrPDbDH/jg
	DFpYygBRb2KzEMQCTAI36u9loChXuH6U/4N06roWxXr+eqszNUChzPGGVFLRGN2C
	YWJ3y6Qu9REulr/mZSeW6k3qxzWizk3zzOrhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwi0x/yHro6JKbGyColmYwr5RX8RVYA1
	fufTp5ylkh7OnXDLocRb9Y+cQ6yDt7dq+rI3vFoe2FF4OGcwCKqdjxwLcFB3GDF3
	1dgIeqsSt/aXktjwTlvkaeVBtX75xRN5ougdwl5b7mBXe/bsvOWn9A7S59uSGw6u
	DVyBOI2jSsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D155E82BF;
	Mon, 17 Sep 2012 16:39:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C13182BD; Mon, 17 Sep 2012
 16:39:38 -0400 (EDT)
In-Reply-To: <50571DC9.2030602@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 17 Sep 2012 14:55:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC8028BC-0107-11E2-BE52-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205742>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is interesting that you consider the sort order of string_list to be
> somewhat of an internal implementation detail.  I had thought of its
> current behavior as being the obvious thing and considered it part of
> the API's contract.  For example, the current sort order is already
> observable via the API through iteration or by calling
> print_string_list().

You can prepare an unsorted string list that holds items in the
order you desire, and call print_string_list() on it.  I do not
think we ever promised to keep using the same sort order when you
allow the string list to use sorted insertion by calling the
"sorted" API functions.
