From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 7 May 2008 15:20:45 +0100
Message-ID: <e2b179460805070720o4028a841t6eabe9c1668a7a9f@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
	 <4821AB32.8090700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Brandon Casey" <casey@nrlssc.navy.mil>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 16:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtkWY-0005bF-Gp
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 16:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbYEGOUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 10:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755734AbYEGOUs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 10:20:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:21734 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbYEGOUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 10:20:46 -0400
Received: by rv-out-0506.google.com with SMTP id l9so388565rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D1rnsx+5WGe0OffrhX/ozw/xFs2BXiOFAPg4g9p/WP8=;
        b=R0HNPNU3neRnA2RJ7vBYuOqTVSou46R3ggdYGG6p1lF5tvQjzC2tyW0I4rbU7CezByPOh9jgBBD1kuqeeTV8YD7StOoW3wAyc7H0h97vJKgCgUyApgV7zVMn4+2RZVJiBwTI9N7i+D0rNIvTqSvhfWAoiVm0b26RrV84IYzYdQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LRBrj41e/A2qZM8MhP9Ks3SWToo3HPlgmaHvkje3DgqcEaPu4ynX8n6EUaunpy3Jg3AAlFY5HtJixl4zljItdHD/Up0dhbJzEShbwojQSxvvFLr3UatoVh3K/DD+wy95h66MHWQ+HdkDMNQYzL28O9bDFnHMqSJoQNR0YUqJ/OE=
Received: by 10.140.163.3 with SMTP id l3mr982925rve.117.1210170045548;
        Wed, 07 May 2008 07:20:45 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Wed, 7 May 2008 07:20:45 -0700 (PDT)
In-Reply-To: <4821AB32.8090700@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81438>

2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
> Mike Ralphson schrieb:
>
> > 2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
>  So you we in the same boat.
>
>  > The warnings are harmless, though untidy.
>  > I don't believe it's anything to do with _LARGE_FILES. Could you try
>  > building first with one commented out, then the other? I don't think I
>  > have access to a 4.3.3 box any more.
>
>  Untidy, yes; harmless: not necessarily. It has a lot to do with _LARGE_FILES.
>
>  The #define fopen in git-compat-util.h essentially defeats the effect of
>  _LARGE_FILES as far as fopen() calls are concerned: If
>  FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
>  fopen64(), but when it is defined, it is redirected to git_fopen(), which
>  in turn uses fopen() instead of fopen64() (due to the #undef in
>  compat/fopen.c).
>
>  This might be dangerous if some other function of the f*64() family uses
>  the FILE* that the fopen() call returned. I don't know if there is such a
>  usage pattern somewhere in git.
>
>  Why did you need _LARGE_FILES in the first place?

Welcome aboard!

I was seeing test failures in t5302-pack-index.sh

Specifically tests 9 and 20
#   9: index v2: force some 64-bit offsets with pack-objects
#   20: create a stealth corruption in a delta base reference

These tests seem to be skipped these days if off_t isn't large enough,
I preferred the passing tests to the skipped ones. Maybe it isn't an
issue in the real world.

Mike
