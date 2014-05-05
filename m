From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: #178 parsing of pretty=format:"%an %ad" causes fatal: bad revision '%ad'
Date: Mon, 05 May 2014 16:02:34 -0700
Message-ID: <xmqqtx9396d1.fsf@gitster.dls.corp.google.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
	<20140502172358.GI9218@google.com>
	<CABPQNSYTWYwSgd=sa0QGmaFDuzprLzLNYmQEx-6MrZ_HEZimww@mail.gmail.com>
	<BLU0-SMTP387BC836A8719897DD84B79F4D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <kusmabite@gmail.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
	"GIT Mailing-list" <git@vger.kernel.org>,
	"msysGit" <msysgit@googlegroups.com>
To: Dave Bradley <dbradley2@bell.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:20:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiD1-0007Xo-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbaEEXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 19:02:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53425 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756864AbaEEXCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 19:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC54F15158;
	Mon,  5 May 2014 19:02:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qW2Vx2jw5BJR+qOIXVyo75fyARE=; b=vXoQ3Q
	nGlkFnK/mHSQJEbMmyUuYwJvYIGFLBHtv3O0JHNxpfyfpvlWfmEvltng2eZzh9+0
	2VfcRvwL8Pod/5zdWlW5b8N1yr5dZcD5ShAIZ4NnG/WiWZgBXfi5fJ7kEFbNqz7r
	FjcOrFaxc96ft4U61yxo7STf02ubxR6zHEbVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O/e7Bh/kRfDxHkemWUYobICWHyTn0Nz0
	Wtl42m0UtJ8Td4jYx7kixaVi7lhZ/1+NfvOagQsqqrCeNSNf6owqzcu6X4vOv+oB
	m6/Flmj70rwwlZxIiVGRnR921g4PKuuYkCF34PBeIyX17HmLjINvwuKKFhIXtYQF
	qUNzvDo3g9s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C207F15157;
	Mon,  5 May 2014 19:02:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9442715155;
	Mon,  5 May 2014 19:02:36 -0400 (EDT)
In-Reply-To: <BLU0-SMTP387BC836A8719897DD84B79F4D0@phx.gbl> (Dave Bradley's
	message of "Sun, 4 May 2014 06:14:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 596E78AC-D4A9-11E3-9539-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248179>

Dave Bradley <dbradley2@bell.net> writes:

>> Original #178 content
>> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all
>> "--pretty=format:"%an"    "%ad"" -- pom.xml
>>xxxx xxxx    Mon Nov 23 03:09:17 2009 +0000
>>xxxx xxxx    Mon Nov 23 02:42:24 2009 +0000
>
> This added to my confusion as by right dq within dq should be
> formatted.

I do not see any dq within dq here.  Perhaps you need to count again
to see which one pairs with which one.

What I see are these three strings concatenated together:

        --pretty=format: (which does not need any dq)
        %an"   "%ad     (the dq protects 3 SPs inside)
                        (an empty string inside the final dq pair)

So the single parameter that begins with --pretty given to "git log"
is exactly the same as what is inside the single dq pair in the
following:

	"--pretty=format:%an   %ad"

A more conventional way to spell it may however be one of:

	--pretty=format:"%an   %ad"
	--pretty="format:%an   %ad"
