From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 06 May 2007 18:10:22 +0200
Message-ID: <vpqwszm9bm9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 18:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkjJl-00050U-Fz
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbXEFQKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXEFQKe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:10:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:55037 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbXEFQKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 12:10:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l46GANeX012006
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 18:10:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkjJX-0006hO-41; Sun, 06 May 2007 18:10:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkjJX-0003Pc-1i; Sun, 06 May 2007 18:10:23 +0200
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 May 2007 18:10:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46341>

Hi,

I've read the manual, and I belive I have a correct understanding of
how the index works, technically speaking. Still, I'm not clear about
the rational for such design.

Almost any other decent system has an equivalent to cache the stat
information (bzr calls this stat-cache, hg calls it dirstate IIRC).
That is, if your run "$vcs diff" twice, the second run will only need
to stat all files, never diff them.

But the fact that git actually remembers the _content_ of files in the
index, and that the default behavior for "commit" is to commit only
the content that is explicitely "git add"ed is something I've never
seen outside git.

At first, I find it rather annoying. My usual workflow is

<hack hack hack>
% $vcs status
% $vcs commit -m "describe whatever I did"
<hack hack hack>
...

With git, i'd do

<hack hack hack>
% git status
% git add X
% git add Y
% git status
% git commit

or

<hack hack hack>
% git satus -a
% git commit -a -m "..."

In the former case, I have more commands to type, and in the second
case, I loose part of the stat-cache benefit: If I run "git status -a"
twice, the second run will actually diff all the files touched since
the last run, since "git status -a" actually updated a temporary
index, and discarded it afterwards, so it doesn't update the stat
information in the index (while "git status" would have).

In both cases, I can't really see the benefit. I'm pretty sure this is
a FAQ, and I'm also pretty sure there are good arguments for it, but I
can't find it anywhere.

Thanks for your answers,

-- 
Matthieu
