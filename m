From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 4 Jan 2011 16:58:26 -0600
Message-ID: <20110104225826.GA2122@burratino>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
 <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
 <vpqhbdoxpzp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Vallon, Justin" <Justin.Vallon@deshaw.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 04 23:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaFq4-0000X1-DJ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 23:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab1ADW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 17:58:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43736 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1ADW6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 17:58:35 -0500
Received: by qwa26 with SMTP id 26so15072909qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gnCw4SFStGybb44WQ0KoxiJGeKxTipJwXKNNk3m8aa4=;
        b=lO5XvZ52g8Lw+D1w0eagAO2hnBOWuK5VOKw8tNAUBcE6h7geH/AEkLe+M4KEDsimU2
         UCnQXDS/K9/a9mVBkGVmd47gq1fa9FjMXPInZ6ewLnfRKvd6x5Zo6Cov5AgQU9E7bToY
         V7GXtHgHUYnsm4bZhhtjmuvxvUFFLevC0VZ6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AWCMsvBJ7Qi6y1FACaPc/yAml0tui1Br0eiTbv/UsHxCYHw1ESAIyueJuCddaY1Vng
         gLGkW1aeWQHtMuPVeJ2Sgr3ZWHPM/0Kvqk1x65NM+hpKJhY+L3MxhIQT+ctRNXUb0e6O
         +PrIozo8sxMFHj7ELNd/0dG6kGXUK7RMxax7Y=
Received: by 10.224.63.195 with SMTP id c3mr20796550qai.364.1294181914069;
        Tue, 04 Jan 2011 14:58:34 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id l12sm13103316qcu.7.2011.01.04.14.58.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 14:58:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpqhbdoxpzp.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164523>

Matthieu Moy wrote:
> "Vallon, Justin" <Justin.Vallon@deshaw.com> writes:

>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -71,8 +71,9 @@ test_expect_success 'setup' '
>>  # "exec" commands are ran with the user shell by default, but this may
>>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>>  # to create a file. Unseting SHELL avoids such non-portable behavior
>> -# in tests.
>> +# in tests. It must be exported for it to take effect where needed.
>>  SHELL=
>> +export SHELL
>
> (my bad, I wrote this SHELL= without exporting it. Since bash
> re-exports already exported variables when they are assigned, and my
> /bin/sh points to bash, I didn't notice)

Isn't that how export works in all Bourne-style shells?  For example:

	$ env var=outside dash -c '
		var=inside;
		dash -c "echo \$var"
	  '
	inside
	$

Maybe in the failing case SHELL was not exported but just set to
/bin/false in .bashrc or similar?
