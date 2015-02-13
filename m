From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ls-files -X option is relative to repo root
Date: Fri, 13 Feb 2015 12:54:45 -0800
Message-ID: <xmqqiof5mt0q.fsf@gitster.dls.corp.google.com>
References: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
	<xmqqmw4hmtlw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Finnie <dan@danfinnie.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 21:55:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMNGI-0007k0-E2
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbbBMUyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:54:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753150AbbBMUys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:54:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BE8C3717B;
	Fri, 13 Feb 2015 15:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYlfoYcgIFekUzkK9TZXqE9iDMU=; b=W9pOOu
	LCDMe6C4g92bCLF96iKFyOYTQeC91fbN70Cl40poaFSkz7M5AQllQ3UHNwRZPhPC
	o+f9pEv1vATwUJVMWZ792Z+2ahlrjEXl0CAZPRbKXyrmODIr8BUB9L8QLldL76PU
	6r+3ykrdJ9Ml8teFKlHQpi5AgnZWxGIyq5t7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLggTYh7QXXx9k5dzkPTdOso2CeoC69y
	zjSzMfrotimUSvtiJx1oFjs/Op5fxU2W/sN9ru2XB/nk66ZhyxrwSnCkvaVbOWxd
	kpSy8zEyN03JRk9ftWg8aI87UiUHxH015IX6Irb6uu4B1bWiK9tQAQsLBK3JvRYO
	/YLss4hK9M0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A9D3717A;
	Fri, 13 Feb 2015 15:54:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B997137179;
	Fri, 13 Feb 2015 15:54:46 -0500 (EST)
In-Reply-To: <xmqqmw4hmtlw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 13 Feb 2015 12:42:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B28B620-B3C2-11E4-BB96-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263833>

Junio C Hamano <gitster@pobox.com> writes:

> ...  It does not make sense to allow where you are
> to affect behaviour of the command, i.e. in these two invocations of
> ls-files:
>
> 	git ls-files -X /var/tmp/exclude -i
>         cd example && git ls-files -X /var/tmp/exclude -i
>
> if the same line in /var/tmp/exclude meant completely different
> things, it would be crazy.

To put it another way, think of --exclude-from as a way to specify a
replacement for .git/info/excludes, and --exclude-per-directory as a
way to specify a replacement for the in-tree .gitignore files.

Historically, we did not have the --exclude-standard option from the
beginning, and only after we gained experience with --exclude-from
and --exclude-per-directory in our scripts, the --exclude-standard
was added to codify the (then-) best-current-practice after the fact,
and we used --exclude-from for exactly that purpose before then.

cf. 8e7b07c8 (git-ls-files: add --exclude-standard, 2007-11-15)
