From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: git add / update-cache --add fails.
Date: Wed, 27 Apr 2005 12:48:43 -0400
Message-ID: <87ll74go7o.fsf@coraid.com>
References: <200504260726.04908.rhys@rhyshardwick.co.uk>
	<E1DQcOc-00054l-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Wed Apr 27 19:20:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqBP-0008Bf-EV
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVD0RU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVD0RUX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:20:23 -0400
Received: from main.gmane.org ([80.91.229.2]:18904 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261818AbVD0RSb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 13:18:31 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DQq3C-0006yl-7o
	for git@vger.kernel.org; Wed, 27 Apr 2005 19:10:14 +0200
Received: from adsl-34-233-6.asm.bellsouth.net ([67.34.233.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 19:10:14 +0200
Received: from ecashin by adsl-34-233-6.asm.bellsouth.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 19:10:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-233-6.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:LfvCpLquEZxYSz8UgAnqm2o9WgQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Herbert Xu <herbert@gondor.apana.org.au> writes:

> Rhys Hardwick <rhys@rhyshardwick.co.uk> wrote:
>> 
>> rhys@metatron:~/repo/learning.repo$ strace update-cache --add w1d4p1.c
> ...
>> open("w1d4p1.c", O_RDONLY)              = -1 ENOENT (No such file or 
>> directory)
>
> The file that you're trying to add doesn't exist.

Maybe the user should be informed as soon as update-cache knows that?


--=-=-=
Content-Disposition: inline; filename=diff

update-cache.c: 11388582a830a6161d1c769aa8616bed6f593b8a
--- a/update-cache.c
+++ b/update-cache.c
@@ -98,6 +98,7 @@ static int add_file_to_cache(char *path)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
+		fprintf(stderr, "update-cache Error: %s\n", strerror(errno));
 		if (errno == ENOENT) {
 			if (allow_remove)
 				return remove_file_from_cache(path);

--=-=-=


By the way, I created that patch with "git diff" in my git-pasky
working directory.  Strangely, I had to redirect standard error to the
same place as standard output in order to get the filename in the diff
output.  I didn't check why the filename is on standard error,
though.

-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

