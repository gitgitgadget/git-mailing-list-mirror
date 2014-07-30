From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit --amend: test specifies authorship but forgets to check
Date: Wed, 30 Jul 2014 12:44:30 -0700
Message-ID: <xmqqppgmy6ld.fsf@gitster.dls.corp.google.com>
References: <0ba2fcaf784bb74ee5a9f8d13dce64ab09e66d7b.1406713446.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZnn-0006N7-8y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbaG3Toj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:44:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51862 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaG3Toi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:44:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30A862CEB8;
	Wed, 30 Jul 2014 15:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MbgnnodyV7YiWVLaEMuRzWgjIr0=; b=FGDdmb
	DCj7S0JdQ8tIlQCv0RhIbtIOP04jToMWavww/zOx6pCx6Zc0nDHabEISkPe13fxV
	+5FiTRhgfofPJiTAJZwxMbLeaZucn5o+rxMOZjLvbgWQCtKdSNHSmN+14T/U4CX0
	OaXvh45xYPEKKP4eSK8qg4Mzntq5JwGuAPlro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5xRLU8+9azGMnVDGquPq8wodHn5Tc7O
	xlrOe+hxzP1eebILcxI8gf6E5BmcZSq2YcT8I5FRpYyR8th+1udHzL70iGiOBe1a
	Qwcq3TrWtkbkz/YdQ6YvY3tSdUuQbPUAYERtF2MHb5r83jlT1H69NM82iqt4b26S
	RCLP4teU38M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 220EB2CEB7;
	Wed, 30 Jul 2014 15:44:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B09702CEAC;
	Wed, 30 Jul 2014 15:44:31 -0400 (EDT)
In-Reply-To: <0ba2fcaf784bb74ee5a9f8d13dce64ab09e66d7b.1406713446.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 30 Jul 2014 11:45:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED03C7B4-1821-11E4-AED8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254515>

Fabian Ruch <bafain@gmail.com> writes:

> The test case "--amend option copies authorship" specifies that the
> git-commit option `--amend` uses the authorship of the replaced
> commit for the new commit. Add the omitted check that this property
> actually holds.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
> Without the check, the test case succeeds even with nonsense in the
> `expected` file. An `--amend` implementation which simply uses the
> committer name and date as if it was not amending would have been
> deemed correct. This is not the case, the implementation still passes
> the test suite after the correction.
>
> Quickly skimming over the rest of the file, I couldn't find the same
> thing twice.
>
>  t/t7509-commit.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> index b61fd3c..9ac7940 100755
> --- a/t/t7509-commit.sh
> +++ b/t/t7509-commit.sh
> @@ -77,6 +77,7 @@ test_expect_success '--amend option copies authorship' '
>  	git commit -a --amend -m "amend test" &&
>  	author_header Initial >expect &&
>  	author_header HEAD >actual &&
> +	test_cmp expect actual &&
>  
>  	echo "amend test" >expect &&
>  	message_body HEAD >actual &&

Makes sense; thanks.
