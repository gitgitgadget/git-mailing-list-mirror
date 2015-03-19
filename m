From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Thu, 19 Mar 2015 14:15:19 -0700
Message-ID: <xmqq3850it94.fsf@gitster.dls.corp.google.com>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
	<xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
	<20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhmp-00058q-6t
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbCSVPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:15:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbbCSVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:15:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A16FA41833;
	Thu, 19 Mar 2015 17:15:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUuZLX+a18PnXtWXEmQMpQInsqM=; b=w0BrFp
	1vpA3buOwQbNowKBFIFsxLNgNUp2hguT8U1yDSmNbNzRR5V67t/dJAgiyJfrzmhL
	C4K7eKGX8UxN+TuLvgtRpdp2WqrABxFL5Z2fR981r/sjvuHtYDs6yIURNrbr4Ofm
	d186Ko/auRbwqurbHF63B845D3ZihrgHORsp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X4vn0mQBIO/W9ER3AE9fFu1O26Yy+qWE
	Vyy9vEA6Kuz0soSKx0aWZ5FHaB0eFbwjhCn+sUTwSLyJTGqEvFCOkyyfmbIwobBh
	Ubt+AHxIKBUgd0SAgl1SJoWGY8VdbXPiZgwArpncZ41s1UR0dla56K6DJwqsu4WZ
	kiFe3+9uQLI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 997DB41832;
	Thu, 19 Mar 2015 17:15:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A64141830;
	Thu, 19 Mar 2015 17:15:20 -0400 (EDT)
In-Reply-To: <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com>
	(Trevor Saunders's message of "Thu, 19 Mar 2015 16:15:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C60FC64-CE7D-11E4-B28A-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265834>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> On one hand it seems kind of user hostile to just toss out any changes
> in the submodule that are uncommitted, on the other for any other path
> it would seem weird to have git checkout trigger rebasing or merging.

I think that is exactly why we do not do anything in this codepath.

I have a feeling that an optional feature that allows "git submodule
update" to happen automatically from this codepath might be
acceptable by the submodule folks, and they might even say it does
not even have to be optional but should be enabled by default.

But I do not think it would fly well to unconditionally run
"checkout -f" here.
