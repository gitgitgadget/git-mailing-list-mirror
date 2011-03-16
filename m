From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/6] silence -Wuninitialized warnings that previously
 used the a = a trick
Date: Wed, 16 Mar 2011 06:35:40 -0500
Message-ID: <20110316113540.GB15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp15-0000rZ-KF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1CPLfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:35:47 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38963 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1CPLfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:35:45 -0400
Received: by yia27 with SMTP id 27so612422yia.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pCQVMZyTAFPfD+aNLK7ycNja2H0jDtE4P7nlsUcxGXA=;
        b=Dy1vt9BLv+V4wkEVbIQ4R13/1ywF8e1aPf3+KTHT/Uv60Q3H335yM6m9ZNqjxKqCCv
         t/NmkrM6W2p636RKYo+F3hPgxjETRgdUwD7Y2+tH+szcf6eae7DW05oWAqFWc4hNY4nR
         D3hpWJ2Yb3WioQHQx1hFHIDsChw/kiqZN9ViI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cMqrvfO+o5tLnVyTMhXUyDQOB89KirifUFEDIIVx9PIL0yaHBHVcZJ/XaB7dcYGnfL
         W49hdj8qlpwIlrMQX7L4kGBW8A6Zf5ShpT1IzDsbBP3FWOMBdj/iRVjS94I/EfRoPp5L
         d+SzWYAlaca68jfyMZGAkgu8x/RJHKW0Ip4HQ=
Received: by 10.100.32.3 with SMTP id f3mr480240anf.40.1300275345146;
        Wed, 16 Mar 2011 04:35:45 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id u13sm1133959ank.23.2011.03.16.04.35.43
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316105709.GC8277@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169141>

Jonathan Nieder wrote:

> Right.  Below is a patch to play with which gets rid of the
> 'expire = expire' style suppressions.

And here are patches on top to squash the remaining "may be used
uninitialized" warnings (from gcc-4.6 -O2) that they were meant to
address.

The change descriptions are placeholders.  In an ideal world, someone
interested might pick these up and rebase against master
to skip the relevant parts of the above patch altogether.

Jonathan Nieder (6):
  match-trees: kill off remaining -Wuninitialized warning
  run-command: initialize failed_errno to 0
  diff --submodule: suppress -Wuninitialized warning by initializing to
    NULL
  rsync transport: clarify insert_packed_refs
  wt-status: protect against invalid change_type
  fast-import: suppress -Wuninitialized warning by initializing to NULL

 fast-import.c |    2 +-
 match-trees.c |    7 +++++--
 run-command.c |    2 +-
 submodule.c   |    2 +-
 transport.c   |   35 +++++++++++++++++++----------------
 wt-status.c   |    2 ++
 6 files changed, 29 insertions(+), 21 deletions(-)
