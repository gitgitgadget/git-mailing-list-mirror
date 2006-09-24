From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 24 Sep 2006 18:56:07 +0200
Message-ID: <4516B8A7.6010007@lsrfire.ath.cx>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 18:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXH6-00084h-Ce
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 18:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWIXQ4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 12:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIXQ4M
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 12:56:12 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34693
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751146AbWIXQ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 12:56:11 -0400
Received: from [10.0.1.3] (p508E7663.dip.t-dialin.net [80.142.118.99])
	by neapel230.server4you.de (Postfix) with ESMTP id 2A8DD36082;
	Sun, 24 Sep 2006 18:56:10 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27676>

Junio C Hamano schrieb:
>  - We should deprecate git-tar-tree.  However, it has been
>    around and advertised for quite some time, so we need to make
>    sure people would not get burned too badly.  It might be
>    worthwhile to rewrite git-tar-tree as a thin wrapper to
>    "git-archive --format=3Dtar" and remove git-upload-tar now (in
>    other words, "git-tar-tree --remote" will continue to work,
>    but it will talk with "git-upload-archive", not with
>    "git-upload-tar" on the other end), release 1.4.3 with it
>    with a deprecation warning, and then remove it in 1.4.5.

Hmm.  The local case in git-tar-tree is already a thin wrapper.
How about something like this shell script as a replacement for
the entire command?

Ren=E9

--- snip! --
#!/bin/sh
#
# Copyright (C) 2006 Rene Scharfe

USAGE=3D'[--remote=3D<repo>] <tree-ish> [basedir]'
=2E git-sh-setup

case "$1" in
--remote=3D*)	remote=3D1;;
*)		remote=3D0;;
esac

case "$#,$remote" in
1,0)	exec git-archive --format=3Dtar                     "$1";;
2,0)	exec git-archive --format=3Dtar --prefix=3D"$2"/      "$1";;
2,1)	exec git-archive --format=3Dtar                "$1" "$2";;
3,1)	exec git-archive --format=3Dtar --prefix=3D"$3"/ "$1" "$2";;
*)	usage;;
esac
