From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 14:16:22 -0700
Message-ID: <xmqq3838nl5l.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
	<554BBCBE.1020408@diamand.org>
	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
	<554BCE25.5070308@diamand.org>
	<xmqqa8xgnlme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 07 23:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqT9i-0003n8-IN
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbbEGVQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 17:16:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750995AbbEGVQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 17:16:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3197509CB;
	Thu,  7 May 2015 17:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=auKxJOCNSIJlEENePKsqq00/1IQ=; b=DJIg7Z
	C4LmXGh4nnOBeDk5S9LlLC5R2I1ygqWeZ+4G+Bx1+XGPe8hgY+WEm6UmvWtt5dzQ
	73JD56vvQiR93SlqOf35MXqMqTpHg7v8FDZgPnMb+JLsOOZ7QgTWw6PXdi9hxhtd
	k0WthPuimzBbydIaRhvzi8c3KBBq2x+cIITC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYjjYk4UDP8PQC1y+SStZE3rLmObkHfU
	0XshY1/LXZpTzlq19UziTk4oV9NIshkJE25pAkQtI8KtFktRaqcv17wiziE5ngmG
	u+Z2VvqRZSJgp2tyNd08NQHa7siUtPiOEFnrYn0F5PBpE6f62u8BWUsS8Pr7P1nq
	3+nUzBgXTeU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA6E1509CA;
	Thu,  7 May 2015 17:16:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C1D8509C8;
	Thu,  7 May 2015 17:16:23 -0400 (EDT)
In-Reply-To: <xmqqa8xgnlme.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 May 2015 14:06:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 504140E0-F4FE-11E4-819E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268590>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps something like this would work (totally untested)?
>
> diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
> index 8931188..a47b44b 100755
> --- a/t/t9805-git-p4-skip-submit-edit.sh
> +++ b/t/t9805-git-p4-skip-submit-edit.sh
> @@ -90,8 +90,9 @@ test_expect_success 'no config, edited' '
>  		cd "$git" &&
>  		echo line >>file1 &&
>  		git commit -a -m "change 5" &&
> -		P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
> -		export P4EDITOR &&
> +		customEditor="$TRASH_DIRECTORY/ed.sh" &&
> +		P4EDITOR="\$customEditor" &&

Sorry, this inside should be quoted a bit more so that the executed
command becomes

       sh -c '"$customEditor" "$@"'

i.e. the shell at the beginning of system sees "$customEditor"
(including the double quotes) as a quoted variable, expand the
environment variable as exported, and treat it as the path to
the program.  Again untested but I think

	P4EDITOR="\"\$customEditor\"" &&

should do the work.

> +		export customEditor P4EDITOR &&
>  		git p4 submit &&
>  		p4 changes //depot/... >wc &&
>  		test_line_count = 5 wc
