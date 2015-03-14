From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential files
Date: Sat, 14 Mar 2015 15:14:18 -0700
Message-ID: <xmqqfv97w7k5.fsf@gitster.dls.corp.google.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-2-git-send-email-pyokagan@gmail.com>
	<20150313061530.GA24588@peff.net>
	<CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 23:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWuKA-0001DK-31
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 23:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbbCNWOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 18:14:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751215AbbCNWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 18:14:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D49B3E76D;
	Sat, 14 Mar 2015 18:14:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZZsMy13SdElw4OoAjgzA4tzinyk=; b=YDnJwU
	KTHyw+hZ4iJ/M8Y0ksgh32nkRGUQPayqh7KRI7Qqhr9lEOC5PRVFpIxjI2Wv+GOJ
	yB70hBtsQPfSo2Hs6JLU7XYDsmsiLL4hX1k/Ay9+/DoKfmG2E7R1wfwndx0tONWK
	B0mqhGf7B5yvip/6gvGtmT5zPLNnofomKmejM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlhlLRbSNKjMpiB6gfVbb75GcxEH52lI
	x5d6r6F3kvYw7qiR9zxa6ZJYH/m++AHI6tyGqHi5/2uPAZFBV2rO1YxjcsInryIy
	mjKVd67jn9DugBze5jWxzJBL9iCfyjClITvi71isaMai4Qcna77ouIWoTqoA0KAQ
	EE+qTgVFpaY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26A3F3E76C;
	Sat, 14 Mar 2015 18:14:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 965713E76B;
	Sat, 14 Mar 2015 18:14:19 -0400 (EDT)
In-Reply-To: <CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
	(Paul Tan's message of "Sat, 14 Mar 2015 16:15:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75FC1E68-CA97-11E4-B8FD-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265463>

Paul Tan <pyokagan@gmail.com> writes:

>> I think you could even get away without passing default_fn here, and
>> just use the rule "the first file in the list is the default". Unless
>> you are anticipating ever passing something else, but I couldn't think
>> of a case where that would be useful.
>
> Even though in this case the store_credential() function is not used
> anywhere else, from my personal API design experience I think that
> cementing the rule of "the first file in the list is the default" in
> the behavior of the function is not a good thing. For example, in the
> future, we may wish to keep the precedence ordering the same, but if
> none of the credential files exist, we create the XDG file by default
> instead.

I am not sure if this is not a premature over-engineering---I am not
convinced that such a future need will be fulfilled by passing just
a single default_fn this version already passes, or it needs even
more parameters that this version does not pass yet, and the
interface to the function needs to be updated at that point when you
need it _anyways_. One thing that we all agree is that we don't need
the extra parameter within the context of what the current code does.

So, it smells like a case of YAGNI a bit, at least to me.
