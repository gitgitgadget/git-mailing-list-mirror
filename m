From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/8] commit.c: new function for looking up a comit by
 name
Date: Wed, 13 Oct 2010 14:59:26 -0700
Message-ID: <7viq15iwjl.fsf@alter.siamese.dyndns.org>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
 <1286478657-61581-3-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:59:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69MM-0000p3-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0JMV7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:59:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMV7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:59:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD86DEAE8;
	Wed, 13 Oct 2010 17:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AvhzVhAw1hVqnDl1mrNgxym+anc=; b=HwvuhYH5XUnhW07KatC5ont
	SwMajp6gaLYvi1gjl7m1jxCsKgunasNSL75Un5tN/t1X6KPDBK4AA9w2tkkh4CeP
	Z5k5IrVWuhC+3F1GEHOceTiLAiwYqIiMBicmDIahHBX/I3ak0XktBq9c6qte3iMJ
	6ReQ04igdrHX1jPNiR64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=S5Kw06vPvXCrGelnrPH3mz5HMBpajCiAYVkJEC5jdec5jhbvk
	8vVMfM7ejFGLEQ+jWwWybt/4/w6Wp825nVGPtsQ7VWFNunp0n+C8V2JqVs0/W/ST
	wIecnEItQWZ8FOylYlKcgZHs2TTumwFgHfbt3zOUs8ogQc91GK9/ADHbSg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E284DEAE6;
	Wed, 13 Oct 2010 17:59:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A1E0DEAE4; Wed, 13 Oct
 2010 17:59:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2795EA80-D715-11DF-BBBE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158988>

s/comit/commit/;

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/commit.c b/commit.c
> index 0094ec1..f51098a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -49,6 +49,19 @@ struct commit *lookup_commit(const unsigned char *sha1)
>  	return check_commit(obj, sha1, 0);
>  }
>  
> +struct commit *lookup_commit_reference_by_name(const char *name)
> +{
> +	unsigned char sha1[20];
> +	struct commit *commit;
> +
> +	if (get_sha1(name, sha1))
> +		die("could not lookup commit %s", name);
> +	commit = lookup_commit_reference(sha1);
> +	if (!commit || parse_commit(commit))
> +		die("could not parse commit %s", name);
> +	return commit;
> +}

Although this wouldn't _hurt_, not very excited without seeing codepaths
that can use this helper to reduce lines (there should be a lot of places,
I would think).  And when that happens, the helper that dies would not be
very useful, as some potential callers that can benefit may want to decide
what messages to issue themselves.
