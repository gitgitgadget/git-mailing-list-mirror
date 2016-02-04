From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Wed, 03 Feb 2016 16:51:16 -0800
Message-ID: <xmqqio25jo1n.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-5-git-send-email-sbeller@google.com>
	<xmqqd1sdl7bx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZwGPNHeZFcu7-60U8cTZhC8t6TZ5=4ZzBbP+4MrLqRZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR88q-0004Q2-C2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 01:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbcBDAvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 19:51:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754030AbcBDAvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 19:51:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C035942618;
	Wed,  3 Feb 2016 19:51:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=10fQtOTxqVXPSk90oiWH6ezAX2k=; b=hQehHv
	16u4SVtbxnNZmrBHstW1SJV9YmOjzT/pwMxfPv1jZnWJnFaC0iDqYttCDr3Z42on
	L/CGt6RvYNR3LUYInK77vk1KrQNNczdmRd6RdOI/6XLpaLZY2CmGV4u8WoG9y9Yv
	KQ+oKWNQorenmwTpJ8qJ4JbY0DRVI2OeDYTKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=puOcZv1WKIyHYK2evRi6MDKma3HB2FoA
	0nuvOuq04cdU241IUaWsCJ27xMamLk8zvTlzAEdw11Tr50T0ZpObklpy+HYJlaqv
	oA6Wb5eAGN+Jx3piHXuR95rULQ8xCKKfMSSxNTscPFgMfXRRZJKownIfXACgIfGe
	h6DKJx7MrXM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6A1042617;
	Wed,  3 Feb 2016 19:51:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39AB842616;
	Wed,  3 Feb 2016 19:51:18 -0500 (EST)
In-Reply-To: <CAGZ79kZwGPNHeZFcu7-60U8cTZhC8t6TZ5=4ZzBbP+4MrLqRZQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 3 Feb 2016 15:26:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6696410E-CAD9-11E5-BE5C-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285387>

Stefan Beller <sbeller@google.com> writes:

>> The same comment as in the footnote for the review on [3/8] applies
>> here.
>
> Ok, so we want to have
>
>     [section ""]
>
> and
>
>     [section]
>
> be different, such that we could have a submodule with an "" name,
> but still be able to differentiate to the common section which should be
> applied to all submodules?

It is not about submodule per-se, but what is the right way to use
the parse_config_key() function.  If the caller is interested in
seeing if the name is two-level or three-level, NULL-ness of the
subsection pointer is the right thing to check, not the length of
the subsection (set to 0 or positive number if exists--and otherwise
it is set to 0).

People copy & paste existing uses of API functions, and even if for
the specific use of your code (i.e. submodule) it is illegal to have
an empty second level, we shouldn't leaving a bad practice in the
code to be imitated.
