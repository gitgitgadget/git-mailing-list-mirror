From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] add basic tests for merge-tree
Date: Tue, 13 Jul 2010 16:31:28 -0700
Message-ID: <7vaapv0xin.fsf@alter.siamese.dyndns.org>
References: <1278854215-9022-1-git-send-email-wmpalmer@gmail.com>
 <1278854215-9022-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:31:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYowx-0006p7-69
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab0GMXbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:31:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab0GMXbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:31:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F119C38CF;
	Tue, 13 Jul 2010 19:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DpkduxhWduc938Csi3XaGP5BVDs=; b=YgSe3J
	kmBhELTFimYh8mLQp/N4gjZeqceVP3HBKg3jMgByNs+l2UTCXVC4XTg8Jkm+h4vh
	yYPsO3QuVVLXMchmJ0i3qsvoM5nWvcDO7l7bXB5ZZMTLDT8mnNmJtDFiPB5dIBUR
	CCAtTqQX+IR2R5NWyJuIkAV7P2xrhkXySitM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcq7BspSQQXiYYsYfgEiQoPa/Wy9pl/9
	fX13/JTd26RcYhY63QBztpjNvEnZC/aqLrt6JCcM12QBb7BFMKZZS+A/i+O+PMQM
	fbMkjQHt7AMTfDNDXQTsXeg5CJhjwnWEXePcptud3r0dM8syCQTL50F2P4wLFHFY
	vt5MgCES0Oo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66D2FC38CE;
	Tue, 13 Jul 2010 19:31:33 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08696C38CC; Tue, 13 Jul
 2010 19:31:29 -0400 (EDT)
In-Reply-To: <1278854215-9022-2-git-send-email-wmpalmer@gmail.com> (Will
 Palmer's message of "Sun\, 11 Jul 2010 14\:16\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C59CD72A-8ED6-11DF-A28F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150939>

Will Palmer <wmpalmer@gmail.com> writes:

> merge-tree had no test cases, so here we add some very basic tests for
> it, including some known-breakages.
>
> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> ---
>  t/t4300-merge-tree.sh |  277 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 277 insertions(+), 0 deletions(-)
>  create mode 100755 t/t4300-merge-tree.sh

This does not sound like part of "the diff commands", unlike apply/diff/log.
Perhaps somewhere in t3xxx "other basic commands" series?

> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> new file mode 100755
> index 0000000..b2ae3a1
> --- /dev/null
> +++ b/t/t4300-merge-tree.sh
> @@ -0,0 +1,277 @@
> ...
> +test_expect_'file add A, !B' '
> +	cat >expected <<EXPECTED
> +added in remote
> +  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> +@@ -0,0 +1 @@
> ++AAA
> +EXPECTED

Since you do not use any variable substitution in the here text, please
make that clear by quoting EXPECTED like this:

	cat >expected <<\EXPECTED
... your here text goes here ...
EXPECTED

to help the readers, who otherwise have to scan the here text to find if
there is any interesting substitution going on.

> +	git reset --hard initial
> +	test_commit "add-a-not-b" "ONE" "AAA"

Please fix missing && cascades.

Thanks.
