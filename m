From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching reachable sha1
Date: Tue, 05 May 2015 15:16:27 -0700
Message-ID: <xmqqmw1id610.fsf@gitster.dls.corp.google.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
	<1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:21:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YplDC-0001Cx-Sd
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 00:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933777AbbEEWVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 18:21:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933628AbbEEWQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 18:16:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8C5D4E631;
	Tue,  5 May 2015 18:16:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kq4uF0AlWyr6DSSqtJV176Q+E8Y=; b=wcyEni
	DHpKjsgRYgbsJCcvYaZ+wpEjib5hIVnUyE+JB7I+L8sBI/WIrVhFlAsCEKF68PUA
	xU/GuAkf/wiI56C6r+inbzsUQX/4MHhJ+PR6yn6fFYz6dRrxXuqsuDAC79vNn/2R
	J/NNU9RbXlrRzqJByWtEk3q06Zlb9bWJTNDCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i6WlOpSmVnMu6nxRTUZS9qeQ86NacVR4
	YUgdnMhChwQqMFFdHyxFlhtJZHNIEyrk89bARV6xyc9NRUVyKqerMr+EZ8bO84nI
	epU2pI77XycD7vV/jTxCp/hPZ8IJ3jzfk1/F4znkiGIEpSNvWH63+fWlV4gLqD/5
	ULrwsDTuvTY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D14404E630;
	Tue,  5 May 2015 18:16:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D8944E62F;
	Tue,  5 May 2015 18:16:28 -0400 (EDT)
In-Reply-To: <1430860888-6146-1-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Tue, 5 May 2015 23:21:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60383A8E-F374-11E4-BA68-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268428>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> With uploadpack.allowreachablesha1inwant configuration option set on the
> server side, "git fetch" can make a request with a "want" line that names
> an object that has not been advertised (likely to have been obtained out
> of band or from a submodule pointer). Only objects reachable from the
> branch tips, i.e. the union of advertised branches and branches hidden by
> transfer.hiderefs, will be processed. Note that there is an associated
> cost of having to walk back the hstory to check the reachability.

s/hstory/history/

>
> This feature can be used when obtaining the content of a certain commit,
> for which the sha1 is known, without the need of cloning the whole
> repository, especially if a shallow fetch is used. Useful cases are e.g.
> repositories containing large files in the history, fetching only the
> needed data for a submodule checkout, when sharing a sha1 without telling
> which exact branch it belongs to and in Gerrit, if you think in terms of
> commits instead of change numbers. (The Gerrit case has already been
> solved through allow-tip-sha1-in-want as every change has a ref.)
>
> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
> ---

Much easier to read and understand.

>  Documentation/config.txt |  6 ++++++
>  fetch-pack.c             |  9 ++++++--
>  t/t5516-fetch-push.sh    | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>  upload-pack.c            | 19 ++++++++++++-----
>  4 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..76cd713 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2538,6 +2538,12 @@ uploadpack.allowtipsha1inwant::
>  	of a hidden ref (by default, such a request is rejected).
>  	see also `uploadpack.hideRefs`.
>  
> +uploadpack.allowreachablesha1inwant::

I know that the existing allowtipsha1inwant is spelled that way, and
it may be better done as a separate clean-up patch (either before or
after this step), but the documentation and the first line of the
log message would be easier to read with

	uploadpack.allowReachableSHA1InWant

I'd think.

> +	Allow `upload-pack` to accept a fetch request that asks for an
> +	object that is reachable from any ref tip. However, note that
> +	calculating	object reachability is computationally expensive.
> +	Defaults to `false`.

s/<TAB>object/<SPACE>object/

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 48526aa..fb01b6c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -43,7 +43,7 @@ static int marked;
>  #define MAX_IN_VAIN 256
>  
>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
> +static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want, allow_reachable_sha1_in_want;

Do we anticipate need for other variations of "allowing bare SHA-1
that they did not advertise" in the future?

That is a trick question.  We didn't anticipate it, and that is why
the existing feature squats on a whole integer variable.  And we are
paying the price of that lack of foresight by having to enhance with
this patch.  So the only sensible answer to that question is "we
might need to keep this extensible".

How about renaming the existing allow_tip_sha1_in_want to something
more generic to cover all such needs, e.g.

    #define ALLOW_TIP          01
    #define ALLOW_REACHABLE    02
    static int allow_request_with_bare_object_name;

Then you do not have to write (tip || reachable), and more
importantly, you do not have to force the next person to update that
to (tip || reachable || his_new_kind), I would think.

> @@ -789,6 +796,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
>  	if (!strcmp("uploadpack.allowtipsha1inwant", var))
>  		allow_tip_sha1_in_want = git_config_bool(var, value);
> +	else if (!strcmp("uploadpack.allowreachablesha1inwant", var))
> +		allow_reachable_sha1_in_want = git_config_bool(var, value);

Using all lowercase is correct here, even though the "camelCase in
documentation and log message for humans" suggestion above still
stands.

Thanks.
