From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 maint] git-svn: Fix git svn log --show-commit
Date: Fri, 20 May 2011 09:17:16 -0700
Message-ID: <7vk4dl4a9f.fsf@alter.siamese.dyndns.org>
References: <87y622doa7.fsf@norang.ca>
 <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Bernt Hansen <bernt@norang.ca>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 20 18:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNSOO-0002JI-52
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 18:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935043Ab1ETQRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 12:17:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934520Ab1ETQR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 12:17:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 468A54E6F;
	Fri, 20 May 2011 12:19:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20J+WO/9HLk94sy9gWbO+qovcNU=; b=YPv7cP
	SYntK3eQliD2iNgvxVeERUJMbqSa1omoYz1xEstc0lpJkjCf2NopMHZeUTHV6spF
	ponAoEBmQNczreEn51vUvY5E4DRV+IJ+qt5ETmKwi9cTPgcbscRmIPSi7ZzC9DJh
	ECLaApd8x9BdKU4ZjLI8bn1/4PkZGB2uQcFHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSz7Cx4rJlTSYFgX8QWz0R3tJHANjqPN
	VuPZ2wGJUz+qzsDqj99/meUEzjV3npG4NQ/bbVXAt6mEHeRUuOO/23SUlLUCrxP7
	V8WDMlmqx1D7khIdU7+ylIRX8o/2XZV0nYbshril+lA3KCGe91sjU+b5X4ZmJGtv
	67pGrc31+KQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04B694E6E;
	Fri, 20 May 2011 12:19:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B9354E66; Fri, 20 May 2011
 12:19:26 -0400 (EDT)
In-Reply-To: <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 20 May 2011 13:16:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1AF922E-82FC-11E0-9B22-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174063>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git svn log --show-commit had no tests and, consequently, no attention
> by the author of
>
> b1b4755 (git-log: put space after commit mark, 2011-03-10)
>
> who kept git svn log working only without --show-commit.
>
> Introduce a test and fix it.
>
> Reported-by: Bernt Hansen <bernt@norang.ca>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> git svn scares me.

Sorry about this breakage. 

> diff --git a/git-svn.perl b/git-svn.perl
> index a5857c1..0cee0e9 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -5735,7 +5735,7 @@ sub cmd_show_log {
>  	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
>  	while (<$log>) {
>  		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
> -			my $cmt = $1;
> +			my $cmt = $2;

Even more defensive approach would be not to grab the grouping by doing:

-  		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
+  		if (/^${esc_color}commit (?:- )?($::sha1_short)/o) {

and not to change anything else. I should have noticed the $1 reference
that was immediately on the next line when I saw and applied your patch,
but if there were more references in the scope that is outside of the
patch context, the same bug would be likely to have gone unnoticed.

I do not have enough bandwidth to read every single line of the patch from
everybody, so small bugs in patches from known to be good people (you
included) can slip through, unless marked with "I am not familiar with
this codepath" or "I am not strong in Perl regexp" or somesuch, in which
case I try to allocate more time to give it another pass of eyeballing.

In any case, thanks for the fix. I think being defensive with (?:) would
be a better idea, so I'll tweak the patch before applying with your test.
