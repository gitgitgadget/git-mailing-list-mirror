From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Avoid overflowing page body frame with large images
Date: Wed, 19 Feb 2014 11:32:55 -0800
Message-ID: <xmqq38jeaoew.fsf@gitster.dls.corp.google.com>
References: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com>
	<A4E05D52-1CED-46FC-B137-BCDFAD638E1D@kellerfarm.com>
	<C66B1A3C-7148-4514-B385-537E0BB6E187@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Tony Finch <dot@dotat.at>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 20:33:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGCtJ-0002z9-1r
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 20:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbaBSTdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 14:33:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbaBSTdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 14:33:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A40506C1D5;
	Wed, 19 Feb 2014 14:33:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=du6z9SkY2IjCr6ViJfMhqg7Mz6M=; b=LuAOTH
	WRffLKInuFr8RWPqN6m/0BgGZe3csDco3fMRTg/30M6jPDLLhYpVWYdpKRuvIYYq
	LawPl7n5lMxqBfHB31bSUCT2quisxVl6K1eDhAfL2e2iq3cQvUWizYEBzvduOjEO
	IVoYdgDThcvC3iaXom17t9UQxpdK4yhph9hTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocA3JBCIBFm0nBLi++ItMXq22o87AvCC
	mwBV5mInwqXKjV5DLE3tgnp39xtwXCGFxJ/CLVlE7dbEh9mXwHAVk6cOMsYosB/0
	XWl01k48N4x6wCws92uGFI9r8hF4QuCvZ42x3rDL4DHIkMmvQzDZnQg81dPlHc+o
	moaPCKecbp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 784BA6C1D1;
	Wed, 19 Feb 2014 14:33:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C93536C1C7;
	Wed, 19 Feb 2014 14:32:58 -0500 (EST)
In-Reply-To: <C66B1A3C-7148-4514-B385-537E0BB6E187@kellerfarm.com> (Andrew
	Keller's message of "Mon, 17 Feb 2014 09:25:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A381031C-999C-11E3-812F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242399>

Andrew Keller <andrew@kellerfarm.com> writes:

> When displaying a blob in gitweb, if it's an image, specify constraints for
> maximum display width and height to prevent the image from overflowing the
> frame of the enclosing page_body div.
>
> This change assumes that it is more desirable to see the whole image without
> scrolling (new behavior) than it is to see every pixel without zooming
> (previous behavior).
>
> Signed-off-by: Andrew Keller <andrew@kellerfarm.com>
> ---
>
> This is an updated copy of this patch.
>
> Could I request a thumbs up, thumbs down, or thumbs sideways from those who develop gitweb?

I do not develop gitweb, but the change looks reasonable to me.

>  gitweb/gitweb.perl       |    2 +-
>  gitweb/static/gitweb.css |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3bc0f0b..79057b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7094,7 +7094,7 @@ sub git_blob {
>  	git_print_page_path($file_name, "blob", $hash_base);
>  	print "<div class=\"page_body\">\n";
>  	if ($mimetype =~ m!^image/!) {
> -		print qq!<img type="!.esc_attr($mimetype).qq!"!;
> +		print qq!<img class="blob" type="!.esc_attr($mimetype).qq!"!;
>  		if ($file_name) {
>  			print qq! alt="!.esc_attr($file_name).qq!" title="!.esc_attr($file_name).qq!"!;
>  		}
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 3b4d833..3212601 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -32,6 +32,11 @@ img.avatar {
>  	vertical-align: middle;
>  }
>  
> +img.blob {
> +	max-height: 100%;
> +	max-width: 100%;
> +}
> +
>  a.list img.avatar {
>  	border-style: none;
>  }
