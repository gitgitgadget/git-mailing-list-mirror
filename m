From: Jan Larres <jan@majutsushi.net>
Subject: check-attr doesn't respect recursive definitions
Date: Sat, 30 Mar 2013 09:45:51 +0000 (UTC)
Message-ID: <slrnkldd3g.1l4.jan@majutsushi.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 11:15:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsoa-0008N9-3S
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 11:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab3C3KOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 06:14:44 -0400
Received: from plane.gmane.org ([80.91.229.3]:43727 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213Ab3C3KOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 06:14:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ULsoS-0007wM-Pz
	for git@vger.kernel.org; Sat, 30 Mar 2013 11:15:04 +0100
Received: from 101.98.187.16 ([101.98.187.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 11:15:04 +0100
Received: from jan by 101.98.187.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 11:15:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 101.98.187.16
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219586>

Hi,

I am trying to write a custom archiving script that checks the
export-ignore attribute to know which files from an ls-files output it
should skip. Through this I noticed that for files in directories for
which the export-ignore (or any other) attribute is set, check-attr
still reports 'unspecified'. More precisely:

$ git init test
Initialized empty Git repository in /home/jan/test/.git/
$ cd test
$ mkdir foo
$ touch foo/bar
$ echo "foo export-ignore" > .gitattributes
$ git check-attr export-ignore foo
foo: export-ignore: set
$ git check-attr export-ignore foo/bar
foo/bar: export-ignore: unspecified

I would expect the last command to also report 'set'. I've also tried
other patterns like 'foo/' and 'foo*', but it didn't make any
difference. Is this expected behaviour? It does make checking the
attributes of single files somewhat more difficult.

git-archive ignores the directory as expected, but unfortunately it
doesn't have an option to just list the files it would archive instead
of actually archiving them.

This is with git version 1.7.10.4.

-Jan
