From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/19] pathspec.c: move reusable code from
 builtin/add.c
Date: Fri, 28 Dec 2012 12:32:43 -0800
Message-ID: <7v8v8hj4t0.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-17-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Togc6-00064H-4u
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab2L1Ucs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:32:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab2L1Ucq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:32:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAAEBA87D;
	Fri, 28 Dec 2012 15:32:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RCH6CDFBE8k3hqsyZcLuMxDhs6M=; b=P7XE08
	bss7DEjfWyDr1xEi7ZynUKl0epPEnvauYuSqSMD5Rqpy59ZRpk8lJCoZGp+NEhIK
	Gf276cy0QFg5+enXmYLAX7w0bePOSMZkeBC7pqj+Pf8IvCcwIeUHB/cjYJ+jfKCD
	/9CwEWpOlAnH4mAXdauBPUnUzisLzjqfxa7X0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sAb8Z93g8qnJ46eget9lDl2jBK+KlHFM
	YaOh9sW0ps6j39YwEcknPX4F4Km5v5/kRiIQHaUIwlXupTt/0Vl9oXNYvjLCSYmQ
	DFbVMV2paVwP3TR6bS9CQI28447xvII39tm1yHVqVh/Kk9Gd5p1tN7zTU23aPmO/
	TDOO5mG+HSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C680AA87C;
	Fri, 28 Dec 2012 15:32:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42CC9A87A; Fri, 28 Dec 2012
 15:32:45 -0500 (EST)
In-Reply-To: <1356575558-2674-17-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC85F47A-512D-11E2-BF04-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212256>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/pathspec.h b/pathspec.h
> new file mode 100644
> index 0000000..8bb670b
> --- /dev/null
> +++ b/pathspec.h
> @@ -0,0 +1,5 @@
> +extern char *find_used_pathspec(const char **pathspec);
> +extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
> +extern const char *treat_gitlink(const char *path);
> +extern void treat_gitlinks(const char **pathspec);
> +extern const char **validate_pathspec(const char **argv, const char *prefix);

Protect this against multiple inclusion with "#ifndef PATHSPEC_H".
