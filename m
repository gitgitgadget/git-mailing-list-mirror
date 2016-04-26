From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] submodule add: label submodules if asked to
Date: Tue, 26 Apr 2016 15:49:50 -0700
Message-ID: <xmqq7ffkc7e9.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:49:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBnr-00008e-1k
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbcDZWtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:49:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752147AbcDZWty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:49:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CF0E15755;
	Tue, 26 Apr 2016 18:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CPGSdXbUi9de2n3MBxJo5628M8=; b=A0uIVt
	M0zAl+rK42s0Lb8hj5UI/g8KvqLGY5AbM1e8Yv3f3tFFprPcHmGmWBzPINXWa1tV
	IqoqPvlL4bcSiuEkHNAxe8Ed89Es1dIe5Q7Ugezml3I6LPXy9ZQTCxK5iEvFwnGl
	PG/LA6QjzKQjwhdO6hk4C4WHDX21AdhBVDn1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBPtxZLp8ilTJiFttDhpNwm2uNgDg4xb
	zpeSVtUtltTefbxfO8C0ZXOgHz0BTOVYPHTMud+HxhQupF/oO4rxAInCCUw3cHMX
	ZDlLSc5qrANyPBnzIziGW0tenhXUXiu8YkgDYi604bPWjSw8kR5VTyO5YeE+TYJ5
	AkH6n8aU7lc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22BAE15754;
	Tue, 26 Apr 2016 18:49:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 771E615750;
	Tue, 26 Apr 2016 18:49:52 -0400 (EDT)
In-Reply-To: <1461703833-10350-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30444894-0C01-11E6-998A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292693>

Stefan Beller <sbeller@google.com> writes:

> When adding new submodules, you can specify the
> label(s) the submodule belongs to by giving one or more
> --label arguments. This will record each label in the
> .gitmodules file as a value of the key
> "submodule.$NAME.label".
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-submodule.txt |  5 ++++-
>  git-submodule.sh                | 14 +++++++++++++-
>  t/t7400-submodule-basic.sh      | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8c4bbe2..349ead8 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> +'git submodule' [--quiet] add [-b <branch>] [-f|--force] [-l|--label <label>]
>  	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> @@ -109,6 +109,9 @@ is the superproject and submodule repositories will be kept
>  together in the same relative location, and only the
>  superproject's URL needs to be provided: git-submodule will correctly
>  locate the submodule using the relative URL in .gitmodules.
> ++
> +If at least one label argument was given, all labels are recorded in the
> +.gitmodules file in the label fields.

I think this is better without "If ... given,".

I am not sure if it is sensible to make "label" namespace always
global to be shared with the project by updating .gitmodules,
though (it can cut both ways, so this is not an objection).

> @@ -165,6 +166,13 @@ cmd_add()
>  		--depth=*)
>  			depth=$1
>  			;;
> +		-l|--label)
> +			labels="${labels} $2"
> +			shift
> +			;;
> +		--label=*)
> +			labels="${labels} ${1#--label=}"
> +			;;
>  		--)
>  			shift
>  			break
> @@ -292,6 +300,10 @@ Use -f if you really want to add it." >&2
>  
>  	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
>  	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
> +	for label in $labels
> +	do
> +		git config --add -f .gitmodules submodule."$sm_name".label "${label}"
> +	done &&

Is the acceptable syntax for "label" defined and documented
somewhere?

I didn't see it in the documentation patch.  I am seeing that we do
not allow $IFS whitespaces in them, but are there other restrictions
we want to enforce?  Remember, starting with narrow and widening as
we discover the need is the right way to design things.  Once we
start allowing random strings, it is very hard to later reject some
to carve out namespace for ourselves.

The above implementation happens to allow users to say

	git submodule add -l "labelA labelB" -- $there $path

and give two labels to the module, and that will be something you
end up needing to support forever, unless you restrict early.
