From: John Szakmeister <john@szakmeister.net>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 17:37:45 -0400
Message-ID: <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeuFj-0008Lf-W5
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3EUVhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:37:47 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:51809 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3EUVhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:37:47 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so631184wes.12
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mLLnY3DxPf7VcGx/RPZIk7/xEQdmb/NnjgaP5fAed4M=;
        b=jYRK0F5/pquahAyIofFj6aPuNBZP1hQMAjqCkzP4RCGli2LsEwQMb++2+Q6ckwDF7V
         G5SU9qZJtxGXRFmEr139hp6X89ppaSO5FuUfzeCmKMlXQbHJM2tpmerLgKziRuVPdkAd
         u8jegrd8ZbgCYP2ak/icC4brLNz8NrOgNGTTND1ZTBcbB1glq0HDRU4iIE7ZUlcbEmN8
         gLuZxR1BEXJ/yCxrDcXiU7a8RyK8464O8VQBnUCMGnpYirM2XBdEMPIecwC8Ea5vPn7M
         HG2a0BLwU1G8WBXi6+uiruEKoiz1C4XTRAXp5HHlT0j4qefxmSqeaHge767ZBjqKsDdc
         QZGg==
X-Received: by 10.180.198.175 with SMTP id jd15mr8772965wic.28.1369172265870;
 Tue, 21 May 2013 14:37:45 -0700 (PDT)
Received: by 10.180.144.233 with HTTP; Tue, 21 May 2013 14:37:45 -0700 (PDT)
In-Reply-To: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
X-Google-Sender-Auth: qgyv3yzyoj__qIPkalTnZr749n0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225083>

On Tue, May 21, 2013 at 5:21 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
> Hello,
>
> I'm building a library to manipulate git repositories (interacting
> directly with the filesystem).
>
> Currently, we're trying to parse commit objects. After decompressing
> the contents of a commit object file we got the following output:
>
> commit 191
> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>
> first commit

Does `git cat-file -p <sha1>` show a tree object?  FWIW, I expected to
see a tree line there, so maybe this object was created without a
tree?  I also don't see a parent listed.

I did this on one of my repos:

>>> buf = open('.git/objects/cd/da219e4d7beceae55af73c44cb3c9e1ec56802', 'rb').read()
>>> import zlib
>>> zlib.decompress(buf)
'commit 246\x00tree 2abfe1a7bedb29672a223a5c5f266b7dc70a8d87\nparent
0636e7ff6b79470b0cd53ceacea88e7796f202ce\nauthor John Szakmeister
<john@szakmeister.net> 1369168481 -0400\ncommitter John Szakmeister
<john@szakmeister.net> 1369168481 -0400\n\nGot a file listing.\n'

So at least creating the commits with Git, I see a tree.  How was the
commit you're referencing created?  Perhaps something is wrong with
that process?

> We hoped to get the same output of a "git cat-file -p <sha1>", but
> that didn't happened. From a commit object, how can I find tree object
> hash of this commit?

I'd expect that too.

-John
