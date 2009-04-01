From: Ali Gholami Rudi <ali@rudi.ir>
Subject: Re: [PATCH] builtin-clone.c: fix memory leak in cmd_clone()
Date: Thu, 2 Apr 2009 00:47:04 +0430
Message-ID: <20090401201704.GA2237@lilem.mirepesht>
References: <20090401144056.GC2237@lilem.mirepesht> <alpine.DEB.1.00.0904011754250.13502@intel-tinevez-2-302> <20090401161254.GD2237@lilem.mirepesht> <7v3acs1gyf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp6tr-00020G-9A
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 22:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763014AbZDAURU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759719AbZDAURS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 16:17:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45100 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757714AbZDAURR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 16:17:17 -0400
Received: by fxm2 with SMTP id 2so212472fxm.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=CaREFwFHatFA+a3009+GufzE+OmrCD0T30gMHFmh1jQ=;
        b=EcxZ8vbFAi0ERgobYMqGgtue3gzt0zRE4xIqdrrMAsP8XSLtbDyL75E/aLlNVDaOvW
         SG4fzgM4oAUDDcVzBW/Xu27mWkai44+fQUvHIQTalYM6FUe6PT6wAaqHMiOiOU7yE4Fo
         PTO6UTokFUtI1pB80RN5sYJRxkzhg+m1XzAkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AtW2Yrpoh/QIKD8HQNu0mOf5/ikekTZrNMcP63fnBoUzIggDPPvMdFRUeeywvvK/vf
         D/CU9gaPrBZRIpLBGYxz+ePIcFUvscZuyTxYytuXCr8//GTW/GyuC0Rqc89GAJbhddLN
         X+1zzjLlIdsXvZKMILQdqDv0QiGonRGHIS3J0=
Received: by 10.86.36.17 with SMTP id j17mr1005699fgj.27.1238617034556;
        Wed, 01 Apr 2009 13:17:14 -0700 (PDT)
Received: from localhost ([85.185.70.156])
        by mx.google.com with ESMTPS id 12sm7172287fgg.17.2009.04.01.13.17.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 13:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v3acs1gyf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115412>

Hi,

Junio C Hamano <gitster@pobox.com> wrote:
> Yup, I'll queue (I won't have time today to work on git it seems) the

Thanks.

> other two patches from you, but I was going to drop this one---unless your
> plan was to make cmd_clone() callable more than once in order to use it in
> say a C rewrite of git submodule or something like that.

The only problem in builtin-clone.c seems to be remove_junk() which is
called from a signal handler or atexit().  cmd_clone() can be changed to
register this function only once.

remove_junk() uses junk_* global variables which are overwritten in each
cmd_clone() call.  Since no concurrent cmd_clone() is allowed (?) and we
only care about the last one, this does not seem to be an issue.

I'll probably send a new patch tomorrow.

Regards,
Ali
