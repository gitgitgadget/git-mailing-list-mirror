From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 15:45:54 -0700
Message-ID: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
References: <7vd31o4dfu.fsf@alter.siamese.dyndns.org>
 <1347657228-16404-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCeeS-0007Vz-0i
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 00:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760276Ab2INWp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 18:45:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760169Ab2INWp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 18:45:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E055E9F46;
	Fri, 14 Sep 2012 18:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cbp6O+WUVuOJdNaITxEDevqam/o=; b=DKR7I+
	S38kDdqwwsmM1VSShHRMCj96zqkmw0UiLhoSX7GxWg0Qt581XZcl8kjBVOufXMTl
	IoQ0dtY2cKyHc8DJF3HhuMwhV6cnxoYI9MwhTfepQKa2BJindHIjRvEwkk1nK/0t
	rwu0NwF7tXoyx48a5JenRbhwzGbKL8g5cJXJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mq/I5WwlOy/judqghO3WM0GG59cGWLun
	GhCRjiOyhG3tuVk3yNQhOKcNXVLTQRlt/eqQVDKfarktL3Yyr9IWXq8MXucWaY6a
	MNmCBbhHVI59gd48CusI1bIUCR9eLr5l86O03TkNWZGRRYGFy8NGkEqIIYhMyKkc
	ze8gkmVjW8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC4E29F44;
	Fri, 14 Sep 2012 18:45:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3128A9F3F; Fri, 14 Sep 2012
 18:45:56 -0400 (EDT)
In-Reply-To: <1347657228-16404-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Fri, 14 Sep 2012 23:13:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F21D1D06-FEBD-11E1-AB4B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205539>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> +	if (option_mirror || !option_bare) {
> +		strbuf_reset(&value);
> +		if (option_single_branch) {
> +			if (option_branch)
> +				strbuf_addf(&value, "+%s%s:%s%s",
> +						src_ref_prefix, option_branch,
> +						branch_top.buf, option_branch);
> +			else if (remote_head_points_at)
> +				strbuf_addf(&value, "+%s:%s%s",
> +						remote_head_points_at->name, branch_top.buf,
> +						skip_prefix(remote_head_points_at->name, "refs/heads/"));

We have already set "remote.origin.url" to this repository, so the
next "git fetch" would simply fetch from "HEAD" per default.
Perhaps worth commenting that here?

Other than that, looks good.  Perhaps we would want a test or two,
too?

Thanks.
