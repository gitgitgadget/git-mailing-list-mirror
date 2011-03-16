From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] fix NO_C99_FORMAT on 64-bit systems
Date: Wed, 16 Mar 2011 00:12:44 -0500
Message-ID: <20110316051232.GA1932@elie>
References: <27484.1172021696@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <jason@acm.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 06:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzj2X-0004SR-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060Ab1CPFMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:12:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37082 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1CPFMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:12:51 -0400
Received: by yxs7 with SMTP id 7so519099yxs.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xKxC0zbR1a8vdnAoyGLitHuxCptCr9wdCvJBsTzLeqk=;
        b=wqHbKTXU3LNLC2xjWMhg/GoJTkO2jwqwfV9fF8//wJ8QhQ6uWe7TB47qzaHVjD2hKE
         u5SGNfrZd4kDyH8hL+/VGHYIiuXfG+nsI4JRyaNWlKw+7HsyNUfRrKS0LlPz8E/TJ+5v
         yXPluHmndsvt5OsoZhnLDLhgQPvYlwZ6rdjeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UfD+QkuJ8KAgCbCznIRsi1yxMNk/LAPeHAW91coNJklsXBYJ3qD9gsyX6hbOfTt02/
         avwviwzBMZA5hgq3oeIDzbt5eHlyWl2x5TpK4cK8Guw2CfJRgTkvAOB8CUEf+MWFN0DJ
         DGNY8xwKMSCKQH0OAm4jJmZB3wFq4/BGeNZYY=
Received: by 10.101.144.2 with SMTP id w2mr230281ann.77.1300252370589;
        Tue, 15 Mar 2011 22:12:50 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id x37sm711955ana.8.2011.03.15.22.12.48
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 22:12:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27484.1172021696@lotus.CS.Berkeley.EDU>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169101>

Hi,

Jason Riedy wrote:

> There are no direct
> C99 translations for other uses of NO_C99_FORMAT in git, alas.

So here's an indirect one. :)

The goal of this series is to unbreak "make CC=c89 NO_C99_FORMAT=yeah"
on my amd64 machine.  Side-effects include uglifying mktag a little
and eliminating the NO_C99_FORMAT knob.

Thoughts welcome, as always.

Jonathan Nieder (2):
  mktag: avoid %td in format string
  unbreak and eliminate NO_C99_FORMAT

 Makefile        |   14 --------------
 alloc.c         |   11 ++---------
 builtin/mktag.c |   48 ++++++++++++++++++++++--------------------------
 config.mak.in   |    1 -
 configure.ac    |   24 ------------------------
 sha1_file.c     |    9 ++-------
 6 files changed, 26 insertions(+), 81 deletions(-)
