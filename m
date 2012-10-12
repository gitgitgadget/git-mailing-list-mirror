From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/12] Integrate wildmatch to git
Date: Fri, 12 Oct 2012 10:30:56 -0700
Message-ID: <7v7gqv4my7.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <1349865651-31889-6-git-send-email-pclouds@gmail.com>
 <5077C676.3070209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMj4q-0005Wk-P2
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 19:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992Ab2JLRbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 13:31:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030228Ab2JLRa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 13:30:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D044C99A6;
	Fri, 12 Oct 2012 13:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lT/GMpk0+dg8pqZ96DdtiHeApMM=; b=Sixe/4
	CJs5Yin1UsCFBj2VluCyLk7H/0FLgVpshs1AEFC/bxTPN9xhhsEahsVcFb/gHSFS
	g490Hwjitjja0e5e1Na3v7/DaxrpOqNl61YVRJKGOiOMaZZN7Tj3y0qGJtX12AKB
	/0D/8GtIIqTnqkdDpE+/SVyEMDae/Lke0azaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGTT2UqqY0aljtaHvEhGseWri+kowV6r
	AUakzvvoHe3mYYe/GS6dd0eXolF1T2KgTk529qrH6eAcmy/tcjsoa583xaPj28t+
	6OCmK3scmEkYzwKWroJmHcakg6ERfHSxEigQnV/cK2f4FhDhaoMWBNjHywEAWSzG
	cU1o0tiZKnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC4F99A5;
	Fri, 12 Oct 2012 13:30:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 145F199A2; Fri, 12 Oct 2012
 13:30:57 -0400 (EDT)
In-Reply-To: <5077C676.3070209@viscovery.net> (Johannes Sixt's message of
 "Fri, 12 Oct 2012 09:27:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95865518-1492-11E2-9A4E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207562>

Johannes Sixt <j.sixt@viscovery.net> writes:

> --- >8 ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] test-wildmatch: avoid exit code -1
>
> Our bash on Windows does not recognize -1 as failure.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Please squash this in, in the next round.

I do think the patch is good, but I am curious if people who ported
bash to windows consider this a bug.

Shouldn't the argument to exit() be truncated to its least
significant 8 bits (that is, status & 0377) and be made available to
the waiting parent process (which is bash in this case)?

>  test-wildmatch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test-wildmatch.c b/test-wildmatch.c
> index d716852..74c0864 100644
> --- a/test-wildmatch.c
> +++ b/test-wildmatch.c
> @@ -4,11 +4,11 @@
>  int main(int argc, char **argv)
>  {
>  	if (!strcmp(argv[1], "wildmatch"))
> -		return wildmatch(argv[3], argv[2], 0);
> +		return !!wildmatch(argv[3], argv[2], 0);
>  	else if (!strcmp(argv[1], "iwildmatch"))
> -		return wildmatch(argv[3], argv[2], FNM_CASEFOLD);
> +		return !!wildmatch(argv[3], argv[2], FNM_CASEFOLD);
>  	else if (!strcmp(argv[1], "fnmatch"))
> -		return fnmatch(argv[3], argv[2], FNM_PATHNAME);
> +		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
>  	else
>  		return 1;
>  }
