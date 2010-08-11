From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked
 files
Date: Wed, 11 Aug 2010 11:22:42 -0700
Message-ID: <7vmxstypot.fsf@alter.siamese.dyndns.org>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjFx6-0005XU-Sq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab0HKSWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 14:22:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab0HKSWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:22:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 871C7CC20A;
	Wed, 11 Aug 2010 14:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SOe4GIVr5FSJ0ys3fElxV7b//4=; b=Plq7OU
	9F3hIfgzpZAnFGIT4VvAsKOBq+yHfkDD+I4SWjPav8Sjvz/Nqe9CTsFyIi/ZJylY
	sZX90NqtQ4Yyr+Wy8b8WskrYq2RRM8Wwf7JDQn+YVobC39b7hP6AgPfjYRGig+vv
	sThU+c/d1RuSvcyDObtoq7t3R00JX2Psn2JVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/4QF/kg/Hb+o2JfD/e3ls3gYNZ4d2C3
	lnizJ7AClNaXI0QQhGwG9ItlMbLvfaIeq38urLMCNYAMBOg3ftPEx09BO55JrGVH
	ZLMbV8VYqSEI9bqhe+e/0Hw+9JNPprvjBjOk4zGy34NbbKnT303zn6CzVInq8bcA
	+Mj9Ht/eyU8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C91ACC205;
	Wed, 11 Aug 2010 14:22:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E1A3CC202; Wed, 11 Aug
 2010 14:22:44 -0400 (EDT)
In-Reply-To: <1281510236-8103-1-git-send-email-gdb@mit.edu> (Greg Brockman's
 message of "Wed\, 11 Aug 2010 03\:03\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71B9A6BE-A575-11DF-9888-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153270>

Greg Brockman <gdb@MIT.EDU> writes:

> Currently, 'git add' will complain about excluded files, even if they
> are already tracked:
>
> $ mkdir dir && touch dir/file && cat > .gitignore <<< dir
> $ git add -f dir/file
> $ git status
>   ...
>   new file:   dir/file
>   ...
> $ git add dir/file
> The following paths are ignored by one of your .gitignore files:
> dir
> Use -f if you really want to add them.
> fatal: no files added

Thanks.

I think it is reasonble if we don't complain in this particular case.

What should happen if the user did these instead, after adding "dir" as an
ignored entry, and adding dir/file but not dir/untracked to the index?

 (1)    git add dir/file dir/untracked    ; explicitly named
 (2)    git add dir/*			  ; have shell glob--same as (1)
 (3)    git add "dir/*"                   ; have git glob
 (4)    git add dir                       ; have git recurse

What does your code do?
