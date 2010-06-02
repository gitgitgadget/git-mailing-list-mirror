From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-instaweb: Add option to reuse previous config file
Date: Wed, 2 Jun 2010 11:44:08 +0200
Message-ID: <20100602094408.GD27342@machine.or.cz>
References: <201006012331.37871.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:44:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkUm-0001vC-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab0FBJoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 05:44:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40581 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023Ab0FBJoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 05:44:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B01778620AD; Wed,  2 Jun 2010 11:44:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006012331.37871.jnareb@gmail.com>
 <1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148237>

On Tue, Jun 01, 2010 at 07:14:05PM +0530, Pavan Kumar Sunkara wrote:
> @@ -551,7 +557,7 @@ our \$projects_list = \$projectroot;
>  EOF
>  }
>  
> -gitweb_conf
> +test "$no_reuse" = true && gitweb_conf
>  
>  resolve_full_httpd
>  mkdir -p "$fqgitdir/gitweb/$httpd_only"

It is a better style to write:

	test "$no_reuse" = false || gitweb_conf

The reason is that the script can then be easily run with set -e. But I
know that the rest of git-instaweb doesn't really follow this
convention, so this is just a nitpick. (Moreover, why do you have option
--reuse-config but variable no_reuse with an oppposite meaning?)

On Tue, Jun 01, 2010 at 11:31:37PM +0200, Jakub Narebski wrote:
> If git-instaweb is invoked *without* --reuse-config, the gitweb_config.perl
> would be regenerated whether it exists or not, overwriting your changes.
> 
> If git-instaweb is invoked *with* --reuse-config, the gitweb_config.perl
> would be generated if it does not exist (so if you delete gitweb_config.perl
> and then run 'git instaweb --reuse-config' it would not fail), and reused
> if it does exist.

That sounds like a good idea, but I think at that point --reuse-config
gets to be a way too misleading name. --keep-config might be tiny bit
better, but not a lot.

>   test "$no_reuse" = true || test ! -e "$GITWEB_CONFIG" && gitweb_conf
> 
> or something like that (the test if $GITWEB_CONFIG file exists might be
> moved to the fragment of code that sets no_reuse to true instead).

BTW, I think at the point you have to chain more than two pieces at once
in the boolean sequence, it gets clearer to write an if. Just my
personal opinion, though. (Mainly because I can never remember the
priorities. ;-)


-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
