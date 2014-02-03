From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 1/9] submodule: prepare for recursive checkout of submodules
Date: Mon, 03 Feb 2014 14:23:15 -0800
Message-ID: <xmqqha8fdeek.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<52CC3E16.4060909@web.de>
	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
	<52EFF25E.6080306@web.de> <52EFF290.5090501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WARvc-00073C-BK
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbaBCWXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:23:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaBCWXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 17:23:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4ADB69BB0;
	Mon,  3 Feb 2014 17:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ypt1tnhYEyn9aPv0KdvspyeVhSE=; b=Y4+7o2
	rjmUr45HnDT/SZDLwV1FKNojIPSaL0FiguWEcwn9/JT6RLVmWeG1oR7QrcbxUMl3
	M4I0LoddDaaiyY4n1jX+BWbDnVz+kUAY94zaX5RNImmNErZKNdYQgRuVmChDol/M
	NhoJBRbZ78D7vJJak1kHOMrSfEHcGHbt7EF9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yUqyxfGVfd8CNeR8ZaoxHmhUQ77zaeqD
	kuJQ3iN5X3vCM7BuSzENJQRswtraTuBKQwY1yoXsFOPC89JojVN7wb+Kp7ODr1DV
	eMGqokFpD76wJXQbusZrX2rooo9UyKn0pRMsfGXBDPYiUnZwlv9cOB+h0X0BOKwn
	zp812nLD8B8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E2569BAF;
	Mon,  3 Feb 2014 17:23:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECA0E69BAD;
	Mon,  3 Feb 2014 17:23:16 -0500 (EST)
In-Reply-To: <52EFF290.5090501@web.de> (Jens Lehmann's message of "Mon, 03 Feb
	2014 20:48:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C7624BC4-8D21-11E3-BDE3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241481>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This commit adds the functions and files needed for configuration,

Please just say "Add the functions and files needed for ...".

> +++ b/Documentation/recurse-submodules-update.txt
> @@ -0,0 +1,8 @@
> +--[no-]recurse-submodules::
> +	Using --recurse-submodules will update the work tree of all
> +	initialized submodules according to the commit recorded in the
> +	superproject if their update configuration is set to checkout'. If

That single quote does not seem to be closing any matching quote.

The phrase "according to" feels a bit too fuzzy.  Merging the commit
to what is checked out is one possible implementation of "according to".
Applying the diff between the commit and what is checked out to work
tree is another.  Resetting the work tree files to exactly match the
commit would be yet another.

I think "update the work trees to the commit" (i.e. lose the
"according") would be the closest to what you are trying to say
here.

> +	local modifications in a submodule would be overwritten the checkout
> +	will fail unless forced. Without this option or with
> +	--no-recurse-submodules is, the work trees of submodules will not be
> +	updated, only the hash recorded in the superproject will be updated.

It is unclear what happens if their update configuration is set to
something other than 'checkout'.

> diff --git a/submodule.c b/submodule.c
> index 613857e..b3eb28d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -382,6 +384,48 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
> ...
> +int option_parse_update_submodules(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	if (unset) {
> +		*(int *)opt->value = RECURSE_SUBMODULES_OFF;
> +	} else {
> +		if (arg)
> +			*(int *)opt->value = parse_update_recurse_submodules_arg(opt->long_name, arg);
> +		else
> +			*(int *)opt->value = RECURSE_SUBMODULES_ON;
> +	}

You can easily unnest to lose {}

    if (unset)
            value = off;
    else if (arg)
            value = parse...;
    else
            value = on;

Also I suspect that git_config_maybe_bool() natively knows how to
handle arg==NULL, so

    if (unset)
	value = off;
    else
	value = parse...;

is sufficient?
