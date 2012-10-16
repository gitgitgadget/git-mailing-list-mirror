From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fixing problem with deleting symrefs
Date: Tue, 16 Oct 2012 09:54:14 -0700
Message-ID: <7v4nlutl1l.fsf@alter.siamese.dyndns.org>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:54:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAPU-0001pN-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab2JPQyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 12:54:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab2JPQyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:54:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B49782FF;
	Tue, 16 Oct 2012 12:54:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NqDbAQtruBcQWmjHB+QWVK4RXg=; b=tB3BsB
	lfosciJ/EM3kYQYd4b95AVMUHX38ZgmFiS6MSBXEAHdQMnYYDu7nlnZYKiUIADSJ
	2s2krxr0IUIjET1RU5orwEvC8PImienHPItvqtV4a54JJDCDsaeFq7519G9pgvIw
	sgdd/zYDUiZBwJCQTrLbVY7AJm9/N86266ric=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfjZsp81wG9m/dyVWL1TRznSbQPCoies
	7MIp7TYVMZG7Mwwb6Q086b4ALzK7ac1g+Fm4LPe+GP4uWWa720UXByUzMUr7nByO
	W/2uMT5OCeuqxl5y5pWojHcbVbzx9Awcs0tolSWvwo7yO1Aqs4ahgZJc+VxQyGjA
	gustxjrSOYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CCE82FD;
	Tue, 16 Oct 2012 12:54:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81DA982FC; Tue, 16 Oct 2012
 12:54:15 -0400 (EDT)
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue, 16 Oct 2012 15:44:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E5A92E2-17B2-11E2-AEF4-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207847>

Johan Herland <johan@herland.net> writes:

> I see that Rene Scharfe has also worked on the same issue, while I was
> preparing these patches...
>
> On Mon, Oct 15, 2012 at 11:29 AM, Junio C Hamano <jch2355@gmail.com> wrote:
>> Even though update-ref deferences a symref when it updates one to point at a
>> new object, I personally don't think update-ref -d that derefs makes any
>> sense. I'd rather see it error out when given a symref, with or without
>> --no-deref option.
>
> I'm not sure. We have multiple testcases that directly test deleting a ref
> through a symref (e.g. t1400), so supporting this seems like a concious
> decision. Erroring out when given a symref will break the following
> testcases:
>  - t1400 (git update-ref -d)
>  - t3310 & t3311 (git notes merge --abort is broken)
>  - t5505 (git remote set-head --delete and renaming a remote is broken)

"Concious" does not necessarily mean "Sane", though.  But this is
water under the bridge.  Too many people must have started relying
on this crazy "feature" since mid 2008, and removing it would break
them.

 - "update-ref -d --no-deref SYMREF", even though it is a synonym
   for "symbolic-ref -d SYMREF", makes sense.  Removing it would
   only buy us breakage.

 - "update-ref -d --no-deref SYMREF OLDSHA1" does not make *ANY*
   sense as a request, but again it would not hurt to keep it.

 - "update-ref -d --deref SYMREF [OLDSHA1]" is questionable.  What
   is the use case?  What is the next step after doing such an
   operation, now you have SYMREF that is dangling?

>> But even if it did, removing a ref pointed by a symref should really remove
>> it, and forgetting to remove a leftover entry in packed-ref has no excuse
>> bug.
>>
>> I'd say what you observed is a double bug.
>
> Patch #1 - #2 fixes the 2nd bug (removing through a symref should remove
> both loose and packed versions of the ref).

OK.  That is surely needed.
