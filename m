From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] autoconf: remove some redundant shell indirections
Date: Wed, 18 Jul 2012 17:29:18 -0700
Message-ID: <7v394owq3l.fsf@alter.siamese.dyndns.org>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
 <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sred2-0002GN-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 02:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab2GSA3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 20:29:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2GSA3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 20:29:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84CB7870D;
	Wed, 18 Jul 2012 20:29:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4U3TmP2L5wdmwPOqeYNKEaDQ9P4=; b=S6eo+a
	rl0Q8DkKLXr8X2RWjuNsh/oKfzHPA2rm/2zkO9ZItYDIYw1KAoXKWz/GnfQgBs+u
	jkkX/55BSAlLLJn/SW4gJ4IVjqpLp7jaWDU1e3ms7OUJ9Wzz7oISDvyZj+GpWIPL
	H1jD1Dg3OgN7IHf8NAzIp/wVKcmEbMbRc15FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wh4wmmCObV7vqR7TW9xgFLctjvw84D9v
	AADKcVHQAiglVkgnOE6Teuj8HvxYaKy4qjKL143p1BX7RODCDUXQXiLeLoglWXO6
	7KK6e8XteRLkdlH+9EWueWQk4UVK7SlncVp/RJkIArMQTHTiXjFfcO7gMUAdMiXe
	KmR9BL0+KxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E75870C;
	Wed, 18 Jul 2012 20:29:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4A5E8707; Wed, 18 Jul 2012
 20:29:19 -0400 (EDT)
In-Reply-To: <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Thu, 19 Jul 2012 00:34:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7CA715A-D138-11E1-BADB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201709>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> diff --git a/configure.ac b/configure.ac
> index 789926f..9472f6b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -29,13 +29,12 @@ AC_DEFUN([GIT_ARG_SET_PATH],
>  # --without-PROGRAM is used.
>  AC_DEFUN([GIT_CONF_APPEND_PATH],
>      [m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
>      if test "$withval" = "no"; then
>  	if test -n "$2"; then
>  		GIT_UC_PROGRAM[]_PATH=$withval
> +		AC_MSG_NOTICE([Disabling use of GIT_UC_PROGRAM])
> +		GIT_CONF_SUBST([NO_]GIT_UC_PROGRAM, [YesPlease])
> +		GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])

Nice.

The inconsistency between the existing one that does not quote the
string that is not substituted, i.e.

	GIT_UC_PROGRAM[]_PATH=$withval

and the new one that quotes _PATH, i.e.

	GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])

looks somewhat strange, though.
