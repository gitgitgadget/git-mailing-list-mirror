From: Madhu <enometh@meer.net>
Subject: git/path.c - order of accessing ~/.gitconfig
Date: Wed, 18 Sep 2013 20:10:06 +0530 (IST)
Message-ID: <20130918.201006.407922449.enometh@meer.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 16:40:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMIvd-0002ZJ-Js
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 16:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab3IROk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 10:40:26 -0400
Received: from vps4.hungerhost.com ([199.167.40.167]:37443 "EHLO
	vps4.hungerhost.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab3IROkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 10:40:25 -0400
Received: from [59.92.9.129] (port=34725 helo=localhost)
	by vps4.hungerhost.com with esmtpsa (SSLv3:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <enometh@meer.net>)
	id 1VMIvV-0006DA-U5; Wed, 18 Sep 2013 10:40:22 -0400
X-Mailer: Mew version 6.5 on Emacs 24.3.50 / Mule 6.0 (HANACHIRUSATO)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps4.hungerhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - meer.net
X-Get-Message-Sender-Via: vps4.hungerhost.com: authenticated_id: enometh@secure.meer.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234968>


* commit 21cf32279120799a766d22416be7d82d9ecfbd04
|
| Author: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
| Date:   Fri Jun 22 11:03:23 2012 +0200
|
|    config: read (but not write) from $XDG_CONFIG_HOME/git/config file
|
|    Teach git to read the "gitconfig" information from a new location,
|    $XDG_CONFIG_HOME/git/config; this allows the user to avoid
|    cluttering $HOME with many per-application configuration files.
|
|    In the order of reading, this file comes between the global
|    configuration file (typically $HOME/.gitconfig) and the system wide
|    configuration file (typically /etc/gitconfig).


However git/config.c (git_config_early) commit accesses xdg_config
before user_config.  So the comments and documentation are
inconsistent with the code.

[This looks like an intentional bug, I spotted it when commenting out
 the accesses to files under ~/.config.  (protip: chmod 000 ~/.config helps
 identify and blacklist NWO "apps" and now git started complaining) ---Madhu
