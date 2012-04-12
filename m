From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected empty directory removal
Date: Thu, 12 Apr 2012 11:32:26 -0700
Message-ID: <7vehrs6bt1.fsf@alter.siamese.dyndns.org>
References: <4F870C04.9060304@of-networks.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Wilson <gary.wilson@of-networks.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 12 20:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIOoy-0006H6-5c
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 20:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab2DLScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 14:32:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756503Ab2DLSce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 14:32:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 371E672E1;
	Thu, 12 Apr 2012 14:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5VNGFBH7jPzU5RDf7Naj0L3JthY=; b=rCVBcg
	ICM0mYtWZK205zreb6ascQ7mc9tnv6bFAeKzUo+JTRL0baMpwIS9DYcrGvMGPNpL
	40qzdtmfywhHXs7xl9FJkPZr0KeCuNhhMuoO/FQpnBVc/KXXWYs5MPADsO72WiFe
	2JtBOavzy2ZY0QG2WZMc49rk3upekCVgT7ri4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQXkC1rXQbD0SxeWkdopbqQ7dbiHsSm7
	R3EXGXVCRNKd88lXFk1IDA2F7UNR3JRFyax5zm27Lj6977HixtTVWewqoJIXYoPP
	xXre7K5x6LWrfkhgts6jMxIv+mC4YNmwqc3YS3+SNFL2vJDVZklQapAzTBW+vF6T
	S9+tXegcWHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9D472E0;
	Thu, 12 Apr 2012 14:32:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B53D672DC; Thu, 12 Apr 2012
 14:32:28 -0400 (EDT)
In-Reply-To: <4F870C04.9060304@of-networks.co.uk> (Gary Wilson's message of
 "Thu, 12 Apr 2012 18:08:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBBC3872-84CD-11E1-9A7C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195354>

Gary Wilson <gary.wilson@of-networks.co.uk> writes:

> Use case to replicate:
>
> 1. Have path/files/a.file exists (and/or path/files/*) on client A and
> client B
> 2. Remove the physical files from the path/files/ directory on client A,
> so that the directory is empty
> 3. git commit
> 4. git pull on client B
> 5. On client A an empty path/files/ directory exists on client B it has
> been removed, meaning path/files/ no longer exists.
>
> Is this the expected behaviour?

As Git does not track directories at all, but merely uses directories as a
means to instantiate files (which it tracks), when the last file is
removed as the result of a merge in repository B, it notices that the
directory is no longer needed to hold anything it cares about, and removes
it.

If you ran "git rm path/files/a.file" in repository A to remove the last
file in the directory may also remove the now-empty directory (I do not
remember offhand if it does), which is also expected.
