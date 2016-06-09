From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t1404: document function test_update_rejected
Date: Thu, 09 Jun 2016 09:05:04 -0700
Message-ID: <xmqqa8iujqkv.fsf@gitster.mtv.corp.google.com>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
	<2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
	<5756FCF3.7050509@kdbg.org> <57598F2F.9050806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:05:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB2SP-0003H3-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 18:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbcFIQFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 12:05:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932075AbcFIQFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 12:05:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 830B32104C;
	Thu,  9 Jun 2016 12:05:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SOmZoqd+nJvNLXqcnBYT7rsua1U=; b=vKnaPL
	Nmw566P80mUVOAUELKqTRsQz9tEifu3HXquKfX5fdg1k0My6X+iy8ra+hXKV6CZr
	cjYcurbHSYVoWhYaN2FhczA/VpSt64mHpGE05zk1/e4Tl3hK2bwmdeLLALd2uKuB
	dEgFUQ4yuebhTUiRgtjAc6jxsQ9DZSg2yRDRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRVW1GAlY0+Db0cutZ3YnxLticfaLjyq
	ol0Zj5zm105psGoaPPOdpnSV4XQ3xtMvFiBOO40N0mZb65UXQbVewM7T6wEJGsv7
	CYL2p7rgYQDvhqSnGLM3Ll/YZ62VhuhRtvACTqZPMMBAfgRgmxPyteN0VIPIkjcB
	zlU61z9NR/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B0E92104B;
	Thu,  9 Jun 2016 12:05:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5282921049;
	Thu,  9 Jun 2016 12:05:06 -0400 (EDT)
In-Reply-To: <57598F2F.9050806@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 9 Jun 2016 17:45:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEC4D5F0-2E5B-11E6-8152-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296897>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/07/2016 06:57 PM, Johannes Sixt wrote:
>> Am 07.06.2016 um 13:50 schrieb Michael Haggerty:
>>>   test_update_rejected () {
>>> +    local prefix before pack create error &&
>> 
>> Do we want to add more of unportable 'local' declarations?
>
> Sorry, I forgot that `local` is not in the POSIX standard.

Regarding portability we say three things.

 * It is supported practically everywhere, and it is even in POSIX,
   so let's use it.

 * Even this is not in POSIX, it is supported practically
   everywhere, and it is too cumbersome to do things without using
   it, so let's use it.

 * It is not available in some platforms we (collectively) still
   care; it is not even in POSIX.  Don't use it.

I think "local" falls into the third one.

: bash; ksh
$ v=1
$ f () { local v; v=2; echo f; }
$ f
ksh: local: not found [No such file or directory]
f
$ echo $v
2
$ exit
: bash;
