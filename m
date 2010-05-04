From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: update-index --really-refresh unsets assume-unchanged bit
Date: Tue, 4 May 2010 21:41:36 +0200
Message-ID: <20100504194136.GA19300@localhost>
References: <20100501092512.GA15941@localhost>
 <20100501092720.GB15941@localhost>
 <20100504085722.GA32217@localhost>
 <z2h32541b131005040941m79724daq4cd8b0c427bb218a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 21:41:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9O0E-00089x-Of
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941Ab0EDTlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 15:41:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35944 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab0EDTlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 15:41:52 -0400
Received: by fxm10 with SMTP id 10so3592842fxm.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/d4xpKj83w9MKfhDfmgd0Y5xWn4pptdGjA3SmIwh2is=;
        b=Q2POHOHkXes8LHkGygzV9POMl9UiMflxgfENaV7VnroiGIONXLVsHCw/Bcy2uixnKg
         HWnG6S0E+DhRkLHTDyLFNsqOs+5QqSnjaXUfCdZGhTYoDY8FJgCbH2pKVqABvjBa3lEn
         4g42umRtqHhicQCt/X2fxTHHT/6VhAwoqFIsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=xosNSvePwvPvVWZwlKyEtufsB8fdoak4ICc+WR/wU9kqsszV0b62AYyYKjYY9nZIWM
         j4dh3W4Fr2phxOJVJW2Oq69HO1taeFci5HhpxzXFWDHmVZ3Dfp6gV8LJKkNQtkFtE4Vg
         3u1Idp8xGh/cgJUZL9w1Iow18lICWB8dDN4yU=
Received: by 10.223.72.156 with SMTP id m28mr4558887faj.26.1273002111043;
        Tue, 04 May 2010 12:41:51 -0700 (PDT)
Received: from darc.lan (p549A456A.dip.t-dialin.net [84.154.69.106])
        by mx.google.com with ESMTPS id 1sm11973532fkt.11.2010.05.04.12.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 12:41:50 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O9Nzs-0005Hz-Fn; Tue, 04 May 2010 21:41:36 +0200
Content-Disposition: inline
In-Reply-To: <z2h32541b131005040941m79724daq4cd8b0c427bb218a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146339>

On Tue, May 04, 2010 at 12:41:22PM -0400, Avery Pennarun wrote:

> On Tue, May 4, 2010 at 4:57 AM, Clemens Buchacher <drizzd@aon.at> wrote:
>
> > Scratch that latter part, please. I just noticed the bit is unset only for
> > modified files. If the file matches the index, or even if it has been
> > deleted in the work tree, the bit is _not_ unset.
> >
> > So the current behavior is quite strange. I see several possible
> > interpretations of --really-refresh:
> 
> I don't know, the current behaviour sounds consistent with the name:
> "assume unchanged."
> 
> If the index says the file is unmodified, then assume it's unchanged;
> don't check for changes.

This is not about changes with respect to HEAD.  The "assume unchanged" flag
is unset if the work tree differs from the index.  Whether or not the file
is modified in the index is irrelevant.

> If the index says the file is modified, then clearly it's changed; it
> would be pointless to assume otherwise, so the "assume unchanged" bit
> should probably not be set.

On the contrary. I _want_ git to assume the file is unchanged, even though I
know it changed. This is an intended and documented use case (from the
git-update-index manpage):

 This option can be also used as a coarse file-level mechanism
 to ignore uncommitted changes in tracked files (akin to what
 `.gitignore` does for untracked files).

But even if you look at it from the performance optimization perspective,
the behavior is still inconsistent, because it does not unset the bit for
deleted files.

Furthermore, after update-index --really-refresh --add, the file is in fact
unchanged again and it would make much more sense to keep the
assume-unchanged flag.

> (Plus it's quite possibly dangerous to
> assume the file permissions are the same as they were when you first
> noticed they were changed; imagine if the file has changed twice and
> now has a different length or mode.)

What do you mean, "dangerous"? I tell git to update the index, and then
continue to ignore changes to the work tree, until I explicitly update
again. I can already achieve this behavior using

 git ls-files -v | grep ^h | cut -f2 -d' ' >my-ignored-files
 git update-index --really-refresh
 cat my-ignored-files | xargs git update-index --assume-unchanged

Clemens
