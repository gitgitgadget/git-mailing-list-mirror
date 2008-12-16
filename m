From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: git filter-branch and superproject
Date: Tue, 16 Dec 2008 15:01:00 +0200
Message-ID: <4947A68C.1010503@panasas.com>
References: <loom.20081216T114923-354@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 14:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCZZJ-0007M0-1Q
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 14:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbYLPNBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 08:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbYLPNBI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 08:01:08 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:58858 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbYLPNBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 08:01:06 -0500
Received: by ewy10 with SMTP id 10so3643491ewy.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Myh6gRs2Zqcnij/V5Vpf6mUq2wfZYMPkwP+5KSOuun4=;
        b=fSJ5vthpLUXmqJY+c17bys0bwbxaEaJ5AuQHSp6/lqDp7P1DlSUVS/9ixXM1yPxejr
         xo/TKSnQYSCERVqb3J4vL2k63YJ6FIVl9s/p9POYH7McuJP5xmids//CI7M+/cSZScnv
         907l0JpO6DG82DG9hsXDjYOvyxPfuNLoT34mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kfm9Dadwk82Vz8Py9//gKQOXcIKlO2fXKnpJ1M1NcnTmyC8vsYVhSRhFd3HESHXRjY
         3LkdJ5M3MTZ4+pmDIMO4rbgKff+2rFhwaxVMkqEFSIrLw55ixUstGtsClg5I3kww6flw
         bOHJrnz5QREckzHt/48hQz5CAsy8m5BjPfQS0=
Received: by 10.210.87.19 with SMTP id k19mr5909550ebb.51.1229432464969;
        Tue, 16 Dec 2008 05:01:04 -0800 (PST)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 3sm1297606eyj.55.2008.12.16.05.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 05:01:04 -0800 (PST)
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <loom.20081216T114923-354@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103279>

Sergio Callegari wrote:
> Hi,
> 
> once a sub-project has been rewritten by filter branch, there is a problem with
> references in superproject.
> 
> This is obviously a case where something "has been published" so filter-branch
> is not a good idea.  However, super-projects are a very special case of
> publication since they might be "in full control" of whom did the rewriting of
> their submodules.
> 
> Is there a way to filter branch the superproject so that whatever commit is
> referenced that is in refs/original/something in the subproject gets updated to
> the corresponding rewritten commit (or an error is given if such a
> correspondance does not exist)?
> 
> Namely, can filter-branch on the subproject deliver a "commit conversion table"
> that can then be fed to a filter-branch in a superproject?  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

If I recall correctly, submodule was recently enabled to reference
a soft label, like a branch name, instead of an hard UID. Look it up
in the newest git.

But your post brings up another concern. The HEAD referenced by the
superproject does not have any hold in the subproject. So if the
subproject under-gone a git-gc the reference UID might disappear, as
in your case. I wish the git-submodule command would create a TAG or BRANCH
in the subproject of all referenced HEADs, so they will not disappear
in future maintenance of the subproject tree. (And it could be very
informative when viewing in gitweb). The subproject TAG name could, for
example, be the commit and date of the superproject's submodule commit.

Boaz
