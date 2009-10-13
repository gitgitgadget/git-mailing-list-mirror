From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Questions about the new refs/replace mechanism
Date: Tue, 13 Oct 2009 14:33:49 -0700 (PDT)
Message-ID: <m3skdnf08l.fsf_-_@localhost.localdomain>
References: <loom.20091012T115746-719@post.gmane.org>
	<4AD31EBF.6090307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp9H-0004He-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZJMVe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZJMVe2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:34:28 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:57660 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbZJMVe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:34:27 -0400
Received: by fxm27 with SMTP id 27so10750714fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tlDFTNO4P9t+MxFzbRnIFgohxPD4AiN8m0EdEWUqZDI=;
        b=oyTYOv+P23vHcL0THExefpx/0JHy/cMBY9Y8yPfLH9cGPj9+YRDuvrZwHCe/oCsUDp
         MdJGJEwQlIMCvL/V2dpRt5nAh8BAqkMWxJpLbGuvsRjfntCEc2p7ZIOQZaLUKRn3xgYh
         iUtaTZDwfZHCfKJbi2fl1SiDwsPVpSIlujFHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ePYoxbESJiR/HDsLFIvgQskVBWu9oz21tngwB9oGqhN6Rulwq8v4KQxDik1jKnce4A
         HGP4M25fN4tryJmt1BsJhZGuwpo2D0LIRI1Djw3/PaqG+7F0zF5gjhzyFM2wMBYyOfO6
         1kFuDRUeCKpRSXHzeazD00UpPDSCnstwsANmw=
Received: by 10.103.84.6 with SMTP id m6mr3266779mul.26.1255469630356;
        Tue, 13 Oct 2009 14:33:50 -0700 (PDT)
Received: from localhost.localdomain (abvb70.neoplus.adsl.tpnet.pl [83.8.199.70])
        by mx.google.com with ESMTPS id j10sm202404muh.30.2009.10.13.14.33.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 14:33:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9DLXGIO005843;
	Tue, 13 Oct 2009 23:33:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9DLWwH4005838;
	Tue, 13 Oct 2009 23:32:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4AD31EBF.6090307@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130217>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Sergio schrieb:

> > 3) If I remember correctly, there was a reason why grafts were not
> > considered suitable for transferring across repos. Can someone
> > remind me about it? How does the replace mechanism address this
> > issue?
> 
> The problem with grafts was that, for example, git-pack-objects obeyed the
> graft, and could create a broken repository by removing grafted-away
> objects. And since git-fsck also obeyed the graft, it did not notice the
> breakage.

To be more detailed, the problem is that if git-pack-objects, git-fsck
and git-gc obeys grafts, it can create broken repository by removing
grafted away objects.  If git-pack-objects, git-fsck and git-gc
doesn't obey grafts, it can created broken repository (well, broken if
we include grafts) by removing grafted in objects.

> 
> OTOH, history walkers (upload-pack, send-pack, pack-objects) and fsck
> never obey replace entries in the history. But they do keep track of them
> (and the history that they reference) because they are referenced from the
> refs/replace namespace.

In the case of refs/replace git-pack-objects, git-fcsk and git-gc
doesn't "obey" refs/replace... but replaced objects are protected by
pruning by being referenced from refs/replace ref.

One of problems with grafts file was to come up with rule what do do
if both repository you fetch from and the repository you fetch into
have both grafts; in the case of refs/replace the usual rules about
(conflicting) refs apply.

It is also easy to select whether to follow refs/replace or not: you
fetch them into your refs/replace or not; you would have to add extra
option to git-fetch to select whether to fetch and follow grafts in
remote you fetch from.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
