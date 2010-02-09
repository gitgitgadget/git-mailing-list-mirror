From: Avery Pennarun <apenwarr@gmail.com>
Subject: [Announce] bup 0.09: git-based backup system for really huge datasets
Date: Tue, 9 Feb 2010 17:48:03 -0500
Message-ID: <32541b131002091448o6f809322x1d86d2d7f74a80ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:48:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neysf-0005NX-KE
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab0BIWsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:48:24 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:60553 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0BIWsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:48:24 -0500
Received: by iwn13 with SMTP id 13so8983181iwn.25
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=yb8AaIavVmUkAyjD9Npwi/V1X7neOuAasIR1hz1oT0w=;
        b=fGAyExdaUf3ombm64pHNulvmeW+k8UbpgAxSD3t0vzuGNyUAsaKBLiHKXVoVy9DpHT
         PBX04ZhMw3xg+cbVBEHMLQ7lF1uoX1nKJaIeqVwiKD9C63XXKBgkwqtFl6wdP7+EVXho
         EcrrjhrqyDfsuIqdHQQsFYWBI2rb+WLl6+kJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=lfyeKx+jTEJHmJq0TiZag1bpDEukB0eAAJOOT24Z+1a+a+hCCy6KC14lsFFZHkxKEQ
         rgFiLqA9gu7h63Oqf4IzQWECfCC1J59NuTh4Huv6p0Ilt+fgvIxP8Opdsa3KhWiokLbX
         eF3eD0kAKvw/OLdoQ+ST6/VTma4qLnRAJ7g1w=
Received: by 10.231.162.9 with SMTP id t9mr237915ibx.5.1265755703087; Tue, 09 
	Feb 2010 14:48:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139456>

Hi all,

bup is a file backup tool based on the git packfile format.  If you're
interested in git, you might find bup interesting because:

- It can handle really massive datasets (hundreds of gigabytes)
without melting down.

- It can handle huge individual files (hundreds of gigabytes), such as
virtual machine images or giant textual database dumps, while neither
wasting disk space nor bogging down in xdelta.

- It can backup files directly to a remote server, without creating
git objects on the local system first.

- It uses a different format for its index file (.bup/bupindex) that
allows you to search and iterate non-linearly.  Thus if you have a
filesystem with a million files and only one of them is marked dirty,
bup can back it up near-instantly.

- Like git, it separates the concept of indexing the filesystem from
the concept of actually making new commits.  Thus it would be easy to
plugin an inotify-like system eventually, avoiding the slow filesystem
iteration every time you want to make a backup.

- It introduces a "multi-index" file (midx) that has a sorted list of
the objects from multiple .pack files, so that checking for a
nonexistent object only needs to swap in two pages at most.  (This is
unimportant in git, but critical when most of your work is ingesting
huge files whose sha1sums haven't been seen before.)

- It provides a FUSE-based filesystem so that you can easily browse
your backup history, including exporting it via samba if you want.

bup doesn't yet back up extra file metadata (beyond what git already
tracks).  Obviously this will be needed relatively soon.

bup is still pretty experimental, but it's already a useful tool for
backing up your files, even if those files include millions of files
and hundreds of gigs of VM images.

You can find the source code (and README) at github:

    http://github.com/apenwarr/bup

To subscribe to the bup mailing list, send an email to:

    bup-list+subscribe@googlegroups.com

Looking forward to everyone's feedback.

Have fun,

Avery
