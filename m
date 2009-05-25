From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 23:39:08 -0700
Message-ID: <7vocthy9df.fsf@alter.siamese.dyndns.org>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	<7voctirzu6.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	<7vfxeurwh0.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
	<fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
	<cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
	<fabb9a1e0905241557l403037f6p7c1df1f587cb9cf7@mail.gmail.com>
	<cb7bb73a0905241603r4949abb5g1a9e861aba40c6fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 08:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8TqP-0000dz-L3
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbZEYGjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZEYGjJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 02:39:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39447 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbZEYGjI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 02:39:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525063908.BJSG25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 May 2009 02:39:08 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vif81b0064aMwMQ03if8H9; Mon, 25 May 2009 02:39:08 -0400
X-Authority-Analysis: v=1.0 c=1 a=cKKtvLOY1ucA:10 a=pGLkceISAAAA:8
 a=J5WQ9VrmoZyw_-i-iZ8A:9 a=_meeTwAlW8mggPePahgA:7
 a=uPsfFCSZtotTP4ZAEAD148cATSoA:4 a=MSl-tDqOz04A:10 a=zzooIisAW3TT70o4:21
 a=4OTeNjueSjhKCeeS:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119888>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> But then the name munge would not be descriptive of what the command
> does. If git am is to be left untouched, I would rather then have
> something like git import-patches that accepts patches in 'any'
> format,...

There is no need to introduce any new program, I think.

Nobody is against your teaching the "git am" callchain to accept things
other than Berkeley mbox.  "git am" is "import-patches" in that sense
already.

You can add a conditional (perhaps triggered by a "the patches are in this
format" command line option) to "git am" to alter the way it splits the
input into individual pieces of e-mail, named 0001, 0002, 0003, ..., and
leaves the total number of message in $dotest/last.

Currently we call "git-mailsplit" to do all of that; your new conditional
will take StGIT export, and instead of calling "git-mailsplit", read the
series file and process individual patch files into 0001, 0002,... that
are in proper mbox format (i.e. you would need to fix the "Subject: " less
title line when you do this), and leave the total number of patches in
$dotest/last file.

With that change, the main loop that iterates 'while test "$this" -le
"$last"' does not have to change, right?

We could for example add RMAIL format support in the same way.
