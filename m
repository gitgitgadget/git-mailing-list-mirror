From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git cherry-pick: Add NULL check to sequencer parsing
 of HEAD
Date: Thu, 03 May 2012 10:13:09 -0700
Message-ID: <7vobq5fasa.fsf@alter.siamese.dyndns.org>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
 <1336054159-5123-1-git-send-email-nhorman@tuxdriver.com>
 <vpqtxzx5hxz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	mmueller@vigilantsw.com, rene.scharfe@lsrfire.ath.cx
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 03 19:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzag-0001eB-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 19:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab2ECRNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 13:13:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab2ECRNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 13:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB36B784C;
	Thu,  3 May 2012 13:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+tJOcOZCCj/XkyQKzw80GBvMQu4=; b=GATU2j
	l3eOTasMyIM7O2ScHWfPp4J15tkzB6i6qO/sN+dW6G4HK1K6ui1S8aVTOy9LNNxI
	w0WgKpkaeOOXtT8T/Hw6zMnammcVVDkvB+kOrdAX6PrId03PA1wTXWuHVjwTG3M3
	s1U2+EaAVFBOgWlA8mwCnvpCRVSYxziQJvuxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNaSuOBJXwcc8JZlTaWKkpalxVoBeTwU
	LXAJg4vRwtOXzo9/xebN9vhBbFzJLzV4Z6XTEoCDaGTjUXB64RUsGSuLADRBwTZG
	rA3W+KmGaCIdD8p/XLS+4Ypt0uF25qnfA7WuYHawoqr3/cZynkRhFFZI7MxlN3+K
	zhjLZ/zDKGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1252784B;
	Thu,  3 May 2012 13:13:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA087848; Thu,  3 May 2012
 13:13:11 -0400 (EDT)
In-Reply-To: <vpqtxzx5hxz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 03 May 2012 18:48:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42B0F51A-9543-11E1-9DAD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196923>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Neil Horman <nhorman@tuxdriver.com> writes:
>
>> -	if (!head_commit || parse_commit(head_commit))
>> -		return error(_("could not parse commit %s\n"),
>> -			     sha1_to_hex(head_commit->object.sha1));
>> +
>> +	if (parse_commit(head_commit))
>> +		return -1;
>
> Why did you replace the error("...") with only a -1? error() also
> returns -1, but displays a message before, which I think was fine. If
> you want to remove the message, then explain why in the commit message.
>
> If you do not test for head_commit to be null, you can't use it in the
> error message. But from the context, it seems you can use head_sha1. If
> not, a message like "Could not parse HEAD commit" seems better than
> nothing.

Yeah, I think v2 in this series is the appropriate fix.
