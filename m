From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Sat, 13 Feb 2010 03:46:49 +0100
Message-ID: <201002130346.51968.jnareb@gmail.com>
References: <20100207093744.29846.6468.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 03:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng82C-0008Rm-Ft
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 03:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0BMCq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 21:46:57 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:40027 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0BMCq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 21:46:56 -0500
Received: by fxm20 with SMTP id 20so3009261fxm.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 18:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7oU0SAlZhtvAxeplD7sBY7ZY+M6zGhXjUlzlKvg2uxM=;
        b=P3rs2lfkF3zAEs2pxx3275cGVM2EXrZPjkRdgdtPdUSPF8gj5QeT+8mn9MahbYMO8q
         Mc4pqn5i0UJsKxCHjxP137PYBmtPsJxmgQVtpXnOTcjgDJ4rCDVBtYmBYYgyJMzYWL7d
         hi0S2zk+1rl5aCmB9YS9ELg83Ku4qWSr5Rwj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GKbUGbN9OVKZ9UiAkWBXT8lZ9FpwunB1j86R8Yf00aM5KCwalFXaGUhiSpXYuCrgzn
         hJEoG1ornd8T4a6CT+9Vrg5PYe8n8T00DHDueysPQjOAy9b7a/qHQYHJ+SmdjxdVNkcF
         5ob6vTk1LmD5lvaA0RHwsY+P4Yq6E9xgZc5eE=
Received: by 10.103.50.15 with SMTP id c15mr1527054muk.35.1266029214504;
        Fri, 12 Feb 2010 18:46:54 -0800 (PST)
Received: from ?192.168.1.13? (abvw238.neoplus.adsl.tpnet.pl [83.8.220.238])
        by mx.google.com with ESMTPS id j9sm21519474mue.36.2010.02.12.18.46.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 18:46:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100207093744.29846.6468.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139771>

Ping!

I didn't want to push for it before 1.7.0, but now that 1.7.0
is out...

On Sun, 7 Feb 2010, Jakub Narebski wrote:
> Otherwise the errors can propagate, and show in damnest places, and
> you would spend your time chasing ghosts instead of debugging real
> problem (yes, it is from personal experience).
> 
> This follows (parts of) advice in `perldoc -f do` documentation.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
  Acked-by: John 'Warthog9' Hawley <warthog9@kernel.org>

http://thread.gmane.org/gmane.comp.version-control.git/139226/focus=139230

> ---
> This is fallout from my work on [split] "Gitweb output caching" series.
> Before I used `die $@ if $@;' in t/t9503/test_cache_interface.pl, tests
> failed for no discernable reason...
> 
> So I think the same should be done for the gitweb config file.
> 
>  gitweb/gitweb.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1f6978a..a5bc359 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -556,6 +556,8 @@ if (-e $GITWEB_CONFIG) {
>  	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
> +# die if there are errors parsing config file
> +die $@ if $@;
>  
>  # Get loadavg of system, to compare against $maxload.
>  # Currently it requires '/proc/loadavg' present to get loadavg;
> 
> 

-- 
Jakub Narebski
Poland
