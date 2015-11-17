From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] parse-options: allow -h as a short option
Date: Tue, 17 Nov 2015 11:19:30 +0100
Message-ID: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydMx-00054u-59
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbbKQKUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:20:05 -0500
Received: from mout.web.de ([212.227.15.3]:58075 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbbKQKUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:20:01 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lz2vo-1aTAtN2cxU-014ERI; Tue, 17 Nov 2015 11:19:37
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:sq7HySWL3DcdyP7xwjEbsiDaoVlhgHqDPN4nvoRfhJ881UPjkcw
 zQUuoXx4xHqhplIbMJuM2RdTdQ681LKOoNY9LR8fz221QjOF+CeQY3tDfDmJQSA0o1rdTIn
 xyVkmYYjZTCx7FWj7tiyW3X766gXimCwiA8qzV+YMLG9bVKRQ7F5ETt/AZyEzy9JGcORMDK
 Lk79j69ESQgiIxhwdZNyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vbe7VdFa3Jg=:UTLGATn/tExvI6KFZ5gjBC
 SLY+o6Ji5kvVW+QOxbjrGDTF120pnhqwaE5YRDXZEnFFWLl5cHuvKLgqUjL2YjW65UJ5CFNQg
 uIhgBWaY1w5wnT0qJJKEt7UyCDQANLtZ2HCeWBBEn1ksZKjjwTVCw8N4oH6F50u5ZMXdEkLLf
 wpfeHuvwFMxG1edEaM5KwlWQa3MIPj5gSHFOFCey9cEAZiUBHNMlva1s145GevF5vtqGgloua
 Raw79CCrwyuYtisgppENQhp2OEzM3IgIx4U9208G2Pq3m+8RVBxgPzr4IT7kheJGE2ZNvMBjo
 hojpX8V0HmywvMDu+hoVSZc0ZW/ZwfwtezbRYVK3Smb81XItGXIKAbG/8/ASfCsO/9jgBV+ZB
 I1smtoPd6v/Sahdnqm+QoPHL4knCLWXmXYkiAkmvt/fWdI/GeguW08tfUINfVJBQiSgB3BFNo
 S7l5EcolT/IJ/dllM8Q+uSRtVPAu1qnbRYvP9AWGDC3sT3JReJeDv/NPRtMMtVlwBpRCn5v0c
 5QlHXU6PqAkYRHhJ16S8YRuYptd/yiDyKK8NAXqfJlGWtVKEApB7mhDZha7OUsAdfSR6IjMRf
 Lw4H+fvqWmEan8Fx8gsyK9vqWHdFUqCMwZFgyq9Uoc3AOrUJ+Fe8qMYWJJpwQJdTGp1Uep/v2
 p64c2zowoEjKzblrp3KDE4TrdF7MPG2UWgx5xBF0TuKRUEhO9LLh1OdEh32i2cgVjqt2b8B9A
 O8NJoRq1wwUuAPtVwzr0D/eszTKDImZy5a8tEwtVvXyP6Jv4h8H2gORCAzw9C6VaTaZ4ghCL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281394>

The short option -h is hard-wired in parseopt to list the options of
a command together with a short explanation.  If -h is to be given a
different meaning then the flag PARSE_OPT_NO_INTERNAL_HELP has to be
specified, which turns off handling for -h, --help and --help-all
(except that --help handling is effectively overridden by git.c, but
that's a different story).

Most commands that do that, grep and show-ref in particular, still show
the usage when -h is specified as the only parameter and with --help-all
by  implementing explicit handlers for them.  This series makes it
easier for them by letting them override -h handling without any flag.

Rene Scharfe (5):
  parse-options: deduplicate parse_options_usage() calls
  parse-options: inline parse_options_usage() at its only remaining caller
  parse-options: allow -h as a short option
  grep: stop using PARSE_OPT_NO_INTERNAL_HELP
  show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP

 builtin/grep.c     | 17 +----------------
 builtin/show-ref.c | 12 +-----------
 parse-options.c    | 40 ++++++++++++++++++++--------------------
 parse-options.h    |  2 +-
 4 files changed, 23 insertions(+), 48 deletions(-)

-- 
2.6.3
