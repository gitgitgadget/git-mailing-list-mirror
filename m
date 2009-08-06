From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to	significantly
 speed up packing/walking
Date: Thu, 06 Aug 2009 19:35:32 -0400
Message-ID: <4A7B68C4.8070406@gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de> <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com> <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com> <20090806203223.GK1033@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCVD-0000ZH-1F
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbZHFXfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZHFXfl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:35:41 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:57948 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZHFXfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:35:40 -0400
Received: by ywh7 with SMTP id 7so1633491ywh.21
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G5GGKOzMQ3B+ZiEjCOqHeGNe0s5XAfdcRLJHoF353Og=;
        b=b2oWAVM/T+K+mttqsIorWA1DOOZ1lUgNr2nMdoOptVk7Ltc1WTzx60Zdr2oOH5gyhK
         IYp6LTAZL4K7Gxw/M1V/CP4OEEdeozcgDqNcYoAkl3QXT73HdtksuNixUjBh7l9EOXwd
         tv8wUTXMkrOV1x/ToVVWoviEzgz5wZb23JcU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=l6HOk2qosqQ5iqc4+VpA3f2RN/PQLXZNDIoUaNygf8EIf+nkSsA0fRRddmxQbPo5sC
         yAuP6P8rqXXMLk2j9S0oRX1HE2yl66XJcO9h02cjMTh9FGsZ/WWyHkBmbEqDYxFrDjcW
         mzWZ5/bP01Ggnz/5np7zf5JS23+TkOUqjrGrU=
Received: by 10.90.75.9 with SMTP id x9mr350251aga.71.1249601739954;
        Thu, 06 Aug 2009 16:35:39 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 20sm1200808agb.75.2009.08.06.16.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 16:35:39 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090806203223.GK1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125141>

Shawn O. Pearce wrote:
> Nick Edelen <sirnot@gmail.com> wrote:
>> Hrmm, I just realized that it dosn't actually cache paths/names...
>> This obviously has no bearing on its use in packing, but I should
>> either add that in or restrict usage in non-packing-related walks.
>> Weird how things like that escape you.
>>
>> I think I may go ahead and add support for this tomorrow.  It should
>> have no effect on performance and very little impact on cache slice
>> size.
> 
> You may not need the path name, but instead the hash value that
> pack-objects computes from the path name.  All that matters is
> the hash, so pack-objects can schedule the objects into the right
> buckets when its doing delta computation for objects which are not
> yet delta compressed, or whose delta cannot be suitably reused.
> 

Please do NOT expose the hash values. The hash used by pack-objects is 
an implementation detail of the heuristics used by the _current_ object 
packing code. It would be a real shame to have to maintain backward 
compatibility with it at some future date after the packing machinery 
has changed.
