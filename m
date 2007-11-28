From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Thu, 29 Nov 2007 00:10:58 +0700
Message-ID: <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
References: <20071128165837.GA5903@laptop>
	 <Pine.LNX.4.64.0711281703470.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQRW-0005sc-2h
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759675AbXK1RLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759536AbXK1RLB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:11:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:58906 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759269AbXK1RLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:11:00 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1472965nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w0OfMs1/yV+Z7s9ncPBqiRLgN6wubLxhVGYb8BqmRWU=;
        b=TlIZfskYFpHyBY0jGElmRM5Y1YdkWl5FAJuHItUXBu0h7kj0hbaXUQYJ4EPEc4NRr/I6f4y2tZM/4ukQyE3MXtf20X8MdOHkMlKdSpArq7Sx08WRPGk2pqEk25CXtdSBCxn5lVMQmozhPm8RPM//Ga/X5z2vRURZSCGLhM5tXiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jh3ZKfzgdgcpA01bNQ3p1K3ePqUHvuGVZ1Gjk6e/fLAbpLAgLp0aN1rVv/+hdefjE+/ZqfdVFlYQPq/yKjyAIvw/cjKnvUFy9r4+5fIaUUd9B3Kik54Gf27HC2+N5tZ+JxO2AJZEWOBzqsxvKA79KGmHv4V07Q6WGhnv2GfggU0=
Received: by 10.86.79.19 with SMTP id c19mr5161953fgb.1196269858683;
        Wed, 28 Nov 2007 09:10:58 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 09:10:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711281703470.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66388>

On Nov 29, 2007 12:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 28 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
> > @@ -246,8 +246,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >                       static char buffer[1024 + 1];
> >                       const char *retval;
> >
> > -                     if (!work_tree_env)
> > -                             return set_work_tree(gitdirenv);
> > +                     if (!work_tree_env) {
> > +                             retval = set_work_tree(gitdirenv);
> > +                             /* config may override worktree */
> > +                             check_repository_format();
> > +                             return retval;
> > +                     }
> > +                     check_repository_format();
>
> Why not move this check before the if?  Other than that, ACK.

If so it would be called twice if work_tree_env is not set.

> Ciao,
> Dscho
>



-- 
Duy
