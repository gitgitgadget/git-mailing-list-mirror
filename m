From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/11] contrib: cc-cmd: ignore chunks with no original lines
Date: Fri, 19 Apr 2013 13:04:58 -0700
Message-ID: <7vmwsuz3px.fsf@alter.siamese.dyndns.org>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
	<1366399831-5964-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 22:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHYU-0004sA-8y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 22:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab3DSUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 16:05:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab3DSUFC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 16:05:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 061A317D39;
	Fri, 19 Apr 2013 20:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sbm3VR+QLzEMFN67qPWLzv2H0y8=; b=oqaYiN
	9cQukPoHRVCZeB7hNqO3cjFmGOpfgYb982VVjmwxR+fWYTZesq1PvAUnKkn2ezUB
	J1CBqZhNMzk1RnGWOA4/c+C/2SgGxAcIeuKJJ0JrN1IawWbdMe5UPbjJDVL/aCmz
	VsAbW5IEAh9awBKbEKDgtxc6X9sHCwvkZS6bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tt9CTqp9oESAt1xIAzom2PfwOH8gmozQ
	xbkHk2UfoFvGYB+7VGhc1NQ4dVvoWde+Vj7CDk6ccCw8TlxEN7YUeQn3Tftk2+Qn
	akDQUDJB6pox2s1H/FUUePE46izWvLvngwH40aQTtfHUNVxeZ21KfldxtW/4sPhr
	9kYWIL0XpXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F133617D38;
	Fri, 19 Apr 2013 20:05:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F02117D37;
	Fri, 19 Apr 2013 20:05:00 +0000 (UTC)
In-Reply-To: <1366399831-5964-12-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 14:30:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A70E2BA-A92C-11E2-8703-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221816>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/cc-cmd/git-cc-cmd | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
> index 9a2d2fd..02841c4 100755
> --- a/contrib/cc-cmd/git-cc-cmd
> +++ b/contrib/cc-cmd/git-cc-cmd
> @@ -125,7 +125,7 @@ class Commits
>    end
>  
>    def get_blame(source, start, offset, from)
> -    return unless source
> +    return unless source and offset

I do not think a separate patch at the end is a good idea for a
fix-up like this, even if to give credit to others.

Just squashing it in to the original would help reviewers; that way,
they do not have to wonder "why is this broken" and later notice
"ah, it is fixed at the end".

I do not know if that is an "offset", though.  It is the "offset"
for the end of the block relative to its beginning, but people
usually call that the "size" of the block, I think.

>      File.popen(['git', 'blame', '--incremental', '-C',
>                 '-L', '%u,+%u' % [start, offset],
>                 '--since', $since, from + '^',
