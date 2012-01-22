From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: [RFC/PATCH git-remote-bzr] Adapt to new semantics of remote-helper
 "import" command
Date: Mon, 23 Jan 2012 00:35:40 +0100
Message-ID: <4F1C9D4C.6090603@samba.org>
References: <20120122054657.GA25103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org,
	Simon Poirier <spoirier@rlnx.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 00:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp6wv-0003xp-6k
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 00:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2AVXfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 18:35:45 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4866 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab2AVXfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 18:35:44 -0500
Received: from [192.168.178.23] (a83-163-205-244.adsl.xs4all.nl [83.163.205.244])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id q0MNZeqv077445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jan 2012 00:35:40 +0100 (CET)
	(envelope-from jelmer@samba.org)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120119 Thunderbird/10.0
In-Reply-To: <20120122054657.GA25103@burratino>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188974>

On 01/22/2012 06:46 AM, Jonathan Nieder wrote:
> Git 1.7.7 (commit 9504bc9d, "transport-helper: change import
> semantics", 2011-07-16) incompatibly changed the interface of the
> "import" capability.
>
> Before, git would always send a single import command, which the
> remote helper would respond to with a fast-import stream, terminated
> by end of file, meaning there was no way to fetch multiple refs in one
> connection.  Nowadays, git instead sends a sequence of import lines:
>
> 	import refs/heads/foo
> 	import refs/heads/bar
>
> terminated by a blank line.  The helper is to respond with a
> fast-import stream terminated by the "done" command and process
> further commands until another blank line indicates the end of the
> command stream.
> ---
> Hi Simon and Gabriel,
>
> Here's a rough patch against git://github.com/lelutin/git-remote-bzr.git
> master.
>
> Without this patch, whenever I try to use "git clone bzr::<something>",
> after doing all the work it removes the resulting repo and exits with
> status 141 (SIGPIPE).  Maybe the transport-helper should mask SIGPIPE
> when writing the final newline to avoid that.
>
> I'd have prefered to write a patch for remote-bzr that works with
> older versions of git fast-import, too, but it wasn't obvious how.
> Hints welcome.
>
> BTW, would you mind if I sent a patch to include git-remote-bzr in
> git.git under contrib/?
Please note that the bzr-git package, which provides git integration for 
bzr and vice versa, also includes a 'git-remote-bzr' command. Apart from 
the 'import' command, it includes experimental implementations of 
'fetch' and push as well.

It would be nice to consolidate the efforts, or at the very least 
prevent name clashes.

Cheers,

Jelmer
