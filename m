From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/2] git-submodule: replace duplicated code with a module_list
 function
Date: Fri, 22 Aug 2008 20:01:02 -0400
Message-ID: <48AF533E.9020102@gmail.com>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com> <7vpro064qz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWgaG-0001hY-FP
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbYHWABH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYHWABH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:01:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:32341 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbYHWABG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:01:06 -0400
Received: by wr-out-0506.google.com with SMTP id 69so609371wri.5
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DoFrgm9gUGO2I2utlzfbzcHzXQ5RhIXL3voLP46bZA0=;
        b=JSSq2Z+JsmJRhFl+WxeAxidZpD77XP6g/BwaSz+b9tRYxV1+9xl3tP/jetcdiHDLAR
         I03AZ7JV89EMzC8Y+Pe3J3hBLiOHAAEfi62mU64DQuiV3dDRRySrNWxYAU/1eIc9o28n
         LbnlvukuvbHC55CZPSdlvtWXWe2uDs0VAs+Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qWBVoeSh+WcVQTevuAYohjQyZrY0aM+nTYDZRhkqunvmooss1fqSbXEpAAhDxGVY0y
         ctKc1XeqkV4eFgWPxICArACOWoe/mK/wujcQOdqquoGgsWk01ZvTi9x+BqrRIckmzA+A
         B3MVV8SDkjGtrfrmHDRKJB2jb0LyFpkrQQk/c=
Received: by 10.90.83.18 with SMTP id g18mr2204998agb.76.1219449665171;
        Fri, 22 Aug 2008 17:01:05 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.163.41.46])
        by mx.google.com with ESMTPS id s40sm1629774hsb.7.2008.08.22.17.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 17:01:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vpro064qz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93404>

Junio C Hamano wrote:
>>  cmd_foreach()
>>  {
>> -	git ls-files --stage | grep '^160000 ' |
>> +	module_list |
>>     
>
> Thanks.
>
> I think the original "foreach" implementation does not pay attention to
> "$@" not by design but by mistake, and we should pass "$@" here as well.
>
> Other than that I do not see anything obviously wrong with the patch.
>
> Mark?
>
>   

Actually, this was by design, not mistake, though we did not discuss 
this at all. I'm not sure what the semantics would / should be: first of 
all, some part of "$@" is the command to be executed in each submodule, 
and as written "$@" in its entirety is what is used. Also, as written 
and documented, foreach operates in each checked out submodule, not a 
subset. I guess the basic questions are:
a)  What specific option or options to git ls-files makes sense here?
b) How do we distinguish the ls-files options from the command to be 
executed?

Mark
