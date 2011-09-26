From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
 number links
Date: Mon, 26 Sep 2011 12:27:43 -0700
Message-ID: <7v62kf2jf4.fsf@alter.siamese.dyndns.org>
References: <1317060642-25488-1-git-send-email-peter@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Mon Sep 26 21:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GqE-0002FU-HS
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab1IZT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 15:27:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab1IZT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 15:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C49B5CF4;
	Mon, 26 Sep 2011 15:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VlLpJfRZepARXeqbQ6aVRK2L29w=; b=B1dmfa
	X6iSzpCsJEWyuR0TROViRJdw/r5odUlRRTILotU2cFkTpYlHCKPGkSPlHxAIChx0
	+gAmUctFoRVLGu36TXUbyAmMF9JxVfkEyWfTKQUzKAKqgz51lQZUBAIyLGEpAeYH
	1EYcqNcywxJ/ED5Mhns/cmvPI2s3PRvoGvcZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gshAmuQXygnTmRAoaKjFDjAP6aLAbGVX
	VDB29/Uj8oJRQwfJTrkzjPhoBIw6JPKCfRiRL/6On6gU+9f/rZReXn1ra/QHlYoO
	JtAhuUetJkQRnuWjzVYbLEiPnoIaT7mwUbAatxuoDSdkDwoLIgu4P8OgbIOt4CF6
	kthwKB3KAYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246D35CF3;
	Mon, 26 Sep 2011 15:27:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ADFD5CF1; Mon, 26 Sep 2011
 15:27:44 -0400 (EDT)
In-Reply-To: <1317060642-25488-1-git-send-email-peter@stuge.se> (Peter
 Stuge's message of "Mon, 26 Sep 2011 20:10:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BEAD22A-E875-11E0-8841-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182154>

Peter Stuge <peter@stuge.se> writes:

> Signed-off-by: Peter Stuge <peter@stuge.se>
> ---

Care to elaborate a bit more please?  Explanation of what you are fixing
is totally lacking.  What happens with the current code, why it is wrong,
and how the updated pattern improves the result in what way?

>  gitweb/static/js/javascript-detection.js |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/js/javascript-detection.js
> index 93dd2bd..003acd1 100644
> --- a/gitweb/static/js/javascript-detection.js
> +++ b/gitweb/static/js/javascript-detection.js
> @@ -16,7 +16,7 @@
>   * and other reasons to not add 'js=1' param at the end of link
>   * @constant
>   */
> -var jsExceptionsRe = /[;?]js=[01]$/;
> +var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
>  
>  /**
>   * Add '?js=1' or ';js=1' to the end of every link in the document
> @@ -33,9 +33,9 @@ function fixLinks() {
>  	var allLinks = document.getElementsByTagName("a") || document.links;
>  	for (var i = 0, len = allLinks.length; i < len; i++) {
>  		var link = allLinks[i];
> -		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
> -			link.href +=
> -				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
> +		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01](#.*)?$/;
> +			link.href = link.href.replace(/(#|$)/,
> +				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1$1');
>  		}
>  	}
>  }
