From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Thu, 13 Sep 2012 22:35:37 -0700
Message-ID: <7vr4q56uae.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
 <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 07:36:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCOZs-0004PE-52
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 07:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab2INFgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 01:36:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab2INFfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 01:35:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D69079DFD;
	Fri, 14 Sep 2012 01:35:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EotO5QgZwhHt
	P3pmBIi6vqDifqc=; b=qY5HUyGPO4rC/w2uZ9jS7Bx3K2L/lgOYuwyT0SjEJQCO
	YiFkZfURUgLaltwkUUitUjgdHsuJJIl4S8u60P/SULYdw2Vvw0QdYjEbi48IqWgA
	Zal9y6Yrctm8qGYW+OEL1QLrgm8aCiFWzBvhyamHeMymvVUmiIT+jQQ3YeaGLFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o1beap
	LFDVXqoN2isKpKDTTh1Z70bRWq25a5ZB/Y1McbdSENWJnp4ZIKBaFgxOsYR3uHlC
	Fvoy0QL/juMfW1RkdNbnmkIwwqwzsdbiUW5/yLkBs2GjEauNlmkxbo4sIz0KcCq8
	VlcPFI7n9ZkuGQ+loQTcGHUzltiMsGHvlMSr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C35AE9DFC;
	Fri, 14 Sep 2012 01:35:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21EA69DFB; Fri, 14 Sep 2012
 01:35:39 -0400 (EDT)
In-Reply-To: <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Fri, 14 Sep 2012 07:09:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0445F2B8-FE2E-11E1-8F6A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205455>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> After using "git clone" with the "--single-branch"
> option, the configured refspec for this repo was
> "+refs/heads/*:refs/remotes/origin/*".
> After fetching changes from this repo again, it'll
> receive all refs instead of the single ref which
> was used in "--single-branch". Fixing the refspec
> that it just contains the ref of the branch which
> was cloned.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/clone.c | 5 ++++-
>  1 Datei ge=C3=A4ndert, 4 Zeilen hinzugef=C3=BCgt(+), 1 Zeile entfern=
t(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5e8f3ba..3e74d55 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -754,7 +754,10 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
>  	}
> =20
> -	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
> +	if (option_single_branch)
> +		strbuf_addf(&value, "+%s%s:%s%s", src_ref_prefix, option_branch, b=
ranch_top.buf, option_branch);
> +	else
> +		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);

Who guarantees at this point in the codepath that option_branch is
set when option_single_branch is non-zero?  Until we talk with the
remote, "clone --single-branch" without an explicit "--branch" will
not learn which branch at the remote we are going to fetch (it will
be their HEAD).

I wonder if this should be more like this:

	if (option_single_branch) {
		if (option_branch)
			Your patch "+refs/heads/foo:refs/remotes/origin/foo";
		else
			"HEAD";
        } else {
        	Original "+refs/heads/*:refs/remotes/origin/*";
	}

That is, "clone --single-branch" will continue fetching from and
integrating with their HEAD without storing any remote tracking
branch.
