From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git diff-index --raw HEAD and git diff --raw HEAD output the same thing?
Date: Sun, 2 Mar 2008 14:07:18 +0800
Message-ID: <46dff0320803012207g450f7447h7266a059194709f0@mail.gmail.com>
References: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
	 <alpine.LSU.1.00.0803011320100.22527@racer.site>
	 <7vbq5xvfpk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 07:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhN1-0005WD-V0
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 07:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYCBGHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 01:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYCBGHU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 01:07:20 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:63439 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbYCBGHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 01:07:19 -0500
Received: by an-out-0708.google.com with SMTP id d31so1092047and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 22:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zhuRIeKZGF6sme1ozvVqdaCOFi0iPi3bjAdPEnvqozI=;
        b=PpVzO9sEtrDpeLVmPkGWat0Vz3MYg94C83cawgfIItT+WSYFmBJB5c9vddGZKDiBMomEhzyIFwqAEbpBHDyZE1/NwQvIIcDIh5nN3j3uflLKCZThWG/IKA4mVxJHcsZ81CV0sAFp1iGuu9Y3o2R9kG3EkijpYDZts+3K9Rnyjsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EDR4QUJoPj4hxuZ6n/INTC6WRlsQttArBfeoyjK/wIp6qj3YKnUWHKIwAw5kkLgylZhZKR4+ncQqH5ieTO7sIiBocKJNNElJCpkZSvvuPWkk+PbDHWRrTXjwijVosQlnAjioXSuj4cqHbIz2gnDrkUPvFl1arZnn5wmZq6aI4s0=
Received: by 10.100.136.15 with SMTP id j15mr25154828and.80.1204438038388;
        Sat, 01 Mar 2008 22:07:18 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 22:07:18 -0800 (PST)
In-Reply-To: <7vbq5xvfpk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75727>

On Sun, Mar 2, 2008 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>  > On Sat, 1 Mar 2008, Ping Yin wrote:
>  >
>  >> Strange things is this line
>  >> :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
>  >> 0000000000000000000000000000000000000000 M      commonmake
>  >>
>  >> why mod is 160000 while sha1 is 0000...
>  >
>  > This indicates that a submodule (160000) was deleted (00000).  It is
>  > easier not to handle a deletion as mode change...
>
>  Read the question again.
>
>  When you compare something with a work tree state, and when the work tree
>  state is dirty, we always show 0{40} to mean "it is dirty and we do not
>  know what the object name of that thing is, until you actuallly run
>  git-update-index (or git-add) it" (and at that point it would stop being
>  dirty).  For blobs (be it a regular file or a symbolic link), this has an
>  advantage of not having to run hash-object to obtain the object name of an
>  object that would be created if you actually did git-add it.
>
>  When we check if it is dirty, we already do an lstat(2) and know the type
>  of it, so we can show the mode bits.  So you will see 100644, 100755 or
>  120000 for blobs.  Similarly for a submodule.
>
>  For a submodule, we could read the value from $sub/.git/HEAD, but it is
>  more consistent to show 0{40} on the work tree side (typically the right
>  hand side, unless you use -R).
>
I should read the git-diff/git-diff-index man pages more carefully.  It says
"<sha1> is shown as all 0's if a file is new on the filesystem and it
is out of sync with the index"

But unlike git-diff-index, git-diff does the right thing for me

$ git diff --raw HEAD
:160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
c1f46b3f10cc041e196c388490ddb049dacc7dc0 M      commonmake

while git diff-index desn't

$ git diff-index --raw HEAD
:160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
0000000000000000000000000000000000000000 M      commonmake

Maybe the man page should clarify the different behaviour of git-diff.

I really want the real sha1 instead of 0{40} in my submodule summary
patch, or i have to use git-diff instead of git-diff-index

-- 
Ping Yin
