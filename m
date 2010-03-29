From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Mon, 29 Mar 2010 16:14:09 -0400
Message-ID: <32541b131003291314r2f5a77e8g28e79b5983821e41@mail.gmail.com>
References: <20100329133132.GA12201@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Mar 29 22:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwLM9-00085y-L6
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0C2UOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 16:14:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64108 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0C2UOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 16:14:30 -0400
Received: by gwaa18 with SMTP id a18so4267798gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3POjKKwRlG+he9GEMXom3f9hUU1sC3wBRgi2bgih1Vc=;
        b=CrGaX+D+z7qDvJGcbxve8/c5eRwGmrjrowmzFi2vu7tXmm8uQMvX1oy/NKhrDLdH0y
         7z0Rs42tOCcF3WlxH+Ac9sbP37rzxF0NSGXsdX5sJGvPmnWgIznrS6OcZ4DMCEiFGZ4Y
         A5oW7+2UIoWo/vYb2dKhu5DAtfQnnfJsr0uCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jdLC78JKvyFl/vSgxAD3kv5+ZfCvzgPa9yRLl1Ufx8wBvf5RW9TpSpabJ5OuVOvwk3
         N2qsb0sVoab0Y/K/A8j0X7eyOfENypuKmUPzMct8Pmi4c9zjJU2lrzT2UKzrOtOG/h0Q
         Azj8T5Vx3PPm1IOjrS4Gw7pew8w37OIwwbEgw=
Received: by 10.150.203.4 with HTTP; Mon, 29 Mar 2010 13:14:09 -0700 (PDT)
In-Reply-To: <20100329133132.GA12201@thyrsus.com>
Received: by 10.150.180.12 with SMTP id c12mr5209313ybf.144.1269893669159; 
	Mon, 29 Mar 2010 13:14:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143513>

On Mon, Mar 29, 2010 at 9:31 AM, Eric Raymond <esr@thyrsus.com> wrote:
> My editcomment script, as it exists, has a technical problem...the
> editor needs to be something like emacsclient that actually invokes i=
n
> a different X window, otherwise whatever it writes to stdout will end
> up stuffed in the comment along with the text I actually wanted to pu=
t
> there. =A0The underlying problem is that git-filter-branch is sort of=
 a
> nuclear-powered chainsaw - gets the job done, but in a way that is
> prone to messy side effects. =A0A more elegant implementation would
> probably need to tie deeper into the plumbing.

It ought to be easy to work around this; simply extract the log
message *before* filter-branch using something like

       git cat-file commit HEAD | tail -n +6 >msg.tmp

(I'm sure someone will correct me by providing a less revolting way to
extract the commit message, but it's somehow not coming to me right
now.)

Then launch $EDITOR to edit the message, then inside the
filter-branch, just use that file instead of launching the editor.

Alternatively, in case you want the option of editing *multiple*
commit messages at once, you could just redirect stdin/stdout to
/dev/tty.

A further option would be to extend git-rebase--interactive.sh (yes,
it's just a shell script) to take an option that makes a given commit
(or commits) 'reword' by default instead of 'pick'.  And maybe another
option to make git-rebase--interactive.sh not actually pop up an
editor before it starts running.  Then your editcommit script could
just be a thin wrapper around rebase with those options.

<insert obligatory wistful reference to git-sequencer> (I don't
actually know anything about git-sequencer.)

Have fun,

Avery
