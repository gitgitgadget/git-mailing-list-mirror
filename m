From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 0/19] git-subtree updates
Date: Sat, 9 Mar 2013 19:19:10 +0000
Message-ID: <CALeLG_=2WO6jgCbEmF33RCHGpXJnX0dE0Rt==6CX+-7RttALHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	James Roper <jroper@vz.net>, mhart <michael@adslot.com>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Peter Jaros <pjaros@pivotallabs.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPIx-0004FU-J3
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab3CITTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:19:12 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:46605 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:19:11 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so3256962oag.37
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=qyx9x9xYQLkfJLDebQdRIR85+cazLbZgE9UaHBJdCOc=;
        b=b/0PgHrl6YN73mwXdBG0tVwRAmM6oA8RiLN4a3EZDPyh72Y1M9AnZeEIdo9LYUTQBM
         1P4UFKxG9KPtHcqRl6n3cWHmTEkuqkSpVKkzfj5ng3X4OCl2mlfk6znKLF4LttAdnET6
         3C4Wq+D34ikIaK6nquMWFfbJC6AXvXjYBTApubTS78WXoCKmjyytlpLJHUVas9xW1ihG
         YFPgS1ZZFY0376jfcU5eTzG4hLTB93Hbyaum8npHpa7dj6oYk2pwiiZ9ClZHT7HCi2V4
         MQm0RpZk6jcq4TIEAXcAVm11ESFaulDo2cq1X/UZaUhk3g0Ye8dqj+oMYIz4hJHxkXmr
         7RKA==
X-Received: by 10.60.14.226 with SMTP id s2mr5051952oec.124.1362856750861;
 Sat, 09 Mar 2013 11:19:10 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:19:10 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnNdmEh7dZFHvo16RCu0MFRh7jEPMyFynuzY4R+eBfUbGB7R2gLE+B0ov4s7L+9ygLl8NQ+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217736>

The following set of commits are taken from the collection collated by
Herman van Rink and offered to the list in May of last year
($gmane/196667).

Where updating a commit to resolve a conflict has cleared the original
author of the commit I've noted the original author in the commit
message. Thus I've left the From lines in the format-patch output as
none of the work here is mine and I don't want to assume another's
credit.

I have tried to leave the commit's in a state as close to their
original, with only enough modification to allow them to be applied to
the current HEAD of master.

The git-subtree tests work (make test), but they don't cover any of
the new commands added nor the use of the .gittrees file for storing
the subtree metadata.

They provide the following:

In git-subtree.sh:

* OPTS_SPEC
  * pull/push: options for repository and refspec are both optional,
[<repository> [<refspec>]]
  * new sub-command: pull-all
  * new sub-command: push-all
  * new sub-command: list
  * new sub-command: from-submodule
  * new sub-command: prune
  * new sub-command: diff
  * new option for push: --force
* Trailing slash on prefix is removed
* Stores subtree metadata in .gittrees as:
  [subtree "$dir"]
    url = $repository
    path = $dir
    branch = $refspec
* Replaces a non-visible carriage return character with a properly escaped one
* pull and push: reads options from .gitrees if not provided on the command line
* Implementation of diff
  Fetches remote repo as a temporary git-remote then uses
git-diff-tree to compare before removing the temporary git-remote
* Implementation of list as plain wrapper to new functions subtree_list
  Iterates over subtrees listed in .gittrees and prints out their details
* Implementation of from-submodule
  Converts a git-submodule into a git-subtree
* Implementation of prune
  Removes entries from .gittrees where the $dir is missing
* Implementation of pull-all
  Performs a git-subtree pull for each subtree
* Implementation of push-all
  Performs a git-subtree push for each subtree

In git-subtree.txt:

* Adds brief descriptions for commands:
  * pull-all
  * push-all
  * list
  * from-submodule
  * prune
  * diff ("TO BE DOCUMENTED")
* Notes optional -f|--force for push sub-command
* fixes a typo in text for Example 1 (s/incldued/included/)

-- 
Paul [W] Campbell
