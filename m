From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Fri, 06 May 2016 15:21:55 -0700
Message-ID: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com>
References: <1462529978-31322-1-git-send-email-rbraun@sceen.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Richard Braun <rbraun@sceen.net>
X-From: git-owner@vger.kernel.org Sat May 07 00:22:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayo8I-0000KQ-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 00:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899AbcEFWV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 18:21:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758670AbcEFWV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 18:21:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63ABB18DE7;
	Fri,  6 May 2016 18:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9z+klcq7z0UUL09KQMJXgSSYzM=; b=Npu6pi
	CHepjMS/iju4qxl1/nsbji/zPRFRUW3Yo6Of6Mt8fUWGIXFUcoBX5es0ravEg/tA
	aeIa/Kmloc+iThKFnsnny/UsvAHDFlgpu4+X44F8gG+tQckiSb0dFBqAL0WzFWMl
	9/ejpPaLJ9Ic1DRVEjUrk0rOlQgEaEfedlX0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkGgbN7HdWxHoBbIAORe8+Ovc6rMOP0u
	iZgpoErBkKv2zZoBxlV7ZgVF5LPJV9h8u2ADyIa60WwA6MMhJX4mHUCFbp8yI2Pl
	0wRL9brMJPNpGRINPIZDXOkuKlUMP+1IGPcmapzHmGRNVqsq7xlq2GuySkYI3hs+
	apywr6xppKE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C3F718DE6;
	Fri,  6 May 2016 18:21:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB6C618DDC;
	Fri,  6 May 2016 18:21:56 -0400 (EDT)
In-Reply-To: <1462529978-31322-1-git-send-email-rbraun@sceen.net> (Richard
	Braun's message of "Fri, 6 May 2016 12:19:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1A11114-13D8-11E6-9F7C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293865>

Richard Braun <rbraun@sceen.net> writes:

> Signed-off-by: Richard Braun <rbraun@sceen.net>
> ---

Could you justify your change with a bit more than "fix"?  That is,

    gitweb, when used with PATH_INFO, shows a link to parent diff
    like [fill in the blank].  However, it is wrong because [fill in
    the blank].

    Make it show it like [fill in the blank].  Because [fill in the
    blank], delete 'hash_parent' element from the %params hash once
    we used it; otherwise [fill in the blank to describe "this bad
    thing happens"].

or something like that.

Thanks.

>  gitweb/gitweb.perl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 05d7910..f7f7936 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1423,7 +1423,12 @@ sub href {
>  			delete $params{'hash'};
>  			delete $params{'hash_base'};
>  		} elsif (defined $params{'hash'}) {
> -			$href .= esc_path_info($params{'hash'});
> +			if (defined $params{'hash_parent'}) {
> +				$href .= esc_path_info($params{'hash_parent'});
> +				delete $params{'hash_parent'};
> +			} else {
> +				$href .= esc_path_info($params{'hash'});
> +			}
>  			delete $params{'hash'};
>  		}
