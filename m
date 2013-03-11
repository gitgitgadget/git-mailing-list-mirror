From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Mon, 11 Mar 2013 18:05:49 +0100
Message-ID: <20130311170542.GB4167@sandbox-ub.fritz.box>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF6B5-0000F1-Te
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab3CKRF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:05:58 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:47468 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3CKRF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:05:57 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UF6AY-0005nl-4p; Mon, 11 Mar 2013 18:05:50 +0100
Content-Disposition: inline
In-Reply-To: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217892>

On Mon, Mar 11, 2013 at 01:47:03AM +0530, Ramkumar Ramachandra wrote:
> git operations are slow on repositories with lots of files, and lots
> of tiny filesystem calls like lstat(), getdents(), open() are
> reposible for this.  On the linux-2.6 repository, for instance, the
> numbers for "git status" look like this:
> 
>   top syscalls sorted     top syscalls sorted
>   by acc. time            by number
>   ----------------------------------------------
>   0.401906 40950 lstat    0.401906 40950 lstat
>   0.190484 5343 getdents  0.150055 5374 open
>   0.150055 5374 open      0.190484 5343 getdents
>   0.074843 2806 close     0.074843 2806 close
>   0.003216 157 read       0.003216 157 read
> 
> To solve this problem, we propose to build a daemon which will watch
> the filesystem using inotify and report batched up events over a UNIX
> socket.  Since inotify is Linux-only, we have to leave open the
> possibility of writing similar daemons for other platforms.
> Everything will continue to work as before if there is no helper
> present.

While talking about platform independence. How about Windows? AFAIK
there are no file based sockets. How about using shared memory, thats
available, instead? It would greatly reduce the needed porting effort.

Since operations on a lot of files is especially expensive on Windows it
is one of the platforms that would profit the most from such a daemon.

Cheers Heiko
