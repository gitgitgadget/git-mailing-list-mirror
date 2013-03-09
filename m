From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ignore pattern with trailing whitespace in .gitignore is void
 using git 1.8.1.5
Date: Fri, 08 Mar 2013 21:25:47 -0800
Message-ID: <7vehfpf8kk.fsf@alter.siamese.dyndns.org>
References: <CAMn8hCd6_V2Kq_OUgBFAoOkqqmrTpN_ohcP3wM44qWvQB_8R5g@mail.gmail.com>
 <CAMn8hCexsiizsjoXO-ebfpEtZcW7n0dY-jV0q+aLh8U+pbUo9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thor Andreas Rognan <thor.rognan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 06:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UECIT-00030y-6q
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 06:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3CIFZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 00:25:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756Ab3CIFZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 00:25:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED999834A;
	Sat,  9 Mar 2013 00:25:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DdCvP7Ao8s5GM0wEKILF+BCk1K4=; b=TNLsZa
	GaviwfL2oozGJ7dcEDBMNu0zFubRvE2oXCQWQ7uNcx7/Y4FwPTUPqOOfmM81yvUM
	jhex7QcLPb/03KF9zLu1ArYhFdNIdK4PoFaB6H/WQNaCUsHPzAPMe7QxDadungY7
	dl4IQlSwwcbf/V5gkWaes81vpmye9IqsL3jkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLJtPCdBlX2MErbdkxqXKcPicx18mkrt
	vF8GDYz9/6M+qjehy/Jx7yGI8rZtaFaixf7CKJubrC+t7Ff7zvCBCAvCFKmk30Qe
	+F0KlAjKYNGAf07fUutitCd8St/dyi1lpFTxn/S9nhoVYbvBY+GBS6Jrj2rHt5kD
	WZP/fxmJMcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFE408349;
	Sat,  9 Mar 2013 00:25:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E8D18346; Sat,  9 Mar 2013
 00:25:49 -0500 (EST)
In-Reply-To: <CAMn8hCexsiizsjoXO-ebfpEtZcW7n0dY-jV0q+aLh8U+pbUo9A@mail.gmail.com> (Thor
 Andreas Rognan's message of "Sat, 9 Mar 2013 02:36:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD6AE0B0-8879-11E2-8585-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217701>

Thor Andreas Rognan <thor.rognan@gmail.com> writes:

> Maybe I'm doing it wrong, or maybe it's the intended behaviour,
> but I find that a trailing whitespace after a pattern in .gitignore
> makes the pattern void with git 1.8.1.5.

I doubt we do anything clever like that.

        $ git init
        $ touch hello.o "hello.o " "hello.o  " hello.c
        $ echo "*.o " >.gitignore
        $ git status | cat -e
        # On branch master$
        #$
        # Initial commit$
        #$
        # Untracked files:$
        #   (use "git add <file>..." to include in what will be committed)$
        #$
        #       .gitignore$
        #       hello.c$
        #       hello.o$
        #       hello.o  $
        nothing added to commit but untracked files present (use "git add" to track)$
        
The user tells to ignore anything followed by a dot followed by a
lowercase Oh followed by a SP.  We ignore "hello. ", but not "hello.o"
nor "hello.o  " (two SPs at the end), just as told.
