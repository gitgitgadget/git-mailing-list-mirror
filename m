From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/3] git-submodule - Follow top-level remote on init/update/clone
Date: Mon, 11 Feb 2008 20:34:04 -0500
Message-ID: <47B0F78C.1050605@gmail.com>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802112152050.3870@racer.site> <47B0EFA2.9070903@gmail.com> <alpine.LSU.1.00.0802120109270.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 02:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOk2s-0003Re-Mj
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbYBLBeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 20:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbYBLBeK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 20:34:10 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:62247 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbYBLBeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 20:34:08 -0500
Received: by rn-out-0910.google.com with SMTP id i24so6366178rng.19
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 17:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ceP7VFCmUUvrsnlzlv0+yOPArKK50SmOcPMQxRVYZPQ=;
        b=CJOs74RpfM4Mo+/juN7sunqlIIHpkDqXYGweL06CsyVdxtYsEDrYQLi+oqcm+PsxxQWA6347d9VaWpuHQqUWBs212DysVSkHg3HLPDaZQ0G0eWtDP5EJz33uKhEJE0wL4r+XZj10DHYGDcXRf/DsMplG86Ou6vT/mUbRUNcp4zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=wCVMMX1v0FYaLDxi0HOG7nSrF3ZRII30X6Qs0yjfhtJwMQhNOh+1jfSn66D7HwGBlvEAV1nFkz2B61f2ZV4bgqNW9tnd1N/Md39XZxuYql6RkK3dbo1RKONR2yXQXqi1Bu4uu6+MAjhykDPRGA5+K8n/rUDBz6NMez1IACXHbo4=
Received: by 10.150.145.20 with SMTP id s20mr259414ybd.5.1202780047660;
        Mon, 11 Feb 2008 17:34:07 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.29.241])
        by mx.google.com with ESMTPS id c53sm42125915wrc.13.2008.02.11.17.34.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Feb 2008 17:34:06 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802120109270.3870@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73618>

Johannes Schindelin wrote:
> Hi,
>
> On Mon, 11 Feb 2008, Mark Levedahl wrote:
>
>   
>> Johannes Schindelin wrote:
>>
>>     
>>>> @@ -107,7 +112,7 @@ module_clone()
>>>>  	test -e "$path" &&
>>>>  	die "A file already exist at path '$path'"
>>>>  -	git-clone -n "$url" "$path" ||
>>>> +	git-clone -n -o "$remote" "$url" "$path" ||
>>>>  	die "Clone of '$url' into submodule path '$path' failed"
>>>>  }
>>>>      
>>>>         
>>> If you do _that_, you will _force_ the submodule to have no "origin" 
>>> remote.  As discussed _at length_, this is not what you should do.  
>>> The only reason to use "-o <other-nick-name>" is if you plan _not_ to 
>>> use the same URL for the default remote.
>>>       
>> This *must* define the remote using the same name as flowed down from 
>> top-level, whatever that name is.
>>     
>
> At this point, I give up my review in despair,
> Dscho
>
>   
The submodules must use the same remote name to refer to the same 
server/repo-tree as top-level, or the coordinated fetch / update driven 
by top-level's branch.<name>.remote cannot work. It is always origin, or 
always frotz, not mix and match. There are two ways to achieve this:

1) Use the name given by top-level, as I did.
2) Restrict git to only allow one remote name, *origin*, ever (or at 
least if submodules are used). Not just the default remote, *any* 
remote. This removes branch.<name>.remote as that is defined to be origin.

I infer you choose option 2? It is certainly simpler, though 
significantly more restrictive.

Mark
