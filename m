From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Thu, 16 Aug 2012 16:40:25 -0700
Message-ID: <7vk3wyxv6e.fsf@alter.siamese.dyndns.org>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
 <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk>
 <7veho1exu6.fsf@alter.siamese.dyndns.org>
 <501043D9.70604@ramsay1.demon.co.uk> <20120725205120.GD4732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29g2-0007oc-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab2HPXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:40:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464Ab2HPXk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:40:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 588FB926C;
	Thu, 16 Aug 2012 19:40:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SB96p6rKMh2hBOIaOzc/7WU/bY=; b=xrnRmu
	/GfGnctfKVKGUy1PO/kBNZEeKu984G6m1Ya80jEp+OCH6i6mAcvgjSCj/VuAqV80
	oS/imX5+8osWQY74Ud/0KsqzLhyK2ft+zSKuViAJVQFo22b1szSlVBNGAZP9WTcC
	Or+3u6zhe0HXZzlFY/s4lRoXZw3uwFkWzU0zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZfaRXzcRAyAIx2CUKc1Xpig1/2YTdvGz
	BY3ryJKh93W9ezO3QXLijEIM3DeDDH6B6De9LCuvmwoxQxLqN95w0h6oMp23Ctmh
	oFJCV9vioU4TXe6TCMBenZyGztOSgR0SSjeeQhJCHWiKJafOMACahUdpe+brh2IZ
	I0rgeAU5YWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44F4D926A;
	Thu, 16 Aug 2012 19:40:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98C639266; Thu, 16 Aug 2012
 19:40:26 -0400 (EDT)
In-Reply-To: <20120725205120.GD4732@burratino> (Jonathan Nieder's message of
 "Wed, 25 Jul 2012 15:51:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C175968E-E7FB-11E1-8736-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramsay Jones wrote:
>> Junio C Hamano wrote:
>
>>> Observing that all well-written test scripts we have begin with this
>>> boilerplate line:
>>>
>>>	test_expect_success setup '
>>>
>>> I wouldn't mind introducing a new helper function test_setup that
>>> behaves like test_expect_success but is meant to be used in the
>>> first "set-up" phase of the tests in a test script.
>
> Neat.  This could be used for later set-up tests, too, perhaps with a
> long-term goal of making non set-up tests independent of each other
> (reorderable and skippable).
>
> [...]
>> [1] For example, what should/will happen if someone uses test_must_fail,
>> test_might_fail, etc., within the test_fixture script? Should they simply
>> be banned within a text_fixture?
>
> Why wouldn't they act just like they do in test_expect_success blocks?
>
> FWIW I find Junio's test_setup name more self-explanatory.  What
> mnemonic should I be using to remember the _fixture name?

I see that I was distracted by the "where does the fixture come
from" and did not follow through.

I think what it does makes sense (I haven't checked all the
redirections, though).  Do we want to resurrect the topic?  It needs
a paragraph in the proposed commit log and t/README to explain the
motivation and the usage.

Thanks.
