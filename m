From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/7] add special "matching refs" refspec
Date: Wed, 30 Apr 2008 11:35:00 +0200
Message-ID: <48183D44.8080507@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org> <7vfxt31ys6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:36:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr8jD-0000az-8Z
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 11:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYD3JfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbYD3JfF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 05:35:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:27285 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYD3JfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 05:35:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so88459fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=PSZx7oMiUXeifMI/OisGioXH81wfZ+hRygKn66CqwBw=;
        b=WkuIQXbL5uitObMX7WIGI4jfnSxOYXc+GFHZZEMyK9QRdEVN4iEZriG7PdE0kHUXQJNy8Awk3PNNd3Lhz/hlgOOoP5SC5N22Bj9R02CNPOZqMXAZksZYlRey8AjYKHImua7/i630GIOBnsRD4DBmeWtIeHSyn9s4Z/jbRVxxIKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=IFk/2UhT3OnchUTQh8HS67SdZyRH7g+zOjqtX/reBhuPrhLZg9/I2Ap98Z1R0de/tSnHtew3PmIkxwYLEpF+9IO37xg2jW0h5NkJk8IHidxXSokpCTtj5Sgz7veevSBuSBbS5E8MOeKiiZzZ6f9dimrYitHB+TxbIT0HwGPiPxA=
Received: by 10.86.54.3 with SMTP id c3mr718465fga.58.1209548098921;
        Wed, 30 Apr 2008 02:34:58 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 4sm383310fge.5.2008.04.30.02.34.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Apr 2008 02:34:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vfxt31ys6.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80819>


>> +		if (rs[i].matching &&
>> +		    (matching_refs == -1 || rs[i].force)) {
>> +			matching_refs = i;
>> +			continue;
>> +		}
>
> It is probably better to document that you would force if you have both
> "+:" and ":" for the same remote, even though I am not sure if allowing
> that (instead of diagnosing it as an error) is the right thing to do.

I screwed up here.  I was sure that something like

         push = refs/heads/*:refs/heads/*
         push = +refs/heads/*:refs/heads/*

would also force, instead the first one wins.  I'm ok with just removing 
the "|| rs[i].force" part.

> Is it an error to have both ":" and "some:other" refspecs for the same
> remote?  If so who makes the check?

No, it is not an error.  For example, it allows to have a

	push = refs/tags/*:refs/tags/*
	push = :

refspec, which pushes all tags but only pushes branches if there is a 
matching ref on the other side.  I don't have a use for this, but it 
made sense to support the general case.

> Otherwise this patch seems to be very cleanly done.  Especially I like how
> the updated match_refs() looks.

Thanks.  Should I resubmit?

Paolo
