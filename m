From: Junio C Hamano <gitster@pobox.com>
Subject: Re: detached HEAD before root commit - possible?
Date: Sun, 23 Jun 2013 22:01:18 -0700
Message-ID: <7vbo6wdrvl.fsf@alter.siamese.dyndns.org>
References: <20130623225505.GO20052@goldbirke>
	<20130623235432.GA3024@elie.Belkin>
	<CANiSa6jNjCDjj_ZD7COXyDUx9DxFpuVqT-Lm24KQVMDK=serpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 07:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyuI-000158-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 07:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab3FXFBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 01:01:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3FXFBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 01:01:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 346DF273F8;
	Mon, 24 Jun 2013 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ejGYSf4sGhfYqza91cz2WNyT+GU=; b=o+0RTQ
	SXr7c6uOEOGwbNoazuHMTwXLus1Va62ZAjF8hkATS8Ti7btAsPw/DLDjYP8mf+rp
	/T5FHRnGZx0mg9EpO/9jzrNur8UWhzrfrz36NFR//UdTZ7+2d1Hp/Fril+c3+PG+
	yFAQ6FF1oyPXn0+oee+Cux1VAKSblE6w1bbOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ML7tDXBQETT3akOj0YzjTX+D2sSxARg6
	xgeSU0YFMAqylrhU6LjW1IPH7WuZbckIgB3x1+UEJGze7AQ04nWO0EbdxXulsVi3
	A6GV4SlgoXzXWWwOGEbch7d+yHILHOgpERk2hN8FY+BtBbtG2xJW2D5cv6/57L51
	jLw33CVDzuU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B6F273F6;
	Mon, 24 Jun 2013 05:01:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 980D7273F5;
	Mon, 24 Jun 2013 05:01:19 +0000 (UTC)
In-Reply-To: <CANiSa6jNjCDjj_ZD7COXyDUx9DxFpuVqT-Lm24KQVMDK=serpw@mail.gmail.com>
	(Martin von Zweigbergk's message of "Sun, 23 Jun 2013 21:20:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B9BFD86-DC8B-11E2-867B-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228776>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Sun, Jun 23, 2013 at 4:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> In other words, HEAD always either points to an unborn or existing
>> branch or an existing commit.  It's not clear to me what it would
>> mean to detach from an unborn branch.
>
> I think it should mean that the next commit would be a root commit (of
> course) and that HEAD would be detached and point to that commit.

Yup.  As Jonathan outlined how the current system works:

 - $GIT_DIR/HEAD could be a symref to a branch, which may or may not
   exist (the latter being "unborn"); or

 - $GIT_DIR/HEAD could be directly pointing at an existing commit,
   which is the definition of "detached", as you "detach HEAD at
   that commit".

even though such a "I do not have any commit and I will not be on
any branch" state were to be supported, the consequence of that
would be that a natural implementation of such a state is to
represent it by not having $GIT_DIR/HEAD at all.  That will break
quite a lot of things, as such a directory $GIT_DIR will not be
treated as a git directory in the first place.  Of course, you could
fix them up to support it, but I doubt if it is worth the trouble.
