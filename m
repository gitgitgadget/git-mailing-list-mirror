From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report about symlinks
Date: Fri, 01 Aug 2014 09:23:07 -0700
Message-ID: <xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 01 18:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDFc1-00016b-3m
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 18:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaHAQXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 12:23:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54480 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaHAQXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 12:23:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAC582CBDA;
	Fri,  1 Aug 2014 12:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vKDzB6Zl3p+m
	BaNuGSHDT2U6cwI=; b=BilZ17HbHU5bCW2Yeayjsoa8bVByM3IXyaCPPFkssria
	X+SPfiEugBKZkqzh07jImthTpfaf0VOuobaP/bsYP+ViaDC2REEJS1AUlWWcn30+
	qgsxSPL4puv9AIpyvi6jcXfYTXSNe2BHrRHaOjtGUDd38wdMg290msw3NP3jnks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pwjLQ8
	TpmVZw8alVEegpl4WtDhxqZY4nMJJj74T7cg7qCuVgN4KuKsCao43xlt3hj9uePL
	3EJssNv0hieu3WVXV2Pf34u2hyYSsrgsvObWnREVoKMhq/yjSaRrW3uphEtb8UyU
	s1erMnBKKyiCqOnGdTD4wpe07fj9UP+qBmIg0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE5462CBD9;
	Fri,  1 Aug 2014 12:23:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 49B272CBD3;
	Fri,  1 Aug 2014 12:23:09 -0400 (EDT)
In-Reply-To: <53DABD69.7010004@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Fri, 01
	Aug 2014 00:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20274E46-1998-11E4-9DB7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254628>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> # Create test repo with two directories with two files each.
> $ git init
> Initialized empty Git repository in /tmp/.git/
> $ mkdir a b
> $ echo x >a/equal
> $ echo x >b/equal
> $ echo y >a/different
> $ echo z >b/different
> $ git add a b
> $ git commit -minitial
> [master (root-commit) 6d36895] initial
>  4 files changed, 4 insertions(+)
>  create mode 100644 a/different
>  create mode 100644 a/equal
>  create mode 100644 b/different
>  create mode 100644 b/equal
>
> # Replace one directory with a symlink to the other.
> $ rm -rf b
> $ ln -s a b
>
> # First git status call.
> $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>
>         deleted:    b/different
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         b
>
> no changes added to commit (use "git add" and/or "git commit -a")
> ...
>
> It could be debated if the first git status call should also report
> b/equal as deleted.

Hmph.

I wonder if "could be" is an understatement.  The difference of
reporting between b/equal and b/different may indicate that somebody
is mistakenly comparing the index with these paths, without first
checking each path with has_symlink_leading_path(), or something,
no?

Or am I misreading the report and codepath?

Puzzled...
