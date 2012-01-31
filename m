From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Tue, 31 Jan 2012 12:14:14 -0800
Message-ID: <7v8vkn8wa1.fsf@alter.siamese.dyndns.org>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:14:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsK5v-0005Xw-AL
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 21:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab2AaUOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 15:14:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab2AaUOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 15:14:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 846847DF6;
	Tue, 31 Jan 2012 15:14:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vMf2cDzP8nQoYdjjyPkA8rwGKLk=; b=rl0JTZ
	n0qMEaRviZbkz8/af1D7onCeX86iJQ+9N8anxPgdW2USaaZncFZO1PWFaNrym50Z
	5Z2dqG4I7MeRw1Dxeyacq3AkDPvRiF+WjDzyjhcRYuDA+KTTHAlWmgz2td/68uyg
	LmXrXuoHiocT1RdrdwAzM6yyii6SQkpU3/cqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PO2mLkEL48svSGkk4UlfkZFkLKl5w6Zd
	rgaCDCQBdc4OAKfl2xttsqFyAykha+JeLLpgHvhuTjc/ByU0J2OoiEoviK+92m3P
	uoCfg2cbRBXn/sP/39qr+RD73a5Wt/dmojGtGBb8VkR4LdcA/ynM8GF4NwHrM4rc
	p28dDPiaLDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9AE7DF5;
	Tue, 31 Jan 2012 15:14:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 133157DF4; Tue, 31 Jan 2012
 15:14:15 -0500 (EST)
In-Reply-To: <20120131192053.GC12443@burratino> (Jonathan Nieder's message of
 "Tue, 31 Jan 2012 13:20:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 263FC68E-4C48-11E1-A0FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189469>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 		off_t delta_len = off_t_or_die(len, "enormous delta");
> 		postimage_len = apply_delta(delta_len, input, ...);
>
> What do you think?

Another possibility would be to make the "die" part responsibility of the
caller of the helper function, e.g.

	if (value_out_of_range(off_t, len))
		die("enormous delta");

which may make the caller easier to follow and the helper easier to reuse.
