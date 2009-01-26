From: Hannu Koivisto <azure@iki.fi>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Mon, 26 Jan 2009 18:15:01 +0200
Message-ID: <83skn6doxm.fsf@kalahari.s2.org>
References: <20090121210348.GD9088@mit.edu>
	<1232578668-2203-1-git-send-email-charles@hashpling.org>
	<7v1vuuvt11.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRU8a-00044M-2l
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZAZQPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbZAZQPM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:15:12 -0500
Received: from s2.org ([195.197.64.39]:39905 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbZAZQPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:15:11 -0500
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LRU74-0007Jw-Aw; Mon, 26 Jan 2009 18:15:02 +0200
In-Reply-To: <7v1vuuvt11.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 23 Jan 2009 09:20:10 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107222>

Junio C Hamano <gitster@pobox.com> writes:

> Charles Bailey <charles@hashpling.org> writes:
>
>> Previously, git mergetool used cat-file which does not perform git to
>> worktree conversion. This changes mergetool to use git checkout-index
>> instead which means that the temporary files used for mergetool use the
>> correct line endings for the platform.
>>
>> Signed-off-by: Charles Bailey <charles@hashpling.org>
>
> Sounds like the right thing to do and from a cursory review it looks Ok to
> me.
>
> But I do not use mergetool myself, so an Ack from Ted and a Thanks from
> whoever reported the breakage would be encouraging ;-).

I apologize for not being able to test this earlier and I'm
certainly thankful for the patch, although admittedly I reported
the issue mainly to help improve git, not because mergetool is part
of my normal use of git (that may change when I find time to study it
and see if I can easily add ediff support to it in addition to
emerge).

Now that I tried the patch, I observed that while the stage2 and
stage3 temporary files have CRLF line endings, the merge result
buffer/file has LF line endings.  I'm again using Cygwin git,
mergetool -t emerge and native Windows Emacs.  So when I quit the
mergetool, I get

...
Hit return to start merge resolution tool (emerge):
warning: LF will be replaced by CRLF in kala.txt
warning: LF will be replaced by CRLF in kala.txt

and indeed hexdump proves that the file in my worktree now has LF
line endings even though it had CRLF line endings before invoking
mergetool.

I wonder why I didn't notice this the first time.  I can certainly
reproduce it now without Charles' patch as well so I suppose this
is a separate issue and the patch does what it is supposed to do.

-- 
Hannu
