From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Tue, 13 Apr 2010 13:01:43 -0700
Message-ID: <7vsk6zt93s.fsf@alter.siamese.dyndns.org>
References: <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com> <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com> <20100413090604.GB770@arachsys.com>
 <20100413090713.GC770@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 22:02:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1mJC-0003BJ-C9
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 22:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab0DMUBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 16:01:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0DMUBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 16:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08893AAE0C;
	Tue, 13 Apr 2010 16:01:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YEzgywInMldtOiYsrAKaZ/AtkGg=; b=ky/OtjRJ9Pown9X96LjSpTJ
	CqcU46TXNftYSqr/IDA+W0700gnp7KMBwNb0Yh1fQrVl4ppnQPEWxOUqlMaNd/wz
	qPIY2tqx2/45AkAhgqjJMfO9aIsxtNTENXUF7xMHfpl19RdXZki+1Kw+Vmh0yNxr
	HYGSlG9E61FPr8DKv3Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xUS9k1nj0xy3BJkBe0jgAjHpQ1I3YahQCfk1wfvimyZKLK5Wv
	coer49QtVRzAEEsj60vKKGJDZl5GXJkMy52QH+2KjS/IBznRLnM+aMezF0UFBq5g
	CpeG6bt8vFzUlF16i0hAHKQG9Z5WrPlKGVryMU+s/CevSs9I+gtbTTvvBI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0BF9AAE09;
	Tue, 13 Apr 2010 16:01:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AEF0AAE04; Tue, 13 Apr
 2010 16:01:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65117FB4-4737-11DF-97D0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144830>

Chris Webb <chris@arachsys.com> writes:

> In exec_cmd.c, git hard-codes a default path of
> /usr/local/bin:/usr/bin:/bin.  Get an appropriate value for the system
> from <paths.h> if possible instead. We only try to include <paths.h> on
> Linux, FreeBSD, NetBSD, OpenBSD and GNU where it is known to exist.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  Makefile          |   10 ++++++++++
>  exec_cmd.c        |    2 +-
>  git-compat-util.h |    6 ++++++
>  3 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 910f471..f4fe941 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -735,10 +735,12 @@ EXTLIBS =
>  ifeq ($(uname_S),Linux)
>  	NO_STRLCPY = YesPlease
>  	NO_MKSTEMPS = YesPlease
> +	HAVE_PATHS_H = YesPlease
>  endif

Ok.  Somebody else may want to add an autoconf support on top of this, but
this is good as-is, I think.

Thanks.
