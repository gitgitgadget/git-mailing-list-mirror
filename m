From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 29 Feb 2012 10:15:37 -0800
Message-ID: <7vlinltsja.fsf@alter.siamese.dyndns.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <878vjn8823.fsf@thomas.inf.ethz.ch> <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
 <4F4E003C.1050301@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:15:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2o42-0004cv-1f
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965838Ab2B2SPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 13:15:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965830Ab2B2SPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 13:15:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D917D05;
	Wed, 29 Feb 2012 13:15:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dHodiPv0Qc5c++cfKJI1Q9M+4/M=; b=FR0gu5
	PQPEpA9HItiyfHrusmi46ztuHt7cyrbAHHxPv7/M055phXGySgFxd6ErOnusSGmk
	LYX2cj+yAbC/JUA3heYI6a2f4IP9wqSwjxKPNC2yHgCxFOWjmpWShqhXhiL3hRPw
	2b7pTVweSe1YEoui40Ky/RwrZmaaMxbIwBHDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yeveme82uXtccBEcIC97Ge3VgxfmBpkX
	RIZzADYYRCvJ4a2QBqWoiE0VY3DtguvXYYfWDSdKa1Uc885tTyqIs79Axs0jk4K2
	1QfnM5vkhLEVGUygFG+rxpWJ/TO7G6X+L8u8Oo0/PBx9Agxu/VrLlt70tF6thNXD
	He6yI4p9jMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD4C7D04;
	Wed, 29 Feb 2012 13:15:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BDA87D02; Wed, 29 Feb 2012
 13:15:39 -0500 (EST)
In-Reply-To: <4F4E003C.1050301@seap.minhap.es> (Nelson Benitez Leon's message
 of "Wed, 29 Feb 2012 11:38:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62300F76-6301-11E1-99B5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191839>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 02/28/2012 08:24 PM, Junio C Hamano wrote:
>
>> I've heard rumors that libcurl on some versions/installations of Mac OS X
>> deliberately ignores the environment. For those who agree with Apple, it
>> would be a regression if we suddenly start the environment ourselves and
>> using it.
>
> Hi Junio, what did you mean by "we start the environment and using it"?
> I didn't understand what you mean there..

The reason you didn't understand is because the statement does not parse
X-<.  Thanks for pointing it out.

What I meant was that on these platforms, allegedly (note that I do not
have a first-hand experience with them), user's http_proxy environment
setting did not affect libcurl based applications and that is a deliberate
platform decision to give precedence to proxy settings the platform has
elsewhere.  The users who agree with this platform decision are happily
using the proxy settings stored elsewhere in the platform with git, but
may have http_proxy environment pointing at a proxy that they do not want
to use for git.

If we suddenly start reading from http_proxy environment ourselves and
explicitly telling libcurl to use the proxy specified, it will change the
behaviour for these users, i.e. a regression.
