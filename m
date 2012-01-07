From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: rerere.enabled overrides [ -d rr-cache ]
Date: Fri, 06 Jan 2012 21:17:12 -0800
Message-ID: <7vk454gkh3.fsf@alter.siamese.dyndns.org>
References: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch> <7vfwfsk24y.fsf@alter.siamese.dyndns.org> <87boqge19s.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 07 06:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjOev-0004sc-58
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 06:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999Ab2AGFRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 00:17:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2AGFRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 00:17:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83CE670D0;
	Sat,  7 Jan 2012 00:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSV8KnCC3prXc/MROGxAxOW0W2k=; b=e2kEcu
	70AvUWP7zVQVp9S8v2f71eqaYLKC46IRQvT6yeh9OnntTRoL5L1LkjVrg45Yh9Fb
	MOTC/3q8U9ChPfXbk72f2UPOC1/h79uOnd5oBz4IoJFAal4RDRThML+TKMC6f68h
	fB2pIOSZoMKqPkezMhiaGzHBov/pRMS+JZenw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iuh9g6XyImsTszjefJffnyHpT/BJTYjv
	qvcn+ZQBtvtDZKQOVSFpGq2ajFLfh6RB+YAWJUFOYqewDD21KirzW1U+i9Xm5UGh
	J5MdEOzLfYL6n9r9t1ISOGllgkQPO7PamQMKMpa3e1TZ4kJK8G0JS92+fg1ybHSl
	BWVxWZCtuNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782A770BD;
	Sat,  7 Jan 2012 00:17:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07478704D; Sat,  7 Jan 2012
 00:17:13 -0500 (EST)
In-Reply-To: <87boqge19s.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Sat, 7 Jan 2012 02:42:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBE4CAA6-38EE-11E1-AA11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188065>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The manual page for "rerere" talks about "configuration variable
>> rerere.enabled"; perhaps it should also refer to git config manual page to
>> make it more discoverable?
>
> Maybe, but it already says you should set the variable in two different
> places.

That is not the point.

The documentation for git config seems to be the only place where we
explain that the existence of rr-cache determines what happens when the
user does _not_ set the variable; lack of that description will lead to
the confusion you describe below:

>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> ... OTOH the
>>> auto-creation of rr-cache can cause strange behavior if a user has
>>> rerere.enabled unset and tries it once, as in
>>>
>>>   git config rerere.enabled true
>>>   git merge ...
>>>   git config --unset rerere.enabled
>>
>> That is because the last one should be
>>
>> 	git config --bool rerere.enabled false
>
> I definitely meant --unset.  If the user knows the distinction, and
> wants to return the variable to the state it had before his test ...

Running "unset" is how to return the _variable_ to the previous state, but
that is _not_ how to return to the previous state of the _repository_.

Perhaps something like this in addition?


diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04f5e19..c523c67 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1786,7 +1786,8 @@ rerere.enabled::
 	conflict hunks can be resolved automatically, should they be
 	encountered again.  By default, linkgit:git-rerere[1] is
 	enabled if there is an `rr-cache` directory under the
-	`$GIT_DIR`.
+	`$GIT_DIR`, e.g. if "rerere" was previously used in the
+	repository.
 
 sendemail.identity::
 	A configuration identity. When given, causes values in the
