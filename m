From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 03:59:12 -0400
Message-ID: <32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Asger Ottar Alstrup <asger@area9.dk>
X-From: git-owner@vger.kernel.org Mon May 25 09:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8V5w-0006rp-Bp
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbZEYH7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZEYH7b
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:59:31 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:41734 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZEYH7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:59:30 -0400
Received: by gxk10 with SMTP id 10so5369727gxk.13
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m7DNKMtJE1qTeZiLD5oHj3quZipYzzbXV6UIKoOGTAg=;
        b=NwvVvCl4JMYXctyjN9t8006MxorO/Mik76I5DprkCQwNVL+TFh0yLQL/rQtXljZaJo
         CG/KMBbvuZNr3NfkL3/Gzm+lYzGFnLW9oJfJpo3mC08nHS/C3nCumN7wwQ8806gSryso
         /g8g8KgWqS834Uy0lqEbBfguD3Bl+Hy8tDy5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dQAEJCqp6TbOzfu000cFBJLyRBgY4j6F30XjGX3TZMxYzmreynrXdI4KolrKjO9PBK
         hcjiypaOreDhuPd94BdIcyfBD6PcLJNkGbZIya2MmuCVkr1WB0dSxnOe/8cIdBcO/QPj
         kg1Et7VYDlAqfzueJNpV2+u28H7T1PVzLpQyU=
Received: by 10.151.131.3 with SMTP id i3mr13634988ybn.206.1243238372053; Mon, 
	25 May 2009 00:59:32 -0700 (PDT)
In-Reply-To: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119899>

On Mon, May 25, 2009 at 3:21 AM, Asger Ottar Alstrup <asger@area9.dk> wrote:
> I am considering different ways to get git to handle repositories with very
> big files in a setup where partial clone is required, and it seems git
> subtree might be a part of the solution.

Well, that wasn't really what it was originally made for... but perhaps.

> Does git subtree support splitting at the file level, or only at directory
> level?

Currently only at the directory level.  In theory, there's nothing
stopping us from working with any subset of files... but it's really
much simpler this way (both to code and to explain) so I'd much rather
leave it as is.  Can you reorganize your tree so that you divide the
needed files into different subdirectories?

> Also, how are conflicts handled when you subtree merge changes back
> to the master?

'git subtree split' generates a new commit history on top of the *most
recently merged* commit from the subproject.  To merge back into the
subproject, you would take that newly-generated commit and do the
usual "git merge".  (ie. you'll have to check out the branch and merge
it as usual)

Alternatively, you could 'git subtree pull' the subproject first,
resolve the conflicts there, and  'git subtree split' after that; in
such a case, the newly-generated commit would be a fast-forward from
the original subproject's HEAD, so it would be okay to push right away
without switching branches first.

(Someone else suggested that we add a 'git subtree push' command to
make the split-then-push sequence nice and obvious; I think that's a
good idea and pretty easy.)

> Can the
> reduced split repositories reuse pack files from the original repository?

Yes, all the tree and blob objects are identical between the two
repositories (except that the superproject has more of them, of
course).

Have fun,

Avery
