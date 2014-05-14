From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Wed, 14 May 2014 14:57:32 -0700
Message-ID: <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
References: <20140514184145.GA25699@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Wagner <accounts@mwagner.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhBI-0002Mf-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbaENV5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:57:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58491 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaENV5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:57:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92135180FF;
	Wed, 14 May 2014 17:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d9cbqGAzdAzJmz58PAwJ+No/Zyg=; b=sTG76u
	dfl8dzgwR5c6lBQhkSBdRjCXLf4f2N72DFueqlqb6t23cCXWNRk06NdevexH1UPu
	Jwnv+5ztlGfAI73bVr8IZWBe1G37ZaMId+zewAE4KKs/E2jrL1h5DSMR0AsQEP6l
	yslR9vpaBQWlpY/6asuwVmuKvxXRSjwJhTJ0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfwJBfzyFirUX5yrUpzJZEaXnE7AFxue
	/e1O3wnzUQkywsPvu4nmsWs6fJMj1iy41d9BlP0l5B/46VoQfQrM7qHqFNSC238T
	3gtyFU/R6w69emCYk9NTbwKpc6MxOvrrOxImEhNICFNR3b9Jkc0mOhIDdy/89R7L
	xRssk8OaYqU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89517180FD;
	Wed, 14 May 2014 17:57:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C2B6180EC;
	Wed, 14 May 2014 17:57:34 -0400 (EDT)
In-Reply-To: <20140514184145.GA25699@localhost.localdomain> (Michael Wagner's
	message of "Wed, 14 May 2014 20:41:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1288FAE-DBB2-11E3-96ED-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249003>

Michael Wagner <accounts@mwagner.org> writes:

> Perl has an internal encoding used to store text strings. Currently, trying to
> view files with UTF-8 encoded names results in an error (either "404 - Cannot
> find file" [blob_plain] or "XML Parsing Error" [blob]). Converting these UTF-8
> encoded file names into Perl's internal format resolves these errors.
>
> Signed-off-by: Michael Wagner <accounts@mwagner.org>
> ---

Cc'ing Jakub, who have been the area maintainer, for comments.

One thing I wonder is that, if there are some additional calls to
encode() necessary before we embed $file_name (which are now decoded
to the internal string form, not a byte-sequence that happens to be
in utf-8) in the generated pages, if we were to do this change.

>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a9f57d6..6046977 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1056,7 +1056,7 @@ sub evaluate_and_validate_params {
>  		}
>  	}
>  
> -	our $file_name = $input_params{'file_name'};
> +	our $file_name = decode("utf-8", $input_params{'file_name'});
>  	if (defined $file_name) {
>  		if (!is_valid_pathname($file_name)) {
>  			die_error(400, "Invalid file parameter");
