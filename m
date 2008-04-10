From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff-tree -r and new directories
Date: Wed, 09 Apr 2008 23:52:54 -0700
Message-ID: <7v1w5eyzeh.fsf@gitster.siamese.dyndns.org>
References: <47FDB3DB.8020705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqgG-0003ve-9O
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbYDJGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbYDJGxN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:53:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYDJGxL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:53:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F079268A;
	Thu, 10 Apr 2008 02:53:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AAD792689; Thu, 10 Apr 2008 02:53:03 -0400 (EDT)
In-Reply-To: <47FDB3DB.8020705@viscovery.net> (Johannes Sixt's message of
 "Thu, 10 Apr 2008 08:29:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79183>

Johannes Sixt <j.sixt@viscovery.net> writes:

> In one of my scriptlets I have this:
>
>    git diff-tree -r --name-only --diff-filter=AM -z "$rev" HEAD --
>
> and I had assumed that only files would ever be listed because of the -r
> switch. But this is not true: If there is a new directory, it lists only
> the directory's name instead of the files. Is this the intent? Is it worth
> changing?

Hmm. you would need a better reproduction recipe than that.

    $ git init
    Initialized empty Git repository in .git/
    $ >file
    $ git add file
    $ git commit -a -m initial
    Created initial commit 2f9da65: initial
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 file
    $ mkdir new
    $ >new/file
    $ git add new/file
    $ git commit -a -m second
    Created commit a1fa8fb: second
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 new/file
    $ git diff-tree -r --name-only --diff-filter=AM -z HEAD^ HEAD |
      tr '\0' '\n'
    new/file
    $ git diff-tree --name-only --diff-filter=AM -z HEAD^ HEAD |
      tr '\0' '\n'
    new

Perhaps you somehow did not have "-r" even though you thought you had?
