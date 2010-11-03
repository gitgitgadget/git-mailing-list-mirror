From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Wed, 3 Nov 2010 11:13:12 -0500
Message-ID: <20101103161311.GA12934@burratino>
References: <loom.20101101T182113-378@post.gmane.org>
 <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
 <loom.20101102T165800-486@post.gmane.org>
 <AANLkTi=T5kHfgNOpOtCDCoq7epEgwUrVayaUCbf35dSU@mail.gmail.com>
 <loom.20101103T162424-483@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Paul Drews <paul.drews@intel.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 17:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfy4-0005Gh-PO
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0KCQNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:13:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0KCQNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:13:37 -0400
Received: by yxk8 with SMTP id 8so581581yxk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Tpcx7J3ZzMtqrhiAzdBCnPS0BxHg4ItpGuJKDBL38Nc=;
        b=Gmvzfpu3coedJ2VXtDRsUTZnreXPaVUGxlv3MS2FI9XvX4gD7I1HEM5Aqr+Ko1nJg0
         YaeiiewKNNyKxetpOrSloDWgOtn65YwSrY7yWGk2cQ/RGvmwbzlZwtkB8XKVf9dEsi+9
         dekL3ZFL31LhX/mKO5EDtDyNzeVWX7Sru1Z4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GdAZQAxrWBVawd6MLQ/CDUrzegUgIcygdU8OqnOjfzAxRLYcL9zHCmZ7g3Cmde8+r/
         ehixl8J9Jo7+HIJbFEZKwmDRUWC6Kn3kIkIP5v244gK3LnPAi9ELUb10kUNft0p/pu/S
         FI8/mUJ64Ajnh4Ba39eq1uwHr1l2sMVMsoOfA=
Received: by 10.223.86.16 with SMTP id q16mr2956130fal.58.1288800816021;
        Wed, 03 Nov 2010 09:13:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k4sm3766384faa.32.2010.11.03.09.13.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:13:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20101103T162424-483@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160605>

Paul Drews wrote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

>> Another one: create a .git file with this line and put it in worktree's
>> topdir
>> 
>> gitdir: /path/to/real/git.dir
>> 
>> See gitrepository-layout.txt.
>
> Ooh!  That would be my favorite, since it's a documented legal usage.

By the way, .git symlinks have been historically supported and are not
likely to break, either.  Maybe gitrepository-layout should grow to
include a section on the repository search.

> Unfortunately, although the rebase scenario works that way a local
> "git clone" doesn't work:
> 
> # git clone /abs/path/to/proj
> Cloning into proj...
> fatal: failed to open '/abs/path/to/proj/objects': No such file or directory

enter_repo() never learned .git file support, though I see no reason it should
be hard to add.

Pointers:

 - v1.5.6-rc0~93^2~3 (Add platform-independent .git "symlink",
   2008-02-20)

 - v0.99.9l^2 (daemon.c and path.enter_repo(): revamp path validation,
   2005-12-03)

The precise return value from enter_repo() is currently only used by
"git daemon", to handle directory arguments as in

	git daemon -- /srv/git

so returning a fictional path like

	/abs/path/to/proj/.git

might work ok. :)

Good catch.
