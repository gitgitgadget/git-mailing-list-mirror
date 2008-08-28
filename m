From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Relative submodule URLs vs. clone URL DWIMming
Date: Thu, 28 Aug 2008 10:50:49 -0400
Message-ID: <48B6BB49.3000703@gmail.com>
References: <200808271400.54302.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYir1-0008Ie-LG
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYH1OvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYH1OvB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:51:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:3831 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYH1OvA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:51:00 -0400
Received: by wr-out-0506.google.com with SMTP id 69so336035wri.5
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PUAZ3a68Zei886/ky0DE86DPVoO1oe5V6OuaAk8wRKs=;
        b=Tjdw7mx6Yk5pPrhVW3TYepvOhnYf43NduDeTJQyGndnM73pHhELE1RxgQvqWDx7ORM
         HwY6r9smAziOamiKWpaY95wNGfGrwOwwXDS4U29uHGkZ4/XqgsxuaWrhUGm/Ap0QWuxq
         hLImuRAaLHOU2YwAGMWQrELdYXXNxB3oZgVKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xIGuBkuOr5Srxg1ow+Dg7q6lrvlDgSxyHo+eMIvW3fcm+YLscCZxvIsqhQgpl6MDBC
         FATxpXRflDmMu/7AzybWco0QWlgxCRseIfmUX0tpEI+s9T0vRbjTdIZwE1AyO2cTEmCf
         rzo4Aq5aV65RcZkXIQ07LXWzTxLO7wlTZoias=
Received: by 10.90.66.14 with SMTP id o14mr1758803aga.38.1219935059270;
        Thu, 28 Aug 2008 07:50:59 -0700 (PDT)
Received: from ?192.168.1.117? ( [96.231.30.188])
        by mx.google.com with ESMTPS id 36sm1139502aga.10.2008.08.28.07.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 07:50:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200808271400.54302.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94064>

Johan Herland wrote:
>
> I'd like to fix this, but I'm not sure whether the fix belongs in 
> builtin-clone.c (i.e. making sure the origin URL is always "correct" 
> wrt. resolving relative submodule URLs), or in git-submodule.sh (i.e. 
> adding smarts when resolving relative submodule URLs against the 
> super-repo's origin URL).
>
>
> ...Johan
>
>   
I think the right approach is to start with clone and make it record the 
real url it is using, regardless of what was input. The problem with 
doing this in submodule is that in effect this replicates the search 
logic clone would use, and furthermore could lead to nasty surprises by 
grabbing the wrong submodule in an extreme case of having two 
identically named repositories in different locations on a server.

I was about to create a patch for submodule to always remove trailing 
"/.git" before resolving, but in fact a user could put the submodule 
.git into the superproject's .git, in a non-bare repository, and then 
gitlink that in the checked out submodule. So, it may also be good to 
define and enforce rules on how relative url naming can be used for this 
purpose. So far, I have only used it for bare repositories using the 
"../<path> form keeping the submodules out of the superproject.


Mark
