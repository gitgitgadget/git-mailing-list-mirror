From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/14] t/t5505-remote: test multiple push/pull in remotes-file
Date: Sun, 23 Jun 2013 01:07:30 -0700
Message-ID: <7vobaxfdx9.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 10:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqfKq-0006qz-VK
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab3FWIHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:07:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab3FWIHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:07:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C9F82682A;
	Sun, 23 Jun 2013 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Ihdmsszwki0IorxNLHajH3HVlvg=; b=Sl964TBywO1gKm6SGhJl
	/sZaHDhShMHi1x1HezczXOA3KsR7BPdae68fDGcSmdoV4JnzDJnCdSuWZk6Q4XIV
	D6v4bEmmvMOPBeUP5IDlb8t/wbY+CebXoj7aFdCX+/TOXqg1hY7bOMlhURm0ft4z
	UUwCTbVpFxqMbFkqqwkYmiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=U+xv3EzMW6GEf43q2WGvgCsxknpXd6S1UQLxnxAUTjMoQU
	7zXNlrg+J9RJiaoLlRc8P/2p4n9PS1TKnkzKCTnV5M5k0AChjtqBozPQLPfRsv2T
	pqMLJnFHv3RHetViW5dZM43vcLz9YqOChfhFpD6HoTqNQDrHkr7qIf/O+ifRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73AC026829;
	Sun, 23 Jun 2013 08:07:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E75E926828;
	Sun, 23 Jun 2013 08:07:31 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F46BED8E-DBDB-11E2-B264-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228731>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Extend the test "migrate a remote from named file in $GIT_DIR/remotes"
> to test that multiple "Push:" and "Pull:" lines in the remotes-file
> works as expected.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5505-remote.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 229a89c..6a622fc 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -735,7 +735,9 @@ test_expect_success 'rename a remote with name prefix of other remote' '
>  cat >remotes_origin <<-EOF
>  URL: quux
>  Push: refs/heads/master:refs/heads/upstream
> +Push: refs/heads/master:refs/heads/upstream2
>  Pull: refs/heads/master:refs/heads/origin
> +Pull: refs/heads/master:refs/heads/origin2
>  EOF

I do not think we ever designed this to get 'master' pushed to
update two separate destination branches or their 'master' to update
our two separate tracking branches.

If you want to make things more realistic like you did in 08/14, I
do not see a point to change the tests that is already done for a
useful and realistic case by making it deliberately less realistic.

The same comment applies to the bogus quux URL from the patch 04/14.

I'll reject 04/14 and tweak this patch to use 'next' for the new ref
mappings, not duplicated 'master'.

Patches 07/14, 12/14, 13/14, and 14/14 are bad idea (these will not
be queued on tonight's pushout of 'pu'; neither 04/14 will be).  We
may not be encouraging, but that is very different from deprecating
the original mechanisms.  The tests that depend on them to work
should be kept.  Otherwise, we will never know when we break them
like we did at df93e33c accidenally.

If we want to have tests that exercise the equivalents spelled with
the modern in-config mechanism, they should be added as new tests,
not by replacing the existing ones.
