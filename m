From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Added tests for the case of merged and unmerged entries for the same file
Date: Wed, 20 Aug 2014 14:00:26 -0700
Message-ID: <xmqq8umiub9x.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<7782c581021d529947a1385939231eeb145d150e.1408533065.git.jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKCzr-0008Ea-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 23:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbaHTVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 17:00:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53825 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaHTVAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 17:00:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B16C0322B8;
	Wed, 20 Aug 2014 17:00:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0Hmwn4mNJRKb4KBCTV4sGu/2/Rs=; b=SxFb66
	8Y26KlfUjBIAPgrJXvAXaxUib9FP8tpVqu9xq429LF/2cFAB6x9UTVITw+TApW2H
	tk7o8NQfu17/aagkmslADw/wdA860jN5Vgazahf8lUDYh4SbYd0V5jA6GI9L6O2J
	CG0TSumaWFc+h9IGBVQ9cNmOjsMAAQYoF3IfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qa7wRleWAHeTTDYqG59Fw4zXsRYbqgjy
	InUCQ7x0D2snaswG7XBZVLfe+Rs+EEtXpUdi6l5OApdTMc6VePQSnKf/KKq5pbrr
	at0yEG5AKUGnxvIzXMpR7oeVHzWH07v3C2GWJu1I4Am6wQgBob8qTQ6T2noJv7Vy
	RzJJqtaNz9A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8B4B322B7;
	Wed, 20 Aug 2014 17:00:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E01BF322A1;
	Wed, 20 Aug 2014 17:00:27 -0400 (EDT)
In-Reply-To: <7782c581021d529947a1385939231eeb145d150e.1408533065.git.jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Wed, 20 Aug 2014 13:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0363DAEE-28AD-11E4-A0C7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255586>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
> ---
>  t/t9904-unmerged-file-with-merged-entry.sh | 86 ++++++++++++++++++++++++++++++

Isn't this number already used for another test?  A test on the
index probably belongs to t2XXX or t3XXX family.

>  1 file changed, 86 insertions(+)
>  create mode 100755 t/t9904-unmerged-file-with-merged-entry.sh
>
> diff --git a/t/t9904-unmerged-file-with-merged-entry.sh b/t/t9904-unmerged-file-with-merged-entry.sh
> new file mode 100755
> index 0000000..945bc1c
> --- /dev/null
> +++ b/t/t9904-unmerged-file-with-merged-entry.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +
> +test_description='Operations with unmerged files with merged entries'
> +
> +. ./test-lib.sh
> +
> +setup_repository() {
> +	test_commit A conflict A
> +	test_commit A conflict2 A2 branchbase
> +	test_commit B conflict B
> +	test_commit B conflict2 B2
> +	git checkout branchbase -b branch1
> +	test_commit C conflict C
> +	test_commit C conflict2 C2
> +	test_commit something otherfile otherfile
> +}

No error is checked here?

> +setup_stage_state() {
> +	git checkout -f HEAD
> +	{
> +		git ls-files -s conflict conflict2
> +		git merge master > /dev/null
> +		git ls-files -s conflict conflict2
> +	} > index

No error is checked here?

Style: no SP between redirection operator and its target, i.e.

	git merge master >/dev/null
	{ ... } >index

> +	cat index | git update-index --index-info

Do not cat a single file into a pipeline, i.e.

	git update-index --index-info <index


Thanks.
