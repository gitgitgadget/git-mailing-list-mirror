From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:45:34 -0800
Message-ID: <20130212194502.GA12240@google.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-6-git-send-email-drafnel@gmail.com>
 <7v621xgxax.fsf@alter.siamese.dyndns.org>
 <511A98C0.70201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>,
	Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Lnr-0000g7-4H
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933473Ab3BLTpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:45:44 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:46473 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385Ab3BLTpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:45:43 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so180300daj.8
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 11:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=y+aB6ZNHcWAr4Ln/vllMhIBIVfDOn4eRsgv0ZJfs3aw=;
        b=wLMzC3HpaF26hJ+356F0uaVRmoH2CHpY0Gt+vJRp7TC2wwvBuPnXAQ2it2xXMDXoiO
         mCWeX20xPEvkrbbkHf8kzSHuH5Lul/4BQdoKpCErFYBEwVNLKEp0J1aJpTJxadkXrCE2
         npOv19PGfDr42z2fdldrKdaOb/fV8rUk01E41j+bsjslmORFVKyOwzIv9LclZ3p8eyXr
         zBvENN20vNFv3T+DCAtAYpP60xKK8zHtWho7/uGwCf2fLI4PhZkJFZVrIOV+5Gc1335W
         ir7EYHcGLQv154hxzV2S65DNapdEQYXsc8xQuYNrozr13lTaMgMPOxc5caObcd4Ata7s
         WJDg==
X-Received: by 10.66.88.198 with SMTP id bi6mr55272533pab.54.1360698342285;
        Tue, 12 Feb 2013 11:45:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id i6sm77302885paw.19.2013.02.12.11.45.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 11:45:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <511A98C0.70201@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216179>

Brandon Casey wrote:
> On 2/12/2013 11:13 AM, Junio C Hamano wrote:
>> Brandon Casey <drafnel@gmail.com> writes:

>>> +static int is_cherry_picked_from_line(const char *buf, int len)
>>> +{
>>> +	/*
>>> +	 * We only care that it looks roughly like (cherry picked from ...)
>>> +	 */
>>> +	return len > strlen(cherry_picked_prefix) + 1 &&
>>> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>>> +}
>>
>> Does the first "is it longer than the prefix?" check matter?  If it
>> is not, prefixcmp() would not match anyway, no?
>
> Probably not in practice, but technically we should only be accessing
> len characters in buf even though buf may be longer than len.

Yep.  Technically the buf[len - 1] == ')' check is enough to avoid
false positives, but if it and the 'len' check were dropped then this
would be checking that buf is a "(cherry-picked from" line instead of
checking that its first 'len' bytes are one.

So it's just paranoid futureproofing.  In the long term, it would be
nice to drop the "number of bytes to ignore at the end" argument to
append_signoff to avoid having to think about this kind of thing.

Jonathan
