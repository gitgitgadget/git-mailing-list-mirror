From: Junio C Hamano <gitster@pobox.com>
Subject: Re: logging disjoint sets of commits in a single command
Date: Tue, 31 Jan 2012 16:48:58 -0800
Message-ID: <7vobtj5qf9.fsf@alter.siamese.dyndns.org>
References: <CB4DC432.72D%bryano@fb.com> <CB4DC442.72F%bryano@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Bryan O'Sullivan" <bryano@fb.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:49:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsONn-0001V8-4K
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2BAAtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 19:49:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab2BAAtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 19:49:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB0A6F8A;
	Tue, 31 Jan 2012 19:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dhqlZTz/abiDoxyQJGqJL4PvPTI=; b=kply1j
	t8BsreO8MKlqDQKukuoy+TBkuRnSr7Su14v3ip/98ENqhapfQdszgzhT55yt+5Cx
	6492IexmJyemxWDSyaNFeQTtqZh0c3oee0ZaIT0hkqeJH3rd6/fh3NIiBYlv3wx8
	cIBTXnHIOHt4din2eCR1PbhoA0GpitGoDNSv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IyqR3wq10reL2mIu+ihIr9in9wmfjomD
	yrD7SRTuP6O2ct/qIm8wyKFfeNmRX26rTL4hY0+rdZFykU0Avmv1B9KZvbwV5Epa
	apGhr8D8sFGORpmCqyer+O6HSNUW2LjnOpGK4hFEOFp/n3l3mb1CuyVJKOEje2z8
	5uud9QKOb6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640106F89;
	Tue, 31 Jan 2012 19:49:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDCF76F87; Tue, 31 Jan 2012
 19:48:59 -0500 (EST)
In-Reply-To: <CB4DC442.72F%bryano@fb.com> (Bryan O'Sullivan's message of
 "Wed, 1 Feb 2012 00:27:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876A8DEC-4C6E-11E1-B917-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189488>

"Bryan O'Sullivan" <bryano@fb.com> writes:

> Here's a sample command line against a kernel tree:
>
> git log 373af0c^..373af0c 590dfe2^..590dfe2

This command line is _defined_ to be the same as this.

	git log ^373af0c^ 373af0c ^590dfe2^ 590dfe2

Hence,

> Is there some way around this, or would a patch to fix it be acceptable?

the answer to the second question is "no, that is not a fix but is a
breakage for the *current* Git users".

The answer to the first question is that you may be able to do something
like this:

        (
            git rev-list 373af0c^..373af0c
            git rev-list 590dfe2^..590dfe2
        ) |
        sort -u |
        xargs git show

Having said all that, for users of Git 2.0, giving richer meaning to the
explicit range notation to make your original command line work just like
the above scripted way would be more intuitive.  While an unconditional
change to break the current users would totally be unacceptable, we would
want to see somebody come up with a clean migration path toward that goal
without hurting existing users in the longer term.
