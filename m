From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Wed, 07 Oct 2009 11:55:19 -0700
Message-ID: <4ACCE417.5080907@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <4ACC6055.1070204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 07 20:59:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvbjQ-0000yA-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759715AbZJGSxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758079AbZJGSxu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 14:53:50 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:59762 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZJGSxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 14:53:49 -0400
Received: by fxm27 with SMTP id 27so4908931fxm.17
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=a5/+89ppC0ogQgTzLz5P2rVtUbc7kTuXF4RI05daxws=;
        b=UYS8t4q65r42nlG+yzy9Oz+Hk8iHjUnlmQLVPKH1iwHGAOMoc7sYDa73HEHADhGH+L
         yZJxN2BnB19OHaoflSvz5DHk8GEZGpBxIh3Vk+Vhf4YcDgsE+djQkMaJrlpZCpMQxOFn
         wBWWLL+uVtFG2gVSW31hjaAz+2wcLzNyMT9kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=SKGSh9s/WUeAGgkipbuucVxm0UbwSkVB5zpKqUyvqCXPk/P5ukzOYAQT0V6rXGD6jy
         dLABVKIcmeAtbCj0Xi6xBsQnTn9IS1Sp1sYYNJ8HouyfPmxhHRCaCMsXbXKsH5pq9Urq
         RxBSIHgg42JMcYWn1OaI2yIw6Cw6SF2dxMVEg=
Received: by 10.86.231.13 with SMTP id d13mr281352fgh.41.1254941591903;
        Wed, 07 Oct 2009 11:53:11 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id l12sm177996fgb.16.2009.10.07.11.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:53:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <4ACC6055.1070204@viscovery.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129651>

Johannes Sixt wrote:
> Is it necessary to change the body of the loop? Your version spawns two
> processes on each iteration, while the original spawned no processes.
>
> You can avoid the pipeline (i.e. yet another process) using a "here-string":
>
> 	local i aliases=$(git --git-dir="$(__gitdir)" config -z \
> 				--get-regexp "alias\..*" 2>/dev/null)
> 	while IFS= read -rd '' i; do
> 		i="${i#alias.}"
> 		echo "${i/ */}"	# could be: echo "${i%% *}"
>   	done <<< "$aliases"
>
> but I don't know how well bash handles variable values with embedded NULs.

I can't get the above snippet to work, but maybe I'm doing something wrong.

I had a problem with the newline between the key and the value. bash
gives me the whole line in the loop, but when I try to trim it $i is
treated as two values. I couldn't figure out any other way to do it,
besides piping $i to cut or tr.

Maybe a better solution would be to add --keys-only or something to
git-config?
