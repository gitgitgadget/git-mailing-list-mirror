From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 06/10] parse-options: never suppress arghelp if LITERAL_ARGHELP
 is set
Date: Fri, 03 Dec 2010 09:53:42 -0800
Message-ID: <4CF92EA6.8060206@gmail.com>
References: <20101201232728.GA31815@burratino> <20101201233136.GG31815@burratino> <4CF8B55F.8020203@gmail.com> <20101203094020.GA11910@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 19:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZwv-0008RM-UF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 19:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab0LCSBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 13:01:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43299 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab0LCSBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 13:01:32 -0500
Received: by yxt3 with SMTP id 3so4428555yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mDxO0dxSntrM5WKzJ+3NSGLJz8WhB9SxMdyaene63ps=;
        b=p+NTtYCJuvyp7nxRoeo8HflKdjFfsRWk3gWz4YMQdhixB5Fcm3pf30f/NyCVG4hnMz
         QXHsjQJ/KF9+Sp8rqpfZOciNqa+gs/rLNeDVeE423MK5TCGoRTt4rj5U8Vd4+82JDoYY
         CGhp82sViZnVV/WCDwtGD+AK0N/UC4GhmRcFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=CmGWnPPeqBtwD2DJRfVgHq7lhqtwyq5cLQTvTvI7SrvISf8CWUUkSGcBJq/2diWDZ2
         GSxFiaD5MJtRqlkfaEoIMYndgS8HLZH+a1be9Y1n61k656ha1Y4O62qqxVAx/JHGxX88
         B0VOC5JXL7R58Rn7AymrEZN5DS4f1jX9wurs0=
Received: by 10.151.105.16 with SMTP id h16mr4351907ybm.75.1291398833029;
        Fri, 03 Dec 2010 09:53:53 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id v39sm642086yba.7.2010.12.03.09.53.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 09:53:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101203094020.GA11910@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162821>

On 12/03/10 01:40, Jonathan Nieder wrote:
> 
> Just to clarify: the NOARG was not meant to affect the usage message
> but the actual accepted usage.  The idea was that
> 
> 	git update-index --cacheinfo=100644 87a8767c87b file.c
> 
> should be rejected, because if it is accepted that would tempt people
> to try
> 
> 	git update-index --cacheinfo=100644 -q 87a8767c87b file.c
> 
> which fails.  That is, the argument to --cacheinfo is not <mode>,
> since --cacheinfo takes _three_ arguments and therefore the sticked
> form sends a wrong message.
> 

Sorry, I don't quite understand why we should reject the sticked form
when we don't advertise its usage anywhere (man pages or usageh). Maybe
I'm just not thinking right since I'm' optimistic people won't do that
-q thing.

But if you really want to do it we don't really need to add a new flag
right? We can just die in the cacheinfo callback if the context's opt
pointer is set. If this ever becomes a common thing we can add the flag
later. Putting a comment like "if only we had PARSE_OPT_NOSTICKED..."
would be fine too.

I'll be fine with or without the flag though.
