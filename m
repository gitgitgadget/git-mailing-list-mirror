From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched
 branch
Date: Mon, 17 Sep 2012 13:08:55 -0700
Message-ID: <7vhaqwv2co.fsf@alter.siamese.dyndns.org>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
 <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhcx-0003BM-7t
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab2IQUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:08:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755612Ab2IQUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57357998A;
	Mon, 17 Sep 2012 16:08:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CDQ5uOhB8sPuNn8CzU/CtcDEmHk=; b=vxOM1w
	aPk4t5VQs+o40VRTYK3bCRPeEBz0rZy90frX0nQjmQY2gj7gkLYjZVOrpt3H1Oao
	S/9f82+g8DDaQ+iIvK1Gszfxw6yGJTqwm12S6L6gmIyoG/RV59TZDcJlkp3iHpGK
	HNkECTZgAb+wqcnNvUEKiz+pgbsmTGsEyRVIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edeg2FWY/uSCXNaeI8CkaAOMqZWIwVdF
	JOO1C585GbpwALGJxQfJrvzLyevxqXdV81gcEoi4QIubBpaQDv3c48B1Rc3FE8wS
	dEc7XT+Je6NON8gA1fwBp+gGipwOTU2ckbf5r+kRva2d56WjOqEwFDaUUWoWfVVt
	4n5FJGAJ1iU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44CF59989;
	Mon, 17 Sep 2012 16:08:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACC819988; Mon, 17 Sep 2012
 16:08:56 -0400 (EDT)
In-Reply-To: <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 17 Sep 2012 19:06:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82E5CABC-0103-11E2-8DF6-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205733>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> --mirror --single-branch combination does not look right. The "heads/"
> part is missing..

What does it supposed to do in the first place?  "mirror" is
primarily about grabbing everything without leaving stuff out, and
"single" is about grabbing only one thing without other stuff.  It
smells like a nonsense case we didn't even bother to catch and
diagnose as an error to me.

Besides, mirror implies bare, so we would expect to see

    refs/heads/$single:refs/heads/$single

and that matches what the "single" gives us without "mirror", no?

How about explicitly forbidding that combination, or ignoring mirror
when single is given?
