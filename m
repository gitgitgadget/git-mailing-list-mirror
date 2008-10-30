From: "James North" <tocapicha@gmail.com>
Subject: Re: Encoding problems using git-svn
Date: Thu, 30 Oct 2008 04:28:23 +0100
Message-ID: <8b168cfb0810292028x225202b9hece862a350440472@mail.gmail.com>
References: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 04:37:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvOLt-00006f-6Z
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 04:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYJ3DbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 23:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbYJ3DbY
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 23:31:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:15672 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYJ3DbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 23:31:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so121612fkq.5
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cMCqIaudxkiw2uDeBCQ/4CvycCwq+OhRls6CQUv1XHk=;
        b=MMKx4ryIe003Z3cpg8SH3SzDf8B/STS6YctMKfdbRK8KuZQ47TSVa6fVu6qloRhqG3
         U1jH4nKauX7ngsMwvznzJUCS4QP3ejhLoCZjWajfIeREIf7Hr3J/F4iqfKJldl+HwQx8
         +mZgQtPcwhIjNY/Glc5ra+5dZhT9hicQ2hXsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xmkj9yJ0Iy1ldBLtbbli4BVj9wqSlx019RhcVNPAZ5UDhm2FqWzgNM6SHhyIKoCiyT
         Ty6KmV2UMGwz4w3heXoysb1bCY1lTQJbkwX/TPO2yLQslNF7CroKuJrmaa8GJqeupoBH
         mUL+psSo20YIsDMkJwqkDwXrkPZA3fzV3vaJs=
Received: by 10.187.183.7 with SMTP id k7mr937810fap.43.1225337303204;
        Wed, 29 Oct 2008 20:28:23 -0700 (PDT)
Received: by 10.187.203.14 with HTTP; Wed, 29 Oct 2008 20:28:23 -0700 (PDT)
In-Reply-To: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99444>

Ok, I made a quick change in git-svn script and seems like is working
now in my system with locale set to iso-8859-1.

Dunno if this is the right place to post this, but I hope someone
knowledgeable see this and tells if this would work as a general fix.

This patch is against 1.6.0.2

--- git-svn     2008-09-15 13:04:46.000000000 +0200
+++ git-svn.mine        2008-10-30 04:21:09.000000000 +0100
@@ -43,6 +43,7 @@
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Encode;

 BEGIN {
        # import functions from Git into our packages, en masse
@@ -1061,6 +1062,7 @@
                    && !$saw_from) {
                        $msgbuf .= "\n\nFrom: $author";
                }
+        $msgbuf = encode("utf8", $msgbuf);
                print $log_fh $msgbuf or croak $!;
                command_close_pipe($msg_fh, $ctx);
        }


On Wed, Oct 29, 2008 at 4:14 AM, James North <tocapicha@gmail.com> wrote:
> Hi,
>
> I'm using git-svn on a system with ISO-8859-1 encoding. The problem is
> when I try to use "git svn dcommit" to send changes to a remote svn
> (also ISO-8859-1).
>
> Seems like git-svn is sending commit messages with utf-8 (just a
> guessing...) and they look bad on the remote svn log. E.g. "Ca?\241a
> de cami?\243n"
>
> I have tried using i18n.commitencoding=ISO-8859-1 as suggested by the
> warning when doing "git svn dcommit" but messages still are sent with
> wrong encoding.
>
> I'm mising something?
>
> Thanks everyone
>
