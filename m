From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 7 Feb 2010 14:27:27 +1100
Message-ID: <2cfc40321002061927m522f0c3aj7d727c47a2f0cb22@mail.gmail.com>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	 <201002070236.12711.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 04:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndxsk-0000jC-VL
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 04:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab0BGD1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 22:27:30 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:49882 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0BGD13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 22:27:29 -0500
Received: by ywh27 with SMTP id 27so4542935ywh.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 19:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qZb7N6EboHUfLbB/s1u5kwwXvulC6/egti9Pv+uf8kU=;
        b=qmxmQNRc/CWok7Jxa9SCtkPwh8vNfHhi1LZ2QJyi/7VHPDkrKKFJFxipmqRkgwMgSI
         C1fcSy9LSj1jzDDdocCP6aHt9ZxQXV6U7a01dx2qeieF6Z8HaRKIKPFFlqw3n6zjf4dm
         dh9OnWJqN/juZZ0GT2TNBtKOy8g/XYdZDIxzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dsKxmZNonT8jeLKk4puHc1V7GrO/42eKgryNkDMf2+GjqL8nNGCR00kqS2UpUNBWup
         VRUy4yZsk7FkSfiXeYvR0hwCaaqauCxjYBtA5ul9yNW+nsONU5seFtTMgIcrGjiSNPrH
         umWokJr/WWHxQvLDI2SgYc1NLw0H8ZXj/vyVc=
Received: by 10.151.86.17 with SMTP id o17mr1732345ybl.117.1265513247730; Sat, 
	06 Feb 2010 19:27:27 -0800 (PST)
In-Reply-To: <201002070236.12711.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139214>

> I still don't see why this provides anything that isn't already supported by
> either using 'git tag', or by implementing support for notes-as-trees in the
> notes feature.
>

The intent of the metadata facility is to associate derivatives of
sha1 with the sha1 itself. If I have calculated a derivative of sha1
in the past, then let me reference that derivative using a metadata
path which I can look up knowing only the sha1 of the input and
nothing more. Yes,  I could create tags of the form
${sha1}/metadata-path for all my derived results but really, this
seems an abuse of the tag facility.

Here's another motivating example:

Suppose git-svn wrote the SVN id it was synched with into structured
metadata associated with a commit, instead of into the commit message,
the equivalent of:

    echo ${svn-id} | git metadata write-blob ${sha1} svn-id

Which means: for the specified sha1, read a blob from stdin and create
a metadata item with a metadata path called svn-id

To get it out again, you would write:

    git metadata read-blob ${sha1} svn-id

Which says, for the given object ${sha1}, read the blob from the
metadata tree at path svn-id and write its contents to stdout.

This would avoid cluttering the commit message with the svn-id, avoid
cluttering the tag space with the info and allow any commit to be
tagged in this way.

Admittedly similar function could be achieved a little more clumsily
now with appropriate use of GIT_NOTES_REF or with note subtrees, but I
share Junio's  reservations about trying to generalize notes from
blobs to trees, given way notes are currently used by the rest of
infrastructure.

jon.
