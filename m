From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Wed, 13 May 2009 00:43:33 +0800
Message-ID: <46dff0320905120943j303ef104ve7bad25f1874007f@mail.gmail.com>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
	 <20090512160749.GA29566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 12 18:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3v50-00030a-3o
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbZELQng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZELQng
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:43:36 -0400
Received: from mail-gx0-f159.google.com ([209.85.217.159]:40635 "EHLO
	mail-gx0-f159.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZELQnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 12:43:35 -0400
X-Greylist: delayed 7684 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 12:43:35 EDT
Received: by gxk3 with SMTP id 3so157825gxk.17
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qic1q92M5WkMy4PEw1Jj0ylmdL6fGu9vTsfPp7pbESQ=;
        b=IJVcicruEuNfacHnk++RRCikOBgdBED3Zwq2WbRiwfYpsbk3RPQkl5Xuf6lrQii8jV
         4YIysHUuQO1wdGn9TY8pg1+M4QAuI3HYqUzPHDZe0Tx2OoofrWn5glkeqcTABpb4w9u9
         vtztytHYHtwU2cf+/kISwt4BP5eSZ69oYayr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J6WpXSfp2LEnUh31HMg64YYckpNrQ2iKMIxVR/L/z6CreYMWt/gdeyt/mFzpkAVgzd
         BrhgPiCbN4Sxbk4ZSpgdNjJVjVEMTulqnTVb+dPoPlWSNJqKOqO3ZUkXJaqsUEHX9J8e
         zPx8NT9wAa9PEraAJbu9jdRZ69l9fk++5Vakc=
Received: by 10.90.69.15 with SMTP id r15mr7317542aga.90.1242146615404; Tue, 
	12 May 2009 09:43:35 -0700 (PDT)
In-Reply-To: <20090512160749.GA29566@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118924>

On Wed, May 13, 2009 at 12:07 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 12, 2009 at 10:35:30PM +0800, Ping Yin wrote:
>
>> a----b
>> =C2=A0\----c
>>
>> Given the graph above, I want to create a commit b1 on top of c, whe=
re
>> b1 and b have the same content. i.e.
>>
>> a----b
>> =C2=A0\----c----b1 =C2=A0 =C2=A0( content(b) =3D=3D content(b1) )
>>
>> If there are no untracked files in the working directory, i can do
>>
>> git checkout b
>> git reset c
>> git add .
>> git commit -m "the copy of b"
>>
>> Is there any simpler way? And if there are untracked files in the
>> working directory, how to do it?
>
> You can just munge the index directly, and skip the working tree
> entirely:
>
> =C2=A0rm .git/index
> =C2=A0git read-tree b
> =C2=A0git commit -m 'the copy of b'

In a non-conflict status, "git read-tree b" will update the index to
full match the tree of b, so "rm .git/index" is unnecessary, right?


> You can also do it without even touching the index by using the commi=
t
> plumbing:
>
> =C2=A0echo 'copy of b' >message
> =C2=A0tree=3D`git rev-parse b^{tree}`
> =C2=A0commit=3D`git commit-tree $tree -p c <message`
> =C2=A0git update-ref c $commit

Nice solution. Thank you and thank so powerful git!

Maybe a -c option can be added to git-commit-tree?
