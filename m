From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git/path.c - order of accessing ~/.gitconfig
Date: Wed, 18 Sep 2013 17:01:57 +0200
Message-ID: <vpq8uyuxjfe.fsf@anie.imag.fr>
References: <20130918.201006.407922449.enometh@meer.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Madhu <enometh@meer.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 17:15:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMJT2-0007Wl-AM
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 17:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab3IRPO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 11:14:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33019 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab3IRPO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 11:14:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8IF1u6A011922
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Sep 2013 17:01:56 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VMJGQ-0003KE-3D; Wed, 18 Sep 2013 17:01:58 +0200
In-Reply-To: <20130918.201006.407922449.enometh@meer.net> (Madhu's message of
	"Wed, 18 Sep 2013 20:10:06 +0530 (IST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Sep 2013 17:01:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8IF1u6A011922
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380121321.18781@9Qgw30mtIVueiCq42eFC/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234970>

Madhu <enometh@meer.net> writes:

> * commit 21cf32279120799a766d22416be7d82d9ecfbd04
> |
> | Author: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> | Date:   Fri Jun 22 11:03:23 2012 +0200
> |
> |    config: read (but not write) from $XDG_CONFIG_HOME/git/config file
> |
> |    Teach git to read the "gitconfig" information from a new location,
> |    $XDG_CONFIG_HOME/git/config; this allows the user to avoid
> |    cluttering $HOME with many per-application configuration files.
> |
> |    In the order of reading, this file comes between the global
> |    configuration file (typically $HOME/.gitconfig) and the system wide
> |    configuration file (typically /etc/gitconfig).
>
>
> However git/config.c (git_config_early) commit accesses xdg_config
> before user_config.  So the comments and documentation are
> inconsistent with the code.

It seems the commit message is wrong, indeed. But it's too late to fix
it. OTOH, the documentation seems right to me
(Documentation/git-config.txt). It says:

  $(prefix)/etc/gitconfig::
  	System-wide configuration file.
  
  $XDG_CONFIG_HOME/git/config::
  	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
  	or empty, `$HOME/.config/git/config` will be used. Any single-valued
  	variable set in this file will be overwritten by whatever is in
  	`~/.gitconfig`.  It is a good idea not to create this file if
  	you sometimes use older versions of Git, as support for this
  	file was added fairly recently.
  
  ~/.gitconfig::
  	User-specific configuration file. Also called "global"
  	configuration file.
  
  $GIT_DIR/config::
  	Repository specific configuration file.


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
