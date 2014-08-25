From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Mon, 25 Aug 2014 12:01:15 -0700
Message-ID: <xmqqzjesl7gk.fsf@gitster.dls.corp.google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
	<047d7b624d36142d46050131f336@google.com>
	<20140822154151.GK20185@google.com>
	<xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
	<20140822184515.GL20185@google.com> <20140823054646.GA18256@peff.net>
	<CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzWF-0000Bo-Tj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbaHYTB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:01:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57522 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933174AbaHYTB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:01:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8527835A97;
	Mon, 25 Aug 2014 15:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dRgq3QPy1uBYaTTCC9Y1Cd2xGg=; b=vwZa89
	X/PBp4xNOTF370xMq5of8F1VXqz8gMlzrfY4QQQv7pux+keyJAmPyOSvp0aTLsPL
	MpdQm8TCbMsYYsMIRqeXxAsnePP5wdxzzFRnHyMuuNklVIKAVvNE4U0R8Km0XNqQ
	pBhCe+3S77V0FH65nCEtZSnSjSYptRVn8+dd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nlHkWatVT6b7HynANh+ZKpe+BALKouKn
	/KzqLa6paUwsoDuanm955KZYlewCKUMbJHtQ6lwoGqmNSOISMJJpRNmBoQi3u6Zw
	+RgZi2Er4RPCqKvRVsZHkgRmKgNt1FPz45Yc3IAgPyv/dYZYLtTu58z+F7Ee1j8H
	msjJXUmoLbc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 778E535A96;
	Mon, 25 Aug 2014 15:01:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A25B735A8F;
	Mon, 25 Aug 2014 15:01:17 -0400 (EDT)
In-Reply-To: <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com>
	(Ronnie Sahlberg's message of "Mon, 25 Aug 2014 10:43:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 319313A4-2C8A-11E4-8211-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255853>

Ronnie Sahlberg <sahlberg@google.com> writes:

> There are also a lot of places where we assume that a refs will start
> with "refs/heads/" and not just "refs/"
> for_each_branch_ref(), log_ref_setup() (so no reflogs) is_branch() to
> name a few.

for-each-BRANCH-ref and is-BRANCH are explicitly about branches and
it is natural that they will work only on refs that start with
refs/heads/, no?  I am not sure about log-ref-setup ("git grep pu"
does not find it).

> This makes the api a bit confusing and hard to predict. Which
> functions allow refs/foo and which will ignore it?  Are there any
> compelling reasons why refs/foo should be allowed?

The only one I can think of offhand that we internally use is the
stash, but that does not give us any assurance that no third-party
tool is using refs/frotz for its own use X-<.
