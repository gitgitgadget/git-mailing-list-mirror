From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 12:09:38 -0800
Message-ID: <xmqqoacid4zh.fsf@gitster.mtv.corp.google.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
	<1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
	<1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, bturner@atlassian.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:09:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLG7V-0006aM-7s
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbcARUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:09:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756213AbcARUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:09:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B0B43B6DD;
	Mon, 18 Jan 2016 15:09:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytE3ZSF2Qqrz9k9CtfiQhpocEhg=; b=FuGS8u
	y5nNQ0u9oFQ+oNl7qlM/VsafLBD2tKq9sILi9dQCOG61g3BochLn+44QxnNmjdC2
	XSaS6/Kze2WoCxqK3DYnJk+K6JDc+ZYz2lUyr/pzoVrNZIQchZD+6+W9sMk/PG8t
	DFAWmOtkxvsS8F0nOW7iofBNBije72ZSKKSPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1MO6MfHcWDvrYrnXb9m2yvMyQO+J1LD
	MSZ03C2Zar+tTj3FvQoFKfZtBhfyEf9CWIE6qM+5rdd9NrZOg1Cz7xlmR5st9XEi
	44zoUg+9D28/EysvSZVxBJVoTmASqTUz5tF/l6Cj+if2+vaiA9AU1vxD27EqyETf
	sEDNaX2Fkzk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44BF53B6DC;
	Mon, 18 Jan 2016 15:09:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A3D3B3B6DB;
	Mon, 18 Jan 2016 15:09:39 -0500 (EST)
In-Reply-To: <1453136238-19448-6-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Mon, 18 Jan 2016 17:57:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67B00D66-BE1F-11E5-A0B3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284320>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +--symrefs::
> +	Show the symrefs in addition to the other refs.
> +

Micronit.  The above sounds as if the output would not talk about
HEAD at all unless this option is given, which is not what you meant
here.  "In addition to the object pointed by it, show the underlying
ref pointed by it when showing a symbolic ref" or something like that,
perhaps?

> @@ -58,6 +60,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			 N_("take url.<base>.insteadOf into account")),
>  		OPT_SET_INT(0, "exit-code", &status,
>  			    N_("exit with exit code 2 if no matching refs are found"), 2),
> +		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),

Likewise.

By the way, unlike "--heads" and "--tags", which is to choose a
group of refs to be shown, this controls one specific aspect,
i.e. target of symbolic ref, of each thing that is being shown,
without affecting the set of refs that the command talks about.

Shouldn't this option be "--symref" (and variable named as
show_symref_target or something more explicit)?

Other than these nits, the code itself looks good.

Thanks.
