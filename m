From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Fri, 09 Dec 2011 22:35:41 +0100
Message-ID: <op.v58rlrrm0aolir@keputer>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
 <1323207503-26581-2-git-send-email-fransklaver@gmail.com>
 <7vpqg1e3au.fsf@alter.siamese.dyndns.org> <op.v56xbxqs0aolir@keputer>
 <7vaa71hd5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 22:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ86n-0002VC-CT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 22:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab1LIVfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 16:35:46 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35067 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1LIVfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 16:35:45 -0500
Received: by eekc4 with SMTP id c4so589249eek.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 13:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=5nVWUY7/FhycPLRYeUlHOa8qiSFqcz4PHTXYQ3tEkeM=;
        b=cf8GaQttfSPP2CdGNHi0dItIQC2jR+yOJseysE/voiemvTEtrgJMFRclVzdWoA8gTW
         QXixeUdPBKqWrEUBtrg2XN57rDNMbU2aktOLSmppToCzlscMYjbvQND4jmPOtbgGEmKr
         vQVYdn01JF7ve2nyOafvydJdmDqHDDj5yDWIo=
Received: by 10.14.4.32 with SMTP id 32mr1028093eei.50.1323466543796;
        Fri, 09 Dec 2011 13:35:43 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id f47sm3146053eea.1.2011.12.09.13.35.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 13:35:43 -0800 (PST)
In-Reply-To: <7vaa71hd5l.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186698>

On Fri, 09 Dec 2011 18:23:50 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> "Frans Klaver" <fransklaver@gmail.com> writes:
>
>>> Wouldn't access(2) with R_OK|X_OK give you exactly what you want  
>>> without
>>> this much trouble?
>>
>> I just had a good look through the man page of access(2), and I think
>> it depends. access works for the real uid, which is what I attempted
>> to implement in the above check as well. However, do we actually need
>> to use the real uid or do we need the set uid (geteuid(2))?
>
> Does it matter? We do not use seteuid or setegid ourselves and we do not
> expect to be installed as owned by root with u+s bit set.

That's what I thought, but needed to know for sure that this was the case.


> access(2) checks with real uid exactly because it would not make a
> difference to normal user level programs _and_ it makes it easier for a
> suid programs to check with the real identity, and our use case falls  
> into the former, no?
>

Certainly looks like. Thanks. I'll reroll somewhere next week.

Frans
