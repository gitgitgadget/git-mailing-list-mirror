From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Metadata storage - let's do this (was: "Tracking file metadata in git
 -- fix metastore or enhance git?") (was: "Revisiting metadata storage")
Date: Tue, 20 Dec 2011 16:45:24 +0100
Message-ID: <CAD77+gSihfmOV1ggAx9zcrqdn3F8CObXGZrJjSfMHKtY25teeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: jrnieder@gmail.com, Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	hilco.wijbenga@gmail.com, Thorsten Glaser <tg@mirbsd.de>,
	git.nabble.com@johnnyutahh.com
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 16:45:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd1t1-0004ST-Gb
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 16:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab1LTPps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 10:45:48 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35709 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1LTPpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 10:45:46 -0500
Received: by wibhm6 with SMTP id hm6so1470738wib.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=GYqjtUjr2SNvyR+sadVWUQVfy2HbKfW7Zd+znUg89kc=;
        b=cPqRfy5v9RsPxZNl7ksdLJBkru3AHxR/Tyh5oFIIS8/E/ehd/mECRoTieRNkdf7MOy
         lByKrUV++VuyhgWxNGx9kyruvrF/vHWvbV9XLdLx90Z4p33sGd8vWmQXIGtVSzdQRCFX
         xHbVHky8USwTQc9npzTwXxx2HkBRpzkGu3xVw=
Received: by 10.180.77.42 with SMTP id p10mr5917847wiw.5.1324395945402; Tue,
 20 Dec 2011 07:45:45 -0800 (PST)
Received: by 10.216.10.208 with HTTP; Tue, 20 Dec 2011 07:45:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187513>

Hi all,

to summarize the current situation: quite a few people want to have
this, but no one seems to be willing to actually jump into the cold
water and swim.

I decided to scratch my own itch and started to collect requirements,
etc. Obviously, those are mine. I can already tell you that I will
focus on mtime and possibly EXIF support as that is what I need this
whole thing for.
You are very welcome to comment on any of this.


Please note that I decided not to tie this into git but to use a
separate file. The rationale being that, this way, normal git
operations are not impacted in any way and allowing re-use elsewhere.


General:
* Must work with non-git
* Must play nicely with git
** Must merge easily when there are no conflicts
** Must conflict merges if layout version is changed
* No XML as that does not merge
* Assuming I spear-head this effort, it will be in Perl 5
* Possible names include
** metamonger
** metamangler
** git meta
* Needs test suite

Storage:
* Versioned storage layout
* Tab-seperated list (handle file names containing tabs via escaping?)
* UTF-8 for file names, ISO-8859-1 for metadata
* All binary data, if any (support for xattr?) will be ASCII-armoured
* Metadata will be both machine and human readable _and_ explicitly be
designed to facilitate manual editing

Syntax:

$0 save # save metadata, recursively, to .meta.db

$0 apply # apply metadata, recursively, from .meta.db

$0 diff # guess.

-q : quiet
-m : comma-seperated list to override what data will be stored/applied/diffed
-f : specify file name to store to/apply from
-F: store to/apply from .meta.db.$HOSTNAME
-U: store to/apply from .meta.db.$(cat /etc/hostuuid)
--exif-db : EXIF <> db
--exif-file : EXIF <> file

I would like to have this tool be able to operate on EXIF data to see
if the file's mtime and creation time are the same. Very specific use
case, but hey. Maybe factor that out into a cleanly modularized system
and call if via a more generic interface, though


Depending on the feedback I get and how busy I am before christmas, I
may get an initial version up and running before 2012.


If you want to help, nag or anything, please do it asap.


Thanks,
Richard
