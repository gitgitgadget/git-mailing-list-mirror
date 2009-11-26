From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Wed, 25 Nov 2009 22:17:54 -0800
Message-ID: <7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:18:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDXg5-0008Nb-UT
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbZKZGRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbZKZGRy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:17:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbZKZGRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B28EF82F75;
	Thu, 26 Nov 2009 01:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TYM+vOG7v58vQOx3fxYT5nj/tvU=; b=hUTaNuxM83ggr5Pi6tH5O+L
	L/dZ1p1FO3I1iyly2FRTONM0y8SUmWg/6Qe+1HQDe2L5Pnw5XLrXDLeLTkTyaPWL
	u45S3z3HwlhVV72TRIkKU+ZhJbbNVTlX6YoAQoyQADt3c58YhVLI5RKQlJ+wHP78
	i1YeHvE0pm/wOiNkUiE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=seGVMiRYIP7W+hmIpnThz3PpHGr41hrFYQBVew0I8DzwAyOnt
	jDtk/iHxXzdfeBIMiEqVvF10Xb7QuwHQUpJvsvItIBvqPQ25qzziXCk4ZlgNLdI7
	OY+4G4XpEBWeu52hymYSTBNZLp3RdeZt23Ix2Fr4cQX810i1bbSWPe1ShU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8875E82F74;
	Thu, 26 Nov 2009 01:17:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD6DC82F73; Thu, 26 Nov
 2009 01:17:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71405A5E-DA53-11DE-A946-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133769>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> ...
> A larger problem is that this tends to encourage a bad workflow by
> allowing them to record such a mixed up half-merge result as a full commit
> without auditing.  This commit does not tackle this latter issue.  In git,
> we usually give long enough rope to users with strange wishes as long as
> the risky features is not on by default.

Typo/Grammo.  "risky features are not on by default".

> (Patch originally by Junio Hamano <gitster@pobox.com>.)
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

Except for parse-optification, this one is more or less a verbatim copy of
my patch, and I think I probably deserve an in-body "From: " line for this
[PATCH 1/8], [PATCH 6/8] and [PATCH 8/8] to take the full authorship of
them.

> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 4da052a..2cce49d 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -58,6 +58,11 @@ extern "C" {
>  #define XDL_MERGE_ZEALOUS_ALNUM 3
>  #define XDL_MERGE_LEVEL_MASK 0x0f
>  
> +/* merge favor modes */
> +#define XDL_MERGE_FAVOR_OURS 0x0010
> +#define XDL_MERGE_FAVOR_THEIRS 0x0020
> +#define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)

This is a bad change.  It forces the high-level layer of the resulting
code to be aware that the favor bits are shifted by 4 and it is different
from what the low-level layer expects.  If I were porting it to
parse-options, I would have kept OURS = 1 and THEIRS = 2 as the original
patch, and instead did something like:

 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, merge_level | merge_style, &result);
+			&xpp, XDL_MERGE_FLAGS(merge_level, merge_style, merge_favor), &result);

with an updated definition like this:

    #define XDL_MERGE_FLAGS(level, style, favor) ((level)|(style)|((favor)<<4)
