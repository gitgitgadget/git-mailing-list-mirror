From: Ciaran <ciaranj@gmail.com>
Subject: Re: [PATCH RFC] Test for apparent regression of merging renamed files
Date: Tue, 3 May 2011 20:15:33 +0100
Message-ID: <BANLkTin6u8e4-x99JgN-D7FFJbO7pXVp-Q@mail.gmail.com>
References: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, newren@gmail.com,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:15:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHL4P-0003sw-LH
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 21:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab1ECTPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 15:15:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39187 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1ECTPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 15:15:33 -0400
Received: by pwi15 with SMTP id 15so188021pwi.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=ENClDDPR+pDzovOVBl6QccjgLJDJNULydVg0alqqj1A=;
        b=Va5YMRWBV7orruqMEwDXf5JLCGRIBuhzZn6B+feDbz47YKIOBk38SJ/OmNdvun2ZGu
         G4o7+iReeXjV8P/keqc9BAYFslSxJePGV/mR6fXjpNpUkYoIXXSgqoKGCwGhl5Ka054C
         u3Nos1da5vKrrNVZy4E6eLeygYMM+XHWvJG0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=vhf007TZGe4F/n5hmnrICPw6IbB9iAYzswamMBke+aaBZO/ry3/qnEsn7TBwcFTgFL
         0NvG/4r1nTF4V0Hjk5FGkPaRdsbUJWL2lm6gQRuIphZTFBTm3SU50Fl0WIKm3W2Q4MiN
         JWu5n7ygRhdWBhs0kxFrrJ4MScLwsGUW9wWME=
Received: by 10.68.0.7 with SMTP id 7mr295860pba.188.1304450133147; Tue, 03
 May 2011 12:15:33 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Tue, 3 May 2011 12:15:33 -0700 (PDT)
In-Reply-To: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172685>

On Mon, May 2, 2011 at 8:04 PM, Ciaran <ciaranj@gmail.com> wrote:
> Provides a test to cover a case that appears to have been regressed o=
ut by:
>
> =A0b2c8c0a762745768e8fb249949801c1aed8f7c1d
>
> At this point no tags contain the above commit, but 'master' does. =A0=
I'm unsure
> what is causing the issue, but can see discussion about this fix here=
:
>
> http://git.661346.n2.nabble.com/BUG-merge-recursive-triggered-quot-BU=
G-quot-td6179353.html
>
> Providing a patch to demonstrate the issue and spark discussion.

Hmm I think with hindsight I should've been clearer ;)   The current
master branch appears to contain a break in it, seemingly introduced
by commit b2c8c0a . The rename & merge situation given in the
associated test results in output from git status such as :

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	deleted:    formatting.txt
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      formatting_renamed.txt
#

Whereas prior to b2c8c0a762745768e8fb249949801c1aed8f7c1d (for example
@ d98a509ec3e9ff22bb642f778900691d0c715ba9 ) the status was:

# On branch master
nothing to commit (working directory clean)

And git log --oneline -1 says :

e03ad75 Merge branch 'rename_branch'

The original behaviour (successful merge) seems 'better' than the
current behaviour 'failed merge, 'erroneous' both modified flag' ...
am I mis-reading this, is this a new non-supported edge case ?

Cheers!
 -cJ.



> ---
> Whilst working up a patch for my 'whitespace ignorant rename
> detection' ( http://git.661346.n2.nabble.com/PATCH-RFC-Rename-detecti=
on-and-whitespace-td6288524.html
> ) I was unable to get my tests working, turns out that something that
> used to work for me, no longer does in master's HEAD.
>
> I don't really understand the fault so I'm throwing it to the list in
> the hope that someone brighter than me can take it on (I've
> CC'd the signoff-s to that end! :) Sorry!
>
> =A0t/t9801-merge-rename.sh | =A0 41 +++++++++++++++++++++++++++++++++=
++++++++
> =A01 files changed, 41 insertions(+), 0 deletions(-)
> =A0create mode 100755 t/t9801-merge-rename.sh
>
> diff --git a/t/t9801-merge-rename.sh b/t/t9801-merge-rename.sh
> new file mode 100755
> index 0000000..363911f
> --- /dev/null
> +++ b/t/t9801-merge-rename.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description=3D'Test for rename merge regression'
> +
> +. ./test-lib.sh
> +
> +write_out_files() {
> +cat > noformatting.txt << EOF
> +if(true){
> +// Meaningless
> +}
> +EOF
> +
> +cat > formatting.txt << EOF
> + =A0 =A0 =A0 if ( true ) {
> + =A0 =A0 =A0 =A0 // Meaningless
> + =A0 =A0 =A0 }
> +EOF
> +}
> +
> +# Test the case where a rename happens in one branch and
> +# a whitespace change occurs in a different branch. =A0The rename
> +# change should apply to the whitespace modified file
> +test_expect_success setup '
> + =A0 =A0 =A0 write_out_files &&
> + =A0 =A0 =A0 git add formatting.txt &&
> +
> + =A0 =A0 =A0 test_tick &&
> + =A0 =A0 =A0 git commit -m Initial &&
> + =A0 =A0 =A0 git checkout -b rename_branch &&
> + =A0 =A0 =A0 git mv formatting.txt formatting_renamed.txt &&
> + =A0 =A0 =A0 git commit -m Rename &&
> + =A0 =A0 =A0 git checkout master &&
> + =A0 =A0 =A0 rm formatting.txt &&
> + =A0 =A0 =A0 mv noformatting.txt formatting.txt &&
> + =A0 =A0 =A0 git commit -a -m Reformat
> +'
> +test_expect_success 'merge' '
> + =A0 =A0 =A0 git merge rename_branch
> +'
> +test_done
> --
> 1.7.4.1
>
