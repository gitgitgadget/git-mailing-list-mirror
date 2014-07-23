From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebase flattens history when it shouldn't?
Date: Wed, 23 Jul 2014 10:52:18 -0700
Message-ID: <20140723175218.GB12427@google.com>
References: <87k374xkpq.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:52:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA0iH-0007p1-M7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbaGWRwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:52:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47725 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaGWRwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:52:21 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so2194906pad.9
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=agU7zD2Qgdz3Wx+L2rny2YtzFLVmsOf2IH0XwjAbudY=;
        b=vouAWeSdWxIw87E7TXQjlOK+bR7QJfFQTuZvpqaTcBGcoo6q04K8ZbvQKvZBhNLFtv
         6y8mga8QE0m+4ybHX3DCCVsHhhHtwU/4uoz/cV2lzafd28nxQHYjx31vsM5S8JgT1bv1
         xXDSrhRUaEIjR/PyhAfoqnaowe1/X1ERk6v3q2ThcKnCh8mWkx2KdUcWR7H8j7BwU1wQ
         +QJmbD5q4gFrA7ODlJAZTm4WYXFsAtE4n3/6EWb6lj0+tHGsYnUgMB4kC24hAat6s2kl
         cU1sntRrdsAAH9Yr9UIe72UIvhtZJK9smsFt5GB+pr3wwSiwboSP3SnB/dZSIGKq2eHJ
         X2SQ==
X-Received: by 10.66.65.193 with SMTP id z1mr4008111pas.9.1406137941167;
        Wed, 23 Jul 2014 10:52:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:44e7:c0c7:2154:3495])
        by mx.google.com with ESMTPSA id fj2sm3980833pdb.66.2014.07.23.10.52.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 10:52:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k374xkpq.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254097>

Hi Sergei,

Sergei Organov wrote:

>      --C--
>     /     \
>    /   ----M topic,HEAD
>   /   /
>  A---B master
>
> shouldn't
>
> $ git rebase master
>
> be a no-op here?
[...]
> I'd expect --force-rebase to be required for this to happen:
>
> -f, --force-rebase
>     Force the rebase even if the current branch is a descendant of the
>     commit you are rebasing onto. Normally non-interactive rebase will
>     exit with the message "Current branch is up to date" in such a
>     situation.
[...]
> Do you think it's worth fixing?

Thanks for a clear report.

After a successful 'git rebase master', the current branch is always a
linear string of patches on top of 'master'.  The "already up to date"
behavior when -f is not passed is in a certain sense an optimization
--- it is about git noticing that 'git rebase' wouldn't have anything
to do (except for touching timestamps) and therefore doing nothing.

So I don't think requiring -f for this case would be an improvement.

I do agree that the documentation is misleading.  Any ideas for
wording that could make it clearer?

Hope that helps,
Jonathan
