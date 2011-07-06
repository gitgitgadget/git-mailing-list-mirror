From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Wed, 06 Jul 2011 10:57:55 -0700
Message-ID: <7vliwbmgv0.fsf@alter.siamese.dyndns.org>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1309970337-6016-2-git-send-email-rctay89@gmail.com>
 <1309970337-6016-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 19:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWMO-0000uu-Ey
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 19:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab1GFR6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 13:58:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab1GFR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 13:57:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B12FC50BD;
	Wed,  6 Jul 2011 13:57:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DRrjuUkPTNAkuQ8eNCh4N7eoRjg=; b=eh1yW2
	10DUrDsXWS0Cj24CL6n+i3YlR1NzyRg4nfOkgHgJR5XgYXVh9XhoFsKnE2U5m80d
	6Mz8reVIcHeUaC4MCgFGSggRQItDNoLCe5hWZktYJ2Phq3wJ75qZvL7uvrCfVyyH
	c/B00Jaxt9dQ5747xYy4CWO1MgqisHQBEY1vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+/I+9ZfZtzTKWPSgPi1s7wD63g7c+fy
	nq0pwjt/Ee8eQLftYEtDeXr5CNf9hwxQM5rhzdNo1RuqqsldBJHjnk20B6yCZeRO
	vueml4BeAlSi0osxjV8B2Y9ZLfkOhzrLbGyrYo2aS336UhHT6OyOlyZnLSYPWA09
	J73Zed/lOYE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A98CD50BC;
	Wed,  6 Jul 2011 13:57:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18DF650BA; Wed,  6 Jul 2011
 13:57:57 -0400 (EDT)
In-Reply-To: <1309970337-6016-3-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 7 Jul 2011 00:38:55 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ADCE67A-A7F9-11E0-A7D5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176717>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Group free()'s that are called when a malloc() fails in
> xdl_prepare_ctx(), making for more readable code.

Nicer, but I wonder if we can get away with a single label that lets us
abort with freeing whatever we have allocated by making sure that the
various pointer fields and variables are initialized to NULL, which may
lead to even more readable code.
