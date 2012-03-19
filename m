From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange git merge behaviour with empty branches
Date: Mon, 19 Mar 2012 12:51:17 -0700
Message-ID: <7vvcm09xoq.fsf@alter.siamese.dyndns.org>
References: <20120319185349.GH12789@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ic1-0005fe-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 20:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032675Ab2CSTvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 15:51:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2CSTvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 15:51:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5A0698B;
	Mon, 19 Mar 2012 15:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/rB42iuHIdGouN4nowAVrQ1Os4I=; b=C0Zfta
	TC4BjOj3Hb5PepGxA6sX/QLuIQN9He3APA6CPgeP/G0MxzLx1rDULsbAjNESpdE5
	SIl5AJl1ko827waIvl1ZhyhL6fyoXcpeMw+TTy5XC7K9NAEY7nBW6BOzxDRWdrqR
	Y1KDKvJ14oTpCAp6DguIqIVYKEoUIFrvqXmus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hab842fr6cG3o7O77CZY44puUwWFY12A
	2gxzAQje0lTtnkVQLg1FXReqkvNb3odUne0ZRFt+Eic8Pwa/XemtyCWKfXUBGjp/
	CcI6UXjolKPVpxdNOmmrbFi+4MabJgkrZAzQTiXQ+2edYtK18eGqC2Ju07WbDtCs
	L3TA5+Moh7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53694698A;
	Mon, 19 Mar 2012 15:51:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E00BB6987; Mon, 19 Mar 2012
 15:51:18 -0400 (EDT)
In-Reply-To: <20120319185349.GH12789@mudshark.cambridge.arm.com> (Will
 Deacon's message of "Mon, 19 Mar 2012 18:53:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E539EF90-71FC-11E1-A306-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193452>

Will Deacon <will.deacon@arm.com> writes:

> Any thoughts?

What is recorded in Octopus merges is a rather torn issue.  The original
motivation was to allow recording anything the user throws at us, even
though some are ancestors of others, without reducing them to the minimum
set of parents that are necessary to represent the full history, because
that is after all what the user wanted to do. You see some of that there.

On the other hand, there was an edict from the original maintainer that we
shouldn't record useless merge parents, so there were some changes in that
direction to cull obviously redundant parents from the parent list.

But over time, novelty of Octopus merges waned, and nobody serious uses it
for real work these days, except when bored and being curious, playing
around and seeing what it does.

An advice for an end-user is "Don't throw meaningless parents at
Octopus. It will do whatever it does, and the only guarantee you are
getting is that it does not record wrong parents, it may omit obviously
redundant parents, and it will never discard an independent parent."

An advice for a developer is to update it to make sure only the
independent parents are recorded; "show-branch --independent" may be a
good tool to compute them
