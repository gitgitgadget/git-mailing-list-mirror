From: =?UTF-8?Q?Antonio_Garc=C3=ADa_Dom=C3=ADnguez?= 
	<nyoescape@gmail.com>
Subject: Re: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 20:01:12 +0100
Message-ID: <2b8265361003091101x1e3a3410hc3be2446dc7ddce@mail.gmail.com>
References: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ryan Phillips <ryan@trolocsis.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 20:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np4gC-0002kl-5c
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 20:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab0CITBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 14:01:16 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:63790 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab0CITBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 14:01:14 -0500
Received: by fxm5 with SMTP id 5so1684642fxm.29
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wk8ibZnlzcfgqgm8frpuqC0O38c/KKRImzcUEMFkbm8=;
        b=reaIcIOnlDpL9EzMTvzAgoNegi+1mmj1Fk3i7Me7QHlSWeRDW9dA8sewvZYV936RWC
         bSgVSJi/9mLFB9BFDeJYMFaNQfwjjR7tmBI/EyGsZfdkpVugV0dTcmqL/3+tfOsYh2C+
         e/gilHTlSlOZTxS/cMPvaWKRYTMFlDWWSResE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SJy/9PozeN7a/rDTbbEPLmIrIGo0T7S+SaExaW2eQQZNhAGvEb/oLBZPUQ529DB+iA
         nxn7KQURVrBEw+xr8/YCPxc9hBabiSSnm2NVCE12McfkHPKpjv1o5nl04PtP/PbGzxxV
         axnRBxzq8P0pqI/+f30nwngbZLBKoeRkYNf7M=
Received: by 10.87.66.29 with SMTP id t29mr821194fgk.49.1268161272707; Tue, 09 
	Mar 2010 11:01:12 -0800 (PST)
In-Reply-To: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141840>

Hi Ryan,

> Anybody know what I missed?

I think you need authentication for everything regarding
git-receive-pack, even that GET request. I ran into that issue while
patching Redmine's mod-perl authentication module to handle smart HTTP
[1]. Public projects (which have anonymous pull and authenticated
push) would just not work.

Git first GETs that URL you mention, and then POSTs to the usual
git-receive-pack URL. Both need authentication, but you're only
authenticating the POST. I suggest you authenticate every request to
the git-receive-pack service. Try something like this (warning,
untested!):

>        <LocationMatch "^/git/.*/[^/]*git-receive-pack$">

If anyone else has a better idea, I'd like to know myself :-).

[1]: http://www.redmine.org/issues/4905

Cheers,
Antonio
