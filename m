From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run,
 rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Fri, 3 Sep 2010 18:32:52 -0500
Message-ID: <20100903233252.GD30310@burratino>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
 <20100903182323.GA17152@pengutronix.de>
 <20100903184351.GC2341@burratino>
 <201009040058.18028.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bug-patch@gnu.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 01:34:47 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1OrfmQ-00086F-0L
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 01:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab0ICXeo (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 19:34:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53043 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0ICXeo (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 19:34:44 -0400
Received: by qwh6 with SMTP id 6so2298786qwh.19
        for <multiple recipients>; Fri, 03 Sep 2010 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DSr63Qy/1F0uZVw0ruhxpcV2dR2Y20Ga5NVi2x/s2vQ=;
        b=SdVTx4dKh/U/k5STS+Rjps2m9oD3RWty4eVGskSqFduHXHXo5GeBoZRxv3rBBQxWnm
         9NS2/AvUtgm6GwKNi0UG4dgZJmpccJl0F6CqnPP6k3v2oHQmT8JiNOX9PirluCpnLxV2
         A1UN08EqHDs0u9Vh8bAmo+pZ1FaiIPmLgm084=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KfHf58rHpRTp+yMqyfWp6KJnFH2rgwhkUQhVNu0cXBoZutwlnVikQ/lGQs5wXHYmvx
         2hhktnwf2RBfzmLZE+9kMWA83UxTBOXgKQVlBjIao6ozevoG1GFt19ONmDnno4DVpba7
         dAuHcZ9ZlAsRsN7Ty2i/piHneeJtg8Y3Sq0oY=
Received: by 10.229.224.148 with SMTP id io20mr1366240qcb.88.1283556882562;
        Fri, 03 Sep 2010 16:34:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q8sm2572864qcs.24.2010.09.03.16.34.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 16:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201009040058.18028.agruen@suse.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155287>

Andreas Gruenbacher wrote:

> something pretty bizarre is going on here.  The wget output modifies the same 
> file twice, but both patches to this file have the same source sha1 (5645f35):

>From the git v1.6.0-rc0~92 changelog entry:

    apply: fix copy/rename breakage
    
    7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught "git-apply" to
    grok a (non-git) patch that is a concatenation of separate patches that
    touch the same file number of times, by recording the postimage of patch
    application of previous round and using it as the preimage for later
    rounds.
    
    This "incremental" mode of patch application fundamentally contradicts
    with the way git rename/copy patches are designed.  When a git patch talks
    about a file A getting modified, and a new file B created out of A, like
    this:
    
        diff --git a/A b/A
        --- a/A
        +++ b/A
        ... change text here ...
        diff --git a/A b/B
        copy from A
        copy to B
        --- a/A
        +++ b/B
        ... change text here ...
    
    the second change to produce B does not depend on what is done to A with
    the first change in any way.  This is explicitly done so for reviewability
    of individual patches.
    
    With this commit, we do not look at 'fn_table' that records the postimage
    of previous round when applying a patch to produce a new file out of an
    existing file.

> How was this patch generated: with git itself?

Yes, the patch basically agrees with what I get by applying it and running

 git format-patch -M -B HEAD^..HEAD
