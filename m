From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Fri, 29 Aug 2008 16:58:14 +0200
Message-ID: <237967ef0808290758p2bd1de55idcb9ad9150389b2b@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 16:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ5RZ-0001Uy-Jt
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 16:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYH2O6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 10:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYH2O6R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 10:58:17 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:2015 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbYH2O6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 10:58:16 -0400
Received: by ik-out-1112.google.com with SMTP id c28so529680ika.5
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=X4KV+PC2ZRmwxMf+O5KLjCy9IvblWRuhY6jQRRs2K8Q=;
        b=EXSrtVzPLbink/9gc002vhpKZ0TqSZ7XXBmG05NtVHlTEM4obAJvTQFWexApbd319v
         t7dHL2HYVrsHEg14kSFVbVY7tL+4WVgEMalZarzikygegrwkVMVViXZbhPctF4Dkcyo1
         TyvWjTloUPnbdJw2cSCFEVMhWLhEvdFMYzmZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Xs+KovHKuRYceELrLcK61ganCrPtHDT7OjNcpudS1kKtvLy9te+ZfMCZd9Qph96Y7u
         DdBwSuu73RwbA8dNb2e3QgYEIAjBaO5eiwPEmPT80ZElUx2qp+FiWbn5qUkwE2pkhpCV
         BU0HNZHcop/dPMBBZ1vZuSDnYh2yJhGTn8yR0=
Received: by 10.210.127.13 with SMTP id z13mr1732983ebc.106.1220021894216;
        Fri, 29 Aug 2008 07:58:14 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Fri, 29 Aug 2008 07:58:14 -0700 (PDT)
In-Reply-To: <20080828212722.GF6439@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94302>

2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:
>
>        swap = 0, insertion = 1, substitution = 2, deletion = 4
>
> A typical output would now look like this:
>
>        $ git sm
>        git: 'sm' is not a git-command. See 'git --help'.
>
>        Did you mean one of these?
>                am
>                rm
>
> The cut-off is at similarity rating 6, which was empirically determined
> to give sensible results.

I merged the branch in pu into next, which I think should work, but I get
these segfaults for some commands... I tried running in gdb but even with
-g3 I only get nonsense backtraces, not sure why.

% git puhs
WARNING: You called a Git program named 'puhs', which does not exist.
Continuing under the assumption that you meant 'push'
in 2.0 seconds automatically...
zsh: segmentation fault  git puhs

% git ma
WARNING: You called a Git program named 'ma', which does not exist.
Continuing under the assumption that you meant 'am'
in 2.0 seconds automatically...
Nothing to do.

At this point I thought builtins crashed and scripts were fine, but...
% git ada
WARNING: You called a Git program named 'ada', which does not exist.
Continuing under the assumption that you meant 'add'
in 2.0 seconds automatically...
Nothing specified, nothing added.
Maybe you wanted to say 'git add .'?

However,
% git ada git.c
WARNING: You called a Git program named 'ada', which does not exist.
Continuing under the assumption that you meant 'add'
in 2.0 seconds automatically...
zsh: segmentation fault  git ada git.c

-- 
Mikael Magnusson
