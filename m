From: "Eric Raible" <raible@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 13:35:10 -0700
Message-ID: <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	 <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	 <20080611213648.GA13362@glandium.org>
	 <alpine.DEB.1.00.0806112242370.1783@racer>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	 <loom.20080612T042942-698@post.gmane.org>
	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	 <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:36:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tWg-0005cE-98
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbYFLUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYFLUfM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:35:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:47723 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYFLUfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:35:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3771074wfd.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ksLnARVVCQlmkes8CxjDY8ROW8CO2Th2oI+kAYWeXuU=;
        b=xefPBqKOSNW7UmY+WoSvz/H5rqPgYx3gPXjuYtpfRqchHsL1E+P2B5aA2l/sx2hVUX
         VHEwQl1gMyV4Ueo09mrHBNC9/R9inZr5SO/u+llV7UgzIMPMDibyEcCyT5iXX5PrcJpD
         0e3WaAGh6ZSB1fIM42tU6l4AEyZRaWXF14TY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tZLsS8glMMTh6KfQyqwI7DvOFY++z0/YMfdyQEjAYO74+BIX+4L85v1CVvBsd1UOQK
         gK6Ow3bOzYdBFtVkKd08BsFUXJTO2FhDu0QEjLyjmPSKr/Yy+62yL+mcSV3IZD/s/XeI
         tpXdZDevMTv6uA4taXquIJleakiwJ2ynBevjM=
Received: by 10.142.230.11 with SMTP id c11mr699545wfh.334.1213302910056;
        Thu, 12 Jun 2008 13:35:10 -0700 (PDT)
Received: by 10.142.180.10 with HTTP; Thu, 12 Jun 2008 13:35:10 -0700 (PDT)
In-Reply-To: <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84788>

On Thu, Jun 12, 2008 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wincent Colaiuta <win@wincent.com> writes:
>
>> So yes, branches _are_ better and more appropriate for long term
>> storage than stashes, but even so I don't think it's right for us to
>> risk throwing away information that the user explicitly stashed and
>> expected Git to look after for them.
>
> Yes, but for a limited amount of time.
>

A limited amount of time?  Why is that?  Can you give a rationale which
at least addresses Wincent's points?

It's bad enough that 'git stash clear' drops all pending stashes w/out
at least echoing them (the way git stash drop does), but what is the
rationale for having git _ever_ forget information which it was specifically
requested to remember?

I know that stash is implemented in terms of reflogs, but that seems
to me an implementation detail which ought not leak out.  Especially
if that leakage ends up forgetting potentially important data.

- Eric
