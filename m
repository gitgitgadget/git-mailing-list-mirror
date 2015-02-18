From: Junio C Hamano <gitster@pobox.com>
Subject: [Q] should "color.*.<slot> = normal" emit nothing?
Date: Wed, 18 Feb 2015 13:03:06 -0800
Message-ID: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 22:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOBn2-0000fW-O3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 22:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbbBRVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 16:04:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751634AbbBRVEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 16:04:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C841739984;
	Wed, 18 Feb 2015 16:04:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	cbvzWhxRfBM3MdekwKLfscy3HM=; b=iYNAxtUXLW5fGBr4jrOucdmsCN+zcqBDt
	Dg51blYDbh5v49LXTT0K8Lg//zhkWeSarpRrZ8HXIBhiemH38Nnr06vRqcIA5T8m
	Arl61bG8364hLhb95G/y+Nf8STi+81Rowyu8X9x9d9LBb+q9QxPmZorA9Akyharz
	frigf9JK3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=iYQ
	7cFnn2dF60Z/GN4ZWti6yc5AT3y7utDYj7HzWtwEh8W2KycLketNU3HxNLhfIj//
	FiKovEQ42fmj3pyuR9dlOezHVFqpNOSAkF1G3npjdfIQ90pfxvZ8QLgCIXCk9Hrh
	ueta2PN0yCJBVHdpzLfhlfJsku1nsgNpGUB0/TyE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE84339983;
	Wed, 18 Feb 2015 16:04:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F271D39907;
	Wed, 18 Feb 2015 16:03:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89FB7D6C-B7B1-11E4-9B55-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264063>

If you wanted to paint the HEAD decoration as the same color as the
body text (primarily because cyan is too faint on a black-on-white
terminal to be readable) you would not want to say

    [color "decorate"]
        head = black

because that you would not be able to reuse same configuration on
a white-on-black terminal.  I would naively expect

    [color "decorate"]
        head = normal

to work, but it does not.  I notice that we have these definitions
in color.h:

    #define GIT_COLOR_NORMAL        ""
    #define GIT_COLOR_RESET         "\033[m"
    #define GIT_COLOR_BOLD          "\033[1m"
    #define GIT_COLOR_RED           "\033[31m"
    #define GIT_COLOR_GREEN         "\033[32m"
    ...

As a workaround, I ended up doing this:

    [color "decorate"]
        head = reset

which should work OK.  But I have a feeling that the definition of
our "normal" may want to do the "reset", not "no-op" like we
currently do.

Comments?
