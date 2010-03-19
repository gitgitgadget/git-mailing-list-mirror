From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 17:30:09 -0400
Message-ID: <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 22:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjmB-0001Xn-IV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0CSVab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:30:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50744 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0CSVaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 17:30:30 -0400
Received: by gwaa18 with SMTP id a18so15693gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=w4zPat3RB8M9uU8Hqx9Xknt5tOOb8WIWIGl7c23wndQ=;
        b=SmgCO1uQre5oDFkchsk1yuhdmhjVLT6xnz2lPLcoGAetcnPPEgQ6ekOB24XydSD0Rn
         27w2ZUfdok5ntTWJ/dBWX4sAdKH2nRQgwwq23qo3b4abnFK7s1dJTybBWjq2ALsOaf+W
         /K8xOmNL11MPtU9gbr7eUX5O35rzw+BoGplTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JsCYNIZw9hzbmz9z2v57EFb8Rfpdn+c+Lmb0uqGGClb9g3hlFmqjCzW9oHqKN/CZzV
         qECI6E/zL8WmRaX3O9qWR0n8nAkHPv0CrJ5rmIaqcWcnKVgwA+R/dzwdHUUVZSAlwarF
         iiosV/Ou2qTRtBuJjpHAutdSYTXafFQwcrOuc=
Received: by 10.150.32.1 with SMTP id f1mr2096634ybf.222.1269034229099; Fri, 
	19 Mar 2010 14:30:29 -0700 (PDT)
In-Reply-To: <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142650>

On Fri, Mar 19, 2010 at 2:39 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Mar 19, 2010 at 19:32, Avery Pennarun <apenwarr@gmail.com> wrote:
>> - all those "extra commands" that git-svn supports are considered
>> backwards compatibility, even if they're absolutely obsolete because
>> of newer commands, and therefore will be very hard to justify getting
>> rid of
>
> I don't think this is true. The proposal is to implement
> git-remote-svn, which would allow _native_ interaction with svn
> repositories, so without using 'git svn'. It would allow 'git clone
> svn://example.com/myrepo' and subsequent "git pull"s from that svn
> source. Do you agree that makes (part of) your comments moot, or am I
> missing something?

I don't know enough about the proposal to comment on this part of the design.

I do know that where git-svn fits into git's UI has not been the
problem for me or my co-workers; we can learn some weirdo syntax if
needed.  Things like branching and merging, and git-svn redownloading
the same stuff 100 times, and oddly-named-svn-branch-hierarchies, and
git pulling between git-svn users, however, have given us lots of
grief.

For example, I'd be very happy to learn that your new design would
allow two people to independently pull from svn://, do work in their
respective copies of the git repositories, branch and merge all day
long, pull from each other, and then push back to svn without a)
making a mess of the svn repo and causing zillions of conflicts, or b)
linearizing history and losing git's complex DAG.

In the current version of git-svn this is very hard. 'git svn dcommit'
generates entirely new git commit objects corresponding to the ones
that were created in svn... but which nevertheless have your merge
history included, which is awesome.  But if a new person clones the
svn repo from scratch, he will end up with git commits corresponding
to those same ones from svn, but *without* the merge history, and
therefore with different commit ids, and which therefore prevent
push/pulling between other people who have cloned the repo.

If the above explanation doesn't make any sense, let me know and I can
clarify it further.  If you know what I'm talking about and have
either solved it or don't care about that use case, please just ignore
me and I'll go back to hide in my hole :)

Have fun,

Avery
