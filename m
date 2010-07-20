From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-shell-commands: Add a command to list bare repos
Date: Tue, 20 Jul 2010 10:42:51 -0700
Message-ID: <7vlj96m4mc.fsf@alter.siamese.dyndns.org>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
 <1279602972-1264-3-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: j.sixt@viscovery.net, git@vger.kernel.org, avarab@gmail.com,
	jrnieder@gmail.com
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:43:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGqd-0006GD-Ci
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472Ab0GTRnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 13:43:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab0GTRnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 13:43:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFC2C6BBE;
	Tue, 20 Jul 2010 13:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwWIMIAtsYfu2hlcNQrAYpB2M7c=; b=GBrLad
	Sc8rfWDdh9vR0Csz+jlfO+yNNRhSRcmkXVJ3jpp8P70YWM0xh3NIede6XWCBggV8
	v50Tq7VItjMZ0iEZRlINE0pVamZIGhx7fw5LzStTkCX8noWi4bU7jNIWTgX2X09/
	uq7yDTmVVLtlKhcF5i/f4YfJaN3dLY+kKnu6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oAViaDOCpbWOq3k71tWBP36rZY6ze9JN
	vRf1ZVzfCtDOZTLgEF0yBXoccXtVSQpIBqfX3XW7B3nybHw9TNiyE85ywMJg65at
	ukUQ0DRr1G5MVB0MUjOzrRKAfJ020phEp0lwVym5dK5K98m7+wpUBzPT5jtAYkbE
	BsOau+xOgnw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5DF1C6BB9;
	Tue, 20 Jul 2010 13:42:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71572C6BAD; Tue, 20 Jul
 2010 13:42:53 -0400 (EDT)
In-Reply-To: <1279602972-1264-3-git-send-email-gdb@mit.edu> (Greg Brockman's
 message of "Tue\, 20 Jul 2010 01\:16\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CE9C816-9426-11DF-8AA5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151336>

Greg Brockman <gdb@MIT.EDU> writes:

> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---
>  contrib/git-shell-commands/list |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>  create mode 100755 contrib/git-shell-commands/list
>
> diff --git a/contrib/git-shell-commands/list b/contrib/git-shell-commands/list
> new file mode 100755
> index 0000000..cd8b15a
> --- /dev/null
> +++ b/contrib/git-shell-commands/list
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +set -eu
> +
> +print_if_bare_repo='[ "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true ] && echo "${1#./}"'

That's a very long line you have here.  It might be better to do split the
line perhaps like this for readability:

print_if_bare_repo='
	if "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true
        then
	        printf "%s\n" "${1#./}"
	fi
'

It is unclear why it limits its listing only to bare repositories.  "It's
my design decision" is a perfectly acceptable answer, but no matter what
the reasoning is, it needs to be documented as a part of "How to use this"
insn to the users.  A separate file README in contrib/git-shell-commands
that reads like:

	Any bare repository whose name ends with ".git" under your home
	directory is visible by "list" extended command (no other git
	repositories are visible).

would probably be a good start.

> +find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune

Also do you need "set -eu" at the beginning?  I don't see it serving a
useful purpose (other than being a development aid, that is).
