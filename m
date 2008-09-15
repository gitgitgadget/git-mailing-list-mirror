From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Mon, 15 Sep 2008 21:01:08 +0700
Message-ID: <fcaeb9bf0809150701j1161f87gcedef0013a244610@mail.gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
	 <200809151240.54495.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 16:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfEej-0004dC-DI
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 16:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbYIOOBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 10:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYIOOBN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 10:01:13 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37255 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbYIOOBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 10:01:11 -0400
Received: by gxk9 with SMTP id 9so24959311gxk.13
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U1zIlk6a85bHACUGSataZIOah6PkIP+ijVzjq/c9CZc=;
        b=x831CD2nfZ0DzCZdUmvo6av4ApOAHlz1fvJYgz9sv53bJrfapk7Rv4r2uS+AetXXQp
         Tig9vPVN8mAb00Zotx5B6McQ//1W9/NwxbJxhDbf8aynL1JkIzFzQxSPcNz9rG3rqArF
         f3GA9dzUi0KH7Cj1xifiZfFxWt0tvtCU9WHGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Jxm+A8IhHac9Cldd8UquQP8wEhWX3tDb6oLLD1sQMrV3UuFMlRMtVBirtcUwAfNxuR
         nvRsOudqCBVKgk0fzT0E4Y/lusmYdPKRelaakW23zRc6t/oi3cj1zCv9Rcv5mPka1tQr
         ftt37EB9KVjfhsxDq5o8guRAEWqNfXaE8xxOw=
Received: by 10.86.80.5 with SMTP id d5mr6005676fgb.11.1221487268990;
        Mon, 15 Sep 2008 07:01:08 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Mon, 15 Sep 2008 07:01:08 -0700 (PDT)
In-Reply-To: <200809151240.54495.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95909>

On 9/15/08, Jakub Narebski <jnareb@gmail.com> wrote:
> [I don't see mails I am replying to on GMane interface to git mailing
>   list, so threads might be broken. Strange... Perhaps too long lines
>   were cause of rejection by anti-SPAM vger filter?]

It was because I used zenbe.com (limited choices at work) to send
mails and did not realize until too late that zenbe.com did not encode
UTF-8 properly in mail headers. It made vger.k.o nervous and refuse to
accept my mails.

>  On Mon, 15 Sep 2008, Duy Nguyen wrote:
>  > On 09/15/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:
>
>
> > > > +Narrow works by applying your rules to the index, marking which
>  > > > +file you need and which file you need not. Modified/Unmerged
>  > > > +files cannot be marked unneeded. Unnecessary files will be
>  > > > +removed from working directory.  Note that after this step,
>  > > > +removed files can still be added to working directory when they
>  > > > +are needed by any git command. For example, when you have a merge
>  > > > +conflict, conflicted files will be checked out on working
>  > > > +directory and will no longer be marked "unneeded".
>  > >
>  > > This paragraph I think need some more love...
>  > >
>  > > So the "checkout rules" are meant to mark which paths are "wanted"
>  > > or "needed", and we would like to have in the checkout, and which
>  > > files are "unwanted" or "not needed" ("unneeded"?) and we want to
>  > > not have them present in working directory; something akin to accept
>  > > and deny rules, isn't it?
>  >
>  > Yes. But rules will be gone, only the results remain. I don't
>  > save/reuse rules.
>
>
> Ah. I understand. The options are only to select which files to check-out
>  (which are "wanted"), and which we do not want and mark with "no-checkout"
>  bit ("unwanted").
>
>
>  > > What are the rules, does all files except those marked explicitely
>  > > as needed are unneeded, or do you have to first mark all files as
>  > > unneeded?
>  > >
>  > > How would the following table look like:
>  > >
>  > >   working directory  || needed       | not needed    |
>  > >   ----------------------------------------------------
>  > >   file is absent     || checkout     | no change     |
>  > >   file is present    || no change    | removed       |
>  > >   file is modified   || conflict     | conflict?     |
>  >
>  > Looks better than my description. Though it would be "no change" for
>  > "file is modified/needed" case. There should be another line for
>  > unmerged entries.
>
>
> Now I am not sure about the line with 'file is modified', because even
>  in simple full checkout case there are different situations dealing with
>  checking out of index (and '-f' option), and switching to other branch
>  (and '-m' option).
>
>  Doesn't unmerged simply mean ignore "no-checkout" bit?

Yes.

>  > > > +Narrow spec will be used to specify how you want to narrow your
>  > > > +checkout. It is a list of pathspecs separated by colons. Each
>  > > > +patchspec specifies what files should be checked out on working
>  > > > +directory. Pathspec can contain wildcards and is relative to
>  > > > +current working directory. Usually asterisk (*) does not match
>  > > > +slashes. If a pathspec is prefixed by a plus sign (+), then
>  > > > +any asterisk will match anything, even slashes.
>  > >
>  > > First, does this mean that you can specify paths containing colons
>  > > (':') only using --add-path and --remove-path, or does it mean that
>  > > you cannot specify paths containg colon ':' (which should be rare)
>  > > at all as checkout limiter / checkout narrowing rule?
>  >
>  > You cannot do othat explicitly unfortunately. You can work-around using
>  > wildcard though.
>
>
> Couldn't you simply escape ':', i.e. write for example Git\:\:Tag.3pm,
>  or Eichten_PRD21\:313,1980_erratum.tex, or \:0.log, or perhaps
>  kmail/jnareb@gmail.com\:@pop.gmail.com\:995, or even something like
>  Mail/inbox/cur/1194202360.32296.mprnq\:2,S, in the same way like you
>  can escape other special characters, for example wildcard characters
>  like '\*' for '*' and '\?' for '?', and of course '\\' for '\'?
>

Sure. Somehow I forgot that.

>  > > Second, wouldn't it be better to use '**' to match also '/'?
>  > > Changing meaning of '*' using per-path flag seems a bit bad.
>  >
>  > It would be better. But I don't see any way but duplicating fnmatch()
>  > implementation and modify it to support '**' so I made a compromise.
>  > Will make another patch for '**' support and see how bloat the code
>  > will be.
>
>
> Well, the alternative would be to tell in commit message _why_ you
>  choose that (for implementation reasons), and perhaps give an example.
>
>  BTW. does '+' prefixed pathspec means that '?' can match '/', directory
>  separator?

No it only affects '*'.

So how about this? Note that document changes that also require code
change like narrow spec escape or '**' do not get in. I will change it
when I update code.

--<--
Narrow checkout
---------------

Normally when you do checkout a branch, your working directory
will be fully populated. In some situations, you just need to
work on certain files, no full checkout is needed. Narrow
checkout is a mode that limits checkout area according to your
needs.

Because narrow checkout uses new index format, it will be
incompatible with git prior to 1.6.0 regarding worktree operations.
Repository-only operations such as clone, push, pull... should not be
affected by narrow checkout. In order to make your working directory
work again with those versions, you can use `git checkout --full` to
return to normal mode (and compatible index format).

In narrow checkout mode, checkout status of every files in your
working directory will be recorded in index. If a file is marked
"no-checkout", it means that file is not needed to be present in
working directory by user or any git command. When a new file is added
to index, it will be marked "checkout" unless narrow spec is applied.
Unmerged files are always "checkout". linkgit:git-update-index[1] can
be used to update "checkout/no-checkout" status in index. When you
checkout new files using "git checkout <file>" they will be
automatically marked "checkout". Other commands such as "git apply"
can also checkout new files if they are needed.

"No-checkout" status is very similar to "assume-unchanged bit"
(see linkgit:git-update-index[1]). The main difference between them
is "assume unchanged" bit just ignores corresponding files in working
directory while narrow checkout goes a bit farther, remove those files
when it is safe to do so.

Narrow spec
-----------

Narrow spec is used to easily specify how do you want to form your
checkout area.  It is a list of pathspecs separated by colons. Each
patchspec specifies what files should or should not be checked out on
working directory. Pathspec can contain wildcards and is relative to
current working directory. Usually asterisk (*) does not match
slashes. If a pathspec is prefixed by a plus sign (+), then any
asterisk will match anything, even slashes.

When you apply new narrow spec to your working directory using either
--path, --add-path or --remove-path, it will update "checkout" status
in index accordingly. Moreover, if a file is marked "no-checkout" and
is present in working directory, it will be removed. If a file is
turned from "no-checkout" to "checkout", then it will be added again
to working directory. Modified and unmerged entries can't bear
"no-checkout" status, if narrow spec applies to them, "git checkout"
will refuse to update working directory.

Narrow spec is not saved by "git checkout". You can form your checkout
area on one go with --path option, or do it incrementally
with --add-path and --remove-path.
--<--

-- 
Duy
