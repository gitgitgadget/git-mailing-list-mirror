From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 13:03:41 -0800
Message-ID: <xmqqzjm67fpu.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<87ha8ewqfv.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:05:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnB3-0006S8-8N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712AbaBDVDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:03:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933696AbaBDVDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:03:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D51AF69ADE;
	Tue,  4 Feb 2014 16:03:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HdX+yr13TUQdNAD80GDnb/GCsG8=; b=v4fjaE
	1xzflLd1NYvICFuIAJanzSLkX8x0gkWD9rURe9OzJ9apIukw5d14a2ImSoRH6EW6
	O1M7TxjyK0tuBN5fXlyEVH4qskbTNANAef/70rBKJ9OOPgkMxxCT7YUhJVnCBZ9m
	tgFpZXVLsZNee0wJbrPnCtFK1tNhvOnGRFCiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LlJgbdrxRaWTlH/xHix271Faq5V64fBQ
	0ZjSidSxvwyZ6066XXO9reBDlRBWbgMgsdzyd+4J612i+GIZ3gd9oX8qOCEUPx5j
	KIpZJCQDHTt9wPeUOj/ssuRLsI30zij8cLq6vFXRAe83PGlkVVRqaIrok8jzC51H
	VlD4LBF/r0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F7669ADD;
	Tue,  4 Feb 2014 16:03:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76AB269AD5;
	Tue,  4 Feb 2014 16:03:43 -0500 (EST)
In-Reply-To: <87ha8ewqfv.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Feb 2014 21:52:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D49442A2-8DDF-11E3-B30B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241553>

David Kastrup <dak@gnu.org> writes:

> Anybody know offhand what I should be including here?  It looks like Git
> has some fallback definitions of its own, so it's probably not just
> <string.h> I should include?

In general, no *.c files outside the compatibility layer should
include anything "#include <system-header.h>", as there seem to be
finicky systems that care about order of inclusion and feature macro
definitions, all of which are meant to be handled by including
git-compat-util.h as the very first thing.
