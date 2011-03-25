From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two grep config options
Date: Fri, 25 Mar 2011 16:25:54 -0700
Message-ID: <7vlj024wal.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:26:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3GOQ-0001tr-QH
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 00:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab1CYX0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 19:26:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1CYX0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 19:26:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FAB44E7E;
	Fri, 25 Mar 2011 19:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=37o72SEeGuH7ofKoVQKDffeyJ4g=; b=s0/ibvOnrc0rbc5ldyaT
	mhfAEK2RMPf2aADyIzAJp9CcOF11f+JbSWLMrv4OjD4G5o6CN7htolceYfscrKcD
	HX0/WEmqDTJc2MFhflvYyfv4h6On8ZqnySDcyeAFsuGuxx6mVnowfWmH5aLyZw1m
	5Qhi87F0GinvxSwjizK7IrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wlUX+TRCRk6j9ahXeZ6mM00HsSfUB70CuO8BXe70ojzBU2
	3uFJ+q24SBOf1K6T0yCvzZRaLrcHSb+sA/G1Mh2mEfUlZltB/Jc5tGTRwrz5RB3F
	pWByLaT7cLmBf165L5o1ezLFfOgEEZ2O0nYdWpXgBfGObKEve64VaIBah0uUg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E167C4E7D;
	Fri, 25 Mar 2011 19:27:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 070B44E7B; Fri, 25 Mar 2011
 19:27:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AEF859A-5737-11E0-A9BE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170033>

Joe Ratterman <jratt0@gmail.com> writes:

> grep.extended-regexp: Enabling this boolean option has the same effect
> as adding "-E" to all "git grep " instantiations.  This can be
> disabled by specifying "--no-extended-regexp" on a particular call.
>
> grep.line-numbers: Enabling this boolean option has the same effect as
> adding "-n" to all "git grep " instantiations.
>
> Signed-off-by: Joe Ratterman <jratt0@gmail.com>

Thanks.

Things to consider:

 - Apply this patch on top of "master",run "git shortlog v1.7.4..HEAD",
   store the output somewhere, and imagine reading that 2 months from now.
   Does a single line in the output about this patch sufficiently tell you
   what it was about?

 - Configuration variables are spelled without hyphens between words (you
   can see "gui.commitmsgwidth" in the context of the patch you sent and
   notice that it is not "gui.commit-msg-width").

 - This will break scripts people have written, knowing that they can rely
   on "grep" they wrote without giving "-E" from their command line will
   use BRE, and force them to update the script with --no-extended-regexp
   for no good reason.  Worse yet, there isn't even --no-line-numbers
   supported to defeat grep.linenumbers configuration to protect such
   scripts.

   I understand that some people would feel that the convenience would
   outweigh the risk of script breakage in this particular case, and I am
   sympathetic to the cause, but I still have to point it out.  Is there
   anything we can do to mitigate the risk somehow?
