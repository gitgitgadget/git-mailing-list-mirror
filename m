From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: post-update hook
Date: Thu, 13 Nov 2008 11:48:52 -0700
Message-ID: <b9fd99020811131048p741cd9aqdcdf4cf410830915@mail.gmail.com>
References: <b9fd99020811130753o13c5aa0cj79126a502d449cde@mail.gmail.com>
	 <7v7i77h7tp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0hGb-0003rY-Lv
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 19:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYKMSsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 13:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYKMSsy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 13:48:54 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:32291 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYKMSsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 13:48:53 -0500
Received: by qw-out-2122.google.com with SMTP id 3so629631qwe.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hOL+lC+IuHPqRys+gJJYwvZrOKQR0MG+R6CSqggE6wI=;
        b=Y/29cN3jsxEd0p9v8UJ3osQdJukOmgdUuQ1d8f+b6DaSQtISqMSshMCdwTtwbgc33S
         /TAY+0RvHoUUnfaVq2QTryMOj5Yd6awXV3mrZmH7mkHnYYuvxin8fPGJwfmhnvZuJuqx
         4GTw2VJuyfAa8YeRi5NOx8q8O9g0H2s2UTjyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TIbulj4LwRxEJqOQ3fhIcxHSp11fSzVDGfqeFqA3ZlYFPn+WyIj8HAjpxTchQxn76y
         l0SxUlSKqSSSYfbnXOuKs+oIg5vtR8BSsvbnOZhTm5qjRR/Vr0ufC+jAZ0LJR6xxmYWO
         7Z0wWFSBhtK5sVs204H8Cs8ayIHCtOtQxsLSQ=
Received: by 10.215.100.1 with SMTP id c1mr133401qam.113.1226602132226;
        Thu, 13 Nov 2008 10:48:52 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Thu, 13 Nov 2008 10:48:52 -0800 (PST)
In-Reply-To: <7v7i77h7tp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100896>

On Thu, Nov 13, 2008 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jeremy Ramer" <jdramer@gmail.com> writes:
>
>> ...  I tried editting
>> the post-update hook as follows
>>
>> #!/bin/sh
>> echo Update changes...
>> git checkout master .
>>
>> but it does not seem to make any difference.
>
> By above do you mean you do not even see "Update changes...", or do you
> mean you do see that message but "checkout"  does not seem to do anything?
>
> I notice that you said you "tried _editing_"; did you also enable it?
>
> If you enabled it, you would see "Update changes..." but notice that "git
> checkout master" reports modifications.  Try adding "-f" between "checkout"
> and "master".

I did see the "Update changes..."  I enabled the post-update script. Sorry for
not being clear about that.

>> ...  Am I missing something
>> in the way post-update works?
>
> That, or in the way "checkout" works.
>
> By the way, this is one reason why pushing directly into the checked out
> branch of a non-bare repository is not optimal.  A recommended practice is
> to make the automation pretend as if you did a pull from the remote,
>
>> ...  It would be really nice to get this
>> working so I don't have to log into each remote and do a pull.
>
> without actually having to log into each remote and run "pull" there.
>
>  * Realize that if you did go to the remote and run "pull", then the
>   change from the local machine is copied (via the underlying "fetch"
>   that is run by "pull") in "remotes/origin/master", not to the branch
>   "master".  And then the result is merged.
>
>   IOW,
>
>        remote$ git pull
>
>   when fully spelled out, is:
>
>        remote$ git fetch local1 master:remotes/origin/master
>        remote$ git merge remotes/origin/master
>
>   That is, "master" branch tip from local1 goes to remote branch
>   "origin/master" at remote1, and it is merged to whatever is checked
>   out.

I thought I understood this process but I guess I didn't think it through
fully. What you are suggesting makes sense.

>
>  * Arrange that if you push from local1 to remote1, the above
>   automatically happens, in post-update hook.  So
>
>   (1) Do not push into 'master'; IOW, do not:
>
>        local1$ git push remote1 master:master ;# BAD
>
>       Instead, push into the remotes/origin/master, to mimic _as if you
>       fetched in the opposite direction_, like so:
>
>        local1$ git push remote1 master:refs/remotes/origin/master
>
>       Notice that this corresponds to what happens in the "git fetch"
>       phase if you pulled in the reverse.  So all the hook needs to do is
>       to merge.
>
>   (2) Arrange post-update on the remote end to run the merge, when a push
>       came to "origin/master", something like:
>
>        #!/bin/sh
>        case " $* " in
>        *' refs/remotes/origin/master '*)
>                cd .. ;# you would be in .git -- go to the root of tree
>                git merge refs/remotes/origin/master
>                ;;
>        esac
>
>        I didn't test this, though...

I had to make one change to this example to get it to work.  I'll put
it here for completeness

#!/bin/sh
case "$*" in
"refs/remotes/origin/master")
    cd ..
    GIT_DIR=".git"
    git merge refs/remotes/origin/master
    ;;
esac

>
> The advantage of doing it this way is that you can configure it so that it
> does not matter in which direction you actually work.  When you _do_ have
> to go to the remote side to get the changes from local (perhaps on some
> emergency that keeps you at remote), you can do a "git pull local" and you
> can expect that the exact same thing as what your post-update script
> ordinarily does happens.
>

Thanks for the quick response!
