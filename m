From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 2/3] Handle NoRemoteRepositoryException in PushOperation
 especially
Date: Thu, 28 Aug 2008 04:29:08 +0200
Message-ID: <48B60D74.3030105@gmail.com>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com> <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com> <20080828021936.GA8624@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXHB-0006Pc-1U
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYH1C3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYH1C3Q
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:29:16 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:27377 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYH1C3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:29:15 -0400
Received: by ey-out-2122.google.com with SMTP id 6so48021eyi.37
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=T68eEN3n0MPWQtTf/xV64HeoTC4HrockyU36AkvZ4HE=;
        b=EwqjZxw+frrjDj4nDL78OIg2yYpU0OUXNE9GBQgPzHpYIuwmtzsWKYAP2/BPLgT01g
         Zyou6px7CvJJxqgwWn5lZhna8yH35BU7VugTDm+SYw7m5FTTXHkPAN3pE0ji5cDsrHkL
         EYscIonoiqa8FSuVVaVFaT6BeKWBCAE1fUhsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RdSrMMp6ETwx3CXrQ9cqj21Km8Ra30pWZ2h00Xw9MxkH9JUd3/3LKPtZasi50PuWrP
         o+F+yLpa63zwNt5kftLpHpJ55mlwPXwAXUADrbqlQSHI9CedxgT77cPFrDnIs+60wJON
         7sZmRudeDWdG/LFRnCuju2c5HNQVrvt/4EGQY=
Received: by 10.103.218.19 with SMTP id v19mr442555muq.110.1219890553994;
        Wed, 27 Aug 2008 19:29:13 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id s10sm478797mue.15.2008.08.27.19.29.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:29:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <20080828021936.GA8624@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94018>

Shawn O. Pearce wrote:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
>> index 94cf4aa..04ca28f 100644
>> --- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
>> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
>> @@ -61,5 +61,6 @@ ListRemoteOperation_title=Getting remote branches information
>>  PushOperation_resultCancelled=Operation was cancelled.
>>  PushOperation_resultNotSupported=Can't push to {0}
>>  PushOperation_resultTransportError=Transport error occured during push operation: {0}
>> +PushOperation_resultNoServiceError=Push service is not available: {0}
>>  PushOperation_taskNameDryRun=Trying pushing to remote repositories
>>  PushOperation_taskNameNormalRun=Pushing to remote repositories
>> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
>> index 8811800..a0f2e5c 100644
>> --- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
>> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
>> @@ -125,6 +126,10 @@ public void run(IProgressMonitor monitor) throws InvocationTargetException {
>>  				final PushResult pr = transport.push(gitSubMonitor,
>>  						specification.getRefUpdates(uri));
>>  				operationResult.addOperationResult(uri, pr);
>> +			} catch (final NoRemoteRepositoryException e) {
>> +				operationResult.addOperationResult(uri, NLS.bind(
>> +						CoreText.PushOperation_resultNoServiceError, e
>> +								.getMessage()));
> 
> Isn't this when combined with the prior patch going to result in a message like:
> 
> 	Push service is not available: git://repo.or.cz/egit.git push service is not available
> 
> which is sort of redundant and confusingly redundant, isn't it?

More precisely:
Push service is not available: git://repo.or.cz/egit.git push service 
not found

Yeah, this commit may be removed as well, leaving user with info:
Transport error occured during push operation: git://repo.or.cz/egit.git 
push service not found

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
