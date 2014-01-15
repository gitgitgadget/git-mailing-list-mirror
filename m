From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: git-mv with absolute path derefereces symlinks
Date: Wed, 15 Jan 2014 13:48:59 +0100
Message-ID: <20140115124859.GA4283@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 13:49:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3PuA-0005Pb-L1
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 13:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaAOMtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 07:49:07 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:40443 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaAOMtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 07:49:04 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so446622eaj.40
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=E3b4vPA8A7X1C3vTiNzlCD9lUaO6TINgtD8bEO6P9wo=;
        b=waxb+y5xMFXS+TbiKj9DZR0VKMYM6dXTZLtVfFFjwd6bcrngEVA5/+Pvz2ISDlnwlo
         Lm0U+djDhmieQjxzR8xDVVReYfZI2pnYC1/yhQsIu8LqCglUO3sTEuNUSrP7KtZRynJs
         ch0+djlH58UT4EWUhU06pS4n/6EgzQaedcUoq77dyNOv+5F1k4Bvc0xdROpcWWQtkntG
         Q3NDBz+D66TV7/1e7Ll3wmuQWdW5lhnU3pIceUWr5zIf1iGGxYYXSkUV0tABk6rUyBQo
         Hcb+f6jOaKwNfYV/baVIlicNMcjqQWj/0dPVaz8JELS6lnB2x59RNHEw+PZzptC+/fJs
         u3kg==
X-Received: by 10.14.176.195 with SMTP id b43mr3391716eem.39.1389790143173;
        Wed, 15 Jan 2014 04:49:03 -0800 (PST)
Received: from mule ([194.150.18.52])
        by mx.google.com with ESMTPSA id 4sm10046173eed.14.2014.01.15.04.49.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 04:49:02 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240467>

Hi,

If git-mv is provided absolute paths when moving symlinks, it tries to
dereference them and (attempts to) move the symlink target rather than the
symlink itself, this seems like a quite odd behaviour since it's inconsistent
with how git-mv works with symlinks if given relative paths, and I'm thinking
it might be a bug, since it not documented in the git-mv manpage.

###
$ git init linktest
Initialized empty Git repository in /home/arand/tmp/linktest/.git/
$ cd linktest/
$ touch target
$ ln -s target link
$ ln -s /tmp/target link2
$ git add .
$ git commit -m1
[master (root-commit) 3cfea66] 1
 3 files changed, 2 insertions(+)
 create mode 120000 link
 create mode 120000 link2
 create mode 100644 target
$ git mv "$(pwd)/link" "$(pwd)/moved"
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        renamed:    target -> moved

$ git mv "$(pwd)/link2" "$(pwd)/moved2"
fatal: /home/arand/tmp/linktest/link2: '/home/arand/tmp/linktest/link2' is outside repository
###

--
Martin Erik Werner <martinerikwerner@gmail.com>
