From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Thu, 07 Jun 2012 13:42:29 -0700
Message-ID: <7v8vfyg8ga.fsf@alter.siamese.dyndns.org>
References: <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScjXR-0002PY-8S
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008Ab2FGUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 16:42:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756991Ab2FGUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 16:42:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B97B8F69;
	Thu,  7 Jun 2012 16:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLduPtVyfKJZlRz+QRUzp2Lk/aE=; b=ybjRkE
	9orzwLQKiVRFjjcnE6WuF59XjFjW5RvFxDrD2X2bA9lvxmuQ8egUyMA4lRGbikFe
	p86Tx1AoJwe7PFhgtbNfIhi2nXRh6XBtyHyuWj4xRs4jiAhb++Piba+cVjh8PiiK
	Sa317ksJ3xv25UQtCTqOYb4CfYVEnAEZYEQxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wA3ZIez/pjI3spEtqi8eHZ3gv6i2Oh1v
	vZiy1gmOjf59Dd2TYRjyM2TU0MvjrtWlHjR5pKIWMU1P+vXI8leSR1WFKh39dXcj
	3uNW3WwesD1S5YJC4iUjqBkxptQIeY6wcE37FS9oVyqvDoW1J2YXF7uwqCjCLPzM
	y+jVdr0nygE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C478F68;
	Thu,  7 Jun 2012 16:42:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5BBE8F67; Thu,  7 Jun 2012
 16:42:30 -0400 (EDT)
In-Reply-To: <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Thu, 7 Jun 2012 15:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D649264-B0E1-11E1-9539-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199448>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> +static char *read_line_from_git_path(const char *filename)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *fp = fopen(git_path(filename), "r");

We currently do not pass any filename with per-cent in it, but that
call should be git_path("%s", filename) for sanity.
