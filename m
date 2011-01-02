From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fatal: ambiguous message
Date: Sun, 2 Jan 2011 12:34:53 -0600
Message-ID: <20110102183453.GA13463@burratino>
References: <4D1D33D7.7040809@gmail.com>
 <4D1DFF96.4010004@redhat.com>
 <4D20BE0B.6040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>,
	GIT Development <git@vger.kernel.org>,
	GNU Autoconf mailing list <autoconf@gnu.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 02 19:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZSlv-0004Ap-G2
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 19:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab1ABSfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 13:35:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52463 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab1ABSfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 13:35:07 -0500
Received: by iyi12 with SMTP id 12so11583974iyi.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YwmGjO+rj/jrrtUYYHzs1MQzaPPgFmJ9OCQbZWFszBQ=;
        b=jhahko22e3X43i5AW7iinlUGhd8qZzzT9AHAwbxcZl1fmt8nSXMuDXvKKBnf+icRsm
         YgLRd20N9dXhorXcy//U2Ito5l8kpwgeNwLyRz9NCX2tBi/T3nas3bGV92X9lkPM1bZw
         /4r56tw8Ij954R+e7fjZFFY3j+cqeGoBjWOhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IvgHahCF5/q94r4L5l9wXSHmA4OraFDhucmAMdAO+R3p7zE+yFu5IrYKPH2revhPCx
         /kIhfIRrt1tyWu6hO18+IKaBJuq4X738QDCpyzkDu/8/QKNKW5AqHvtHWw23SoDhHKdr
         BOntiMzrh+MPA3jyJd5acfw8lHdfUehW4YdOQ=
Received: by 10.42.227.131 with SMTP id ja3mr6081051icb.250.1293993305878;
        Sun, 02 Jan 2011 10:35:05 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id jv9sm16897371icb.1.2011.01.02.10.35.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 10:35:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D20BE0B.6040104@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164425>

Hi,

Context: http://git.savannah.gnu.org/gitweb/?p=autoconf.git;a=blob;f=build-aux/git-version-gen

Bruce Korb wrote:
>                          So, this message says, "fatal: ..."
> and comes from git and all three "git" invocations redirect stderr to
> /dev/null.  The fact that we see it is a git bug.  Error messages
> should be directed to stderr and thus written to /dev/null.

Were you been able to reproduce that outside the script?

> So, git-version-gen is correct to continue, but git should fail
> with a message that names the program that fails ("git") and
> should direct the message to stderr.

No thoughts on this part.  git has at least four kinds of message it
sends to stderr (fatal:, warning:, error:, and usage:) but I am
not sure it is useful to distinguish them ---

	git add: pathspec 'nonsense' did not match any files

might be nicer.

diff --git a/build-aux/git-version-gen b/build-aux/git-version-gen
index 5617eb8..119d7aa 100755
--- a/build-aux/git-version-gen
+++ b/build-aux/git-version-gen
@@ -119,7 +119,7 @@ then
 	    # result is the same as if we were using the newer version
 	    # of git describe.
 	    vtag=`echo "$v" | sed 's/-.*//'`
-	    numcommits=`git rev-list "$vtag"..HEAD | wc -l`
+	    numcommits=`git rev-list "$vtag"..HEAD 2>/dev/null | wc -l`
 	    v=`echo "$v" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
 	    ;;
     esac
