From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 18:09:59 +0400
Message-ID: <20080724140959.GU2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org> <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1XC-0004dV-GS
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYGXOKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYGXOKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:10:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:24567 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbYGXOKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:10:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1410581fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wU8gT0NFOoTmJnDapD8FPvoSd/Fo6ry9J3/fUUeiM5w=;
        b=n1RnL8N3OyEI7F6kZs1Lawx4OP3p1vCaPIBzvuPvxjz8/2b2KKXfzg9CmXVT7kk80l
         rpkZcZPpt9WsspKCNvdo7oxdocyOVoMvNZFlaxqQbNuKjmUEKI9IqTRP9hfnv8WMgab+
         AoQ2+FpXVaKTmnXaZNRpOVmRw6lzihDmVYWmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ATVsHpYObm1RV/4b6VcfjAkeF3ktSCMEhNzMH+PVYyNu4ZFJjEERwXvO6OfWsBxpyS
         Y68Qd0gRUdh2Kp3H75J5CQYeJP4XqJlsffkEtp0+xQp3Ql5Rerk/2Qz/rmNOF1oPgEg3
         6pglcZ6rnB0vU4PtBcLSSREg4How7AIvMr3io=
Received: by 10.86.50.8 with SMTP id x8mr270473fgx.30.1216908605182;
        Thu, 24 Jul 2008 07:10:05 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id 3sm6536322fge.3.2008.07.24.07.10.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 07:10:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89886>

On Thu, Jul 24, 2008 at 08:06:29AM +0200, Steffen Prohaska wrote:
> 
> I have however a related question:
> 
> Dscho,
> Is the following your use case?
> 
>  "I am the maintainer of this project.  I know that this project needs
>   crlf conversion, because it is a cross-platform project.  Therefore,
>   I want to force crlf conversion for this specific project, even if
>   the user did not configure core.autocrlf=input on Unix."

I suspect that most problems with crlf is caused by Windows users who
have core.autocrlf=false for whatever reason (I suspect without a good
reason in most cases). But perhaps having core.autocrlf=input as default
on Unix and Mac will be better than the current core.autocrlf=false.

> Maybe we could allow 'crlf=guess' in .gitattributes with the following
> documentation:

Please, no. It feels wrong to complicate crlf settings to workaround
incorrect user configuration. I don't think that many people really will
be able to benefit from that. In most cases, people end up with the
incorrect value autocrlf just because the documentation is complicated
and it is difficult to understand from it what autocrlf does.

So I believe the real solution is providing more reasonable defaults
for autocrlf and more clear and simple explanation, i.e. to have
something like in the introduction section describing how to set up
your own repository:

===
If you work on Windows, you are most likely use text files with CRLF
endings. To ensure that your line endings will be correctly represented
on other platforms, you should set core.autocrlf=true.

If you prefer to have LF endings in your text files, you may want to set
core.autocrlf=input to ensure that files with inconsistent end-of-lines
will not enter into your repository.

autocrlf conversion will automatically detect text files and convert
line endings accordingly to the specified settings. In very rare cases,
heuristic may be wrong[*], so you may want to specify what files should
bed considered as text and what as binary explicitly. You can do that by
setting the crlf attribute in .gitattributes, like this:

*.exe -crlf
*.c crlf

The above says that all files with the .exe extension should be treated
as binary and all files with the .c extension should treated as text.

[*] You do not have to worry too much about heuristic being wrong,
because you will be warned if conversion for a file is irreversible.
See core.safecrlf in linkgit:gitattributes[5] for more information.
===

We should not expect every users to read everything written in
gitattributes just to get autocrlf correctly.

Dmitry
