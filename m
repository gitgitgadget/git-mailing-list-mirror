From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] usage: Introduce error_errno corresponding to
 die_errno
Date: Sun, 08 May 2011 11:10:53 -0700
Message-ID: <7v39kpt64y.fsf@alter.siamese.dyndns.org>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
 <1304839851-6477-1-git-send-email-artagnon@gmail.com>
 <1304839851-6477-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ8Ry-0004HI-IR
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 20:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab1EHSLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 14:11:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab1EHSLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 14:11:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 438A150C2;
	Sun,  8 May 2011 14:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gG9r5u3l4pcNzcpKw+gj2lwl+sE=; b=Hdbyiq
	pHkC6iVS+tac7aNMv5yL0ms9C2SvphIVKXTZ44MomUk5edf9+/epa3LaA3kMZa2P
	PsudPkV6wQg9IOpPjT7X1cN9VCA4gQdh4qfHpoe/YlCgcFjhNdQp64/sfjMUjL5g
	YcipTMedu+8/ukNMOsHH+GqLAavb6WhDlYZuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SxFuvEsLsX9UblhS2/y6kKIUg6I8NxYz
	Do44ZT6pL5242Osuc7tu2E1q57jn19s/Djye5vtNmeo4d2CCl79Gy4a+NWJmiVLp
	r8djc6cFnwRACTI/loMqKCaiDSDOgspw8DulAVDUDuLXh6JUvoyNMLrhUUgVSrb8
	jUlHJ6OwyNs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 032A150C1;
	Sun,  8 May 2011 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 885F150C0; Sun,  8 May 2011
 14:13:00 -0400 (EDT)
In-Reply-To: <1304839851-6477-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 8 May 2011 13:00:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D230201A-799E-11E0-A425-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173169>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 40498b3..7b82038 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -241,6 +241,7 @@ extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf,
>  extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> +extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));

Anybody remotely familiar with die_errno() would at least expect that the
new and improved error_errno() function would give the errno neatly
formatted via strerror() in the message, but that is not what the function
does.

> diff --git a/usage.c b/usage.c
> index b5e67e3..c89efcc 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -107,6 +107,16 @@ int error(const char *err, ...)
>  	return -1;
>  }
>  
> +int error_errno(const char *err, ...)
> +{
> +	va_list params;
> +
> +	va_start(params, err);
> +	error_routine(err, params);
> +	va_end(params);
> +	return -errno;
> +}

Can error_routine() do something to cause errno to change?

For that matter, I suspect that the caller who would _care_ about what
kind of error it got would need to save it away itself anyway.  For
example, it is not entirely clear if the callsite of this function in your
other patch is correct.  Can rollback_lock_file() cause errno to change?

	git_config(git_rerere_gc_config, NULL);
	dir = opendir(git_path("rr-cache"));
	if (!dir) {
+		int err = errno;
-		rollback_lock_file(&write_lock);
-		return error_errno("Unable to open rr-cache directory");
+		error("Untable to open rr-cache directory: %s", strerror(err));
+		return -err;
	}

I would prefer to do without introducing a confusingly named API function
whose first and only usecase does not even suggest it would be useful.
