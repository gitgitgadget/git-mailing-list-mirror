From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 05 May 2016 16:27:30 -0700
Message-ID: <xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:27:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySgL-0004YY-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbcEEX1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:27:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756407AbcEEX1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:27:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 222B7194A6;
	Thu,  5 May 2016 19:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dWDwhnmlxeZIcj1rx84b53hdFpc=; b=kQQBIP
	LZw0Hd22AM0A4YZch3XwEZQZSnHU0TMEo4OTlGTshlf8t8RqsZWXwbRqJAZOpik0
	ApLU8vZOE9/OuSquEpyVioWi6MdV1i48Ry6vgwH0srnHqfxry1nVouOtBvJPLif1
	4Upvm9znALNgVuR8VFOWfyt2MXBZtCpaHgqag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rf9aP2pKlTWR05VksS4MpeIlw0a8hfVX
	QMNw5T7mTCRildP3gsXbeL5iFeBXzt5o+eNwh1sFX/POr2Kpi0Wn0ffE4mHDF/fg
	kgYqeicQ8e2Obd2kqVKyDlxa6syQ9nD0TkcXvHqlpJBtc5tVoxMRdx32mkpJ6w8y
	mbca8Szsf1Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19DCF194A5;
	Thu,  5 May 2016 19:27:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BE66194A4;
	Thu,  5 May 2016 19:27:31 -0400 (EDT)
In-Reply-To: <CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 16:15:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0773D38-1318-11E6-AB47-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293726>

Stefan Beller <sbeller@google.com> writes:

>> I wonder if the patches mentioned have something to do with the "git
>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>> repository in some way?
>
> Which is considered a feature now. Maybe we should add tests for that?
>
> http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb

That is a bug, plain and simple.  Duy any ideas where we went wrong?

I think we already have code to avoid adding beyond symlinks.
"git add deep/in/the/tree" should refuse if deep/in is a symbolic
link (and happens to point at a directory that has the/tree in it).
We used not to catch that long time ago, but I think we fixed it.

The logic and the places to do the checks for "no, that thing may be
a directory but is an unrelated repository" should be the same.
