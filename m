X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 15:29:02 +0100
Message-ID: <200612171529.03165.jnareb@gmail.com>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171401.10585.jnareb@gmail.com> <20061217134848.GH12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 14:26:55 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZNmCbZa9T+Ft2QVRBmCci3VJNnvYG9ewfZklWU7v5EgbgmQWftyGD9xRDbK3CKFszmkNEPvHfHdlWkUG9po16LyZnc/RtTjbb0z90UZo6DA8PTIODs/K6+y5Qqjd/uoPvCIJwnPfEGnVLSBa1DwQvQPHbGY5hEBu/zzH9L6N8VI=
User-Agent: KMail/1.9.3
In-Reply-To: <20061217134848.GH12411@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34689>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvwyT-0001KR-Gl for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752699AbWLQO0d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbWLQO0d
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:26:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:27946 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752699AbWLQO0c (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 09:26:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1269401uga for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 06:26:31 -0800 (PST)
Received: by 10.67.20.3 with SMTP id x3mr4789422ugi.1166365591293; Sun, 17
 Dec 2006 06:26:31 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id u6sm7631215uge.2006.12.17.06.26.30; Sun, 17 Dec
 2006 06:26:31 -0800 (PST)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> On Sun, Dec 17, 2006 at 02:01:09PM +0100, Jakub Narebski wrote:

>> Well, in the .gitlink proposal you could specify GIT_DIR for checkout,
>> or separately: GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE, GIT_REFS_DIRECTORY
>> (does not exist yet), GIT_HEAD_FILE (does not exist yet, and I suppose
>> it wouldn't be easy to implement it). By the way, that's why I'm for
>> .gitlink name for the file, not .git -- this way .gitlink can "shadow"
>> what's in .git, for example specifying in a smart way where to search
>> (where to find) object database, but HEAD and index would be stored
>> together with the checked out directory in .git
> 
> What about .git/link or something?
> (Obviously without the capability to change GIT_DIR)

Well, the .gitlink proposal at it is now (by Josef) serves both as a way
to implement lightweight checkout (i.e. having additional working dir to
some repository, or having working dir separate from bare repository),
and as a way to have "smart" submodules (which you can move and rename)
in submodules/subproject support.

Besides, I'd rather either use config file for this (core.link or
core.git_dir), or use .git/GIT_DIR.
 
>> By the way, I'm rather partial to supermodule following HEAD in submodule,
>> not specified branch. First, I think it is easier from implementation
>> point of view: you don't have to remember which branch supermodule should
>> take submodule commits from; and this cannot be fixed branch name like
>> 'master'. 
[...]
> In the setup you described a git-checkout in the supermodule would have
> to switch to a different branch in the submodule, depending on the
> branchname which would have to be stored in the supermodule.
> This a lot more complex.

O.K. Now I understand why you prefer specified branch to HEAD.
I have forgot that checkout must update submodule ref, and if we track HEAD
we would have to remember the branch it pointed to.

By the way, should this ref be in submodule, or in supermodule, e.g. in
refs/modules/<name>/HEAD? And there is a problam _what_ branch should
be that.

Both approaches have advantages and disadvantages...
-- 
Jakub Narebski
