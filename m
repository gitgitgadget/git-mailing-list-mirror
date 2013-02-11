From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] shell: pay attention to exit status from 'help'
 command
Date: Sun, 10 Feb 2013 23:15:50 -0800
Message-ID: <7vd2w7pbh5.fsf@alter.siamese.dyndns.org>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin> <20130211055847.GG15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ncg-0008P6-9e
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab3BKHPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:15:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab3BKHPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:15:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EBA2BF9D;
	Mon, 11 Feb 2013 02:15:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BHdNWrMCEGtxDokjCFsyDkKv65s=; b=mcuvJK
	zZeDDtEflH7ob1ZWdGHTCpOv2QzJS0VknoOnl+VVf8aaO5MY/1O2KzoyITtpqFGr
	NrH7KZtcQXVZrjHfYQVA0aTqZkKBz69UOiEvE0yUmE0zHxoP4bUxsmzyg80Bnfl+
	XfpYp0Qn/K8gh++L5Hkfo++DD8zj8PoMYkld0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIahXjxRFrCJmmJElKD9Oo/eDBcPzEbf
	39V6w7ReXplJzBhryjFaut091BHgnghs3E0ivG5R7HX66MQaI76jjolgIYpyePGy
	qc+ZwmyoluaWciihQ0q0+M/rN+RD1DC36cXVggjhv0qmzKpDoKBwW2zVPps/0xEA
	YGc7hxrT35w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F97BF9C;
	Mon, 11 Feb 2013 02:15:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FC67BF9A; Mon, 11 Feb 2013
 02:15:52 -0500 (EST)
In-Reply-To: <20130211055847.GG15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 21:58:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE9243E2-741A-11E2-9E9C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216010>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
> index 4fe93203..60051e63 100644
> --- a/Documentation/git-shell.txt
> +++ b/Documentation/git-shell.txt
> @@ -59,6 +59,26 @@ users to list repositories they have access to, create, delete, or
>  rename repositories, or change repository descriptions and
>  permissions.
>  
> +If the `help` command exists and exits with nonzero status, the
> +interactive shell is aborted.
> +
> +EXAMPLE
> +-------
> +
> +To disable interactive logins, displaying a greeting instead:
> ++
> +----------------
> +$ chsh -s /usr/bin/git-shell
> +$ mkdir $HOME/git-shell-commands
> +$ cat >$HOME/git-shell-commands/help <<\EOF
> +#!/bin/sh
> +printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"

Where in the sshd to git-shell exec chain is $USER variable set for
the user?  Just being curious if this is the simplest but one of the
more robust ways to get the user's name.

I still think forcing the site administrator create a directory for
each and every user only to house a single script that denies the
access is a wrong design, but the code seems to correctly implement
that design.
