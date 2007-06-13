From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: How to stage a tree with all changes?
Date: Wed, 13 Jun 2007 18:47:56 +0200
Message-ID: <vpqy7inajib.fsf@bauges.imag.fr>
References: <861wgf964g.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyW20-0000eC-LO
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473AbXFMQtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbXFMQtO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:49:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:64451 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758443AbXFMQtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:49:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l5DGlucZ015341
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2007 18:47:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HyW0i-0006MQ-Pr; Wed, 13 Jun 2007 18:47:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HyW0i-0003cJ-Mb; Wed, 13 Jun 2007 18:47:56 +0200
Mail-Followup-To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <861wgf964g.fsf@lola.quinscape.zz> (David Kastrup's message of "Wed\, 13 Jun 2007 18\:22\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 13 Jun 2007 18:47:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50095>

David Kastrup <dak@gnu.org> writes:

> Suppose I have a number of changes in a tree: additions, deletions,
> renames and so on.

At commit time, a rename is just an add+delete for git. It'll
investigate renames with heuristics later, when needed.

> How do I stage and commit all of that?

Well, what I usually do is

  $ git status

(nicer with 
[status]
	color = auto
in ~/.gitconfig)

and then "confirm" one by one the things I actually want to commit.

> git-commit -a
>
> omits new files.
>
> git-add .
> git-commit -a

The -a is not necessary if you just did "git add .".

> seemingly overlooks deletions.

In most cases, you'd have deleted the files with "rm", and you could
have told git at that time, using "git rm" instead. Otherwise,

  $ git-ls-files -z | git-update-index --remove -z --stdin

will remove deleted files from the index after the fact. But I don't
know any porcelain command to do that. Perhaps a "git rm -u" could be
a nice dual for "git add -u"?

-- 
Matthieu
