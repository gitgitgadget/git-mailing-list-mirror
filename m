From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow TTY tests to run under recent Mac OS
Date: Thu, 13 Nov 2014 14:21:42 -0800
Message-ID: <xmqq1tp6zqq1.fsf@gitster.dls.corp.google.com>
References: <1415916087-18953-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp2lz-0001qE-4B
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 23:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934105AbaKMWVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 17:21:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933065AbaKMWVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 17:21:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 925F41E5D6;
	Thu, 13 Nov 2014 17:21:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ZLEVrVaB3s2s5zr17UaLLFpI/A=; b=SIMSfo
	Jbci1iwSb5X3xiAe3sxvRT9B94YCl4Ci5IQKnvfB628I7CB0Qp/jL0QG1ev1HwEn
	/axnnuETb4ctzV+73uo0hjGtA8Ls6/+FhEIpveewujL/NcjfdI8WJRFpIyp7rLcc
	0Lt3lpSNRVXysa3kheETpM26Q9kxwNPRXl2MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V2wVsmPZtykvv5aYYNTqsqu32pP2tZUP
	Ab7ub7Na2nzc2mq9fqFt6sbEyH7kMifCNobCKm2KEf3rlbPpw7raclStXf1ovySp
	84g1c8CLRqdPTz8H+JhlQYw4j67V50Gw//Rcqh/mAsFsilzZ5MshvrqjHeA3VkY/
	LfsojT0vRsQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 893A51E5D5;
	Thu, 13 Nov 2014 17:21:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCC7D1E5D3;
	Thu, 13 Nov 2014 17:21:43 -0500 (EST)
In-Reply-To: <1415916087-18953-1-git-send-email-blume.mike@gmail.com> (Mike
	Blume's message of "Thu, 13 Nov 2014 14:01:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72D11BD0-6B83-11E4-B783-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Blume <blume.mike@gmail.com> writes:

> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
> TTY on Yosemite and higher
>
> Signed-off-by: Mike Blume <blume.mike@gmail.com>
> ---
>  t/lib-terminal.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 5184549..1311ce0 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>  	# After 2000 iterations or so it hangs.
>  	# https://rt.cpan.org/Ticket/Display.html?id=65692
>  	#
> -	test "$(uname -s)" != Darwin &&
> +	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
> +	# appears to be gone.
> +	#
> +	[[ test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1") -ge 14 ]] &&

This is designed to be a plain vanilla POSIX shell script.  Please
avoid these double brackets.

>  
>  	perl "$TEST_DIRECTORY"/test-terminal.perl \
>  		sh -c "test -t 1 && test -t 2"
