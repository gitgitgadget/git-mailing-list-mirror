From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Looking for pre-commit hook to check whitespace errors but not for all files
Date: Mon, 16 Dec 2013 11:06:59 -0800
Message-ID: <xmqq8uvkpqcs.fsf@gitster.dls.corp.google.com>
References: <1387034894.4636.9.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdVa-0006kK-KH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab3LPTHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:07:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab3LPTHC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:07:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44F1F5B43A;
	Mon, 16 Dec 2013 14:07:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uzRglNFYsQg08XQtWV8JnNePKTU=; b=Sbjogn
	ra1vvK0VwMFyHoE6ie+WV20Q/6m82vQ6pplu2/uX+PAA2KKsrvB2qCR2NQsL22bD
	83r79R5Vv7skIQczcJYzHM/8CXShUmNa4U4wF5ONuXCI5JTaQuCizYph2pxZRvAP
	MC/pKLguXFHdY/puneJB7IQmgnLNzmYkzXCo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AILvb6MdmEaTZ3XiHFu7w2rAa1KX0yfO
	csoe/gVz62GE3O8hs6RQzQ7tdl9FpKGKmgGM7fmqwmzyVKLB4XCT/rXL7oFyH5hT
	BVck7DKSDsKbVlX8B7k59VLSN5THutPr/PpTheA91URq417paNPyRfowdoPwqt57
	lTgzp76lB6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA555B439;
	Mon, 16 Dec 2013 14:07:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6851F5B438;
	Mon, 16 Dec 2013 14:07:01 -0500 (EST)
In-Reply-To: <1387034894.4636.9.camel@mattotaupa> (Paul Menzel's message of
	"Sat, 14 Dec 2013 16:28:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E5F4F7E-6685-11E3-B59A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239346>

Paul Menzel <paulepanter@users.sourceforge.net> writes:

> 1. Only the files actually committed should be checked. That means
> running `git commit -a`, abort that and then running `git commit
> some/file` should only check `some/file` for whitespace errors.

Doesn't hooks/pre-commit.sample we ship already gets this right?

	$ git init foobar && cd foobar
	$ mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
        $ for i in foo bar; do echo $i >$i.txt; done
        $ git commit -m initial
        $ for i in foo bar; do echo "$i " >$i.txt; done
        $ git commit -a
        bar.txt:1: trailing whitespace.
        +bar
        foo.txt:1: trailing whitespace.
        +foo
        $ git commit foo.txt
        foo.txt:1: trailing whitespace.
        +foo

> 2. There are certain files that are allowed to have whitespace errors.

As John Keeping alraedy pointed out, you can use the attributes
mechanism to mark what kind of payload each path has to control
this kind of thing.
