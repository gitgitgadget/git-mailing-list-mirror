From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 0/4] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 11:29:45 -0500
Message-ID: <20100612162945.GB1406@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:30:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTao-0004X8-Bi
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0FLQ3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:29:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45656 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0FLQ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:29:53 -0400
Received: by iwn9 with SMTP id 9so1588974iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q7iM6HnW6zUDFtAptPbJfwE6M3khe0hBQ+czyhvS+ZQ=;
        b=Jgte4tTyYXfR+eIp5EJCgPnGbYx7+9brOFc0t1tlrwimZWCfBYCCRWZYUIl47BZCQu
         oJyIonHVvsmup1V6YxGQoSOWjvlgJLNtUigVhCi4yUSkqlGZtMg/HAabZNTQIyjeopu6
         HPr0/BSgyDvJ5jlYjo4wEj3ZZUHe7T7LfYaX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PBqgySBk+6oY46nQJkxLxuhPPzdlQIhsx8tIYnA7VDdYD+IQWF4PLRzBTNN5P87HC9
         udePMcAwxtQ1lRElh/gzwrl16un5+8vcDS6R09KhoIilPKBD34EDSeGYJU0m1tKzqc5w
         n0/00qKYVlOZFLNYM0Ml4HPaZ66RJfo1MQ+uU=
Received: by 10.231.150.15 with SMTP id w15mr3651835ibv.115.1276360191810;
        Sat, 12 Jun 2010 09:29:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm11114699ibg.0.2010.06.12.09.29.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 09:29:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1006121139290.2689@bonsai2>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149015>

Johannes Schindelin wrote:

> Nope, the patch is still there, even after a rebase.

Ah, I see.  Looks like a good patch (d00d655, Unify code paths of threa=
ded
greps, 2010-02-07) though in principle a separate topic, since grep -O
already sets use_threads =3D 0.  I think it is good to base grep-O on i=
t
because it allows cleaner code.

Here=E2=80=99s a rebased version.

Johannes Schindelin (3):
  Unify code paths of threaded greps
  grep: Add the option '--open-files-in-pager'
  grep -O: allow optional argument specifying the pager (or editor)

Jonathan Nieder (1):
  grep: refactor grep_objects loop into its own function

 Documentation/git-grep.txt         |    8 ++
 builtin/grep.c                     |  121 ++++++++++++++++++++++------
 git.c                              |    2 +-
 t/lib-pager.sh                     |   15 ++++
 t/t7006-pager.sh                   |   16 +---
 t/{t7002-grep.sh =3D> t7810-grep.sh} |    0
 t/t7811-grep-open.sh               |  157 ++++++++++++++++++++++++++++=
++++++++
 7 files changed, 280 insertions(+), 39 deletions(-)
 create mode 100644 t/lib-pager.sh
 rename t/{t7002-grep.sh =3D> t7810-grep.sh} (100%)
 create mode 100755 t/t7811-grep-open.sh
