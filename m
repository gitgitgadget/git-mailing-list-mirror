From: Ian Abbott <abbotti@mev.co.uk>
Subject: Question about PERL_PATH
Date: Fri, 6 May 2011 14:30:44 +0100
Message-ID: <4DC3F804.3080205@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 15:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QILES-00027U-Vj
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 15:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465Ab1EFNiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 09:38:06 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:41234 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421Ab1EFNiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 09:38:05 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 May 2011 09:38:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.mev.co.uk (Postfix) with ESMTP id A1BD52901E
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:30:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at mail.mev.co.uk
Received: from mail.mev.co.uk ([127.0.0.1])
	by localhost (mantis.mev.local [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wCXjmh0on0-z for <git@vger.kernel.org>;
	Fri,  6 May 2011 14:30:45 +0100 (BST)
Received: from remote.mev.co.uk (mev2008.mev.local [10.0.0.1])
	by mail.mev.co.uk (Postfix) with ESMTPS id 74C2529001
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:30:45 +0100 (BST)
Received: from [10.0.0.210] (10.0.0.254) by remote.mev.co.uk (10.0.0.1) with
 Microsoft SMTP Server (TLS) id 8.1.436.0; Fri, 6 May 2011 14:30:44 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110503 Lightning/1.0b3pre Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172973>

The Gentoo ebuilds for git have started invoking 'make' with the option
'PERL_PATH=/usr/bin/env perl'.  This doesn't seem to cause any problems
except when running git instaweb, which outputs an error similar to the
following:

/usr/libexec/git-core/git-instaweb: line 135: /usr/bin/env perl: No such
file or directory

There is an easy workaround, which is to modify the invocation of perl
in the httpd_is_ready() function in the git-instaweb shell script.  It
currently invokes perl as "$PERL" (with the quotes).  Removing the
quotes makes it work.

My question is, should git support Gentoo's unusual setting of PERL_PATH
as a multi-word command, or should Gentoo patch around the problem they
have created with git-instaweb themselves?

There is one other place where $PERL is used in git-instaweb and that is
in the mongoose_conf() function.  It has a heredoc that puts the
following line in the httpd.conf file (subject to shell variable expansion):

cgi_interp	$PERL

For Gentoo, that would get expanded to the following:

cgi_interp	/usr/bin/env perl

I don't know if Mongoose would choke on this or not.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
