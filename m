From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 20:04:20 -0400
Message-ID: <l2vc376da901004221704l55f06952z4380c398783e5f9f@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock>
	 <87wrvzs590.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	 <87sk6n4426.fsf@frosties.localdomain>
	 <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
	 <x2l2cfc40321004221538qade3dd4dkc149f2748b94ef81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 02:04:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O56Nh-0004hj-0t
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 02:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab0DWAEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 20:04:23 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:51136 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0DWAEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 20:04:22 -0400
Received: by bwz25 with SMTP id 25so10359793bwz.28
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=Qk7CuLnjdbaACDo/jl5YEwQ3Ypl2ZUTthVNXp6vXLMY=;
        b=RKTSZomh9LTFqGNPsc1J3cP1hJOJbNSR/TrYE4/J87qen/G8V7T0OU1AJSuZMQ1LuW
         H23RoF3SORR/qVX83RAKTj+9r8RUqvlgbAX0CGfgzIAp9kYBJNABqZXF+iN9cMARfKDa
         KUF1ZrYdBHg1wVTel+S351dnpiEWq9jtLulY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=owef10FD50amrF5A4If0qHU2qpabL0GyM1t5RUgqwDYe5YQBhpNo8bmPDwuGD1D9pk
         cEV5dEAibkhmslubDW3Rxf5PIEAyf0O56ZAJ9mJxwoJ3+zoSF0fnutNj94Kr47bUOphS
         oIL0TEc14UvBx2wUd+gxrFAwobf4lFPI1oZmA=
Received: by 10.204.71.20 with HTTP; Thu, 22 Apr 2010 17:04:20 -0700 (PDT)
In-Reply-To: <x2l2cfc40321004221538qade3dd4dkc149f2748b94ef81@mail.gmail.com>
Received: by 10.204.3.147 with SMTP id 19mr2650987bkn.42.1271981060836; Thu, 
	22 Apr 2010 17:04:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145581>

>
> Perhaps I am missing something, but I would have thought git
> diff-files --quiet would be more useful in this context...
>
> jon.
>

Maybe so.  I really just meant to suggest that if you need something
more complicated than a simple git-command, you can put whatever you
want in a shell script and use it like an alias.

Then I learned that git aliases can be pretty fancy if they start with "!sh -c".

After looking at the man pages a bit more, I think "git diff --cached
--quiet" or "git diff-index --cached --quiet HEAD" are the right
condition.  git diff-files will compare the working copy to the index,
so this sequence

  vi file1
  vi file2
  git add file1
  git ci

would call commit -a, and I think that's wrong.

I also now realize that some use needs to be made of the arguments.
As I sent it the first time, "git ci -m whatever" doesn't work as it
should.  Adding "$@" to the git commit call doesn't work either
because it breaks "git ci filename" if there is no index (it calls
"git commit -a filename").
