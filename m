From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] rebase-i: work around Windows CRLF line endings
Date: Tue, 27 Oct 2015 10:25:31 -0700
Message-ID: <xmqqd1w0dy0k.fsf@gitster.mtv.corp.google.com>
References: <cover.1445782122.git.johannes.schindelin@gmx.de>
	<cover.1445939154.git.johannes.schindelin@gmx.de>
	<adcab7dcf9d802b3703b9ec9291132259a092a04.1445939154.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1510271054380.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:25:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr80C-0004f4-1S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 18:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbbJ0RZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 13:25:35 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754398AbbJ0RZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 13:25:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58FC825E6E;
	Tue, 27 Oct 2015 13:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xaWgVxEdXysVI0CyjRGoR1xirVE=; b=bPdtpu
	y0E/xO1Mu+cLKTd5wPDsRBKXE7ojLH6Q3QwsnQR5WQ+yLEYBAwVbTF/X/Ftb8bVo
	uX4YVs/xdfcXQZ1Ojg97VpZ8uudajrC2GphiTxkKPdO5W07N/JO9N5H32eb3m0NV
	wbDTQVwqZsR0ai/0oSgCGpKXzpWkZXWqOxmIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpfeSWLA+mY5COzeug/O4q2erHR7Moum
	2gBmyFbFCtEak2sj/hK97dzqY16KyHk8NlHVyn8YqeG9TSYpUoPedXWJgvxpDxFG
	pNrCy+zyWh9dxRYL3BQ1MHklKgT/tgzd3SrMQ8bv3RtL8IQRtdHXGkiR240SgKMf
	IK0SoPyzZAA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47AF025E6D;
	Tue, 27 Oct 2015 13:25:33 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF91725E6C;
	Tue, 27 Oct 2015 13:25:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510271054380.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 27 Oct 2015 10:55:44 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA28D1CC-7CCF-11E5-9AAA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280269>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 27 Oct 2015, Johannes Schindelin wrote:
>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 5dfa16a..98eb49a 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
>>  	test E = $(git cat-file commit HEAD | sed -ne \$p)
>>  '
>>  
>> -test_expect_failure 'editor saves as CR/LF' '
>> +test_expect_success 'editor saves as CR/LF' '
>>  	git checkout -b with-crlf &&
>>  	write_script add-crs.sh <<-\EOF &&
>>  	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
>
> My apologies: I forgot to spell out explicitly that this passes in Git for
> Windows 2.x' SDK: It does.

Can you add that to the log message?  Your cover letter may also
want to be updated for those who fish for the last version posted
in the list archive.

Thanks.
