From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git fails to detect subcommand when hook is symlinked to a
 builtin
Date: Sat, 19 Mar 2011 12:40:44 -0700
Message-ID: <7voc56rj9f.fsf@alter.siamese.dyndns.org>
References: <20110318151415.GC26236@inocybe.localdomain>
 <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
 <20110319011445.GL26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 20:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q121D-00068w-4T
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 20:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab1CSTkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 15:40:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab1CSTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 15:40:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A634487E;
	Sat, 19 Mar 2011 15:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JF8E6q0JhpzBOyax6PqsRqhGExg=; b=DtytQF
	X2sxCg6Pn6oTMQE0KafgCJhdbFRWJ3ToR/KBAJPcTbTiAYIfD3mSbih48M4dFIdd
	cZk2M4KILfSExaYhVN9Z4db5iNlepl85wE/IeePwCbP/M9AR8LhkJ5Ryb0rGbo4O
	vBSv9ldRVs86asZK3dLTeAPVg7x08gjWM0EPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hagu4cDSg/3a5Dj0C+zIA44oxuK8hMvZ
	GZeBxo4eoOV/ZLMQYANyAUJpO/CzZr6BX6Xg+dfcYYTiuk/mJOH/VvYWY6ViUvoh
	QwRAEtdAr4gAtfcwKGXVHexepAmN3LeVEDf92Jza0JadfCDifn+dNSm+RSZDFp5U
	B3Saogw+C1o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 078FE487D;
	Sat, 19 Mar 2011 15:42:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22527487C; Sat, 19 Mar 2011
 15:42:21 -0400 (EDT)
In-Reply-To: <20110319011445.GL26236@inocybe.localdomain> (Todd Zullinger's
 message of "Fri, 18 Mar 2011 21:14:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C07996-5261-11E0-80C9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169458>

Todd Zullinger <tmz@pobox.com> writes:

>> I suspect the recent change to run hooks via run_command() interface
>> has something to do with it.  From what version did you update to
>> 1.7.4.1?
>
> I should have mentioned it, but I failed to do so.  Sorry about that.
>
> This was moving from 1.5.5.6 to 1.7.4.1.

Ok, that explains it.  update-server-info wasn't a built-in, so didn't
have to look at its name to decide what to do.  It didn't have to spawn
other git commands from GIT_EXEC_PATH so running the command directly
without setting the environment variable happened to work.

But such a usage (this doesn't have anything to do with the symlinking)
was deprecated way before 1.5.4 [*1*], so the answer is still "don't do
that" ;-)

Thanks for a clarification.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/93511
