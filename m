From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] log: decorate grafted commits with "grafted"
Date: Thu, 18 Aug 2011 11:10:20 -0700
Message-ID: <7vobzma435.fsf@alter.siamese.dyndns.org>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fU-0002HA-RV
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab1HRTx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:53:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123Ab1HRTxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CB44B60;
	Thu, 18 Aug 2011 15:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=lK0vlFlARsp6/oWBSaPBQSV1Ufs=; b=CO7VRSAvd2c1Apx+NOXt
	NNsewdElZbary8GVH3nQQ4qdyxSpMSt/rpy602yQ5X2R1RI/7TRamNodxzERK9Hy
	nEKWYZcO33lILyywjZrrZdMBqzRu2c+gjtgste1aT3Tu6+OSiH/c13JNkI4hSPRl
	1AYJaUrX0eRqn7YSchDGYxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=j2SiK3Qq71Zpo/AgofJM0GpV8JA90sG9Uqirz4VW8neWpn
	7hl+LkfV50+3+WX0vqV6oA+DyppsVJxslj1152m7DpNjSeDXUUd+JbNM7u4IBUb4
	KZA/NEhNBLLEGHBZwlYBdgQnwQva0O3IYCtAffqrxgt/g9fvOUMjK+y1aPFT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F31754B5F;
	Thu, 18 Aug 2011 15:53:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89C324B5E; Thu, 18 Aug 2011
 15:53:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBCF38B6-C9D3-11E0-B2D4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179621>

I think this makes a lot more sense than the other option of looking up
graft points every time, as we expect only a handful of grafts, if any,
exist in a repository.

If you have, on the other hand, tons of historical graft points, and you
are viewing only near the tip (e.g. "log -20"), this implimentation still
calls lookup_commit() for all those historical graft points that are
likely to be scattered further back in the packfile, and the performance
may suffer.  But that is what it means when we say that we are optimized
for use case where only a handful of grafts exist, so it is not something
that we worry about too much.
