From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 03 Oct 2011 12:42:38 -0700
Message-ID: <7vwrcleua9.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <201109301502.30617.mfick@codeaurora.org>
 <201109301606.31748.mfick@codeaurora.org>
 <201110031212.13900.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoPW-0004Vd-HX
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab1JCTmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:42:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab1JCTml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:42:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0AF5A23;
	Mon,  3 Oct 2011 15:42:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LZd1J0A4FmGEQPd3jF/ti9HAIp4=; b=jeW91r
	xmPD0RC2lgcQizgzTMe4GjkE916bzUQpkNnr//vLnONIcdIUZLwaxJWVExUBXLNm
	F978cdX6DVZW8ZRGWPUBO9sSZ9v2Hfvy30ENzk3j+S9yYkeNKeqY07aVfS4Ao3Tf
	5763vDCXlUb2s0COSIslUlNzPkY+7su62WT3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPRAwcTA44SxrRbk4KdqcckXc/KCTZje
	IXrBt8aHkHN/CQCJo3kcp/9VXHq0jTg2e+n/MQpsmVM8oLgvbEsEhUn4SPkNf3oT
	dnDLJdqHPH1zBZQrlu2VTpjaS+B8sonXDvEcX3d8tU41SP0cbFDe4eMlzjW21Nf5
	dgoR57iKGno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44385A1C;
	Mon,  3 Oct 2011 15:42:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72D975A18; Mon,  3 Oct 2011
 15:42:40 -0400 (EDT)
In-Reply-To: <201110031212.13900.mfick@codeaurora.org> (Martin Fick's message
 of "Mon, 3 Oct 2011 12:12:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAD35304-EDF7-11E0-8460-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182705>

Martin Fick <mfick@codeaurora.org> writes:

>> I guess this makes sense, we invalidate the cache and
>> have to rebuild it after every new ref is added? 
>> Perhaps a simple fix would be to move the invalidation
>> right after all the refs are updated?  Maybe
>> write_ref_sha1 could take in a flag to tell it to not
>> invalidate the cache so that during iterative updates it
>> could be disabled and then run manually after the
>> update?
>
> Would this solution be acceptable if I submitted a patch to 
> do it?  My test shows that this will make a full fetch of 
> ~80K changes go from 4:50min to 1:50min,

As long as the resulting code does not introduce new races with another
process updating refs while the bulk update is running, I wouldn't have an
issue with it.
