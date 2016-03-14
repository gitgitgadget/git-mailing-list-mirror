From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 14 Mar 2016 11:37:46 -0700
Message-ID: <xmqqh9g8aosl.fsf@gitster.mtv.corp.google.com>
References: <1457739683-1972-1-git-send-email-sbeller@google.com>
	<xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYc1WR9CTBi1F3KpLaYRUSxNPQkQ2jk+P09pshR3jG8aw@mail.gmail.com>
	<xmqq60wra40h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kb731RzLco_thuucTokLCe4xNMbEod9C=gWG+P+ruih7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afXNR-0004Ya-BH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbcCNShz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:37:55 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753738AbcCNShy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:37:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CEA24BCED;
	Mon, 14 Mar 2016 14:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Gp0CmNwT6e0ibTmBSKl9Ik1GUo=; b=gB1fXI
	8zBmwH8jgoeL+xuLmvE8HnNQeWb+jKD+46TeI+/mJUysCr+QYl0Ty/NzRTyD949N
	gez0kgtgRSno6KWQjqH7HmWt7tA3/4X12tmva1a6an66getwy8Vhef6OHlv5sOke
	tpfcu3/dwMtRd0msXWOgZRumu/yG7UyJhIPno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3b9XUL7SHoGr7vSbOBg68z9fjTdlqYI
	Kg0lkXx7zUyGwFhe5N9IqMZMio7jWtUqMG2OqAxWbWo8BT++niDi6+KNjclknJEg
	9yRf1CM5Mg7AmK1mBVpYkmcZ55tfdOLE8TD1YkD0xLE7YOoJyjl+2mVOVRUhJ0Ai
	F93B5VD5IIY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4284A4BCEC;
	Mon, 14 Mar 2016 14:37:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB1474BCEB;
	Mon, 14 Mar 2016 14:37:47 -0400 (EDT)
In-Reply-To: <CAGZ79kb731RzLco_thuucTokLCe4xNMbEod9C=gWG+P+ruih7g@mail.gmail.com>
	(Stefan Beller's message of "Mon, 14 Mar 2016 11:17:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D96DA088-EA13-11E5-871A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288799>

Stefan Beller <sbeller@google.com> writes:

> you'd fetch as usual without moving the anchor point. You could have
> options like
>
>     $ git fetch --recurse-submodules[=label/pattern]
> --unshallow-submodules[=label/pattern]
> ...
> So the first one should be shallowed after fetch, but the second would
> fetch or even deepen automatically?
>
> I am not sure if we add too much "intuitive magic" here as it would be
> hard to explain why that happens?

All of these are things that need to be thought about when you are
making more things recurse into submodules, as you would want to
make sure people can do different things to each of the submodule
they have.

And if my comment to an RFC/PATCH made you think about them, it
served its purpose.  I didn't mean to say "You must implement the
smart from the beginning"--I just meant to say that users will
expect more from the recursive behaviour and you must be prepared
for it.
