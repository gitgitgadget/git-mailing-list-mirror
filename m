From: Russell King <rmk@arm.linux.org.uk>
Subject: git merge vs git commit
Date: Tue, 9 Sep 2008 17:52:37 +0100
Message-ID: <20080909165236.GA8850@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 18:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd6Tf-00034N-W8
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 18:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYIIQwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 12:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbYIIQwp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 12:52:45 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57448 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbYIIQwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 12:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Subject:Message-ID:
	Mime-Version:Content-Type:Sender; bh=E7POiw+cPKMl7KIUrJrWmVQ1/nL
	MIzK+0zTSAXjd4So=; b=iBCW/CnQCnPynl1BcpyI10A0zYkfCNs/X+HKCF0Ajp+
	cJ9jcWc1bXA8NchIYYhnhEVC5U7CjKRVxTU/iisnss1gtqjFkv5Ym4YcSHUwk5fZ
	RzgnzrOPRDTOSTWPrb8B9RasEgWAWbvcfdbmc+TbTQ9RX3sMLcH41aQEwBM5upeQ
	=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1Kd6SG-0005iV-1V
	for git@vger.kernel.org; Tue, 09 Sep 2008 17:52:40 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1Kd6SD-0008Ka-Ud
	for git@vger.kernel.org; Tue, 09 Sep 2008 17:52:37 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95406>

Hi,

Using git 1.5.4.5, I notice that the result from git merge and git commit
are different in an unexpected way.

Take the following tree:

     B---C---D---E2
    /
  -A1
    \
     F---G---H---I3

(letters represent commits, numbers represent where the references are).

Your current head is '1', and you want to merge branches '2' and '3', so
you use:

	git merge 2 3

If there aren't any conflicts, you get a nice clean merge, resulting in:

     B---C---D---E2
    /             \
  -A               J1
    \             /
     F---G---H---I3

However, if you have a conflict that needs resolving, you fix it up as
normal, and then use git commit.  This results in:

     B---C---D---E2
    /             \
  -A---------------K1
    \             /
     F---G---H---I3

instead - an additional reference from commit 'K' back to commit 'A'
which isn't present in the clean merge case.

Is this intentional, or is it a bug?

-- 
Russell King
