From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/gitk: Document new config file location
Date: Tue, 18 Mar 2014 13:07:56 -0700
Message-ID: <xmqqr45z6zj7.fsf@gitster.dls.corp.google.com>
References: <1395165187-3629-1-git-send-email-astrilhayato@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Astril Hayato <astrilhayato@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 21:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ0Iu-0003gV-PV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 21:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbaCRUIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 16:08:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109AbaCRUH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 16:07:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAEBE7392E;
	Tue, 18 Mar 2014 16:07:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=91Zvu76dyHC985sws0d6HV8M09g=; b=uOn8XX
	5WqFjuvz8utmTWjPSU4FCTVvHUUvQHResP/ijAXJjy1o06gse9NxHNcpylKrTclf
	ftOjmiDBYTQaWWVVd9ztsI7x2EI0GHiphkmef2XW+k9y7IL7OUD0PUlHeQ/Btz8L
	ugtKHkmedYPRoCJtODoJ9evubyq7FBMzLwfKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOrCZlhVK5Q3Rt4mGZ8IJ91owF/a7w6J
	0HClg0Gfy9lysU1ql9RlsWVDuN8wYfxImDPpoh9TRLRd33CCwl4KPLtrP2bKWvlu
	g62ZjOXwqGVky8+9kDPEAIT7uEN/MvmX3gJeqY2mCZbdQOpby2twhCvWlLwD0lOQ
	ePA28CeHF/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7B837392D;
	Tue, 18 Mar 2014 16:07:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0942A7392A;
	Tue, 18 Mar 2014 16:07:57 -0400 (EDT)
In-Reply-To: <1395165187-3629-1-git-send-email-astrilhayato@gmail.com> (Astril
	Hayato's message of "Tue, 18 Mar 2014 17:53:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFE2E822-AED8-11E3-81C8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244380>

Astril Hayato <astrilhayato@gmail.com> writes:

> User config file location now complies with XDG base directory specification
>
> Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
> ---
>  Documentation/gitk.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index 1e9e38a..c2aa514 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -166,8 +166,13 @@ gitk --max-count=100 --all \-- Makefile::
>  
>  Files
>  -----
> -Gitk creates the .gitk file in your $HOME directory to store preferences
> -such as display options, font, and colors.
> +User configuration and preferences are stored at (in order of priority):
> +
> +* '$XDG_CONFIG_HOME/git/gitk' if it exists and '$XDG_CONFIG_HOME' is set
> +* '$HOME/.config/git/gitk' if it exists
> +* '$HOME/.gitk' if it exists
> +
> +If none of the above exist then '$HOME/.config/git/gitk' is created and used by default.

The last line is a bit of a lie, isn't it?

If XDG_CONFIG_HOME is set to an non-empty string, config_file is set
to $XDG_CONFIG_HOME/git/gitk.  Otherwise config_file is set to
$HOME/.config/git/gitk.

After that happens:

 - if that file exists, it is used;

 - otherwise:

   . if $HOME/.gitk exists, we use it (in other words, $HOME/.gitk
     is never used unless the user is an old timer who has one);

   . if $HOME/.gitk does not exist (in other words, if none of the
     above exists), then an empty $config_file is created and used.

We use either $HOME/.config/git/gitk or $XDG_CONFIG_HOME/git/gitk
and never $HOME/.gitk when none of the above exists, and the choice
between the two depends on XDG_CONFIG_HOME.

I'll queue this patch as-is, but we may want to further clarify with
a follow-up patch.

Thanks.
