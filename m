From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 10:47:29 -0700
Message-ID: <xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
References: <553CD3DA.9090700@web.de>
	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:47:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymn8A-0004i6-9U
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 19:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbbD0Rrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 13:47:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932656AbbD0Rrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 13:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 375054BE08;
	Mon, 27 Apr 2015 13:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+vo2sOySuMSCM3U3R4vTMEqd1R4=; b=NmuxnA
	wxZhcXgG+97aeD9VON8K9heJmSAHIGF5MvFX5/i1ACfWuz5XEeGT7rSc2h1qggja
	Qle6g/D0nm/X0qtqoadsdBXmaux+GdKUoCixNcnSzt46UWtp24HD4dOgFpM9Yogm
	FWpLqsjGsjt6uuqm2eMccqFOtsJtPdkx5XS5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXc7uj53yrw2hDneuRODq2dwiQ+9DK5f
	cLZP5eO/Xre3lMv0Ks9rcMrXeyl+80nwZ9Jtb9KPU+N9ZsUIsgal1rvov/HukyPg
	hGbZICYKvLoI0RwfEtGg0tQqBU7LlUXqoE0qMwrSLUwh81tOws12HVoLFUEtRpmD
	VfFTMqJ87c0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EA884BE06;
	Mon, 27 Apr 2015 13:47:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 819204BE05;
	Mon, 27 Apr 2015 13:47:30 -0400 (EDT)
In-Reply-To: <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 26 Apr 2015 22:31:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A00AB24-ED05-11E4-B979-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267859>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect (I haven't looked very carefully for this round yet to be
> sure, though) that it may turn out that the commit you are proposing
> to revert was a misguided attempt to "fix" a non issue, or to break
> the behaviour to match a mistaken expectation.  If that is the case
> then definitely the reversion is a good idea, and you should argue
> along that line of justification.
>
> We'd just be fixing an old misguided and bad change in such a case.

The original says this:

    blame: correctly handle files regardless of autocrlf
    
    If a file contained CRLF line endings in a repository with
    core.autocrlf=input, then blame always marked lines as "Not
    Committed Yet", even if they were unmodified.  Don't attempt to
    convert the line endings when creating the fake commit so that blame
    works correctly regardless of the autocrlf setting.
    
    Reported-by: Ephrim Khong <dr.khong@gmail.com>
    Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

But if autocrlf=input, then the end-user expectation is to keep the
in-repository data with LF line endings.  If your tip-of-the-tree
commit incorrectly has CRLF line endings, and if you were going to
commit what is in the working tree on top, you would be correcting
that mistake by turning the in-repository data into a text file with
LF line endings, so "Not Committed Yet" _is_ the correct behaviour.

So I think that the reverting that change is the right thing to do.
It really was a change to break the behaviour to match a mistaken
expectation, I would have to say.
