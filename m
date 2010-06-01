From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Tue, 1 Jun 2010 15:25:18 +0000
Message-ID: <AANLkTinNpIjirZQL1lBi3t4i6_utCIUMuXc8q2gSJvmO@mail.gmail.com>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
	<20100601115755.04ff4a0d@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:25:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTLJ-0005RX-Ax
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab0FAPZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 11:25:21 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:36535 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0FAPZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:25:19 -0400
Received: by pzk15 with SMTP id 15so1514276pzk.15
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yX+Ss84dkpHw8PrjjrLyvUqTE3qE+5dSRe+IkqoR9GE=;
        b=wJg1S09GBj69IseNRdd1ij2RpI/aAetBKhdPHKXPDbhG+gKjOutKb80/ZvsKcASCnH
         ikIV2G6+jZkzgj1+yl2w4Muiiq/4PjpFqrd7N3jNQX6178Wx0Wqrn47MIsSGUWmISnIY
         GDFwK+7jVLYm15yfOSLaNQskpWYb5RG5KLBdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xw2ANuO/HzEny7oYf+j6NVdFY0VIlMdHc/TmnP8gTpOTebYKGIV//MZ7UqAjdJfxh9
         udbzmmipAwFJ3afCF5nhcAy7WYqJnNaO7dYUHec0ejbn26jciSDHJSSjVcKYx+t0sSO8
         nTH4r2GOSXvpBe5kQpqYWLby/KlPIoYPP6dXE=
Received: by 10.142.195.15 with SMTP id s15mr4385579wff.206.1275405918967; 
	Tue, 01 Jun 2010 08:25:18 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 1 Jun 2010 08:25:18 -0700 (PDT)
In-Reply-To: <20100601115755.04ff4a0d@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148127>

On Tue, Jun 1, 2010 at 09:57, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Peter Krefting <peter@softwolves.pp.se> wrote:
>
>> Last time this happened to me, I *did* notice my mistake as I entere=
d
>> the editor, since it came up with the previous commit's message.
>> However, as the commit message file was in a good shape, I found no
>> way to break out of the amend.
>
> It might be easy to miss, but it's there, right in the editor:
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and *an empty message aborts the commit*.
> (Emphasis added)
>
> In general, it might be helpful to warn very loudly upon doing a comm=
it
> --amend after fixing conflicts, but an implementation would probably =
be
> ugly and for all I know, there might be people who frequently cause
> conflicts while amending; those guys would probably be quite annoyed =
at
> such a warning.

I've also introduced the error Peter describes into my history because
I wasn't careful. That required some splitting / reflog fixes later.

Perhaps the best way to solve this would be to change the content of
COMMIT_EDITMSG in cases like these so it gives you an explicit warning
about what you're about to do.

We already do this for merges, from builtin/commit.c:

		if (in_merge)
			fprintf(fp,
				"#\n"
				"# It looks like you may be committing a MERGE.\n"
				"# If this is not correct, please remove the file\n"
				"#	%s\n"
				"# and try again.\n"
				"#\n",
				git_path("MERGE_HEAD"));

		fprintf(fp,
			"\n"
			"# Please enter the commit message for your changes.");
