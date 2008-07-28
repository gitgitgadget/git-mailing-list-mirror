From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 16:54:17 +0200
Message-ID: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 16:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNU8Z-0000FQ-8f
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 16:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002AbYG1OyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756566AbYG1OyT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 10:54:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:35150 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbYG1OyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 10:54:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5778924wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=xb64rHoImwCa3Ywtc61clWsFKhZHZIpvLul18zoZ6ZA=;
        b=ZBTKBQCZvSZUA8f/XIWbmBOfmVt67qWiZ0K6xFOAt09PRYZKjQUk9rIH4y4eYAWG7i
         h/nv6jCA8jJE469IQr3XWezCmrEXTpusP4HKOR89wPCqIczxaCUd7AaR8gOlkq7rziJR
         dJblOGYdfatOepmi/Z46m8kbOFiq8zFgCIKG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition;
        b=NFpJo0FQbSbCi2TiJqFRM3nJI+TcDjtRlKlPPyGhBt4QAaSHw22UQjhdahWO1MB0Zv
         Urt7/l1gheyUUQpwSxOGf1AD+gK/yocnr1g8xNLudU1UnxhFYMtu9tkcDT+h/s6jYzsc
         ZDil0T9Je/qCoxxKZeownPeiaZybeEFkBo/1A=
Received: by 10.142.201.3 with SMTP id y3mr1619235wff.279.1217256857270;
        Mon, 28 Jul 2008 07:54:17 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 07:54:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90463>

On Mon, Jul 28, 2008 at 15:12, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Note that what was asked for, and what Junio implemented before deciding
> that it would do more harm than good in git.git, is not the same as what
> you provide.
>
> Your -theirs is a strict opposite of -ours, i.e. the tree after the
> merge will be identical to the "merged" branch's tip's.

I've been wanting to mail about this for a few days now, but didn't
really know how to bring it up, this seems a good opportunity.

It has happened a few times on #git already that someone asked for the
merge strategies described above (e.g., _not_ the insane ones) for
what I deemed to be valid use cases. (The main reason was that they
wanted to merge with a conflicting branch, discarding the current
master, but still allowing people to 'git pull'.)

I was wondering what to tell those people? Will there ever be such a
version of 'merge theirs' (that is the strict opposite of 'ours')? Or
should they do:

$git checkout otherbranch
$git merge -s ours master
$git checkout master
$git merge otherbranch

Thus resulting in a 'wrong way around' merge as part of master? It
would say "Merge branch 'master' into otherbranch", while what
happened was "Merge branch 'otherbranch' into master".

So, in short: what does the list think about adding
"git-merge-theirs", that does (although possibly less 'hackish'):

cat > git-merge-theirs << EOF
#!/bin/sh
eval git read-tree --reset -u \\\$\$#
EOF

-- 
Cheers,

Sverre Rabbelier
