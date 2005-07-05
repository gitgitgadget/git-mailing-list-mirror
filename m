From: Pavel Roskin <proski@gnu.org>
Subject: Proposed script: cg-info
Date: Tue, 05 Jul 2005 01:46:12 -0400
Message-ID: <1120542372.17286.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 05 07:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpgGH-0000IB-J8
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 07:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGEFqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 01:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGEFqS
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 01:46:18 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:62951
	"HELO roinet.com") by vger.kernel.org with SMTP id S261576AbVGEFqN
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 01:46:13 -0400
Received: (qmail 15352 invoked from network); 5 Jul 2005 05:46:13 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 5 Jul 2005 05:46:13 -0000
To: git <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

It would be useful to have a script to display current status of the
repository - branches, current branch and merge status.  Maybe I'm
missing something, but I don't see such script.

I wrote a script that would do that.  I'm still not fully familiar with
the concepts of cogito, so maybe wrong terms are used in the script.  I
just want to offer this scripts as a base for further work.

cg-info sounds very pretentious, so maybe the script should be renamed
to cg-heads-ls or cg-admin-status or something like that.

Signed-off-by: Pavel Roskin <proski@gnu.org>

#!/usr/bin/env bash
#
# Show status of the GIT repository.
# Copyright (c) Pavel Roskin 2005
#
# The output includes the list of branches and merge status.
# Current branch is marked by ">"

USAGE="cg-info"

. ${COGITO_LIB}cg-Xlib

mkdir -p $_git/refs/heads
[ "$(find $_git/refs/heads -follow -type f)" ] \
       || die "List of heads is empty."

branch=
headlink=$(readlink $_git/HEAD)
if [ "$headlink" ]; then
	branch=$(basename "$headlink")
else
	headsha1=$(cat $_git/HEAD)
	echo "HEAD: $headsha1"
fi

echo "Heads:"

for head in $_git/refs/heads/*; do
	headsha1=$(cat $head)
	headbase=$(basename $head)
	if [ "$headbase" = "$branch" ]; then
		echo ">$headbase $headsha1"
	else
		echo " $headbase $headsha1"
	fi
done

if [ -s "$_git/blocked" ]; then
	tmp=$(cat "$_git/blocked")
	echo "Blocked: $tmp"
fi

if [ -s "$_git/merging" ]; then
	tmp=$(cat "$_git/merging")
	echo "Merging: $tmp"
fi

if [ -s "$_git/merging-sym" ]; then
	tmp=$(cat "$_git/merging-sym")
	echo "Merging-sym: $tmp"
fi

if [ -s "$_git/merge-base" ]; then
	tmp=$(cat "$_git/merge-base")
	echo "Merge-base: $tmp"
fi


-- 
Regards,
Pavel Roskin
