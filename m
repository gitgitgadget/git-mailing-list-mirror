From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C (updated)
Date: Thu, 29 Jun 2006 02:25:47 +0200
Message-ID: <20060629002547.GA27507@steel.home>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060627223249.GA8177@steel.home> <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 02:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvkMI-00066Y-NC
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 02:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWF2A0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 20:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWF2A0J
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 20:26:09 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:28623 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751842AbWF2A0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 20:26:08 -0400
Received: from fwd33.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1FvkM0-0003v0-00; Thu, 29 Jun 2006 02:25:56 +0200
Received: from tigra.home (ZekkTgZXgeV6XEFtL1rH9k0zhDCCFtyihc4j8N7zKUTJYHoTZxhKrK@[84.160.100.234]) by fwd33.sul.t-online.de
	with esmtp id 1FvkLs-1ZPR9U0; Thu, 29 Jun 2006 02:25:48 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6B9C9277B5;
	Thu, 29 Jun 2006 02:25:47 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FvkLr-0002Cl-3O; Thu, 29 Jun 2006 02:25:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-ID: ZekkTgZXgeV6XEFtL1rH9k0zhDCCFtyihc4j8N7zKUTJYHoTZxhKrK
X-TOI-MSGID: 663faa36-bc0f-4b64-8a49-8d115c2f6de7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22827>

Alex Riesen, Wed, Jun 28, 2006 11:34:23 +0200:
> >> > - use a pipe to "git-update-index --index-info" instead of
> >> > using command line
> 
> ...and to take it a step further, a patch (0002) to avoid too many calls to
> git-write-tree and to git-update-index. Brought merge times on my test
> monster (~25k files) down to 2min 30sec (from something around 11 min).

this broke t6022-merge-rename.sh (the second test). It produces an
index with this:

.../t/trash$ git-diff-index white
:100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B
:100644 100644 ba41fb96393979b22691106b06bf5231eab57b85 0000000000000000000000000000000000000000 M      N

whereas git-merge-recursive (and the previous version, without pipe):

.../t/trash$ git-diff-index white
:100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B

I can see that "git update-index --add" is somehow different from a
pipe to "git update-index --index-info", but not very clear. Does this
"zero-sha1" mean that the file "N" is not in the index?
