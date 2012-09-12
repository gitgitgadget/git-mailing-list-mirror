From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ambiguous date handling
Date: Wed, 12 Sep 2012 02:48:27 -0700
Message-ID: <7v4nn3fu6s.fsf@alter.siamese.dyndns.org>
References: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 11:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjYk-00017y-J6
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 11:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab2ILJsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 05:48:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab2ILJsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 05:48:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C28868491;
	Wed, 12 Sep 2012 05:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPO1rXkKmtE8UqZmqjO/8ulftPA=; b=wxiBA+
	poP7iClzcU1oW43GZ11a+4Wt2dMArsdIv2YkdRLPuBS+ZCMQ5X42GdJIyoU6f2Zd
	73TbHWMZWtQOiUmlveuJ7/EQQYJAxVtkoYNiF5Dv0UynkOuRL84unpZR8VIEsC6a
	uxHGZZS060jvXkhoWIqEmGZHVqeVb666yyw+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QcmLE3M3Jlh+sf5LNVtASpVpyOE0yI14
	e0H390Rd1HKZG/uLvQ+TVwzsBnAJmtT2fBp5UF79OByw7CcnYPS3PPIJatQeMeJO
	xomZ7yGFN0U7nF1EH+aAnHDgoCYROniRFtoYgpxVfVxw3bWtKsjT64Ziw/dVILa5
	Z1mRbwK/9V0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEABE8490;
	Wed, 12 Sep 2012 05:48:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ACFF848F; Wed, 12 Sep 2012
 05:48:29 -0400 (EDT)
In-Reply-To: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
 (Chris Packham's message of "Wed, 12 Sep 2012 21:35:50 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 017E336C-FCBF-11E1-B9EF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205275>

Chris Packham <judge.packham@gmail.com> writes:

> Our default MUA has an annoying habit of using a non RFC822 date format when
> saving an email as plaintext. This means the first 12 days of every month we
> run into the ambiguous date problem (our date convention is dd/mm/yy).
>
> I see code in date.c for refusing a date in the future which would have caught
> this...

The most sane thing to do when you know that your MUA *consistently*
does dd/mm/yy (even though it may annoy you) is to massage its
output before feeding it to Git.  And it should be a very simple
matter of a one-liner filter, no?

Regardless of the correctness of that "we reject timestamps way into
the future" logic, it should be taken as the last resort.  If you
are on September 1st, both 9/12 and 12/9 will look like into the
future for more than ten days (which is the cut-off, I think).  If
you are on December 28th, both look like sufficiently in the past.
