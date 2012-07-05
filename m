From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] gitweb: Add support to Link: tag
Date: Thu, 05 Jul 2012 15:29:00 -0700
Message-ID: <7vd349rger.fsf@alter.siamese.dyndns.org>
References: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
 <1341370046-19913-3-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuXw-0005Rf-SJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144Ab2GEW3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:29:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755920Ab2GEW3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:29:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C969027;
	Thu,  5 Jul 2012 18:29:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YR17f8iW9orAjnkXl1Cp+v/uGcU=; b=pv5B6l
	3h6Czc/rO9HvCQfTO1GGjrMLpuIQUD+CkhEY+LVQ4m3/G4UC8q6V8SD2+STkjq4E
	3wW4w3gKnU7j/lR7o1HCPC9Yu2UY+ZAa/vY6SJqdru5fvqTT+TnP56ra9q07r4nt
	UvlEvT/JyreTsZaLslNQ1etEQIGOZxi+Na4B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+YmKXugIr8PzKQrffptYWvF3+a4FxLd
	nskuYhuls8FFvHyePSd33cn0q2z4YahqBpadYIoIMMTU0ZRvdrABmzloUYiIkV0f
	11VfpHjBWtKOUIxY25D71H9zrLK3DgzBaMoUrjWGSK8C2UkF3gD5TWfR8sKSQcHq
	NPAe/1tyssc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B6199026;
	Thu,  5 Jul 2012 18:29:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E09019024; Thu,  5 Jul 2012
 18:29:01 -0400 (EDT)
In-Reply-To: <1341370046-19913-3-git-send-email-namhyung@kernel.org>
 (Namhyung Kim's message of "Wed, 4 Jul 2012 11:47:26 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D23A5A08-C6F0-11E1-A371-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201071>

Namhyung Kim <namhyung@kernel.org> writes:

> The tip tree is the one of major subsystem tree in the
> Linux kernel project. On the tip tree, the Link: (or
> similar Buglink:) tag is used for tracking the original
> discussion or context. Since it's ususally in the S-o-b
> area, it'd be better using same style with others.
>
> Also as it tends to contain a message-id sent from git
> send-email, a part of the line would set a wrong hyperlink
> like [1]. Fix it by not using format_log_line_html().
>
> [1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  gitweb/gitweb.perl |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 362784d..3d6a705 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4494,6 +4494,16 @@ sub git_print_log {
>  			next;
>  		}
>  
> +		if ($line =~ m,\s*([a-z]*link): (https?://\S+),i) {
> +			if (! $opts{'-remove_signoff'}) {
> +				print "<span class=\"signoff\">" . esc_html($1) . ": " .
> +					"<a href=\"" . esc_html($2) . "\">" . esc_html($2) . "</a>" .
> +					"</span><br/>\n";

Thanks.  Is the first use of esc_html($2) correct (I am always
confused between esc_html, esc_param and esc_url)?

> +				$skip_blank_line = 1;
> +			}
> +			next;
> +		}
> +
>  		# print only one empty line
>  		# do not print empty line after signoff
>  		if ($line eq "") {
