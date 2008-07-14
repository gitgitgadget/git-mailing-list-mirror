From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Mon, 14 Jul 2008 04:29:21 +0200
Message-ID: <487ABA01.1050106@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <200807140128.44923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 04:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIDpZ-0005A9-Uo
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 04:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYGNC31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 22:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbYGNC31
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:29:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:10145 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYGNC30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:29:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1997927fgg.17
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=UaW2R+LvSN6tVpIFweopOXTVKggYuOoeboWsXILO/OI=;
        b=uDNyUw+9ajU5NR0fKw2+yCk2sH/SeMYM2vw9KtNHUXUmmtzC3Ox0pPSe0liZTutg0A
         foLeadZAAWKwC07iAwUjUSjvXWKGqYRjbRtJ+GMy9fBR83AhqgDqWEur7UqUzTmLzpNS
         4eB+0dJP+tGcrGZGmThnqebC/YVBACRPRB/hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=lWTNZ1xdA8j6Wo38rbtkPbwCsKIMfEGuU8Sxnhe0R2DmH7u+i/wHLOHM1oPh2CIoyR
         kLEOtzIm4c6XD8ZIJhNK+fURocLAJvPE3T5sBDxdy0iKUUda0fHQ4ko2egRob6YVp7zO
         tYRw9MyGOb2K63xJy6TlLrI2ZzZ6q3nSvy9Eg=
Received: by 10.86.36.11 with SMTP id j11mr13614624fgj.7.1216002564100;
        Sun, 13 Jul 2008 19:29:24 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.92])
        by mx.google.com with ESMTPS id 12sm568354fgg.0.2008.07.13.19.29.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 19:29:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807140128.44923.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88368>

Jakub Narebski wrote:
> I think it would be perhaps better to explain relationship and purpose
> of each class in more detail, including Git::Repo.

Noted, will do.

>>   [Git.pm] tries to do (a) WC access, (b) repo access,
>>   and (c) frontend error handling (with sensible error messages).
> 
> I can see (b) and (c), but I have trouble seeing (a).

Well, Git.pm operates on working copies in the constructor (obviously),
but also wc_{path,subdir,chdir} and hash_and_insert_object.

>>   every working copy has a repository associated with it
> 
> Please remember that the opposite relation is also true.

True. *nods*

>>   but I'd probably let [Git.pm] die a slow death
> 
> I'm not so sure if it is a way to go.  Most git commands wants to just 
> invoke other git commands safely,

Good point.  Perhaps the command functionality of Git.pm and Git::Repo
could be extracted into something like Git::Cmd.

> Non OO things, like ability to write  print color('reset') . "\n";
> is also important.

Perhaps, though you might not get around some instantiation to specify
the semantics of the color command: Honor color configuration in
.gitconfig or .git/config?  Honor non-terminal stdout?  Honor command
line?  I suspect that in the end non-OO functions end up being wrappers
around OO interfaces that simply specify a set of reasonable defaults.

> I'm not sure if using Error module was a good idea for
> frontend error handling.

As a general rule, I'd try to not use program exceptions as a means to
do frontend error handling, unless you're trying hard to keep the
frontend minimalist.  Even if you don't care about i18n, different
frontends have different needs for their error reporting styles.  Also,
things like failed SHA1-lookups might be an error to one frontend but
not an error to another frontend, so you'd have to implement an
exception hierarchy to make fine-granular catching possible.

On top of that, this kind of exception handling doesn't seem very much
like typical Perl style.

> How would you like to catch errors from frontend in Git::Repo and 
> friends?

Handle them yourself -- Git::Repo doesn't die unless a fatal (i.e.
unexpected) error occurs:

($sha1, $type) = $repo->get_sha1('HEAD:/my/file');
if (! defined $sha1 || $type ne 'blob') { ... handle error ... }
$contents = $repo->cat_file($sha1);
... work with contents ...

Also note how there's one well-defined (and known) error point: $sha1
being undefined, or the $type being wrong.  The $repo methods *cannot*
throw errors unless they're fatal, so you can for instance call cat_file
and assume that everything goes right.

> What is max_exit_code

It allows you call the git binary without dying if it exits with
non-zero status; see the cmd_output documentation for details.

The idea is that a non-zero exit status always indicates an internal
(fatal) error, unless you specify that it's OK.

>> - It's buggy and untested.  Neither of these is a problem by itself,
>>   but the combination is deadly.
> 
> Haven't you added t/t9700-perl-git.sh?

Yes (and it alleviated the problem), but I couldn't test the areas where
the untestedness actually hits (e.g. the missing semicolon I mentioned).
 IOW, t9700 is only testing the parts that are working anyway.

> What I worry about is that dependence on Git.pm or Git::Repo would make 
> gitweb installation too hard for some.

If I'm not mistaken you can always drop the perl/Git directory next to
gitweb.cgi.  (I'll add that to the installation notes.)

>> Unrelatedly, should I add copyright notices at the bottom of each perl
>> module so they are displayed in the perldoc/man pages?
> 
> Well, most manpages have information about who made them... which means 
> who was initial author, usually, and/or who is current maintainer.

I don't really care about being credited as the initial author, and I'm
honestly not sure if I'll be able to maintain the modules in the long run.

Should I perhaps add some note along the lines of "Direct questions and
patches to git@vger"?
