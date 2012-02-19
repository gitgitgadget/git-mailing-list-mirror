From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick -x: always insert an empty line
Date: Sun, 19 Feb 2012 00:44:10 -0800
Message-ID: <7vhaynp605.fsf@alter.siamese.dyndns.org>
References: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Raible <raible@nextest.com>
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Sun Feb 19 09:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz2NV-0002Ws-35
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 09:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab2BSIoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 03:44:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab2BSIoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 03:44:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9EF86308;
	Sun, 19 Feb 2012 03:44:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IAzxrCcY+SUOMtyIsFNwldK9nSw=; b=QgfsNN
	1R+Sr1059deEbljL/kNuXjUqrnXGi947UQy7cjzB+Gy7/DoVIPatfuk68Wk6QfC/
	MvmcliMKQVszbP8xMYrqNSBpQk53G+UdPXBK7hIfl1fp0jpKo5YQuTo3io55z2Wt
	NkHHBYvgnNSfZ+osbTvLgyKN+O4zjPWc3zpBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a761nik7JuPKZZzH2GbWlDtfap29SETv
	MwtmZiPn4/YVg31NBZxs4z3jK9Tf7ZpIsX+iOdUerM2whCDLzw68c+hNpr44vPby
	3YwpEDEV7LCV5IVdrwrRLLi4dk/fL/fH0RZuYHHdHnSwLsjJKioHpaMXYo/pd+sk
	7sYmW6ZyY6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C6A6307;
	Sun, 19 Feb 2012 03:44:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77EAD6306; Sun, 19 Feb 2012
 03:44:11 -0500 (EST)
In-Reply-To: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch> (Beat
 Bolli's message of "Sat, 18 Feb 2012 22:14:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E50A5296-5AD5-11E1-A891-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191021>

Beat Bolli <bbolli@ewanet.ch> writes:

> When cherry-picking a commit that has only a summary, the -x option
> creates an invalid commit message because it puts the hash of the commit
> being picked on the second line which should be left empty.
>
> This patch fixes this buglet by always inserting an empty line before
> the added line.
>
> Aside from that, even with a non-trivial commit the generated note
> "(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"
> seems abrupt when appended directly.
>
> Cc: Eric Raible <raible@nextest.com>
> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
> ---
>  sequencer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5fcbcb8..63fd589 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -382,7 +382,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		}
>  
>  		if (opts->record_origin) {
> -			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
> +			strbuf_addstr(&msgbuf, "\n(cherry picked from commit ");

Doesn't this need to be conditional?

If we cherry pick your commit somewhere else with "-x -s", the resulting
commit log message would end like this:

    Aside from that, even with a non-trivial commit the generated note
    "(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"
    seems abrupt when appended directly.

    Cc: Eric Raible <raible@nextest.com>
    Signed-off-by: Beat Bolli <bbolli@ewanet.ch>

    (cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)
    Signed-off-by: Frotz Xyzzy <nitfol@example.xz>

which clearly is worse-looking with the extra LF you added in this patch.

>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
