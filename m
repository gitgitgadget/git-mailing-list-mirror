From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 01 Jun 2016 09:13:09 -0700
Message-ID: <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:13:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88ln-0000W2-3U
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbcFAQNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:13:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbcFAQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:13:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A45711F5DB;
	Wed,  1 Jun 2016 12:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZYZSM+ie/bLSYNgKjePampkjRTI=; b=QYwgU1
	4dmLETWMwENLOfrUJ/KyAGB/j9eNR5YrVWRz9CZyOfcksPAc9qV0o4Tt35WyXk7e
	HUc3F/lNC8OFTwkwEitOQMXakwPvsb80pYZvQ/gSOA41618QmSa8uPwHDrpci0ef
	Eb9t77LIC7tZSv7qBWb7jXUGl9srEPE35p+fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVU5c96YK0AHohzyGdaTcaRP9nvySOII
	hNBB6as6k9ISrzzrEjQ1OiG2eOMkzTMr9o8W4NBpC+8ohgCKd93qgNhcsH2ZlEmC
	aMxsDBtGvO2PvwyX55sBDDxUlWJ3DBXseQtgCLvHmyaaHy4zX9n6TH4BS2BqW0UV
	BuY5Yy+E8b8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D1231F5DA;
	Wed,  1 Jun 2016 12:13:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 356411F5D9;
	Wed,  1 Jun 2016 12:13:11 -0400 (EDT)
In-Reply-To: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 May 2016 16:08:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC6F3DD2-2813-11E6-903C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296097>

Junio C Hamano <gitster@pobox.com> writes:

> relative_path ()
> {
> 	local target curdir result
> 	target=$1
> 	curdir=${2-$wt_prefix}
>
> I am hoping that Stefan's "gradually rewrite things in C" will make
> it unnecessary to worry about this one.  "git submodule" would not
> work correctly on posixly correct shells in the meantime.

These are two other offenders.

$ git grep '^[	 ]local[ 	]' \*.sh
t/t5500-fetch-pack.sh:	local diagport
t/t7403-submodule-sync.sh:	local root

The grep gives many other hits, but those in completion are OK; it
is designed to be specific to bash, and whose tests in t9902 is in
the same boat.  A few more near the end of t/test-lib-functions are
only for mingw where bash is the only supported shell at least for
running tests.
