From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3310: Add testcase demonstrating failure to
 --commit from within another dir
Date: Mon, 12 Mar 2012 11:21:42 -0700
Message-ID: <7vr4wxsmrt.fsf@alter.siamese.dyndns.org>
References: <87boo3m50x.fsf@zancas.localnet>
 <1331564233-1969-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S79sU-0005bw-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 19:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab2CLSVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 14:21:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab2CLSVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 14:21:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5FA66B84;
	Mon, 12 Mar 2012 14:21:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ZxWK8xNcKtHrplRFjIQMKSYo1s=; b=RtGBwA
	70DEHkxdgReX/ZOKyH8bZxwZWxyd/KvVy6SdwGbvjMqXOpSozuXLJljqzTaVBqoI
	L+S4Ny28DbHNKDeLLK0KMe/Cp1sOGiX4F+rmZQDMczhQjcXL1lgYSCPKXMFWY6OB
	PsbOncGZea+Uy4fS1HL60sZoaxhdIC/z8RR1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ar91sLxEX7vMjCDQhSeAcFh+9rB69uhM
	xn3kW7+AU9XPIBydP8UwEtehVCpUboLsr4oTDkIuSzrOU38/QoSuxS013zYGRlrl
	6B8BryI6ks3O/zjOIlkgL6W6od6sqLHIa/gLSgne6fPhUzPGOo2vLsODw4zxfXfX
	d4PnwywVnys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAD736B82;
	Mon, 12 Mar 2012 14:21:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9526B79; Mon, 12 Mar 2012
 14:21:44 -0400 (EDT)
In-Reply-To: <1331564233-1969-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 12 Mar 2012 15:57:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38C81BEC-6C70-11E1-ABE5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192917>

Johan Herland <johan@herland.net> writes:

> Found-by: David Bremner <david@tethera.net>
> Signed-off-by: Johan Herland <johan@herland.net>

Could you clarify what "from within another dir" means on the subject?

What was the expected usage?

	The 'git notes merge' command expected to be run from the
        working tree of the project being annotated, and did not
        anticipate getting run inside $GIT_DIR/.  However, because
        we use $GIT_DIR/NOTES_MERGE_WORKTREE as a temporary working
        space for the user to work on resolving conflicts, it is not
        unreasonable for a user to run "git notes merge --commit"
        there.

Is that the issue?

> ---
>
> (sending again in the correct thread. Sorry for the screwup.)
>
> This is a transcription of David's test script into a git test case.
>
> Thanks to David for finding this issue.
>
>
> Have fun! :)
>
> ...Johan
>
>  t/t3310-notes-merge-manual-resolve.sh |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> index 4367197..0c531c3 100755
> --- a/t/t3310-notes-merge-manual-resolve.sh
> +++ b/t/t3310-notes-merge-manual-resolve.sh
> @@ -553,4 +553,23 @@ test_expect_success 'resolve situation by aborting the notes merge' '
>  	verify_notes z
>  '
>
> +cat >expect_notes <<EOF
> +foo
> +bar
> +EOF
> +
> +test_expect_failure 'switch cwd before committing notes merge' '
> +	git notes add -m foo HEAD &&
> +	git notes --ref=other add -m bar HEAD &&
> +	test_must_fail git notes merge refs/notes/other &&
> +	(
> +		cd .git/NOTES_MERGE_WORKTREE &&
> +		echo "foo" > $(git rev-parse HEAD) &&
> +		echo "bar" >> $(git rev-parse HEAD) &&
> +		git notes merge --commit
> +	) &&
> +	git notes show HEAD > actual_notes &&
> +	test_cmp expect_notes actual_notes
> +'
> +
>  test_done
> --
> 1.7.9.2
