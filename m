From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 04 Jul 2008 12:47:09 -0400
Message-ID: <486E540D.8000008@gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com> <20080702032155.GA13581@sigill.intra.peff.net> <200807021144.46423.jnareb@gmail.com> <20080703195915.GA18532@sigill.intra.peff.net> <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com> <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 18:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEoSC-0003r0-GW
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 18:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYGDQrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYGDQrO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 12:47:14 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:43953 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYGDQrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 12:47:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so258282and.103
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=i7W3Wp6/zKJF1+DrZt6Y3EKkVyfH5q9yR+4ISFGGXnA=;
        b=SXtTqoGPCh4146axz6F2//xDFrc4YI+xxn8yq7JNtU+FpztA1nEPqdSck4Y/jQL0fQ
         Z+rWwETCseJ/+lHLrPsYxWxF7yX/a/Bfsn/cixXHQOgSGEFYN1j6vaJMb2dQKrsvL1p6
         v0IY7YVmk7JN3u4fe+5vMleW3jMUXeqWogs1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wAqhJJQiEjl1GFPJ9AKx+PbXai4ANQWCLyXodxAHiqKP4kh6OEQzQ/yRgkUT39SBun
         Zk0fizzb2MNkv4Yei1Lq0xTUxNMAokOsAQUCkRdwCvnrA1NpZxSzRb8g6/TPIqB1i8ka
         nJQsD4JBdCes8V5hTX/MsixYFJsDrhSb4G6tc=
Received: by 10.100.41.11 with SMTP id o11mr1085592ano.144.1215190032597;
        Fri, 04 Jul 2008 09:47:12 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 30sm890519yxk.4.2008.07.04.09.47.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 09:47:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87402>

Johannes Schindelin wrote:
> I am not convinced.  This sort of feature belongs into git-bundle.  It 
> certainly does not deserve being blessed by yet-another git-* command, 
> when we are constantly being bashed for having _way_ too many _already_.
>
> Ciao,
> Dscho
>
>   
Actually, I would like to see "normal" interface for git-bundle handled 
by git-push, git-fetch, and git-remote. We fixed the retrieve side to 
use git-fetch before first integration, but didn't understand the 
semantics for creation well-enough to put into git-push. Right now, we 
can do "git remote add bundle-nick <path-to-bundle>" and set up the remote.

We should have "git push bundle-nick"  create the new bundle, updating 
the basis refs kept somewhere in refs/* (possibly refs/remotes, possibly 
refs/bundles?).

However, we need two helpers to maintain the basis refs, both I believe 
should be sub-commands of git-remote:

- a "rewind" function to roll the refs back to a previous state because 
the bundle didn't get applied, whatever. This is well supported by 
reflogs, is "expire anything *newer* than time", and for convenience 
should apply to all refs for the given remote so the user doesn't have 
to invoke per branch on the remote. e.g., "git remote rewind bundle-nick 
3.days.ago".

- a "prune" function to remove any branch for the remote that is not 
known to the local refs/heads/* hierarchy. This is needed to support 
cleaning up pruned topic branches. Could be a special behavior of "git 
remote prune" triggered by the remote being a bundle, but that might be 
confusing a perhaps need a new sub-command name. Perhaps, "git remote 
prune-non-local bundle-nick"

If we did the above, then git-bundle can be relegated to plumbing and 
bundles become better integrated to the porcelain.

Mark
