From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: git-fast-import doc problem and git-fast-export does not quote filenames
 correctly
Date: Sat, 04 Sep 2010 08:17:05 +0200
Message-ID: <4C81E461.7010704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 08:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orm3u-00088x-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 08:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0IDGRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 02:17:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44896 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab0IDGRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 02:17:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEAB5B.dip.t-dialin.net [84.190.171.91])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o846H6XA009074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 4 Sep 2010 08:17:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.24) Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.6.666
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155308>

According to the git-fast-import manpage:

> A `<path>` string must use UNIX-style directory separators (forward
> slash `/`), may contain any byte other than `LF`, and must not
> start with double quote (`"`).
> 
> If an `LF` or double quote must be encoded into `<path>` shell-style
> quoting should be used, e.g. `"path/with\n and \" in it"`.
> 
> The value of `<path>` must be in canonical form. That is it must not:
> 
> * contain an empty directory component (e.g. `foo//bar` is invalid),
> * end with a directory separator (e.g. `foo/` is invalid),
> * start with a directory separator (e.g. `/foo` is invalid),
> * contain the special component `.` or `..` (e.g. `foo/./bar` and
>   `foo/../bar` are invalid).
> 
> It is recommended that `<path>` always be encoded using UTF-8.

The first problem is that the doc seems to allow NUL bytes (which I
suspect are not really allowed) or the backslash '\' character (which,
if allowed, would logically have to be escaped, too).

The second problem is that "git fast-export" does not do even the
specified quoting:

$ git init
Initialized empty Git repository in /home/mhagger/tmp/gitfoo/.git/
$ touch '"path with
 and " in it"'
$ git add -u
$ git commit -am 'Madness'
[master (root-commit) 2472bdb] Madness
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 "\"path with\n and \" in it\""
$ git fast-export --all
blob
mark :1
data 0

reset refs/heads/master
commit refs/heads/master
mark :2
author Michael Haggerty <mhagger@michael.localdomain> 1283580642 +0200
committer Michael Haggerty <mhagger@michael.localdomain> 1283580642 +0200
data 8
Madness
M 100644 :1 "path with
 and " in it"

reset refs/heads/master
from :2

Michael
