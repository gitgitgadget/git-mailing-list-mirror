From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Fri, 02 Mar 2012 14:39:38 -0800
Message-ID: <7vaa3ybpat.fsf@alter.siamese.dyndns.org>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3b8e-0000wi-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 23:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965402Ab2CBWjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 17:39:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965331Ab2CBWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 17:39:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE741766C;
	Fri,  2 Mar 2012 17:39:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DLzKqtfbFKK7jf0NqgGPcbUIDfg=; b=nhHCmY
	eB51xWHSE+n2OheNY4jhQMGtqNcWGHZhO/bCEdHy6E73zEwYd+bEzAgO7S1anfxK
	QV3PSQ8qTGYOYs386qPOrN/ml6hvcnsaGmAhJGtRcTY4c8Xw3vi+JcetGwb0bMho
	5shiuH4/PdHTrAbM9fc0t/Mw8ifn37zxCzB5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S3Q8lLACw2RDIQtiWPa6QGWrwWVByOkI
	Z0LKhlMwHsrA03DuSq7bdiovX5+eAGbpqw8JpPDDUpNd+cB1OvLJvRC7Lf6dZopV
	Udr9X4+Xrc7javqhccafqwJFwoYIq+1WhVqyZr8DNlS0U5u78ELlgMoBSekaJhNj
	NVXyfzawzUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6291766B;
	Fri,  2 Mar 2012 17:39:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42BFC766A; Fri,  2 Mar 2012
 17:39:40 -0500 (EST)
In-Reply-To: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 2 Mar 2012 08:27:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99149454-64B8-11E1-96EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192070>

Tim Henigan <tim.henigan@gmail.com> writes:

>  mergetools/DeltaWalker |   12 ++++++++++++

How does an end user choose to use this backend?  Perhaps like this?

    $ git mergetool --tool=DeltaWalker

All the other files in mergetools/ are in lower case, and I _strongly_
prefer to have this new file also be in lower case.

Such a change may mean you may have to override translate_merge_tool_path
in this file, like some other backends seem to do.

>  1 file changed, 12 insertions(+)
>  create mode 100644 mergetools/DeltaWalker
>
> diff --git a/mergetools/DeltaWalker b/mergetools/DeltaWalker
> new file mode 100644
> index 0000000..b9e6618
> --- /dev/null
> +++ b/mergetools/DeltaWalker
> @@ -0,0 +1,12 @@
> +diff_cmd () {
> +	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
> +}
> +
> +merge_cmd () {
> +	if $base_present
> +	then
> +		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED"
> +	else
> +		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED"
> +	fi >/dev/null 2>&1
> +}
