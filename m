From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git mergetool broken when rerere active
Date: Thu, 6 Jan 2011 07:47:28 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101060634480.26654@debian>
References: <alpine.DEB.1.10.1101052119530.26654@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 13:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PapFz-0007gG-Ae
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 13:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab1AFMre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 07:47:34 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41079 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1AFMrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 07:47:33 -0500
Received: by qyj19 with SMTP id 19so19301035qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=77RvgbUemUCzBK3EF2z+h6KypO4njM9W4V18A0zLkrI=;
        b=n0Nt03Z83NN0Z4b/igf/ua5Q5xbGsSkEdp+dGvOzudKrjNQ+jq059sGL+F1bWy+a1I
         7h7i90h0h9rpswcuH82jLgPQQJrhsIy5u+55Ig27mVkMjLz+cDQdp5pr03pU5Zp+6WpR
         XK0iDHZHNtkgrubiOY+vdxj4J3FZDjxGhY/O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=JJQPixu4Po3y31dp0JlJr//BgKCCtwPdrY4jzolvXa6s2W7M4X5TPUGsbiaiUHikYO
         au1G9DDPnBNVWSdJNnhq3zsmUjKDyG3c3eS6fBl9xpCy0QaNVuvtvROvvOTY0pJvEtee
         LMhHgygN0fDAdWjiTgRpntIeY/gCONXeHG/Ew=
Received: by 10.224.80.138 with SMTP id t10mr9555679qak.389.1294318052291;
        Thu, 06 Jan 2011 04:47:32 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm14335923qck.36.2011.01.06.04.47.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 04:47:30 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.1.10.1101052119530.26654@debian>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164630>

On Wed, 5 Jan 2011, Martin von Zweigbergk wrote:

>  (2) When running mergetool again after resolving some (or all)
>      conflicts, so that some of the files have already been added to
>      the index, mergetool will now print something like
> 
>      file1: file does not need merging
>      Continue merging other unresolved paths (y/n) ?
> 

The same problem should arise even the first time mergetool if run if
rerere autoupdate is active and has added some files to the index.

> I would like to have both the original properties in (1) and (2) back,
> i.e. being ready for commit once 'git mergetool' has been successfully
> completed, and having it ignore any files that have already been added
> to the index.

Well, if rerere.autoupdate is disabled, any files resolved by rerere
should not be touched by 'git mergetool' (this was the original
request that lead to the change), but they would not be added to the
index, so we would not be ready for commit. I take that part of my
request back. I guess it would be ok (or even necessary) if, after
resolving all the conflicts reported by 'git mergetool', the user
would still have to explicitly add any files resolved by rerere and
thus ignored by 'git mergetool'.

So I guess what I'm saying here, is that I think only the problem with
'delete/modify' conflicts should be fixed regarding issue (1).
