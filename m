From: Ali Gholami Rudi <ali@rudi.ir>
Subject: Re: [PATCH] builtin-clone.c: fix memory leak in cmd_clone()
Date: Wed, 1 Apr 2009 20:42:54 +0430
Message-ID: <20090401161254.GD2237@lilem.mirepesht>
References: <20090401144056.GC2237@lilem.mirepesht> <alpine.DEB.1.00.0904011754250.13502@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp35W-0004b0-4T
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764715AbZDAQNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764152AbZDAQNF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:13:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:34281 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764732AbZDAQNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:13:00 -0400
Received: by fg-out-1718.google.com with SMTP id e12so216141fga.17
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=x5INhSs8WqZNAPOFJ0gjJe1h8UyLSKqHAfmxvGjVri8=;
        b=Atg+clt+n5SsqDisaeNF+s7vzPkT5P0ZYD+izutRueSasBmnb1AcqlgmjPg8ffLZRr
         YxKGLmI2/BwKhhswtWcCg7oMHYtn0lQCz5gWNGKxI7bwdSCdDrfYTTTn58IY2imeMa3U
         pQolk/vxP8icd6RNAsXN5RL+a08JhTRcM+/Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mvmlkLWFY+8zGujFccOiLSgdT9gAzUKhmJDJa0x8oZVF+ppfuceA6jyOLYK3rfaFeY
         xLGw/mBUp/G+NKHWg14uFPtMmvFbWydgWSTp44RoCYLGlC8COJqpgnFs4idz60CuyS4O
         zndevm9B9pL4S6Ss5aw/4+RIHPnJkBjeSnpBE=
Received: by 10.86.95.20 with SMTP id s20mr6388516fgb.4.1238602377579;
        Wed, 01 Apr 2009 09:12:57 -0700 (PDT)
Received: from localhost ([85.185.70.254])
        by mx.google.com with ESMTPS id l12sm1792922fgb.21.2009.04.01.09.12.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 09:12:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904011754250.13502@intel-tinevez-2-302>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115397>

Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 1 Apr 2009, Ali Gholami Rudi wrote:
> 
> > With this patch, cmd_clone() safely frees its xstrdup()-allocated
> > memory.  Also junk_work_tree and junk_git_dir (used in remove_junk()
> > which is called asynchronously) were changed to use static arrays rather
> > than sharing the memory allocated in cmd_clone().
> 
> If you want to go down that route, you will have a long way to go: the 
> assumption is pretty much in every cmd_() and main() function that 
> singletons will be free()d automatically when the process ends.

Well... I saw strbuf_release() calls in the end of cmd_clone() and had a
quick look at a few other cmd_*() functions; it seems most of them (?)
try to free their memory.  I thought it might make sense to do that for
cmd_clone().  But you're right; they will be freed eventually.  (It
seems like a minor leak which is respected only some of the times :-) )

Regards,
Ali
