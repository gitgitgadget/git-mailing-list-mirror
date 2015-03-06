From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] sequencer: preserve commit messages
Date: Fri, 06 Mar 2015 10:59:19 -0800
Message-ID: <xmqqegp2ymt4.fsf@gitster.dls.corp.google.com>
References: <xmqqd24vjjf0.fsf@gitster.dls.corp.google.com>
	<3e771e1bf45d972c9192441b7dfe6374f5a72bb5.1425649130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 19:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxT9-000277-UL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 19:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbbCFS7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 13:59:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753989AbbCFS7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 13:59:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E5EE3D73B;
	Fri,  6 Mar 2015 13:59:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LkyCIdsqUrvBXFgUKR0K0Gi6YPY=; b=JqQNDM
	TqKq65tFRwN0XKFdAJF1tMMj4aK7d5bYcixi+UGbcaBomJUpsWjlKeqAw3i7Jc9n
	PH1TBd2Tw8yqmdSmRIkdQo4J8Ia8lQsLB/8e0EPGv3YLKVfqIHVCKS7UD1pssK40
	fu5kKchlySSFyZRwWV1ib9PHtwQiSnXZ7jizM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KU4SdZev5VS+eQgccEEyw9PSvd7i0ivK
	FfbCQqL4m52NnCm1M/yRKnlOvKatigePIx2OCB4NZZR3gbeTqgW4CGzgypj2xiWQ
	v7hLZS1ipD/Pmy2T9dNPxki2+9BrEFC2wmk27Ilqui2CxOT8bYgH97L6FPxLzTRf
	/W86UsDCBiQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85D9F3D739;
	Fri,  6 Mar 2015 13:59:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07C893D738;
	Fri,  6 Mar 2015 13:59:20 -0500 (EST)
In-Reply-To: <3e771e1bf45d972c9192441b7dfe6374f5a72bb5.1425649130.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 6 Mar 2015 14:55:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5C86D5C-C432-11E4-98AC-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264951>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> sequencer calls "commit" with default options, which implies
> "--cleanup=default" unless the user specified something else in their
> config. This leads to cherry-picked commits getting a cleaned up commit
> message, which is usually not an intended side-effect.
>
> Make the sequencer use "--cleanup=verbatim" so that it preserves commit
> messages independent of the default, unless the user has set config for "commit"
> or the message is amended with -s or -x.
>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

Looks very sensible.

Thank you very much for your efforts to tie the loose ends on many
topics that were discussed already without leading to their
completion.

Will replace and queue.

>  sequencer.c              |  5 +++++
>  t/t3511-cherry-pick-x.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 77a1266..8cf575c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -373,6 +373,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  {
>  	struct argv_array array;
>  	int rc;
> +	const char *value;
>  
>  	argv_array_init(&array);
>  	argv_array_push(&array, "commit");
> @@ -385,6 +386,10 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if (!opts->edit) {
>  		argv_array_push(&array, "-F");
>  		argv_array_push(&array, defmsg);
> +		if (!opts->signoff &&
> +		    !opts->record_origin &&
> +		    git_config_get_value("commit.cleanup", &value))
> +			argv_array_push(&array, "--cleanup=verbatim");
>  	}
>  
>  	if (allow_empty)
> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index f977279..b7dff09 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -36,6 +36,20 @@ mesg_with_cherry_footer="$mesg_with_footer_sob
>  (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
>  Tested-by: C.U. Thor <cuthor@example.com>"
>  
> +mesg_unclean="$mesg_one_line
> +
> +
> +leading empty lines
> +
> +
> +consecutive empty lines
> +
> +# hash tag comment
> +
> +trailing empty lines
> +
> +
> +"
>  
>  test_expect_success setup '
>  	git config advice.detachedhead false &&
> @@ -53,6 +67,10 @@ test_expect_success setup '
>  	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
>  	git reset --hard initial &&
>  	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
> +	git reset --hard initial &&
> +	test_config commit.cleanup verbatim &&
> +	test_commit "$mesg_unclean" foo b mesg-unclean &&
> +	test_unconfig commit.cleanup &&
>  	pristine_detach initial &&
>  	test_commit conflicting unrelated
>  '
> @@ -216,4 +234,14 @@ test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as p
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-pick preserves commit message' '
> +	pristine_detach initial &&
> +	printf "$mesg_unclean" >expect &&
> +	git log -1 --pretty=format:%B mesg-unclean >actual &&
> +	test_cmp expect actual &&
> +	git cherry-pick mesg-unclean &&
> +	git log -1 --pretty=format:%B >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
