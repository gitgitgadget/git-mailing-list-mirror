Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8D520FD0
	for <e@80x24.org>; Wed, 29 Jun 2016 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbcF2SaU (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 14:30:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbcF2SaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 14:30:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D3EB271CD;
	Wed, 29 Jun 2016 14:30:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HeCGWiz11l+ADYNsQNECho+HdSg=; b=XBc26z
	ZlF1nJVLe/aUd5vAP7eiPctvrWPWszhyQyXI86yK8VQRTXTR1FQ2zLDQr0CyQJkH
	ZaaEW9Pd67Oti+K54EIVg0/K0wNxSSjd91eL/Tsdj6QK2IGp5Jp2ga2W1Ga5w05u
	mkRr5nu4oE+GxgCJxTKCEwnYFRyNA7/MjoHoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l4WxCRwQTJAs05YKlCB2FCBmcIndtWp5
	kDXxN+5kceEYurFUMIOSUtu/QBFVhZv9DooDrnkGIYVbmXti/KlTu0TK7yzzsEY4
	BkgE+k3O8fXGuJ9qqGMiRAqCcXb1peTmYRhHRgBqtWbNe+S1Nd3uZ6kD1UQOK79g
	chsDMfQd7NU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 258F5271CC;
	Wed, 29 Jun 2016 14:30:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBFAD271C9;
	Wed, 29 Jun 2016 14:30:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 11:30:10 -0700
In-Reply-To: <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 16:31:07 +0200
	(CEST)")
Message-ID: <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 846E2A72-3E27-11E6-B5B2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To keep the time t3404 requires short (in this developer's Windows
> setup, this single test already takes a painful 8 minutes to pass),
> we avoid a full-blown GPG test and cop out by verifying the message
> displayed to the user upon an 'edit' command.

This is a tangent, but I wonder if we should be solving it by
parallelizing the tests even more.  If the script for example
can be split into part1 and part2 that share the same set-up
that is prepared by the very first test, we could split this
into three files (common one that is dot-sourced by two actual
test scripts that have part1 and part2).

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3404-rebase-interactive.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c7ea8ba..4c96075 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1281,4 +1281,11 @@ test_expect_success 'editor saves as CR/LF' '
>  	)
>  '
>  
> +EPIPHANY="'"

Why?  If you really need a variable, SQ is probably the way this
codebase typically spell it.

> +test_expect_success 'rebase -i --gpg-sign=<key-id>' '
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1" git rebase -i --gpg-sign=\" HEAD^ >out 2>err &&
> +	grep "$EPIPHANY-S\"$EPIPHANY" err

I am not sure what is going on here.  You are asking to sign using
the keyid of a single double-quote, and expecting the message that
says

	You can amend the commit now, with

		git commit --amend '-S"'

	...

that has a substring '-S"' in it to ensure that the codepath to
parse --gpg-sign= on the command line of "rebase", and to the
message we see here are working correctly, without actually checking
if GPG is invoked at all, or if it is invoked the key given by the
option is correctly passed to the invocation?

If so, can't you do that without confusing users by using keyid "?
IOW, wouldn't using --gpg-sign=me work equally well?  For example:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4c96075..2dd3644 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1281,11 +1281,10 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
-EPIPHANY="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i --gpg-sign=\" HEAD^ >out 2>err &&
-	grep "$EPIPHANY-S\"$EPIPHANY" err
+	FAKE_LINES="edit 1" git rebase -i --gpg-sign=me HEAD^ >out 2>err &&
+	grep -e "commit --amend  '\''-Sme'\''" err
 '
 
 test_done
