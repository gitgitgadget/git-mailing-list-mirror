From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 19:47:04 +0100
Message-ID: <200712191947.05608.jnareb@gmail.com>
References: <20071218173321.GB2875@steel.home> <200712191223.42446.jnareb@gmail.com> <56b7f5510712190921v4350384fx97ab4b89e481ed46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J53xb-00072E-Ta
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 19:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbXLSSrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXLSSrN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 13:47:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53283 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbXLSSrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 13:47:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so329764ugc.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0mJ0rCBT49EC9yzhYn6uAj2SO9jsGmWwilSbBy3WcK8=;
        b=YA+FdOJeDRAyvju1XDPAkkcepxCRFbQzsR5pcX6ImxNYeVG0A8czYY7Xj5A8pbFxXJAI+GaC8K/y9fdGr0ttX3AeSkqudkINH32DTOofHCu12EoiWyk1NLLMfN1BoVvCTQ/ynsnGL19hTqS8MSnkTKe3Mfag54xxi57uaP+2WgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BRcn9tVaPTKSuVbFqMgrJI+Bz24/TaIpXQ3ujHLaeRrAUwNdJSCAQiRoCrLJSi9X7Usaxb+vg8oovFfCmP6Ktqt5IgB9StdP8g87CVhPC6ABIuDmij/VLnz0bfkVlYThQimWVLsucv9WkOjhGIEA+ujzlOS4fZT55I4DqJcEojY=
Received: by 10.78.204.20 with SMTP id b20mr288896hug.33.1198090030464;
        Wed, 19 Dec 2007 10:47:10 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.93])
        by mx.google.com with ESMTPS id r38sm1933294ugc.55.2007.12.19.10.47.07
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 10:47:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <56b7f5510712190921v4350384fx97ab4b89e481ed46@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68930>

On Wednesday, 19 December 2007, Dana How wrote:
> On Dec 19, 2007 3:23 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> 
>> That said, does git-showrel solution proposed by  Johannes Schindelin
>> in
>>   Message-ID: <Pine.LNX.4.64.0712182250040.23902@racer.site>
>>   http://permalink.gmane.org/gmane.comp.version-control.git/68840
>> work for you?
>>
>> Below version of git-showrel script which uses proposed
>> 'commit:./relpath' syntax (it could be improved, of course):
>>
>> cat> git-showrel <<\EOF
>> #!/bin/sh
>>
>> rel=$(git rev-parse --show-prefix 2>/dev/null)
>> git show $(echo "$@" | sed -e "s!:./!:${rel}!")
>>
>> EOF
> 
> It's definitely true I could use this for now.  In the long run
> (meaning after the feature freeze) I don't view this as adequate
> for 2 reasons:
> (1) I would like a consistent interpretation of commit:path
> wherever it is accepted; and

Of course this is only interim solution, after 1.5.4 is out, we are out 
of feature freeze, and <path>:./<relpath> is in.

> (2) If a novice types bad arguments to git-showrel ,  they
> are probably going to be very confused by its error messages
> which are a response to a munged version of their command line.

Actually git-showrel should change only the _last_ argument, passing all 
other unchanged to git-show. But this requires something more than 
simplest script as above...

Unfortunately my shell script hackery is not up to the task ;-(
-- 
Jakub Narebski
Poland
