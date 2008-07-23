From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did not change
Date: Wed, 23 Jul 2008 16:01:04 +0400
Message-ID: <20080723120104.GQ2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222235520.8986@racer> <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:02:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLd2q-0004UE-UZ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYGWMBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 08:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYGWMBL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 08:01:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:4301 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYGWMBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 08:01:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1110241fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Dyw/tnhuq7d0aDbetnQvwZ3bqxLBJrlwgFhJwBzxACU=;
        b=HOaSflSYSIoA/n2NtiJgqZh7sIzkWJZGLZ2zRyiC/dEilQ4wJ1jWaLwU0xwGaFsoOQ
         Ev/vxz7qA9UK2+emU0TEcrTw/eZWOAI2uUQDrOejghwEL5J2ipGNM6iz33aFnzFwAitC
         fJIxuUGuWk1YSdYe4dB51gxEbC0dkwGqs5fB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CIM8i2bmRfvHTW3KRaB1InmTaqBYQePSHO7+8+U1kglLLFZFGhfGsNAPNeWTq4n1Jf
         0ZLPotIya8wd1ja9ZI9dzboLBSKHz45GUthospNayRmsG8bSGcxpfYkDDqIWP6byCjKC
         /dSXQCUxCwnW3V8oLmXql7Td3pAbPxI/of65A=
Received: by 10.86.82.6 with SMTP id f6mr7553903fgb.73.1216814468384;
        Wed, 23 Jul 2008 05:01:08 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id l12sm11052115fgb.6.2008.07.23.05.01.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 05:01:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89639>

On Tue, Jul 22, 2008 at 06:22:34PM -0400, Avery Pennarun wrote:
> 
> This patch is perhaps a symptom of something I've been meaning to ask
> about for a while.
> 
> Why doesn't "edit" just stage the commit and not auto-commit it at
> all?  That way an amend would *never* be necessary, and rebase
> --continue would always do a commit -a (if there was anything left to
> commit).

Actually, it would be better to refuse to continue if there are unstaged
changes in the work tree, and if all changes are staged then just do git
commit.

> The special case fixed by this patch would thus not be
> needed.
> 
> It would also make it more obvious how to remove files from a commit,
> for example, without having to learn about "git reset".  For that
> matter, you wouldn't have to learn about "git commit --amend" either,
> and it would save typing.

It would not only save typing, but also help to avoid costly mistakes
where users, being taught to use "git commit --amend" after editing
during git-rebase, fire this command automatically after a conflict
resolution and get two commits accidently squashed.

So, I completely agree that the current auto-commit behavior is not very
user friendly...

Dmitry
