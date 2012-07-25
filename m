From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] The Makefile.PL will now find .pm files itself.
Date: Wed, 25 Jul 2012 16:11:44 -0500
Message-ID: <20120725211143.GA5455@burratino>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <1343186471-1024-4-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8sB-0003rr-Do
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab2GYVLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:11:54 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57285 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2GYVLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:11:53 -0400
Received: by gglu4 with SMTP id u4so1230110ggl.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=56xdoYJa1aPjSYrPcrFS8wVshi1oUxSyKd56/wvPTQQ=;
        b=O4fRxb3QIGjEICRvzp58rylY/Qnylr+i/fg6+LKPDI9UFruDTovCCovf7TyK2FAW9R
         mCOtYhZIeKETI4kgGr7SbTXq0FpBM2MCfpzVUdTucdoGmKFvlE3DI94rwKvaN2IDNpo5
         sd88iuoWKRZ7ad+3xufYztHukSgfbIplJU08ylVJdrJhNQ3rDKZwzcDAK6d8EJ+0OsKt
         JMNo5nH0caHii1d2oI9eXpmT9riY+nN2EAgCaO8pUW66uyS0cKd03gCkNfO5sQoBChKm
         WrsVWanBn+Z17Bqbo0xx2VTX3MsJSLmF2PvtoyQGThFDwOHsRP4xiqnQpPNrhdqulpEZ
         N+gQ==
Received: by 10.236.144.165 with SMTP id n25mr25418739yhj.61.1343250713232;
        Wed, 25 Jul 2012 14:11:53 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y66sm38421801yhi.10.2012.07.25.14.11.51
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 14:11:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343186471-1024-4-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202197>

Hi,

Michael G. Schwern wrote:

> It is no longer necessary to manually add new .pm files to the
> Makefile.PL.  This makes it easier to add modules.

Thanks!  Sorry I missed this.

[...]
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -2,6 +2,10 @@ use strict;
>  use warnings;
>  use ExtUtils::MakeMaker;
>  use Getopt::Long;
> +use File::Find;
> +
> +# Don't forget to update the perl/Makefile, too.
> +# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease

In a previous apartment I lived in, there was a note taped to the
lightswitch reminding us to turn off the heat, take keys with us, and
lock the door.  The note was useful because by force of habit we would
be turning off the light, and as a result see the note, on the way
out.

Who are these comments in perl/Makefile.PL addressed to?  Why would
such a person be looking at perl/Makefile.PL?  Sorry to sound like a
broken record, but I don't think these questions were answered yet.

How about this patch for squashing in, which would avoid the question
and save me from having to worry that my words are going to stay in
this file after the no-makemaker option no longer exists because
nobody looks at them here?

diff --git i/perl/Makefile.PL w/perl/Makefile.PL
index 3d88a6b9..377fd042 100644
--- i/perl/Makefile.PL
+++ w/perl/Makefile.PL
@@ -4,9 +4,6 @@ use ExtUtils::MakeMaker;
 use Getopt::Long;
 use File::Find;
 
-# Don't forget to update the perl/Makefile, too.
-# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
-
 # Sanity: die at first unknown option
 Getopt::Long::Configure qw/ pass_through /;
 
