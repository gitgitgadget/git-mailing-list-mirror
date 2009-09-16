From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 16:19:27 -0700
Message-ID: <7vab0uwk8w.fsf@alter.siamese.dyndns.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
 <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
 <20090916224253.GB14660@spearce.org>
 <7vtyz2wlhm.fsf@alter.siamese.dyndns.org>
 <20090916230350.GC14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3mr-0006lD-1K
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760343AbZIPXTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760309AbZIPXTg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:19:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbZIPXTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:19:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 588035341F;
	Wed, 16 Sep 2009 19:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vYIE2/xx/6lDzsDryPk0TLcL9Dw=; b=YsywAt
	geVNoLlpSxCiv6PAO/6Va4X20sy0MEVenRqgOZ6XFmHOk2GaGwAu2oeutpU5ifi5
	23WglH9jMDsTlacWSCK4wwBr1zft3fsD/9ycR6bLDE0d+3cgzeK+yNaHHBC1xPmH
	b6Uvmqf1GHcsYYBNU6cuyoDn8W3J0W2i3wtww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgZUSbhStKBdxL1Q1JXjqy7aTOAqMO2e
	vccPOYwVfEE5cHE1tYMtExB0IJ+ysH42buJqkpRg/OCKWMRFUU1JfTb9HoTnqyr6
	ExVARyBvdemReysyP5cH3PDdEZMg4xpU0MIi0Y6dytl6GJsUYKEt2iH8u4vuMXvE
	g9RCJ3PkVsA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B99553416;
	Wed, 16 Sep 2009 19:19:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7243D53415; Wed, 16 Sep 2009
 19:19:29 -0400 (EDT)
In-Reply-To: <20090916230350.GC14660@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 16 Sep 2009 16\:03\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6591D3A4-A317-11DE-9854-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128694>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Also, you might not have noticed, but my illustration patch was merely
>> using it as a hint to optimize, and if the last ref we saw was not X when
>> it is turn to handle X^{}, it simply falled back to the original logic,
>> iow, the patch never compromised the correctness.
>
> Oh, I missed that.  JGit I think flat out panics and disconnects
> if the remote does this to us.  What is the incentive in supporting
> a broken server with a slower client?

There is none.

I think the original logic, being written in shell, run grep in the
output, and the C code we are seeing is a literal translation of that.

In other words, I think it is simply a historical accident.
