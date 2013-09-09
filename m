From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] version-gen: avoid messing the version
Date: Sun, 08 Sep 2013 22:51:14 -0700
Message-ID: <7vtxhuilv1.fsf@alter.siamese.dyndns.org>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
	<1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 07:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIuNi-0003cM-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 07:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab3IIFvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 01:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab3IIFvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 01:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E1639CF5;
	Mon,  9 Sep 2013 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/86PgT6KwqsrXaN+5FmYmBe6yE=; b=YeHjKr
	9rsIbQGRuAlCeF/WP6ICh12OkmGJtD0jd346JPbIQUVxY+JXPrkiFNcgSlJv2tYv
	80EHhS7+PQO0JkD+mRsooqVbYcXrBU60AeCU4NlQq1zD6mIXrtmfplImcY/W8kXz
	PzEjFFKtvKi11SoOH0U5CVe9EyD0yqQ9TDHfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jcZMuyLdh8euyEAiwYmyi/1DSUjPsNr4
	wV/hhzi3dYC/4RPwAnFDO8OKVwqcwRA+nmfREDLm59PLV2Q6yyn8yMFfnVVtJZkI
	Qn8kvMq1ZD4wBYA+E32jHztLm4Zq9qORXBnqWcpCqlX6S+W89eztEyqh0itrkUeU
	mg0N7zda1F4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E819239CF3;
	Mon,  9 Sep 2013 05:51:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67FE639CE9;
	Mon,  9 Sep 2013 05:51:17 +0000 (UTC)
In-Reply-To: <1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 9 Sep 2013 00:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D87DF7E6-1913-11E3-A0D4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234312>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If the version is 'v1.8.4-rc1' that is the version, and there's no need
> to change it to anything else, like 'v1.8.4.rc1'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  GIT-VERSION-GEN | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index b0db139..2b9fd2f 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -24,7 +24,6 @@ then
>  		VN="$VN-dirty"
>  		;;
>  	esac
> -	VN=$(echo "$VN" | sed -e 's/-/./g')
>  else
>  	VN="$DEF_VER"
>  fi

The log message of 5c7d3c95 (Allow building of RPM from interim
snapshot., 2006-01-16) leaves a lot to be desired, but I do remember
that this was added due to user request.  Before that commit, we did
not strip dashes, and RPM packaging did not like dash in the version
name, hence folks on RH and derived distributions could not package
the software out of the box themselves.

I do not offhand know if that RPM limitation was lifted.  I do not
know if there are other packagers with a similar limitation that
have been relying on this version mangling, either.  This change may
end up being a regression for these users.

The mangling is done only for auto-generated names, so I suspect
that anybody who wanted the dash in their version names for whatever
reason has already been using the "version file" escape hatch (or
nobody had a desparate need to use dash instead of dot).
