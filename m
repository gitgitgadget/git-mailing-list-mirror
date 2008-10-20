From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 4/5] gitweb: parse parent..current syntax from PATH_INFO
Date: Mon, 20 Oct 2008 16:52:39 +0200
Message-ID: <cb7bb73a0810200752l70e1952dmb8e14a419b02f61b@mail.gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810201118.44654.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:46:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krw8r-0003MK-Hb
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYJTOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbYJTOwl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:52:41 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58597 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYJTOwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:52:41 -0400
Received: by gxk9 with SMTP id 9so3750477gxk.13
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K7w7HqNqNV9yFBjpO8P9Pe/ad/M8ok0m3WLyd5Sb2fg=;
        b=aKGHmqxgQAbsg2YCOFMJgGF9orfbJyMUlqEWlgiwrKkeVs6EICg6Ag/6dPGYGr60fT
         hM5hURooJ5AGYLzvZK/SL0NW0ySrzc1MXlsMsGqg8iZB8USoyv1VYk8wG6fjLWx4xgqt
         QU2IDWHRQCH4sQj61w94mw01JHScOOCxvn6FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LiKXJXxsCJhjKm8xzS6cJJtXxS/GfPmw5/33PIAce6GkYxtUcTV5Z/9PjCV7SyEk6/
         HlD4UsjqbiugPuiRKDVuNj5nNTfqNbv9gVs/2bECm1P08yN4iTELpUqeAch/vu4EJFmw
         6sfwqOWQCWfYtd0366U8zIfdFmD6ym8sAkJ/Q=
Received: by 10.151.41.14 with SMTP id t14mr4825828ybj.179.1224514359907;
        Mon, 20 Oct 2008 07:52:39 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Mon, 20 Oct 2008 07:52:39 -0700 (PDT)
In-Reply-To: <200810201118.44654.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98675>

On Mon, Oct 20, 2008 at 11:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:
>
>> This patch makes it possible to use an URL such as
>> $project/somebranch..otherbranch:/filename to get a diff between
>> different version of a file. Paths like
>> $project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
>> as well.
>
> Just a nitpick: why '$project' and '$action', but 'somebranch',
> 'otherbranch' and 'filename'?

Good question ... I think I got distracted along the way.

>> All '*diff' actions and in general actions that use $hash_parent[_base]
>> and $file_parent can now get all of their parameters from PATH_INFO
>
> Which currently mean 'shortlog', and I guess in the future would mean
> also all other log-like views: 'log', 'history', 'search' (the commit
> message kind, not the pickaxe kind), and perhaps also 'rss'/'atom'.

I'm not sure rss/atom makes sense, but the others were already in my
todo list after the shortlog patch, so I'll try to get them ready as
soon as I have the time to refactor them as we discussed on IRC.

> Side note: the regexp below allow for $parentpathname to contain
> '..', but we don't want to rely on such minute detail of implementation
> detail (because it depends on whether we use greedy or non-greedy
> matching there).
>
>> +     my ($parentrefname, $parentpathname, $refname, $pathname) =
>> +             ($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?(.+?)(?::(.+))?$/);

Hm, actually it might be a better idea to make the first pathname
match non-greedy.

>> -                     $input_params{'action'} ||= "blob_plain";
>> +                     # the default action depends on whether we had parent info
>> +                     # or not
>> +                     if ($parentrefname) {
>> +                             $input_params{'action'} ||= "blobdiff_plain";
>> +                     } else {
>> +                             $input_params{'action'} ||= "blob_plain";
>> +                     }
>
> Nice.
>
> I was wondering about 'project/hash_parent..hash' syntax, but then I have
> realized that it doesn't change action (as in 'blob_plain' -> 'blobdiff_plain'),
> but is always 'shortlog'.
>
> By the way, I wonder if it should be 'blobdiff_plain' or just 'blobdiff'.
> the 'blob_plain' was here to use gitweb as a kind of versioned web
> server; there is no such equivalent for 'p/hbp..hb:f' syntax. On the
> other hand it is consistent behavior, always using *_plain...

Moreover, it allows sending shorter URLs for patches, which are the
ones you usually write by hand.

>> +
>> +     # next, handle the 'parent' part, if present
>> +     if (defined $parentrefname) {
>> +             # a missing pathspec defaults to the 'current' filename, allowing e.g.
>> +             # someproject/blobdiff/oldrev..newrev:/filename
>> +             if ($parentpathname) {
>> +                     $parentpathname =~ s,^/+,,;
>> +                     $parentpathname =~ s,/$,,;
>
> Hmmm... should we strip trailing '/' here?

I must confess I don't remember why I decided that was needed.

-- 
Giuseppe "Oblomov" Bilotta
