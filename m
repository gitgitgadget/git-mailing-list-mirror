From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/4] Documentation/notes: describe content of notes
Date: Tue, 04 May 2010 11:55:01 +0200
Message-ID: <201005041155.02192.johan@herland.net>
References: <20100503233604.GA27451@progeny.tock>
 <20100503234229.GC27483@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 11:55:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Er0-0000NA-Bc
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 11:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab0EDJzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 05:55:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47151 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab0EDJzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 05:55:43 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1W00ILJ3JRNF40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 04 May 2010 11:55:03 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 223071EA55BF_BDFEEF7B	for <git@vger.kernel.org>; Tue,
 04 May 2010 09:55:03 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F35C31EA3559_BDFEEF6F	for <git@vger.kernel.org>; Tue,
 04 May 2010 09:55:02 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1W00KZL3JQZY00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 04 May 2010 11:55:02 +0200 (MEST)
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <20100503234229.GC27483@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146307>

On Tuesday 04 May 2010, Jonathan Nieder wrote:
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-notes.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 0594776..273264b 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -27,6 +27,10 @@ By default, notes are saved to and read from
> `refs/notes/commits`, but this default can be overridden.  See the
> CONFIGURATION and ENVIRONMENT sections below.
> 
> +Notes can contain any sequence of non-null bytes.  Since they are
> +sanitized with linkgit:git-stripspace[1], empty lines other than a
> +single line separating paragraphs are not significant.

In principle, a note is a regular Git (blob) object, and can contain NUL 
bytes - indeed any kind of (non-)format is accepted.

However, the stripspace/text-based formatting kicks in when specifying the 
notes content with -m or -F, or when an editor is used to edit the notes.

So as long as you stick to the following subcommands, notes should be 
completely binary-safe:

- git notes [list [<object>]]
- git notes add [-f] -C <note-object> <object>
- git notes copy [-f] <from-object> <to-object>
- git notes show [<object>]
- git notes remove [<object>]
- git notes prune

In other words, you can (binary-safely) create notes from files with the 
following construct:

    git notes add -C $(git hash-object -w <file>) <object>

Of course, it doesn't make much sense displaying non-text-format notes with 
'git log', so if you use such notes you'll probably need to write some 
special-purpose tools for doing anything useful with them.

Otherwise, your other 3 patches seem fine to me (modulo Thomas Rast's 
comments) and you can consider them
Acked-by: Johan Herland <johan@herland.net>


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
