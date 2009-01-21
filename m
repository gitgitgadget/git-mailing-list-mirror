From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Added giteditor script to show diff while editing commit
 message.
Date: Wed, 21 Jan 2009 17:33:45 -0500
Message-ID: <4977A2C9.1070502@tedpavlic.com>
References: <1232570841-25641-1-git-send-email-ted@tedpavlic.com> <alpine.DEB.1.00.0901212216310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:35:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlfI-0002fi-91
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbZAUWdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZAUWdu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:33:50 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:54302 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277AbZAUWdu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 17:33:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 63EE980D8054;
	Wed, 21 Jan 2009 17:27:52 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p-JtlPdUJZd5; Wed, 21 Jan 2009 17:27:52 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4358680D8051;
	Wed, 21 Jan 2009 17:27:52 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <alpine.DEB.1.00.0901212216310.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106690>

Thanks for your comments. I've responded below. I just want to 
top-respond to your comment that the fundamental problem is that the 
diff is in a separate file. In fact, this is the point of the script. I 
want to be able to scroll through the diff output independent of the 
commit message.

(alternatively, I realize I could do "git commit -v" and then use my 
editor's "split window" support, but that wouldn't help me with "stg edit")

> the subject could use some work.  For example, I would prefix it with
...
>> From: Ted Pavlic<ted@tedpavlic.com>
>
> As this is exactly what your email said in its header, it is redundant
> information.  Worse, it is information that made me look back to know why
> it needs to be there.  Distracting.

I add --from to my gitsend alias to prevent git send-email from 
prompting me for a "From". Is there a way to have git send-email simply 
not prompt me for "From"?

> What information does the README add that is not in the script itself?
> If there is none, please refrain from adding the README to begin with.

OK. I noticed plenty of other not-very-useful READMEs in contrib/, and 
so I figured it was a pro forma file.

>> +# Find git
>> +[ -z "${GIT}" ]&&  GIT="git"
> Yes, I know it is contrib/, but you may want to adopt Git's coding style
> early.

Ok. Switching to test.

> Besides, I find it funny that you want to override git with $GIT.

Isn't it possible that someone has git somewhere else?

>> +# If we recognize a popular editor, add necessary flags
>> +case "${EDITOR}" in
>> +    emacs)
>> +        EDITOR="${EDITOR} -nw"
>
> Mhm.  Should this not be the user's choice?  Some like emacs to start up
> in a window.

I don't use emacs, but it was my impression that the "no window" flag 
was added to make sure that emacs doesn't fork. That's why "-f" is used 
in the vim line.

>> +# End GITTMP in ".git" so that "*.git/" syntax highlighting recognition
>> +# doesn't break
>> +GITTMP="${TMPDIR-/tmp}/giteditor.$RANDOM.$RANDOM.$RANDOM.$$.git"
>> +(umask 077&&  mkdir "${GITTMP}") || {
>> +    echo "Could not create temporary directory! Exiting." 1>&2
>> +    exit 1
>> +}
>
> Umm.  Why?  Why do you need a temporary .git directory?

The script generates a new "diff" file that I would rather drop 
elsewhere (e.g., in a /tmp directory) rather than here in the current 
directory.

However, maybe you're right. After all, stg drops ".stgit-edit.txt" in 
the working directory. I suppose I could use gitdir, but I wasn't sure 
if it was safe to pollute gitdir.

In the next version, I'll get rid of the temp directory and put the file 
here.

>> +    # Diff is non-empty, so edit msg and diff
>> +    ${EDITOR} "${GITTMP}/${COMMITMSG}" "${GITTMP}/diff" || exit $?
>
> vi users will hate you, as you do not give them a chance to edit the
> message after having seen the diff.

I don't see what you mean. I am a vi user (exclusively), and this script 
works very well for me.

The "-f -o" flags above ensure that gvim will not fork. I'll add "vi" to 
the search string that automatically add "-f -o". Will that satisfy you?

At the moment, giteditor works exactly like EDITOR (or VISUAL) for me, 
but it opens up a second buffer (split in the bottom window in my case) 
with the diff in it. I'm given the opportunity to save.

> git commit will abort anyway if the commit message has not changed.  Plus,
> it does a better job, as it checks only the non-commented-out text.

Okay. Using $1 exclusively.

> BTW why on earth do you put every single variable name in curly brackets?

I always thought that was good practice. It prevents ambiguity, and *I* 
don't think it's an eyesore.

> Besides all that criticism, there is also a fundamental issue.  The diff
> is in a separate file.

That's the point. If I wanted to put the diff in the commit buffer, I 
would have used "git commit -v". I think many would like to be able to 
scroll through the diff without having to scroll through the commit.

Is there no value in having the diff in a separate file?

Thanks --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
