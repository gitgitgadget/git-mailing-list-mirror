From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 02 Feb 2012 12:02:27 -0800
Message-ID: <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2ri-0004JT-LW
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177Ab2BBUCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:02:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119Ab2BBUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:02:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98CB27092;
	Thu,  2 Feb 2012 15:02:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YjcL3nfzuXYo8XJT779uCFvdPXs=; b=n4riY4
	h420zwfinFbzfRr8mugAf40+q5DLZzGAujxfiGfiou14ej4PqOyuOM+m5z8lc5oo
	jxlHydFDs9XIYW/cePEIt15l/MjQ1LXyxCEktHqtBkwB568Cn+1K4ieQZUFRA6ZG
	Q9RS8HdL1Xxcrea0KKUy7A57wc/zRM5gwv6JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDWmDt0NyjSqV+5Tjvgq4+UdFWqDO+wg
	2MAuDPgvHmVtzPHCMz1rSgwDygZxvHB5RYYo6DVfOIJVHgHhxtbo5WleVqw4Y6W4
	tAyqnBUChKxk1HXLNP0TODW8C2S0fMEJFHE52HZ3TO+Az31bXdqxkK6QITmLmxSl
	CwVam9Qy0/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DBD57091;
	Thu,  2 Feb 2012 15:02:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 117E17090; Thu,  2 Feb 2012
 15:02:28 -0500 (EST)
In-Reply-To: <1328209417-8206-1-git-send-email-tytso@mit.edu> (Theodore
 Ts'o's message of "Thu, 2 Feb 2012 14:03:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5AAB0CA-4DD8-11E1-B09C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189688>

Theodore Ts'o <tytso@mit.edu> writes:

> diff --git a/INSTALL b/INSTALL
> index 6fa83fe..978ed09 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -28,8 +28,8 @@ set up install paths (via config.mak.autogen), so you can write instead
>  If you're willing to trade off (much) longer build time for a later
>  faster git you can also do a profile feedback build with
>  
> -	$ make profile-all
> -	# make prefix=... install
> +	$ make prefix=... profile-all
> +	# make prefix=... PROFILE_USE=t install

Thanks for a patch.  How does this compare with what was discussed in the
other thread?

  http://thread.gmane.org/gmane.comp.version-control.git/188992/focus=189172

I would wish a solution ideally would support

	make PROFILE_BUILD=YesPlease
        make PROFILE_BUILD=YesPlease install

or even

	echo >>config.mak PROFILE_BUILD
        make
        su make install

and I think your patch takes us in the right direction.
