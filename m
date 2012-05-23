From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Wed, 23 May 2012 09:56:36 -0700
Message-ID: <7v4nr625vf.fsf@alter.siamese.dyndns.org>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
 <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org>
 <4FBC0F12.2000001@lsrfire.ath.cx> <7vhav73lnl.fsf@alter.siamese.dyndns.org>
 <4FBD0E33.4060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 23 18:56:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXErb-0002dg-4d
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760527Ab2EWQ4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 12:56:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2EWQ4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 12:56:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2BD8AF9;
	Wed, 23 May 2012 12:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YUDiZKyh2Lif
	VbjFVtGHHIdlPwA=; b=lnV6LvE2pVuAHA5+5lDNY2R7RtcQNBR0HqBmOJsUNlGI
	mTpxbemKgBHKFhfm62eQC4TU2Ictg/YdbKiKTsrL/veDDbpygRT8LS6Y7mKE1+/s
	Qf8Stx7/lvjrEFxZz6P5DTvFYNjXP4ODdpMkAGoBC813QpwGY8YwH4RgNYP71/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ufRYrS
	QOuDl/LMhXb0GPqYw5ORxqyWWmxLjKqUQr69LM/XKkctT+v+pm2nbdicIaf9BXHa
	kfTQENaydP0RiQgk5FzjSLZUtTxnxy/JgyppQ6SiDpto8W7ZgJGRFFD6KuvUUimI
	CM9fi49nsauHFldLy2H8xOeZqlfTc2H9G8EEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9306C8AF6;
	Wed, 23 May 2012 12:56:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 170518AF5; Wed, 23 May 2012
 12:56:37 -0400 (EDT)
In-Reply-To: <4FBD0E33.4060309@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 23 May 2012 18:20:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4304C50E-A4F8-11E1-B7A7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198311>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 23.05.2012 00:18, schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>>
>>> What has git grep to do with refs?  It checks if the path in the co=
mmand
>>> above is a ref, which makes it iterate over all of them..
>>
>> Do you mean:
>>
>> 	/* Is it a rev? */
>>          get_sha1()
>>          ->  ...
>>            ->  get_sha1_basic()
>>              ->  dwim_ref()
>>
>> callpath?
>
> Yes, indeed.  Hmm, this is done even if the paths come after a
> double-dash.  Anyway, I don't consider the check to be a performance
> issue, just a quick way to test the allocation count that i stumbled
> upon while working on the recent grep patches.

I was merely reacting "iterate over all of them"; dwim_ref() only check=
s
if .git/blah, .git/refs/heads/blah, .git/refs/tags/blah, etc.  exists a=
nd
the number of checks do not depend on the number of refs you have, so I
was wondering if I overlooked something that does for_each_ref() of
everything.
