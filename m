From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] peel_onion(): add support for <rev>^{tag}
Date: Thu, 20 Jun 2013 11:03:39 -0700
Message-ID: <7v4ncswtfo.fsf@alter.siamese.dyndns.org>
References: <1371605946-32565-1-git-send-email-rhansen@bbn.com>
	<7vvc5aymhd.fsf@alter.siamese.dyndns.org> <51C20FD1.4090203@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 20:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpjD1-0003bN-RC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 20:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab3FTSDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 14:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757977Ab3FTSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 14:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE20B2981C;
	Thu, 20 Jun 2013 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFvyYKD5YCtTBrZ4vrplC8+iktA=; b=lAQHQV
	vAQSF0sid9bAeJYLFwI5aZcYDo1dF/CVTkyUU+4kJNnfyKLXgQril3HZGpSgejaD
	RFbgr5VSrYOdGNKHUCgbRNtC0zgfV0w8HA8aJb4yyTn0Wj7Q/CXkoWSzuUubrw6P
	W0xZ8lHrQktecCHweyiF3Bkh+L20tkF3SkHbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljT7QsHn10NoxuX6eZT94PS1LBceJrEn
	RskfeHpfXZ+dDPZ5vhBmULvFv7TISo+AeHqXOcMDGcFz2JkQKxmxTCxGpQOTAwGO
	iKhzRdARC5R2IOx7jSCycQza3ZyysZO/XC2tinzKEVE62T3Jevi9k9Fvmr1TP/FB
	9YS3WYk9HDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF9C62981B;
	Thu, 20 Jun 2013 18:03:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE8529817;
	Thu, 20 Jun 2013 18:03:41 +0000 (UTC)
In-Reply-To: <51C20FD1.4090203@bbn.com> (Richard Hansen's message of "Wed, 19
	Jun 2013 16:08:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD64C270-D9D3-11E2-99AC-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228517>

Richard Hansen <rhansen@bbn.com> writes:

> Barfing on non-tags is the feature this adds.  It's otherwise useless,
> just like <object>^{object} is useless except to barf when <object>
> doesn't exist.

Thanks.

I could buy that.  And after re-reading the proposed log message,
you do not quite have anything to say that.  Instead, you have this:

    Note that <rev>^{tag} is not the same as <rev>^{object} when <rev> is
    not a tag:

        $ git rev-parse --verify v1.8.3.1^{}^{object}
        362de916c06521205276acb7f51c99f47db94727
        $ git rev-parse --verify v1.8.3.1^{}^{tag}
        error: v1.8.3.1^{}^{tag}: expected tag type, but the object deref...
        fatal: Needed a single revision

The latter peels v1.8.3.1 to a non-tag (i.e. a commit) and then asks
to peel that commit to a tag, which will of course fail, but that is
not a good example.  

Perhaps something like this instead.

    Note that <rev>^{tag} can be used to make sure <rev> names a tag:

        $ git rev-parse --verify v1.8.3.1^{tag}
        $ git rev-parse --verify master^{tag}

    The former succeeds, while the latter fails.
