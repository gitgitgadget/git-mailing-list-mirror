From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-clean: Display more accurate delete messages
Date: Thu, 10 Jan 2013 09:45:36 -0800
Message-ID: <7v7gnl2apr.fsf@alter.siamese.dyndns.org>
References: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
 <7vk3rl3fw5.fsf@alter.siamese.dyndns.org>
 <CAKJhZwQ=RzLgCBUrx_QKY8Xzh-L8QC2UVcQJEpYxxGQz=8LwwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 18:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtMCW-0002Bh-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 18:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3AJRpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 12:45:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab3AJRpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 12:45:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5D17B634;
	Thu, 10 Jan 2013 12:45:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YKPc6uQyDQxsoNgycw4BU9P9Ft0=; b=gL/7H1
	xs1510V5c8RfoGfteAJBpi0CBiLbk8ZBtP7kEPmUIDt4GexFayTqveJXhoX83s3I
	HGmU13BqGqTR9xXyRgW8fHwQ+21pPnSwgCGbJ2UQM9r8mKkAghQyToNazHFkEH/u
	/khUTpnlkz6UPI93cSnCOwcTwxNvnnzBlybD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldY39jjp5LYsY4+nfsNl68EnnuGRufff
	3fRORkl2gC7Q4B2Ri1H/q1NkuPhwr2VVMZ9BkISvWT0ittvxOsRybyapft9AOLdi
	jHEf4jE648Ae7lrSULREWtspfUB1FXe263D3bRyngXlm3heePZszocmqCJjdKZHy
	hEl67J5WoR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C0FB633;
	Thu, 10 Jan 2013 12:45:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E8ADB632; Thu, 10 Jan 2013
 12:45:38 -0500 (EST)
In-Reply-To: <CAKJhZwQ=RzLgCBUrx_QKY8Xzh-L8QC2UVcQJEpYxxGQz=8LwwQ@mail.gmail.com> (Zoltan
 Klinger's message of "Thu, 10 Jan 2013 21:41:56 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B535BA2-5B4D-11E2-8AFF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213143>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

>> I think the code before this patch used to say "Would not remove"
>> and "Not removing" in certain cases to report the paths that the
>> command decided not to remove, but after this patch these two
>> messages no longer appear in the patch.
>>
>> Is it expected, are we losing information, or...?
>
> I do not think we are losing any information.
> Say, we have a repo like this:
>     test.git
>      |-- untracked_file
>      |-- untracked_bar
>      |     |-- bar.txt
>      |-- untracked_foo
>            |-- foo.txt
>
> The original version prints out:
>   $ git clean -fn
>   Would remove untracked_file
>   Would not remove untracked_bar/
>   Would not remove untracked_foo/
>
> We never asked for any directories to be removed so IMHO the "Would
> not remove ..." messages are just noise.
>
> The new version prints out:
>   $ git clean -fn
>   Would remove untracked_file

Oh.  I was blinded by the primary reason of your patch being "be
more careful and defer reporting a removal until we know everything
in a directory did get removed and managed to remove the directory",
and did not realize this "noise removal".

Perhaps add

	Also do not mention that we are not removing directories
	when the user did not ask us to do so with '-d'.

or something to the description?

Thanks for a clarification.
