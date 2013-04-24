From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/7] t7008: demonstrate behavior of grep with textconv
Date: Wed, 24 Apr 2013 10:29:55 -0700
Message-ID: <7vmwsnet0s.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<5137a5a48ae6c70ad716d985a22d53ec311ee05a.1366718624.git.git@drmicha.warpmail.net>
	<7v1ua1l1ki.fsf@alter.siamese.dyndns.org>
	<5177AF62.30104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3W9-00088o-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab3DXR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:29:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000Ab3DXR37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:29:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A1D19482;
	Wed, 24 Apr 2013 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrxEGdIVTjuIl6Gl4DbhlaHt34w=; b=fa1/UA
	ssmRrEcfJvHEk8R2jxidjG+njE5Wnu4VdUqXuaILc2Im29D6ONgcMNG/dqO1Q825
	JUD404o9cn2+rSCxR2sGzMyrcG1pQf/a1w9PN4KO8qSN+KRB2a7GVBcz8qIdcHdK
	7DTzGD94sDHz535aM+exgex+pBfdWd7LsNTb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hc4GVV9hjn7YiSezUTLLk7wZes4yAwx1
	i84CDP1+EhMuZpSAAPPRCKNv/aFN+HDd/T50bvtAQdm/Zxt1Iyw5DO23cFhqogaa
	GCV64mGT0H9H6UyTdWLlZBKI1aolfwJgYXjhR34bW+/qht5P+Ir9yffxnxCklfit
	+dC0tWMNFf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9728219481;
	Wed, 24 Apr 2013 17:29:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF3F51947F;
	Wed, 24 Apr 2013 17:29:56 +0000 (UTC)
In-Reply-To: <5177AF62.30104@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 24 Apr 2013 12:09:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 953E92CC-AD04-11E2-B839-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222274>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> +test_expect_failure 'grep does not honor textconv' '
>>> +	echo "a:binaryQfile" >expect &&
>>> +	git grep Qfile >actual &&
>> 
>> This should pass --textconv to "git grep".
>
> But "git grep" does not know that option yet, so the test would fail for
> the wrong reason.
>
> The point ist that I expect "git grep" to apply textconv filters by
> default, which it does not. (I know I might be the only one with this
> expectation.)
>
> Or do we want to document the absence of that option?

First, whether you write expect_failure or expec_success, please
label the test to say what is expected to happen in the ideal world.
The test in question says "grep does not honor textconv", but if you
want it to honor textconv in the ideal world, it should be "grep
honors textconv (when it should)".

Now, from the point of view of testing "git grep honors textconv"
missing support at the command line parser level and a buggy
implementation of the command line parser that accepts but does not
trigger the feature are the same thing.  The command would not honor
textconv either way.

Marking the above as "failure" without explicitly asking for the
feature with "--textconv" means we want it to use textconv by
default, but that is *not* what the test title says is testing.

In your patch, what the body of the text is really expecting is
"grep uses textconv by default".  If that is what it tests, then
passing --textconv from the command line as I suggested would be
wrong, but I was going by the title of the patch.
