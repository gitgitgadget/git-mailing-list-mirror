From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Fri, 05 Jun 2009 01:45:49 -0700 (PDT)
Message-ID: <m3ab4n6pc6.fsf@localhost.localdomain>
References: <200905122329.15379.jnareb@gmail.com>
	<200906042255.43952.jnareb@gmail.com>
	<20090605004540.GU3355@spearce.org>
	<200906050924.43882.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCV3r-0003P3-S9
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbZFEIpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZFEIpu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:45:50 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:50225 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbZFEIpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 04:45:49 -0400
Received: by fxm9 with SMTP id 9so388199fxm.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gCbl1jUteOv0QjoZQ+3kgdMHvwMmkVTqDyeQNBlBNOA=;
        b=Q9pk1X6mo3ZWye5rHD5dZChwUomFnEIn6HMp6YkBUZ7Zfd8VE8rsi1+KLmPzJf1SjZ
         THDNuUdd4Qx76gd8n2MyHg2nOBeqWT0YheKp1qfsvu/6sbEydLUoLapc1l3CkN0qgQwA
         2dcWsRsw/L1cQPePnU+32fD3EySlOJrDtCxKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qpejEUs9sPQuHHKyXD6SHg4HwrDrcGRTQTGtEqr15W6VhUgX2sMT/L2Ckc6CKIhGLw
         s18ONPfkgQbc6EF1KNJm76sWBDMv4jzbneH1vAi1aVAzuGns68psVaK9R9M2zkynvK+E
         YWe2bNpN2HwbRzRzaFO2YqP8YkyvMH5hbzW4w=
Received: by 10.86.91.13 with SMTP id o13mr3684210fgb.7.1244191550237;
        Fri, 05 Jun 2009 01:45:50 -0700 (PDT)
Received: from localhost.localdomain (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id l19sm1169514fgb.2.2009.06.05.01.45.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 01:45:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n558jkss013878;
	Fri, 5 Jun 2009 10:45:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n558jj40013875;
	Fri, 5 Jun 2009 10:45:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200906050924.43882.jnareb@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120764>

Jakub Narebski <jnareb@gmail.com> writes:

> Also the flush "0000" seems to be required... but when I tried to repeat
> it using the above example it actually does not hang, but doesn't get
> PACK from git-daemon: there is something wrong in above snippet, as 
> I get the same error on server whether I put "0000" flush line or not...
> 
>  c$  perl -e '
>          my $h="c1e54552c9b35521f189db53db24cc82b5b75816";
>          my $c="multi_ack side-band-64k ofs-delta";
>          sub w{$_=shift;printf "%04x%s",4+length,$_;}
>          w("git-upload-pack /git.git");
>          w("want $h $c\n");
>          ## printf "0000";    # <-- commented out!
>          w("done");
>      ' | nc localhost -v 9418
>  
>  s$  git daemon --export-all --verbose \
>          --base-path=/home/local/scm/ /home/local/scm/
>  [12791] Connection from 127.0.0.1:42484
>  [12791] Request upload-pack for '/git.git'
>  fatal: git upload-pack: not our ref c1e54552c9b35521f189db53db24cc82b5b75816 multi_ack side-band-64k ofs-delta
> 
>  [12692] [12791] Disconnected (with error)

While it works against git-clone ("git clone git://localhost/git.git"),
so the problem is with the above snippet, not with git-daemon invocation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
