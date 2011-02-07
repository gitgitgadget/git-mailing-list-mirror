From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] git-p4: test script
Date: Sun, 06 Feb 2011 18:22:06 -0800
Message-ID: <7v1v3kwpm9.fsf@alter.siamese.dyndns.org>
References: <20110205224848.GA30963@arf.padd.com>
 <20110205225105.GB30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 03:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmGkK-0005Hp-D3
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 03:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab1BGCWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 21:22:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1BGCWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 21:22:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFF6F40B5;
	Sun,  6 Feb 2011 21:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pu1w/g5LnFi1+1cbotX+pWD/oTU=; b=WciL/d
	2suZFJ93FAbzRbaby14gR4SfWzbh1y1JPvXiFOYMnYdB1tGWw0P68nlcfJwtP3/X
	/xFDWY6e5/SryIkiPmQs5XqsAchMoYIsdzzHZ+3wNfHGw8WjabE1Rqda52T5rIvN
	pbe0Qu4sX+FO8u74qVgZSDVo6kheT1oz6Zd9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DxGOdaL/G/KC5mRomzE16Kt78XplpRaW
	HxTNNN3OihREC5E7loM10pCJaXgdCzz4ni4BW/2KauBAY5BDPklsHLpti7R3bQKM
	n6/xPvxOC5QNhnM6jIFparUdL944HQikwsXZlpT/1DStOC8eT0FoLXveUVzwoigj
	oVEPqfjLgJw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB6EF40B4;
	Sun,  6 Feb 2011 21:23:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA4ED40B3; Sun,  6 Feb 2011
 21:23:06 -0500 (EST)
In-Reply-To: <20110205225105.GB30963@arf.padd.com> (Pete Wyckoff's message of
 "Sat\, 5 Feb 2011 17\:51\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34A0EE30-3261-11E0-8234-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166222>

Pete Wyckoff <pw@padd.com> writes:

> Add a basic test script for git-p4.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  t/t9800-git-p4.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9800-git-p4.sh
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> new file mode 100755
> index 0000000..f4956b7
> --- /dev/null
> +++ b/t/t9800-git-p4.sh
> @@ -0,0 +1,62 @@
> +#!/bin/sh
> +
> +test_description='git-p4 tests'
> +
> +. ./test-lib.sh
> +
> +p4 -h >/dev/null 2>&1
> +retc=$?
> +p4d -h >/dev/null 2>&1
> +retd=$?
> +if test $retc -ne 0 -o $retd -ne 0
> +then

Use of two global variables with short names makes me feel "yeek!".

	(p4 -h && p4d -h) >/dev/null 2>/dev/null ||
	{
		...
                test_done
	}

> +GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
> +P4DPORT=10669
> +
> +db="$TRASH_DIRECTORY/db"
> +cli="$TRASH_DIRECTORY/cli"
> +git="$TRASH_DIRECTORY/git"
> +
> +test_debug 'echo p4d -q -d -r "$db" -p $P4DPORT'
> +test_expect_success setup '
> +	mkdir -p "$db" &&
> +	p4d -q -d -r "$db" -p $P4DPORT &&
> +	# wait for it to finish its initialization
> +	sleep 1 &&

Is there a guarantee that "1" is sufficiently long for everybody?

Otherwise this will be a flaky test that sometimes passes and sometimes
doesn't, which we try to avoid.

If the answer is "empirically 1 second is sufficient for 99.9% of people",
then I would have to guess that it is 0.8 second too long for majority of
people, in which case I would like to see us try harder to make it both
reliable and efficient.

Isn't there a "noop" command a client can issue against a working server
that fails when the server is not ready (or waits until the server becomes
ready)?
