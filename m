From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Add option to transpose parents of merge commit
Date: Tue, 27 Nov 2012 18:18:00 -0800
Message-ID: <7vzk22ii7b.fsf@alter.siamese.dyndns.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXEC-0003R2-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796Ab2K1CSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:18:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab2K1CSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:18:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6120AA59;
	Tue, 27 Nov 2012 21:18:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HZCZFqLYboqbuBTNKs8y0WfZdMo=; b=J4Do8zNkeNYqcFo4++Nh
	GA+ttneIx9c4YiMonY87p3VApo+ZbTZhfF2JoxamgTqQ3VHfz7FhqJKx3DbXpRRI
	UphAwBFK7Z55Euk76rXCVIaHC5FMoZ6Yhk59bqnxM3faxO3PFZUpI6PZVBuWhM+q
	CWRFVbv5co8qqpt2ijPoy90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=a/gNP8CoqQDgR8olSzcCI3YV5Cwq5J7dm2KDrM9tkBlni6
	Gi5j4JuKe8RJiPQ3pR9SCwrXlMLNkQpCKHYre+PejOTZvGrrg76LdHyuncC9nmvc
	mUM/Fc8wW2iabl9157Za/RXv0MAvGdWj3koE8uCzVMA4NlHIaegfH9WIT3ZTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD1FAA58;
	Tue, 27 Nov 2012 21:18:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EB49AA56; Tue, 27 Nov 2012
 21:18:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5F6881E-3901-11E2-856E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210672>

Kacper Kornet <draenog@pld-linux.org> writes:

> +--transpose-parents::
> +	Transpose the parents in the final commit. The change is made
> +	just before the commit so the meaning of 'our' and 'their'
> +	concepts remains the same (i.e. 'our' means current branch before
> +	the merge).
> +

How does this interact with Octopus merges?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index ee0e884..ab2b844 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1477,6 +1477,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	} else if (whence == FROM_MERGE) {
>  		struct strbuf m = STRBUF_INIT;
>  		FILE *fp;
> +		int reversed_order=0;

Style. s/=/ = /;

> +	OPT_BOOLEAN(0, "transpose-parents", &reversed_order, N_("reverse order of parents")

It smells more like "--reverse-parents" (if you deal only with
two-head merges), no?
