From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git svn log' no longer uses the pager
Date: Sun, 14 Feb 2010 05:54:30 -0600
Message-ID: <20100214115430.GA1849@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngd3w-0006J6-5H
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab0BNLyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 06:54:38 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48576 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358Ab0BNLyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:54:35 -0500
Received: by iwn39 with SMTP id 39so1360396iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 03:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=igQDpq0ttbzmgNnbberkJjQHQv3T7u/K8PibAjSPaKs=;
        b=JHcZO0ele5xgVI6+B5plKdr2G1jySMgYNr6cCIsQ4W63QiOSUWrN0Mqc1nYuKTFl48
         KyLiQ1DxzmaZbXnjmjdwMOCXPrygdagY3Yp53N0KzXPDkXCyc75mCW0cZ61KEY4DM0FT
         1At5LY2YBvyQwYMP5vdxd1m35EfnnWko8Ssec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RivmVi1Pyj+c8+fM89DGDhewetz+nJzWAfB7U4zmsWOfsdqt58lTi3Km7jeoWcbTrI
         q+b6BWqApWPxwTLLWUHU/Y6m7X+toGMY+SJqtF6bdN/9JQGVenqUqkdVoH100fRT9Ukh
         oxA1KhRDNDfioEQSQRDB+BQ/ooGPf1D3mBYC0=
Received: by 10.231.150.74 with SMTP id x10mr5881025ibv.97.1266148475044;
        Sun, 14 Feb 2010 03:54:35 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5129981iwn.0.2010.02.14.03.54.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 03:54:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213235156.GA9054@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139899>

Jeff King wrote:
> On Sat, Feb 13, 2010 at 03:14:54PM -0600, Sebastian Celis wrote:

>> Ever since upgrading to git 1.6.6.1 I have noticed that 'git svn log=
'
>> no longer uses the pager. It definitely used to in git 1.6.5.X, but =
it
>> no longer does.
[...]
> I think it's a bug. It bisects to Jonathan's dec543e (am -i, git-svn:
> use "git var GIT_PAGER", 2009-10-30). But it seems to me that "git va=
r
> GIT_PAGER" is fundamentally broken.

Yikes, you=E2=80=99re right.  Sorry about that.

> For git-config's colorbool support we have the caller pass in a
> stdout-is-tty flag. I suspect we would need to do the same thing here=
=2E

Thanks for the helpful reference.  I think it is simpler for the caller
to disable the pager himself, i.e., something like patches 2, 4, and 5
below:

Jonathan Nieder (6):
  Fix 'git var' usage synopsis
  Make 'git var GIT_PAGER' always print the configured pager
  git.1: Clarify the behavior of the --paginate option
  git svn: Fix launching of pager
  am: Fix launching of pager
  tests: Add tests for automatic use of pager

 Documentation/git-var.txt |    2 +-
 Documentation/git.txt     |    8 ++-
 builtin-var.c             |    4 +-
 cache.h                   |    2 +-
 git-am.sh                 |    5 +-
 git-sh-setup.sh           |   16 +++++
 git-svn.perl              |    9 ++-
 pager.c                   |    6 +-
 t/t7006-pager.sh          |  163 +++++++++++++++++++++++++++++++++++++=
++++++++
 9 files changed, 200 insertions(+), 15 deletions(-)
 create mode 100644 t/t7006-pager.sh
