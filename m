From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: fix nasty bug in ask() function
Date: Sat, 4 Apr 2009 23:31:42 -0400
Message-ID: <76718490904042031o5009a684xcf10aaff163e657@mail.gmail.com>
References: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
	 <1238901801-47109-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bruce Stephens <bruce.stephens@isode.com>,
	Dan McGee <dpmcgee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 05:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJ6k-00036I-Cp
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbZDEDbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbZDEDbq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:31:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:43495 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850AbZDEDbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:31:45 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1625262yxl.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oasdIE4M4YhbiI+1l73Tlo1t8ImscbDg8ClyWmsNJAs=;
        b=IH+grxQM1pX5noAR4eQEeTL/vXOT44aeZhjr1DGRUAVqYFYiNK8vv3BCl9XbfZKkai
         705fLjb9DnWOqG+bQuwNb1FaqG66FwlRxVZ1GppGVHAMiKBSFgES7kigS92LqBHpzuVA
         c1jYYOKhx2pzKLCczMQHa3IqqQ5ggidGav32A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GvmxG1dGLuJOkiSvFnQWB8RyCOXZqFQMkS0zPacDCoQFUSBPMosCTiNo7Q4r28Bruj
         Uubhjv3HxJqj8wtqP7scY8FljQQ+x22iUdaBBO+xLSmL7vz+uxhrHj1FWk3Nt3+2UMd0
         T9m4kqsH7iXDDynwxsPaLDA41Ab3+MFnT67s8=
Received: by 10.151.156.6 with SMTP id i6mr1714690ybo.200.1238902302862; Sat, 
	04 Apr 2009 20:31:42 -0700 (PDT)
In-Reply-To: <1238901801-47109-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115626>

> I'm also super confused why the issue is occuring. You can see from the
> patch below that by default the ask() function attempted to match the
> user's input against the empty regex //, which should match anything:
>
> $ perl -e 'use strict; my $resp="something"; my $re=""; print "true\n" if $resp =~ /$re/'
> true
> $ perl -e 'use strict; my $resp=""; my $re=""; print "true\n" if $resp =~ /$re/'
> true
>
> Any yet while my demonstration above works as I expect, for some reason
> what is basically the same code (AFAICT) in send-email does not match. I
> thought I knew my perl fairly well, but maybe some perl guru can see
> what's going wrong.

Ah, found it in perlreref:

   If 'pattern' is an empty string, the last successfully matched
   regex is used.

Grumble.

j.
