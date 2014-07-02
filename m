From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-am: add option to extract email Message-Id: tag into commit log
Date: Wed, 02 Jul 2014 10:17:13 -0700
Message-ID: <xmqq1tu3isti.fsf@gitster.dls.corp.google.com>
References: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avi Kivity <avi@cloudius-systems.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:17:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OA5-0005bZ-1L
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318AbaGBRRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:17:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54917 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbaGBRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:17:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC2302311C;
	Wed,  2 Jul 2014 13:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RPRy2fZh+2Ryu1QpEt0TCKSAX5E=; b=pDB2l7
	TLZxH32N8dujRWkGYFpX1FUEIVn02nlqa/wjt94Vl4BOCjltbABjvuBJ0VC8fSI9
	o9VQNIUfqJwL1+umNjvE22cyPB5cDpg7uBszl+kh9liPyBDRkSFTSySJCSzQ13ri
	X6jNVC1SwSj/wVaNw5PNCv59FOz0oPwcxZsOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dNWkaEqO/OGulIzmTHEdGr0F2KIb8hMj
	lcijxjQn+OCYuokT22hEeDftdImLnfPLsF2DJhbrxClRT5du0QKLT6mDHKe1Ix51
	TBK9VsxNoCfihURIOzqY52eCK58uT4MA/g2Z9QXVCdp9yu1/vjdAjE1zc5pfCVCl
	5bpjt1Reshc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E10082311B;
	Wed,  2 Jul 2014 13:17:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F76823108;
	Wed,  2 Jul 2014 13:17:04 -0400 (EDT)
In-Reply-To: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com> (Avi
	Kivity's message of "Wed, 2 Jul 2014 11:51:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B315FACA-020C-11E4-82EE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252802>

Avi Kivity <avi@cloudius-systems.com> writes:

> +		if test 't' == "$message_id"
> +		then
> +			grep ^Message-Id: "$dotest/info" || true
> +		fi
>  		if test '' != "$ADD_SIGNOFF"
>  		then
>  			echo "$ADD_SIGNOFF"

Seeing how existing code carefully makes sure that ADD_SIGNOFF has
an empty line before it when and only when necessary to ensure that
there is a blank after the existing log message, I would suspect
that this patch that blindly inserts a line is doubly wrong.  The
output from "grep" may be appended without adding a blank when
necessary, and appending of ADD_SIGNOFF may end up adding an extra
blank after Message-Id.  Am I reading the patch wrong?
