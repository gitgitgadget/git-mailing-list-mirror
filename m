From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] rev-parse test: use test_cmp instead of "test" builtin
Date: Tue, 03 Sep 2013 13:01:13 -0700
Message-ID: <xmqqk3ixr7xy.fsf@gitster.dls.corp.google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com>
	<20130903170715.GD29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwmv-00013l-43
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760709Ab3ICUBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:01:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760199Ab3ICUBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0963F359;
	Tue,  3 Sep 2013 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kY4du6wRWn+AM877506XWK2EZzY=; b=j1rhoJ
	WPCjSNcMAZHeezsWoyaCG3660G2LxS8RIqUVuF4+sqGAXq+SNBQLGJfIOW/mj/ZS
	FsbivpKQwQFstL647k/55YVycJ0fei5QlXBiict6RVz9QB+h2+LZZ4qbxmnG0rVz
	ijCW51K2gKkmLQbUggsy+BR9Gw0NYzZoMw7wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TRP1d6/f/0gDOVgbgxaPkyULLnfdjR2k
	4sPG/F2UcpA/Q5RXjC4nnqWo1uW0xgJ1tSWFHVCHJWbfreevL2EnDZE0k+7/Fabv
	7pz/GdovOhU8/lVm7ZYxP6QdIxfLRKkYe2YsGZGw2wqvYNitiVJe1leX3Vm/+u0N
	QrIawa12JMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80CF83F358;
	Tue,  3 Sep 2013 20:01:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3B373F354;
	Tue,  3 Sep 2013 20:01:14 +0000 (UTC)
In-Reply-To: <20130903170715.GD29921@google.com> (Jonathan Nieder's message of
	"Tue, 3 Sep 2013 10:07:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 969D2228-14D3-11E3-840B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233769>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Use test_cmp instead of passing two command substitutions to the
> "test" builtin.  This way:
>
>  - when tests fail, they can print a helpful diff if run with
>    "--verbose"
>
>  - the argument order "test_cmp expect actual" feels natural,
>    unlike test <known> = <unknown> that seems a little backwards

I do not mind to drop s/a little // here, by the way.

>  - the exit status from invoking git is checked, so if rev-parse
>    starts segfaulting then the test will notice and fail
>
> Use a custom function for this instead of test_cmp_rev to emphasize
> that we are testing the output from "git rev-parse" with certain
> arguments, not checking that the revisions are equal in abstract.
>
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t6101-rev-parse-parents.sh | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
> index 416067c..8a6ff66 100755
> --- a/t/t6101-rev-parse-parents.sh
> +++ b/t/t6101-rev-parse-parents.sh
> @@ -8,6 +8,12 @@ test_description='Test git rev-parse with different parent options'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
>  
> +test_cmp_rev_output () {
> +	git rev-parse --verify "$1" >expect &&
> +	eval "$2" >actual &&
> +	test_cmp expect actual
> +}

After applying this patch and running "git show | grep test_cmp_rev_output",
I notice that the second is always "git rev-parse <something>".  Do
we still need to eval these, or would it be sufficient to do

        test_cmp_rev_output () {
                git rev-parse --verify "$1" >expect &&
                git rev-parse --verify "$2" >actual &&
                test_cmp expect actual
        }

here, and make users like so:

	-	test_cmp_rev_output tags/start "git rev-parse start^0"
	+	test_cmp_rev_output tags/start start^0

Am I missing something?
