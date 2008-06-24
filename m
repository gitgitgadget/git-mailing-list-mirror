From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 18:11:27 +0200
Message-ID: <8aa486160806240911p49d7bcb8q82a8d68c51206543@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	 <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
	 <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
	 <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Klas Lindberg" <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBB87-0002j7-2u
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbYFXQLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbYFXQLa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:11:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:43634 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbYFXQL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:11:29 -0400
Received: by yx-out-2324.google.com with SMTP id 31so543030yxl.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PuUinPRnHT8skPjOZcBaw0ekUIolciYfBLCOlmHWuvw=;
        b=le4qlhkFWdln0yZxbbanQgFyfgfqmU9fi6JlARD/ax0j0hrvjZCIqR/i3ZbQGlNQPe
         VFUW4gMIFjpXZyjXrnoQm2zcMd48CW9Ddm1osqwzQ+oTnRLfoeYlCkXXsY+LgiEets9G
         70nZykAxI7EM4bEL0wm+/CUI3QZr0vYms4o/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L4zDmbzMZazvZkQCGksV2f8u/rWx+xqK/C8O93TYOMbRmRNeRucGXZU13fla3AgU/S
         QLhO5GEJslqgfJPzySsiPiZ41kUlgRx6kTLiKfUx1DQ12n0pl6QlxA00tF4x9s/h25wb
         WBudpSxo/8EVGytaRGVZiPmp5txwydTO3yZJg=
Received: by 10.125.109.15 with SMTP id l15mr1357566mkm.4.1214323887186;
        Tue, 24 Jun 2008 09:11:27 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Tue, 24 Jun 2008 09:11:27 -0700 (PDT)
In-Reply-To: <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86079>

On Tue, Jun 24, 2008 at 17:31, Klas Lindberg <klas.lindberg@gmail.com> wrote:
>
>> Can you explain why you have to do it this way? Or the whole workflow?
>
> I am looking into the possibility of writing a tool that handles
> configurations of trees.

Maybe you should be using the plumbing commands.

> For instance, I want the tool to be able to
> consume some version of a configuration and create, update or reset
> branches in other trees accordingly.

What are the "other trees"?

Do you mean this?

1. You have a repository with different branches as:
  master
  tree1
  tree2
  ..

2. You want /path/to/tree1 to always checkout tree1
  and the same for treeN

Then

3. In /path/to/treeN/.. you do:
$ git clone /path/to/repo treeN
$ git checkout -b treeN origin/treeN

4. To keep uptodate:
$ git pull

5. The branches for the other trees are always uptodate in origin/*.

> The main stumbling block is actually that a lot of git commands have
> side effects on the working tree (usually because they do something
> with a "current" branch).

Sure. So you have to choose those that don't have these "side
effects", you have plenty of them, mainly in the low-level, plumbing
commands.

> In my mind, the user should be able to
> select a configuration that effectively fast forwards branches in some
> trees and resets branches in others -- all of it without touching any
> working trees (unless there is an explicit checkout).

Well, if you touch the current branch, for sure, you want to update
the working tree.

Maybe you want to keep your local branches up to date with respect
their tracking branch?

> The example in this case is that fetching tags to update a branch
> isn't possible.

I don't see the point updating a branch with a tag, but you can make a
tool to update a branch with a tag, see for example
contrib/examples/git-fetch.sh.

Santi
