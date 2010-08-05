From: Jared Hance <jaredhance@gmail.com>
Subject: Re: Git server eats all memory
Date: Thu, 5 Aug 2010 18:45:22 -0400
Message-ID: <20100805224521.GB22430@localhost.localdomain>
References: <wesfwyupgrg.fsf@kanis.fr>
 <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
 <87ocdhlgbl.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 00:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9Cj-00009y-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758974Ab0HEWpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:45:52 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46205 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003Ab0HEWp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:45:27 -0400
Received: by qwh6 with SMTP id 6so4411729qwh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z4g5nQVmiwazoVAExJ1oWtRhkLwMf8LoQ4vfSYZgx3g=;
        b=sJCoOUfd3Q3SM8nyXcgqWUelQKOBhCoRts4QBwH90zSsEvfwA3rumb/HwTNB4kdLtB
         NukrhOERTmNUlkHxjkGj3l2HuAhaJQLgFdGe3NXBM6IreXagjFAXotPE00L1Fo9u/f7/
         7a1HL9ck2gdmfDInQHmhEek04ohBXjmRlTAF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=khnEqi14qEqh0XVZ05txcuGzFmev5gq1MqRVNvziS3oCPDFovG9h9pqIb69XNKBZ+f
         Zj2hk9nDsEm3zZuYsQ8tBtq1S7kIZwNy+TCRNW/y3TTdRyIJTwapIVcWTIyixZCCX3q3
         irsnB1XG6DSUnW4i2cCVYCy2/ZhUVj//Nw9yg=
Received: by 10.224.27.3 with SMTP id g3mr5282604qac.229.1281048326414;
        Thu, 05 Aug 2010 15:45:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id r1sm828959qcq.46.2010.08.05.15.45.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 15:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ocdhlgbl.fsf@kanis.fr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152735>

On Thu, Aug 05, 2010 at 08:33:02AM +0200, Ivan Kanis wrote:
> I am ready to do whatever to diagnose the problem. I know C pretty well
> and am ready to look into it but I am not sure where to start.

It sounds like Git is reading each object into memory to send it to
the client, but doesn't remember to free the memory at the end of
sending the object, so it remains as a memory leak.

I would look in the code for malloc calls that don't have a free call,
or spots where free calls might not be hit.
