Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF0C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39ED420DD4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lPtth/f+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgKYAhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:37:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63885 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKYAhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:37:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 679EA97E19;
        Tue, 24 Nov 2020 19:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KTSRU4D7JX2VWgPtSJIw3wXpkN0=; b=lPtth/
        f+jlM33JD+np8LbnBycP0H2jt4AkjOpCoo8pSqHuUqVtzruo3rpRWcP+jpVTViSZ
        gyoDXC4dLg6GvHXJwGB6YZeh7wn0qs5SQ0UYSUkP+mPtM2JGJkSW933EJm0Eqosw
        fZvOYzD9zHtbekq23pB8tIT/d0wtlb4FhTNlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HMa+CFGKpmyvs9dnZ8uUp76OFimA6uhh
        98s5vkvTJScXkImZ5YmYBmcUErFLq0Hx0TunIqgaWj6qErvFrm4CSmbOb9EjnRAz
        pi0GlV/NKHMiH+ZZ0Q7SZcboQDaKzwGWP2Z9Sc5c5FB3BZXKsELLnfaNRQVok7mJ
        PIgU9uolZD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CBE497E18;
        Tue, 24 Nov 2020 19:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A65C497E16;
        Tue, 24 Nov 2020 19:36:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v2] refspec: make @ a synonym of HEAD
References: <20201125001102.111025-1-felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 16:36:59 -0800
In-Reply-To: <20201125001102.111025-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 24 Nov 2020 18:11:02 -0600")
Message-ID: <xmqqblfmgtlg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 543B2B14-2EB6-11EB-ABC0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index f541f30bc2..f808649de4 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -58,6 +58,8 @@ test_refspec fetch 'HEAD~4:refs/remotes/frotz/new'		invalid
>  
>  test_refspec push 'HEAD'
>  test_refspec fetch 'HEAD'
> +test_refspec push '@'
> +test_refspec fetch '@'

OK.

> +test_expect_success 'push @ with non-existent, incomplete dest' '
> +
> +	mk_test testrepo &&
> +	git checkout master &&
> +	git push testrepo @:branch &&
> +	check_push_result testrepo $the_commit heads/branch
> +
> +'
> +
>  test_expect_success 'push with config remote.*.push = HEAD' '
>  
>  	mk_test testrepo heads/local &&
> @@ -501,6 +510,15 @@ test_expect_success 'push with config remote.*.push = HEAD' '
>  	check_push_result testrepo $the_first_commit heads/local
>  '
>  
> +test_expect_success 'push with @' '
> +
> +	mk_test testrepo heads/master &&
> +	git checkout master &&
> +	git push testrepo @ &&
> +	check_push_result testrepo $the_commit heads/master
> +
> +'

This is OK, but shouldn't this be placed before the tests with
various configuration?  Something along the lines of the attached,
but with the body of the loop properly reindented, would also give
us a better test coverage at the same time.

 t/t5516-fetch-push.sh | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
index d11382f769..0b015a8d60 100755
--- c/t/t5516-fetch-push.sh
+++ w/t/t5516-fetch-push.sh
@@ -436,24 +436,27 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_success 'push with HEAD' '
+for HEAD in HEAD @
+do
+
+test_expect_success "push with $HEAD" '
 
 	mk_test testrepo heads/master &&
 	git checkout master &&
-	git push testrepo HEAD &&
+	git push testrepo $HEAD &&
 	check_push_result testrepo $the_commit heads/master
 
 '
 
-test_expect_success 'push with HEAD nonexisting at remote' '
+test_expect_success "push with $HEAD nonexisting at remote" '
 
 	mk_test testrepo heads/master &&
 	git checkout -b local master &&
-	git push testrepo HEAD &&
+	git push testrepo $HEAD &&
 	check_push_result testrepo $the_commit heads/local
 '
 
-test_expect_success 'push with +HEAD' '
+test_expect_success "push with +$HEAD" '
 
 	mk_test testrepo heads/master &&
 	git checkout master &&
@@ -464,25 +467,27 @@ test_expect_success 'push with +HEAD' '
 	check_push_result testrepo $the_commit heads/local &&
 
 	# Without force rewinding should fail
-	git reset --hard HEAD^ &&
-	test_must_fail git push testrepo HEAD &&
+	git reset --hard $HEAD^ &&
+	test_must_fail git push testrepo $HEAD &&
 	check_push_result testrepo $the_commit heads/local &&
 
 	# With force rewinding should succeed
-	git push testrepo +HEAD &&
+	git push testrepo +$HEAD &&
 	check_push_result testrepo $the_first_commit heads/local
 
 '
 
-test_expect_success 'push HEAD with non-existent, incomplete dest' '
+test_expect_success "push $HEAD with non-existent, incomplete dest" '
 
 	mk_test testrepo &&
 	git checkout master &&
-	git push testrepo HEAD:branch &&
+	git push testrepo $HEAD:branch &&
 	check_push_result testrepo $the_commit heads/branch
 
 '
 
+done
+
 test_expect_success 'push with config remote.*.push = HEAD' '
 
 	mk_test testrepo heads/local &&
