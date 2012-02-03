From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/13] branch: add --column
Date: Fri, 03 Feb 2012 15:11:44 -0800
Message-ID: <7vwr83ldfz.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:11:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSIK-00008r-6Y
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2BCXLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:11:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475Ab2BCXLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:11:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0E6B6C98;
	Fri,  3 Feb 2012 18:11:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G370f4a/DeUB
	tdLsrXWO6WNCA3s=; b=JJRjWAbG6TFYjPtrhL8gHRYKKi12VKsomZaHUp0Ad9FD
	qoqd//Pf41v//T4BZswkb/61B83ZjvSEaWC2+Bspome1R7YlQvyaHt9lAsHCHZXn
	EXwWBMtxzqfQ31xnDoMNTPxHUszB2uWknoAq9BGxqLJ4UObPQmF/nUwpIe0RzBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x5Aa1h
	6HG0KfUBiqZtJVtmd9WDKLz8IcV0RLeQX3Z9/ftu3LslzD+VSx0MyQUHVZ5JRw3h
	u8o7VgzMWApnLrt1kvV4BtMsQwuW8CenmPMAf3PS2kyZnT5RIvl0/tpaEiZagzxq
	YCM6cYwSWWBzOaYHfRW7pa/3po8SvUaDb8eeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88866C97;
	Fri,  3 Feb 2012 18:11:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506C56C96; Fri,  3 Feb 2012
 18:11:46 -0500 (EST)
In-Reply-To: <1328276078-27955-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71884C08-4EBC-11E1-AC76-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189826>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -474,7 +482,7 @@ static void print_ref_item(struct ref_item *item,=
 int maxwidth, int verbose,
>  	else if (verbose)
>  		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
>  		add_verbose_info(&out, item, verbose, abbrev);
> -	printf("%s\n", out.buf);
> +	print_cell(&output, colopts, out.buf);
>  	strbuf_release(&name);
>  	strbuf_release(&out);
>  }

Hmm, disabling column output when verbose is in effect without telling =
the
user what we are doing needs to be fixed, but because of that, at least
this codepath won't try to stuff potentially long strings in a columnar
form.

I am not sure about the utility of columnar output for "git branch" in =
the
short form.  You no longer can just scan the leftmost column to scan fo=
r
'*' to see the current branch.
