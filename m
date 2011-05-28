From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sat, 28 May 2011 18:08:44 -0500
Message-ID: <20110528230844.GA31498@elie>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 01:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQScy-0004yL-HP
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 01:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab1E1XIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 19:08:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39218 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab1E1XIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 19:08:52 -0400
Received: by iyb14 with SMTP id 14so2171919iyb.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=loqOu7BZz8L0Ldh6s+Q3ReNsmRku93AAbJWi6vvJhoE=;
        b=M5x2VKnKpEEvpvVs2briE0rpAM0Ur4wtD7ggGDNQCQGP7Zf94ucVu/su5q0Pc3lPXv
         2HDyhUCVM5bOACeVLfyb5TYZEOcjW1oH9eONuVwi6YqKHk+ZecvuVlH2+nhqptaQkSh1
         6a7+iNjHPjJ9C/0DkL1Pk9h8YrFiGkZ0RsVJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TYQyvQooqVo/7D51/XvNfxEqv0eW2SqWZjjI2QJj2T7thtWzb5tfRfdjD3c1UjIEKX
         cfG3m7TY/T6T0p5sVOcedRZe1tn89nwV1Sga7LwVIA14tKhCiUCh/rI3RmKCu6Dka2zu
         7EzJmJQmnWuKCkNm2wWUfcr0Fb0i12CGysjC4=
Received: by 10.42.150.6 with SMTP id y6mr4110785icv.409.1306624131314;
        Sat, 28 May 2011 16:08:51 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id d8sm728048icy.21.2011.05.28.16.08.49
        (version=SSLv3 cipher=OTHER);
        Sat, 28 May 2011 16:08:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174683>

Hi,

Martin von Zweigbergk wrote:

> Teach git-rebase the --discard subcommand, which is similar to
> --abort, but does not move back to the original branch.  Suggest this
> new subcommand to the user where we currently suggest to delete
> $GIT_DIR/rebase-apply (or rebase-merge).

Good idea.

At first the name --discard made me think it was going to move back to
the original branch and discard the reset of the patch series being
rebased.  Not sure what a better name would be, though.

> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -238,6 +238,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
[...]
> +--discard::
> +	Abort the rebase operation without restoring the original branch.

A reader without a complete mental model for what "git rebase" does
could be very confused by this.  One might think: does this mean that
git has been scribbling over the original branch, and this switch
almost completely cancels that but leaves the branch still
scribbled-on?

How about something like:

 --keep-head::
	When aborting a rebase, do not check out the original branch
	but leave the HEAD alone.  This can be useful if you forgot
	about a conflicted or interactive rebase in progress and have
	been committing on top of one of the commits being replayed.

?

Agh, "git rebase --abort --keep-head" feels a little too long to be
memorable.  Still, hope that helps.

Ciao,
Jonathan
