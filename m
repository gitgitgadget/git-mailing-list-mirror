From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHi v4] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Fri, 12 Nov 2010 13:44:13 -0800
Message-ID: <7v1v6qfc9e.fsf@alter.siamese.dyndns.org>
References: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
 <1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Fri Nov 12 22:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH1QW-0005uu-Jp
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 22:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960Ab0KLVoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 16:44:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932945Ab0KLVof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 16:44:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4E883C25;
	Fri, 12 Nov 2010 16:44:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KI1tdwNTM/+PrOsxPNQwojeq5jQ=; b=Z8IyNd
	mk6AjHoDDZCOfKk2sDnDnA5YZv5v+3K9NoRZhqx+BaWBRBpo0jEmaY2K9MbVHAvP
	Du5mC3Ji3iuMeW60IW5jNpP44LktfVig5dyF5udVNUfnkGuBLNyADe43CnedyloP
	ZqM0AY5Jtw2j+7hUt+sSqTvY9K5R5v/D944Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l93S4sVdpMMZs7Ds5hTqO2EG0ejDuysA
	fwJb7PaoGddSViQTJHG2bRsc5dEhpeAxrIWJKGYljKsmPVVV8wjKI4YY1JNTVRfT
	fEwAAhB1hk6nQr9baNtnEzSE58wxLROaj+1nCbo4FqBH8lKAzwN0aIPjpDdYnL8f
	Jd+8Cppwgj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C5B43C1E;
	Fri, 12 Nov 2010 16:44:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31E343C1D; Fri, 12 Nov 2010
 16:44:19 -0500 (EST)
In-Reply-To: <1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
 (Antonio Ospite's message of "Fri\, 12 Nov 2010 15\:55\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 079C1364-EEA6-11DF-AB75-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161363>

Antonio Ospite <ospite@studenti.unina.it> writes:

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 26c2e93..5e48318 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -324,9 +324,11 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$patches $patches $patches \
>  		2>errors &&
> -	# All the messages are replies to --in-reply-to
> +	# The first message is a reply to --in-reply-to
>  	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
>  	test_cmp expect actual &&
> +	# Second and subsequent messages are replies to the first one
> +	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
>  	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
>  	test_cmp expect actual &&
>  	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&

Looks good ;-)

I'll do the obvious fix-up (below) at my end, so if there is nothing else
there is no need to resend.

    Look at the v2 series in the illustration to see what the new behavior
    ensures:

           (before the patch)          |      (after the patch)
     [PATCH 0/2] Here is what I did... | [PATCH 0/2] Here is what I did...
       [PATCH 1/2] Clean up and tests  |   [PATCH 1/2] Clean up and tests
       [PATCH 2/2] Implementation      |   [PATCH 2/2] Implementation
       [PATCH v2 0/3] Here is a reroll |   [PATCH v2 0/3] Here is a reroll
       [PATCH v2 1/3] Clean up         |     [PATCH v2 1/3] Clean up
       [PATCH v2 2/3] New tests        |     [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation   |     [PATCH v2 3/3] Implementation

    This is the typical behaviour we want when we send a series with cover
    letter in reply to some discussion, the new patch series should appear
    as a separate subtree in the discussion.

Thanks.
