From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG
 does exist
Date: Sat, 14 May 2011 16:06:30 -0500
Message-ID: <20110514210603.GA11502@elie>
References: <201105142137.16541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 23:06:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLM2x-0003ag-FZ
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab1ENVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 17:06:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43555 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab1ENVGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 17:06:37 -0400
Received: by iwn34 with SMTP id 34so3051979iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZOMWL3Cic2ZKCbgTHG+fm3UDVoI1608EBeNv21LnZbQ=;
        b=Phnduet3qNlEQ0zsCk+L6i/MrXf8RLercRY2k4St7MPK+WSDQTqk790h1kCXY12LCP
         ozMvriq+QwLr2nWREiQ2rPoToOjHQP/1xAyZn6NBGeRHIQiBj26OREKkZCqxMXFB6qC8
         y7WzUDrcYCabRH4DVz0TgzOm/dnuxY4Umku/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aIzOf60eOnpi2KCKDhcLlbxIb0SVeWiPb8iN04BFzSj2YMXqzX638kvCx31tHCsgxW
         oUqCUiCDu88tiswIYLHisg69dsb2bryRWCmgAMHOWRoMnEhwxL9UQ4tP/wXTwKI8HSAu
         4voFodzasCkxnwpbRbKzaBu4iF7Dy6R1riqB4=
Received: by 10.43.131.130 with SMTP id hq2mr3540659icc.90.1305407196850;
        Sat, 14 May 2011 14:06:36 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id y10sm1499657iba.46.2011.05.14.14.06.35
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 14:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201105142137.16541.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173606>

Jakub Narebski wrote:

> If per-instance configuration file exists, then system-wide
> configuration was _not used at all_.  This is quite untypical and
> suprising behavior.

I agree.  How to avoid breaking existing installations, though?  (I'm
especially worried because distro packages tend to ship their own
/etc/gitweb.conf, so the admin might not even know about what's
there.)  For example, depending on the content of /etc/gitweb.conf,
this has the potential to break "git instaweb".

It could be simpler to document that users should put

	do $GITWEB_CONFIG_SYSTEM;

at the start of gitweb_config.conf to reuse options from the system
configuration file and override them.  But that's not very satisfying,
since I don't see a nice way to move to a better behavior after that
without breaking some existing installations.  (It would be possible
to check for a new ./gitweb-config-in-addition-to-what-was-in-etc.conf
file but that doesn't seem so nice.)

If this were a command-line tool, I would be happy as long as there is
some way to prevent reading /etc/gitweb.conf through the environment.
For a webapp I don't know how easy it is to set environment variables
typically.  So thoughts from people in that corner of the world would
be interesting.
