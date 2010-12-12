From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fast-import tweaks for remote helpers
Date: Sun, 12 Dec 2010 11:16:33 -0600
Message-ID: <20101212171633.GB18847@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <4CFFCDCD.9060602@dbservice.com>
 <20101212061437.GA17185@burratino>
 <4D049BA5.1060509@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Stephen Bash <bash@genarts.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Dec 12 18:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRpel-00021i-Su
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 18:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0LLRQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 12:16:43 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:63700 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab0LLRQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 12:16:43 -0500
Received: by gwb20 with SMTP id 20so4443692gwb.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o53n1vr5rBBqnIXkfAsTBKsZeoF0nWJNuDtPfHlhDTs=;
        b=MiZgvFu/rz+RZkA+QVRZ7Jw3iK+bnHHcBXAnZCQ7uXvf2luy7YbTSamaEcUllrbKiL
         YXePnGu2tvjppkHQfaS6Ge7uGTRLkGctdt6vyV+81lwAZ/8sKLlSYOjSv+zUt6le3vU4
         06UJoOawQdspy4e151A6RIvZ4+ZOYdAyIRc7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A9KfqcIt2HjKSGe06QLS8KNsFWmTDVeFrK8EruDVntQY5qS1kdrJ+CxbbWX3xPLkFA
         YAQFb6omdo/vNglQCofekdCowXTG1ZExRotRRFfwrlRMq6h3mkMt/CCFnWrtv437TZLx
         lnWpC8A4NHoyodAW5MC7PsHonJwt49TUx8AUg=
Received: by 10.236.108.41 with SMTP id p29mr6705797yhg.68.1292174202192;
        Sun, 12 Dec 2010 09:16:42 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id 55sm2338652yhl.37.2010.12.12.09.16.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 09:16:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D049BA5.1060509@vilain.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163486>

Sam Vilain wrote:

> What happened to --report-fd ?

The patch still works.  The main problem with report-fd is that it
introduced a synchronization point after every commit: the frontend
has to read the commit id before fast-import will continue.

So if the reports can be made optional ("report _this_ commit") or
batched ("report all marked commits") then the result would be easier
to use imho.

>> (In the back of my mind, I have the idea of using a
>> file that allows O(1) access, perhaps of the form
>>
>>	<commit name for rev 1>  NL
>>	<commit name for rev 2>  NL
>>	...
>
> This doesn't scale to many branches

Right.  Another reason to delay getting rid of the git branch with the
full repo.
