From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: load full words in the inner loop of
 xdl_hash_record
Date: Mon, 12 Mar 2012 13:59:08 -0700
Message-ID: <7v62e9r0wz.fsf@alter.siamese.dyndns.org>
References: <1e11b1466ea3209cfe74e1dd8dff45f8666e942b.1331564754.git.trast@student.ethz.ch> <7vmx7lsmjd.fsf@alter.siamese.dyndns.org> <877gypr319.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7CKr-0001o3-1N
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab2CLU7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:59:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756652Ab2CLU7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:59:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F7E7420;
	Mon, 12 Mar 2012 16:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=An+7Mz2AQTHfWdRdt7K3yebplgI=; b=x/dG/8
	IwOfjYh1yyXu64Gr+dvlgWlpE8aG+GpK98ixonKVLu+Iv6bhtSoJ5Dsmlkgsldd0
	R3Fs0iRs7FfL5N/5JrbxIZ8ELfzCGrgRrmITmng9uqzHYZRcqAO/LGKmJD5N0CW9
	iwF1PrOCquqci9csBKSwmfWUbYrlg+3DAvRrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xxt7CgFU3exNb/QTER8/gV2hvSBSvEoV
	LVSPc7aYr4NS2UZsex5h15AAKNMdz4VGOtoSxiJ5jE0ErbRqccdNSqHCPs2wSZwT
	y9TwakIalps5L9DLEc9CK0b7QgsQwARHV9Nr3P7ebP9oi9ywik2RZ9jmph0d+TKc
	rBmwJ89hWO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBBB4741F;
	Mon, 12 Mar 2012 16:59:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71E10741E; Mon, 12 Mar 2012
 16:59:10 -0400 (EDT)
In-Reply-To: <877gypr319.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 12 Mar 2012 21:13:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 372A73E6-6C86-11E1-80F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192945>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> Also definitely post-v1.7.10 material, but I figure many people will
>>> be interested.  Since it's such a central part of much of git, it's
>>> also quite important that it gets tested heavily.
>>
>> I am interested but this is a material not beyond 'pu'.  Until it
>> learns to be nice on platforms that do not like unaligned accesses
>> or use big endian, that is.
>
> Umm, nice how?  It leaves in the old version for those platforms.

Ah, I misread the patch and somehow thought you are unconditionally
replacing the code with the optimized one.

No, I didn't mean to suggest autodetection.
