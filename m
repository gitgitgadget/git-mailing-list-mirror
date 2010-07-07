From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/6] Add a rename + D/F conflict testcase
Date: Wed, 07 Jul 2010 14:26:26 -0700
Message-ID: <7vhbkbt24d.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 07 23:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWc8g-0002uF-Oe
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab0GGV0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:26:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab0GGV0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:26:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01028C2DA9;
	Wed,  7 Jul 2010 17:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=btru+EEl+qqAEtEoMmEXd0k2pbY=; b=VZ/3iFb9BrPA9IvuGmf5Khg
	FA0xPeWVEwSPSw2wfe9ycBQQxl22sCRy4UvQe4jJPyWBnLWS1o7ldPiwSEWQ6Gvd
	6U3/Jn7raWfqxrSI4/lK8AHEig3c6ndCmWPJqWMLdOqW4GkWBcP5vyAMWY3RMb1n
	tDgfNUa+N6fi/G49inpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VTSg+ocQKCkqRHu/WYAhy3U8weIyBPWDTwZPHvsxY0ROPQJfP
	0dNnam4GaBv3OQjZRUuM1e9HhD7Y0Ez4/LJzahDATdkodcpvy474nTj0mPr6sgGm
	DFg9EyyHJ7KI3QW2xa7HfEj1lKVJEIxdAmdYFzq5/ktHyGWwBhV8T+mz3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFFE0C2DA7;
	Wed,  7 Jul 2010 17:26:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF285C2DA4; Wed,  7 Jul
 2010 17:26:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 505E46FA-8A0E-11DF-B96E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150507>

newren@gmail.com writes:

> From: Alexander Gladysh <agladysh@gmail.com>
>
> This is a simple testcase where both sides of the rename are paths involved
> in (separate) D/F merge conflicts
>
> Signed-off-by: Alexander Gladysh <agladysh@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Copying my additional comments from round 2:
>
>   As noted previously this is simply a testcase Alexander sent to the
>   list on March 8 which I'm submitting in the form of a testsuite
>   addition.  He's happy to have his testcase added to the testsuite
>   and/or even submit it himself if that makes more sense -- just let
>   us know what is wanted.  I'm less familiar with format-patch and am;
>   hopefully this submission comes across with him recorded as the
>   author.
>
>  t/t3508-cherry-pick-merge-df.sh |   34 ++++++++++++++++++++++++++++++++++

As t3508 is already used elsewhere I'll rename this to 3509, with minor
style fixes as well.

> diff --git a/t/t3508-cherry-pick-merge-df.sh b/t/t3508-cherry-pick-merge-df.sh
> new file mode 100755
> index 0000000..646a56d
> --- /dev/null
> +++ b/t/t3508-cherry-pick-merge-df.sh
> @@ -0,0 +1,34 @@
> ...
> +	touch f1 &&
> +	git add f1 &&
> +	git commit -m "f1"
> +'
> +
> +test_expect_failure 'Cherry-pick succeeds with rename across D/F conflicts' '
> +	git checkout master &&
> +	git cherry-pick branch
> +'

This is curious.  "branch" only adds a totally unrelated path to its
parent, and picking it should be trivial.  I wonder what it does
here if we used the resolve strategy...
