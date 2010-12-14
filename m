From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] lib-git-svn.sh: Add check for missing mod_dav_svn
 module
Date: Tue, 14 Dec 2010 11:11:03 -0800
Message-ID: <7v8vzsuq48.fsf@alter.siamese.dyndns.org>
References: <4D07B63A.2020501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net,
	avarab@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:11:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaHS-0001Ce-TY
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294Ab0LNTLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:11:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131Ab0LNTLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:11:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22F702CA7;
	Tue, 14 Dec 2010 14:11:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ctyuth9Viuo2D4HlbUWNO8fTa+Y=; b=qfX2bc
	FySSCZDNjZE2NgIu0BNoj1vGC+2ssDvCUFNkoM3pvhcvY7YdQsMeW52uqrl5uy9m
	PYsUo/6eAXjKCDtQSIat1GoGrOPxSWcz6GGwJI4tZJK0HuUKcM8//TsrwFzZ64pO
	Q/Vv4wCrNdUM8UBkvlqfNSGUFD+ucvJSijPLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxsFFAjZMJFkGe9U1L2n0fjUEJNeSaAx
	CfXDxuOo6L+vSu4ta9lS7p8GNbf7yM5diM52krk0saHhsf0VIiLyl+AZwfzWQEdq
	N0oNPmZM3NryTLahwKELD5y6EAwkbrJaNRUZNT0ujHdptOnwnzTgphtSN7g8+OLm
	qeCMctgMUgo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D46F02CA6;
	Tue, 14 Dec 2010 14:11:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53DB82CA3; Tue, 14 Dec 2010
 14:11:31 -0500 (EST)
In-Reply-To: <4D07B63A.2020501@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 14 Dec 2010 18\:23\:54 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8F3CF9A-07B5-11E0-A774-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163677>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  t/lib-git-svn.sh |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 919d45a..154f3d3 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -101,6 +101,11 @@ start_httpd () {
>  		echo >&2 'SVN_HTTPD_PORT is not defined!'
>  		return
>  	fi
> +	if test ! -e "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
> +	then
> +		echo >&2 'Apache module "mod_dav_svn.so" not found'
> +		return 1
> +	fi

Others seem to check with "test -f" for things like this.
Also why "return 1" only on this codepath?

>  	if test -z "$repo_base_path"
>  	then
>  		repo_base_path=svn
> @@ -128,6 +133,7 @@ EOF
>  
>  stop_httpd () {
>  	test -z "$SVN_HTTPD_PORT" && return
> +	test ! -e "$GIT_DIR/httpd.conf" && return
>  	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
>  }
>  
> -- 
> 1.7.3
