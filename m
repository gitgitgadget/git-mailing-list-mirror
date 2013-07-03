From: "Paul A. Kennedy" <pakenned@pobox.com>
Subject: unexpected file deletion after using git rebase --abort
Date: Wed, 3 Jul 2013 18:44:02 -0400
Message-ID: <20130703224402.GF9016@localhost.localdomain>
Reply-To: "Paul A. Kennedy" <pakenned@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul A. Kennedy" <pakenned@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 00:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuVmX-0004dx-0y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 00:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031Ab3GCWoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 18:44:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885Ab3GCWoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 18:44:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1B32DE73;
	Wed,  3 Jul 2013 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:reply-to:mime-version:content-type; s=
	sasl; bh=9ihX3dZlSLiY0XEBfyqAx3cVDnk=; b=TqccInufnPjhUIJifw7GBGY
	q+Lr0Zfd5vE2NSSsoeqVogfE2wA6W+da7LzyH7bFTiewrVusNZTaS6W/cspewu4E
	TzulRFLF/wSN0tVsQgFVa50qxXr+V2N1pl6ngF7VZawCX0/IQP+wNVV7EvEufH1n
	6BfPZDDyPvPJrvQ89AW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:reply-to:mime-version:content-type; q=dns;
	 s=sasl; b=p8qqUcqtqfkayyhBlQ6WFCnMslT1nE6z0wNyyITJrrr4iOxKfixZb
	HrarB3fcQItRIfQuWbtIJjfxNYFT2gU/jnQF47aVbPRXAIyyxm8gcVHbjumWgug7
	sTBu2HGuNqmlr2tMs8L/ZYQ02e8Hfqd2MUsJHwVaRZfqEXDYI7r9/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737462DE72;
	Wed,  3 Jul 2013 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.56.44.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 853482DE6B;
	Wed,  3 Jul 2013 22:44:04 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 1038F120-E432-11E2-A061-E84251E3A03C-07946896!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229543>

Hello!

I lost a previously untracked file that I added to the index in the
middle of a git rebase --interactive session after a git rebase --abort.
This was unexpected.

    $ ls forgotten_file
    forgotten_file
    $ git rebase --interactive HEAD~3 
      [change first rebase command from pick to  edit]
    $ git add forgotten_file
    $ git rebase --abort
    $ ls forgotten_file
    ls: cannot access forgotten_file: No such file or directory
    $

I was (of course) able to find the SHA-1 of the dangling blob using 'git
fsck', and then retrieve the file using 'git cat-file -p SHA1'

Should this behaviour be considered a bug?  That is, should the contents
of the working directory (including untracked files) before the git
rebase invocation be returned (as if preserved by a git stash
--include-untracked)?  

If we don't expect this, should we update the documentation for the
--abort heading in the git rebase man page to indicate that newly
staged content will be lost after a git rebase --abort?

This is for git version 1.8.3

Paul

--
Paul A. Kennedy
pakenned@pobox.com
