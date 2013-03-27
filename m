From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] attribute regression fix for maint-1.8.1 and upward
Date: Tue, 26 Mar 2013 20:57:09 -0700
Message-ID: <7vmwtpqyui.fsf@alter.siamese.dyndns.org>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <20130327011309.GA10946@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, avila.jn@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 04:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKhUi-0000Ak-6L
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 04:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab3C0D5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 23:57:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab3C0D5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 23:57:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A054CA9F4;
	Tue, 26 Mar 2013 23:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=guAM4VzGRfpbrBY8ASbJ7QiGsg0=; b=ygeHfA
	8vb+qdLBW/0cckLSXX/u2WMcOxw7Dput4e4zbaSwSmvSLUz04wrQ/Qb3B48nduzY
	MWa/cmRiPYmGqS+gyoYQKIzbcvbO8wo2/Jkli40REZTNHayJBcGgoIfVLUofLdaA
	pzUx0w7n4gmYD7uW6iFXMYg4O9xW8LXMEEZ+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTY3TYhNp2sz7laY1rYzOHtEE6WmARl9
	nIY3Apjp7l9BZbHttFVQWFDKWB1CUnzO1WC2HDYfGzcYP+RMRxhrr+LwQ1aXcxh2
	BbnVK7TaW2EVDzav1B5jgDGjuV0Lp1RtoKAnhxOfs9C5eeV3xZDbqDEo6zG5/2Dv
	75T9y1hNUso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94FE1A9F3;
	Tue, 26 Mar 2013 23:57:11 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D684A9F2; Tue, 26 Mar 2013
 23:57:10 -0400 (EDT)
In-Reply-To: <20130327011309.GA10946@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Wed, 27 Mar 2013 08:13:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66EB713E-9692-11E2-914E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219237>

Duy Nguyen <pclouds@gmail.com> writes:

> How about this? git_check_attr() now takes dtype as an argument
> and the caller must not add the trailing slash.  This could be
> split into two patches, one for git_check_attr prototype change,
> and the other the real meat.

"git check-attr" fundamentally cannot know, but aside from that do
all the callsites know if the path in question is a directory or
not?  My impression was that there are some cases you do not
necessarily know.

"Add slash when you _know_ it is a directory, but otherwise pass the
path without trailing slash." is easier to understand than "Pass
040000 if you know it is a directory, but otherwise pass 100644",
exactly because "otherwise" in both of these instructions include
the case where the path in question _is_ a directory (you just do
not know what it is).

I do not particularly like the "trailing slash on the basename"
approach, but it feels less bad than passing dtype down.
