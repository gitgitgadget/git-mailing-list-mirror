From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 00/24] Let 'git <command> -h' show usage without a git dir
Date: Mon, 9 Nov 2009 09:02:35 -0600
Message-ID: <20091109150235.GA23871@progeny.tock>
References: <20080125173149.GA10287@edna.gwendoline.at>
 <20091108071152.GA20741@progeny.tock>
 <7vvdhlfk2y.fsf@alter.siamese.dyndns.org>
 <20091108110341.GA23737@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vc9-0001B0-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbZKIOwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbZKIOwy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:52:54 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37860 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbZKIOwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:52:53 -0500
Received: by ewy3 with SMTP id 3so3177340ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aLRLLf2zpoDRbKyx5a8B+lOofoJa1x+utqmhEMRf9Nw=;
        b=lE85q40EDRZz220Vn1fxaxT2B1mn5xd0dH6KsHUTILjFkVBQc0wob8JAnojXlKTBDF
         4dbeLRmHp7rY2WSAkLu2qAk5GqttZ6ILU+I+0LP60nf7vCRfkDrHicI9Yz/G5G0IBDQn
         zKvl+vD/LoP0UEupn8XXyg1ZHR7jqekR6tT9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n175TSs8ivTVO4lgUndU2xqN0qtbk1Xl1q3gVKs/h/QSE/YabCPeQvKrIyW3FOrHKB
         vV6bnp+s+E4vitdIlaEHscGKEmSQiR1IJ07XWuR+cfCjwc3YRwyQn6RziWS7hAKMfpL2
         iym70CNj8QP+MFItdlUFvKwlxDNhECAbkqvNI=
Received: by 10.216.89.131 with SMTP id c3mr695007wef.197.1257778378228;
        Mon, 09 Nov 2009 06:52:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i35sm8913225gve.28.2009.11.09.06.52.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:52:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091108110341.GA23737@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132462>

Junio C Hamano wrote:

> So I think the right approach is something like how you handled http-push;
> namely, check if the sole argument is "-h", and if so show help and exit.

I took a more aggressive approach with some commands.  As long as it
was obviously safe and not too complicated to implement, I let -h work
wherever other options work.

Tested with

git_home=$(pwd)
while read a b
do
	cmd=${a#git-}
	test "$cmd" = "$a" && continue
	echo "$cmd"
	( cd /tmp && "$git_home/git" "$cmd" -h 2>&1 | head -1 )
done |
less

and the test suite.

Thoughts?

Jonathan Nieder (24):
  Retire fetch--tool helper to contrib/examples
  Show usage string for 'git grep -h'
  Show usage string for 'git cherry -h'
  Show usage string for 'git commit-tree -h'
  Show usage string for 'git merge-ours -h'
  Show usage string for 'git show-ref -h'
  check-ref-format: update usage string
  Show usage string for 'git check-ref-format -h'
  Show usage string for 'git fast-import -h'
  Show usage string for 'git get-tar-commit-id -h'
  Show usage string for 'git imap-send -h'
  Show usage string for 'git mailsplit -h'
  Show usage string for 'git merge-one-file -h'
  Show usage string for 'git rev-parse -h'
  Show usage string for 'git show-index -h'
  Show usage string for 'git unpack-file -h'
  Show usage string for 'git stripspace -h'
  merge: do not setup worktree twice
  Let 'git http-fetch -h' show usage outside any git repository
  http-fetch: add missing initialization of argv0_path
  Let 'git <command> -h' show usage without a git dir
  Let usage() take a printf-style format
  merge-{recursive,subtree}: use usage() to print usage
  diff --no-index: make the usage string less scary

 Documentation/git-show-ref.txt                     |    3 +-
 Makefile                                           |    1 -
 builtin-check-ref-format.c                         |    9 +++++++-
 builtin-commit-tree.c                              |    2 +-
 builtin-grep.c                                     |    7 ++++++
 builtin-log.c                                      |    9 ++++++++
 builtin-mailsplit.c                                |    2 +
 builtin-merge-ours.c                               |    6 +++++
 builtin-merge-recursive.c                          |    2 +-
 builtin-merge.c                                    |    1 -
 builtin-mv.c                                       |    8 +++---
 builtin-read-tree.c                                |    4 +-
 builtin-reflog.c                                   |    3 ++
 builtin-rerere.c                                   |    3 ++
 builtin-rev-parse.c                                |   10 +++++++++
 builtin-show-ref.c                                 |   10 +++++++-
 builtin-stripspace.c                               |    4 ++-
 builtin-tar-tree.c                                 |    6 +++++
 builtin.h                                          |    1 -
 .../examples/builtin-fetch--tool.c                 |    0
 diff-no-index.c                                    |    2 +-
 fast-import.c                                      |    3 ++
 git-compat-util.h                                  |    2 +-
 git-merge-one-file.sh                              |   12 ++++++++++
 git.c                                              |   22 ++++++++++---------
 http-fetch.c                                       |   21 ++++++++++++------
 imap-send.c                                        |    5 ++++
 index-pack.c                                       |    3 ++
 pack-redundant.c                                   |    3 ++
 show-index.c                                       |    5 ++++
 unpack-file.c                                      |    2 +-
 usage.c                                            |   14 ++++++++----
 32 files changed, 143 insertions(+), 42 deletions(-)
 rename builtin-fetch--tool.c => contrib/examples/builtin-fetch--tool.c (100%)
