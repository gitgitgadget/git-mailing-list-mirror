From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other remotes
Date: Sun, 23 Jun 2013 15:33:18 -0700
Message-ID: <7vmwqge9u9.fsf@alter.siamese.dyndns.org>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	<1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	<7v8v23mhjy.fsf@alter.siamese.dyndns.org>
	<1371994516.24315.8.camel@localhost>
	<7vvc54ed53.fsf@alter.siamese.dyndns.org>
	<1372023811.24315.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 00:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqsqd-0002jJ-8j
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 00:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab3FWWdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 18:33:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab3FWWdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 18:33:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2062A82E;
	Sun, 23 Jun 2013 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGPuByWxhBOIWOTIIvEGrnqNzZ4=; b=Oh2Xqa
	mC2sOxy798KGM2EaEudPChJ05G+RT9O8tDxPwhRR2Q7Uq8TvFo+o+qCCXQXgW2cX
	p/E7iPW3rvT/p00NftPuvMJ1lH6/ZItyZIvhcXOQmq+nxrsNorqz11bhznBrFndc
	ZCu3Ent4ESEFKxZniT+JLo0avLD7/byXEacxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Abxu3vNEnAWKZvU03+H/s0Ox9vxhrHEZ
	eLeOqTYuJSi4echGT8sK63br8OYa4WoC8D5fvtjXl9kwEq1Sn4DfkHjpmM6nd/YH
	wjVVJ8iTIv9RzerGxcOu3ufOGaPRKzQyuR11rzwvIXuvxEOpsG3IOTP7SSk7LtkV
	ga5Bz6wZH9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 526422A82D;
	Sun, 23 Jun 2013 22:33:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8E822A82B;
	Sun, 23 Jun 2013 22:33:19 +0000 (UTC)
In-Reply-To: <1372023811.24315.15.camel@localhost> (Dennis Kaarsemaker's
	message of "Sun, 23 Jun 2013 23:43:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7CE5430-DC54-11E2-9030-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228764>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On zo, 2013-06-23 at 14:22 -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> 
>> > Equality for
>> > wildcards is allowed and tested for, so do we really want to 'outlaw'
>> > equality of non-wildcard refspecs?
>> 
>> I am not sure what you mean by "equality for wildcards is allowed".
>> Do you mean this pair of remote definition is sane and not warned?
>> 
>> 	[remote "one"]
>>         	fetch = refs/heads/*:refs/remotes/mixed/*
>> 
>> 	[remote "two"]
>>         	fetch = refs/heads/*:refs/remotes/mixed/*
>
> I personally don't consider them very sane and didn't originally support
> that. But this behavior is tested for in t5505-remote.sh test 27, which
> started failing until I stopped warning for equal refspecs. This support
> for "alt remotes" in prune was added by c175a7ad in 2008. The commit
> message for that commit give a plausible reason for using them.

I actually do not read it that way.  What it wanted to do primarily
was to avoid pruning "refs/remotes/alt/*" based on what it observed
at the remote named "alt", when the refs fetched from that remote is
set to update "refs/remotes/origin/*".

The example in the log message is a special case where two
physically different remotes are actually copies of a single logical
repository, so in that narrow use case, it may be OK, but it is an
unusual thing to do and we should "warn" about it, I think.

In any case, I've been assuming in this discussion "allow" is to
silently accept, and overlaps are "warned" but not "rejected".  So
if you meant by 'outlaw' to die and refuse to run, that is not what
I meant.
