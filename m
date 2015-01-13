From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 06/10] receive-pack.c: negotiate atomic push support
Date: Mon, 12 Jan 2015 16:08:51 -0800
Message-ID: <xmqq4mrv5yp8.fsf@gitster.dls.corp.google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-7-git-send-email-sbeller@google.com>
	<CAPig+cQv6Dr7z56qXiqzZLmuBt=_TWcPSpQSTyLv0euT-k+umA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:09:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAp2g-00055n-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 01:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbAMAIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 19:08:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbbAMAIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 19:08:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9712A2F8D6;
	Mon, 12 Jan 2015 19:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P+fi+gSUY3Bu2m5NflCL1e4DEsU=; b=KugQvu
	0GgeFA/5L/q7g7nTO46ajUfotXRFpp/j9bWhZ8rF0KMEdwJW/DZYv4QZciuovGIx
	Z54a7Lfakj8+4VHKh2lxObXCpzizcLNCLYhS3qftPOrR72L3lt6aZTpwUeNVu6on
	189UhqYbJV90CjzkpUkZtaohNYEp7kiKmGxMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xIzUV1MR5JtRnWvVPIxHh8zb6iadfodW
	uhbeyaDm5OicGLTtYBtfF1Lnn88DXvcwvGePw2IQzBjj50ezNDQjiP8eqwgc0bql
	nArfELMNGJlJpUAt6MIn2CkbQva86P1EDQKTkQ9/6jlc9pKYSI7J20OTJMG9ZLLk
	d6xgPLec0LI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BCA22F8D5;
	Mon, 12 Jan 2015 19:08:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA3512F8D4;
	Mon, 12 Jan 2015 19:08:52 -0500 (EST)
In-Reply-To: <CAPig+cQv6Dr7z56qXiqzZLmuBt=_TWcPSpQSTyLv0euT-k+umA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 12 Jan 2015 18:29:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BA8E3F2-9AB8-11E4-A96A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262308>

Eric Sunshine <sunshine@sunshineco.com> writes:

> If it's only intended to assist automated testing, then perhaps
> control it via an environment variable rather than a configuration
> option. (See, for instance, GIT_TEST_SPLIT_INDEX or GIT_USE_LOOKUP as
> precedent.)

Note that passing environment to receive-pack is very cumbersome in
general, unless you know you will only use local transport via forked
process pair.

By the way, is USE_LOOKUP still viable these days?  I think it was
added long time ago as a knob to allow us to experiment, so that we
can decide which codepath should survive, but if nobody has done any
meaningful benchmarking since it was added, perhaps we do not need
to keep the conditionally used codepath.  We, who are too lazy to
even try it out, do not deserve its benefit even if the experimental
codepath turns out to be vastly faster.
