From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: squashing patches
Date: Mon, 09 Jun 2008 08:10:01 -0700
Message-ID: <484D47C9.9050509@gnu.org>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5j1Z-0006gs-KE
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbYFIPKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 11:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754242AbYFIPKO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:10:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:30848 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbYFIPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:10:13 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1832527waf.23
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        bh=6Zo1iE7QNMV8lB2/0Z4v7GDu1nCutW2wtm8Bna5Gums=;
        b=G9YnjuJPDygJ9/dFik6OysNcNhQp5coSStD94+Za8HKILuSJFZ4haSjwmZoK7ERZlK
         GIgNJOywmtz15uS1WFhLI2iUBQ8bJXdCychrRqqjQnNQBqyS0/Iyxl9XpZKezGpWhqmF
         s/ebTDlv0dYT6Ew1887SSUD9HqXJbjpdenv5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender;
        b=r5zTX0NC6OShHyfYjSm3vRgIX1pc2P9wGaNZjYKEjraaCbjPXXec0ozF8UhvTDdg5j
         eebDg/3C1grXVOV5YwU9nD+zqazBFqwRVsfgYj7p5x8k6GeVybAONvEDb6qUv4+n1qsi
         OeRbhfMkPCN7CgL9i3R8OKNhcL073nLQiTYvg=
Received: by 10.114.108.15 with SMTP id g15mr3398907wac.181.1213024212645;
        Mon, 09 Jun 2008 08:10:12 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id y11sm14264472pod.5.2008.06.09.08.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 08:10:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20080609114550.GA8079@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84391>


> If you want to pick several commits and squash them together, there is
> "squash".  BUT there is no equivalent for "file" currently.
> The only way to squash several patches together is with an external tool
> like your favourite text editor, which is not fun but error-prone.
> And there is no way to squash a commit (in the repo) and a patch (as file)
> together (in exactly this order). The only thing is that you could run
> sequencer twice and squash in the second move.

My feedback is in the message from the "-s theirs" thread that I CCed 
you on.

Basic points:

1) I would like a "--strategy" option for cherry-pick and for the 
sequencer's "pick";

2) What about

   mark :1
   pick a
   file b
   pick c
   squash --up-to :1

or, to specify a commit message

   mark :1
   file a
   pick b
   squash --up-to :1 -C HEAD^

or also

   mark :1
   file a
   pick b
   squash --up-to :1 -C HEAD^ -s

to merge all signoffs.  This could be done by providing a stand-alone 
git-squash command; or alternatively, it could be done in the sequencer 
and the git-squash command would simply do

   (echo 'mark :1'
    git-rev-list --reverse $1.. | sed 's,^,pick '
    echo "squash --up-to :1 $*") | git-sequencer

after some option parsing.

3) I would like a totally batch mode-of-operation, which would fail if 
user intervention was needed (the user could choose whether to not edit 
the editor, or whether to use a no-op for GIT_EDITOR).

4) I think the sequencer is an opportunity to improve some commands, 
e.g. git-cherry-pick should grow more or less the same options as 
git-sequencer's pick.

Paolo
