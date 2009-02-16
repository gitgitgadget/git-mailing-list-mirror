From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Cloning into an existing directory
Date: Mon, 16 Feb 2009 08:13:12 -0800
Message-ID: <e38bce640902160813u2771d55co3eb583a0922c09c5@mail.gmail.com>
References: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
	 <c1b8b6670902152331p9bbdb8fo7bf7048039b5301c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ67s-0007KS-Ia
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbZBPQNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZBPQNQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:13:16 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:32732 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbZBPQNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:13:14 -0500
Received: by yx-out-2324.google.com with SMTP id 8so965346yxm.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8v1Q0c5WapbGtVk0CP9CrwpuX9k/blcXe40o/pk/pKY=;
        b=EgsBSzOzO6+3Vx8Q0YQIX2srQKB3k34NkNRm+tsDXcQaMrWybB/k4aReOz4FbUnabw
         G5hKUJmo0op33PxRf2Fp5oJn4swdqPQkBDYo9NjuhF1qDd2/IdYhmPiIc7tYox/8IC41
         zpqUekc5wLC+zv6ATUsIJiSY0vBmHYZElby9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwnQe8DC8CyMO0Ec0eLYhyvhj0OpnLLg34XehIQuYBg2ziz26RIBupRGiovGFqAVCF
         SevZ5rjfUss+gIB4sLB7Gf3hVZt+3DvAM2KcNsezYOOYiIJYu1v0HRmhgIRZXlGs+sfb
         x9Hs2y2uUPZowSewgcWzGkgpGt94InsD665zI=
Received: by 10.90.63.6 with SMTP id l6mr3061292aga.39.1234800792817; Mon, 16 
	Feb 2009 08:13:12 -0800 (PST)
In-Reply-To: <c1b8b6670902152331p9bbdb8fo7bf7048039b5301c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110199>

Thanks very much for the advice, Russell.

I did a test by creating the small repo with one file in it, .bashrc
and got to the point of the git-fetch. That git-fetch did not complain
about the pre-existing .bashrc file. Should it, or is the design of
git-fetch to alter the state inside the .git area only and not the
working tree?  The scan of the user manual and the git-fetch man page
does not seem to clarify the effect (none?) that git-fetch has on the
working tree.

Now, I see that you said it would complain upon checkout, which it did:

$ git checkout master
error: Untracked working tree file '.bashrc' would be overwritten by merge.

Fair enough: git is doing the right thing here and not overwriting the
target file since it is not yet git-controlled.   Given that I may
have many files, my naive way of fixing that is to

1. Move aside each file it complains about
2. Run the git-checkout command again
3. Move each file back to their original names, thus creating a local
edit w.r.t. git
4. Run git diff to see those changes, making additional edits
5. Finally, check in the result

To side-step writing my own wrapper script around git, is there a
command-line option to do steps 1 through 3, but not 4 and 5?

Thanks again for your help,
bg


On Sun, Feb 15, 2009 at 11:31 PM, Russell Steicke
<russellsteicke@gmail.com> wrote:
> On 2/16/09, Brent Goodrick <bgoodr@gmail.com> wrote:
>> Hi,
>>
>>  I would like to manage my startup scripts such as .bashrc and other
>>  setup files relative to my HOME directory using Git. However,
>>  git-clone disallows cloning into the existing "." directory, but only
>>  allows cloning into a subdirectory that does not yet exist.  If my
>>  home directory is /home/brentg and my remote repository is on
>>  remote_machine:~brentg/my_setup.git then git clone in my home
>>  directory on the local machine creates /home/brentg/my_setup with
>>  files such as .bashrc inside it, which is not what I want. I want them
>>  checked out and managed _in_ the current working directory, and not to
>>  mess with other files or directories that already exist that are never
>>  to be managed by git.
>
> cd
> git init
> git remote add origin remote_machine:~brentg/my_setup.git
> git fetch
> git branch master origin/master
> git checkout master
>
> You may have to delete .bashrc and others before git will overwrite
> them on checkout.
>
>
>
> --
> Virus found in this message.
>
