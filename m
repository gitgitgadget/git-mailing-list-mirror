From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Tue, 1 Feb 2011 18:57:48 -0600
Message-ID: <20110202005748.GA13803@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <4D4852EE.6080605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Feb 02 01:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkR3H-0003bT-I0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 01:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab1BBA6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 19:58:08 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42851 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab1BBA6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 19:58:04 -0500
Received: by qyj19 with SMTP id 19so5451646qyj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LhuKnoNAvr/hTW8aXcgb3oBeyXF7yeatr1CUnMmq5BI=;
        b=AQdvlKC675q8JF8bb/LTBAC2Dm11OD9v2zezEU7M5ACodvuYDxrHTYuAdjzmMWX1l9
         eVEMADq6WSyBY7qeGoS6jQYD2I5k8sknADVR9jeAWnEJolKFCtHtemwdbo3TYMxdiiOy
         ZzcvrFv9UN0+v2hhw7AQpb2ubyN+Bw6IRjE8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dLEywxt+H8bW7CenuuvHqb9R/km069pib27oBo3bj58Zqapr8R92KskuwI+XFssoDJ
         2XXe3lXTYFZTE2BFM3/tvtkpituvKjWWi0DtVpHCth9GqgdHkpJCu83+ZHFijPdRvT9D
         qFFOEdZ5r576UNtKVvD2sq7uwrKX48d36qkmU=
Received: by 10.224.28.74 with SMTP id l10mr8106060qac.275.1296608281870;
        Tue, 01 Feb 2011 16:58:01 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id t7sm16097164qcs.4.2011.02.01.16.57.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 16:58:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4852EE.6080605@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165883>

Hi,

Ren=C3=A9 Scharfe wrote:

>    command          deprecated since replaced by
>    ---------------- ---------------- ---------------------

Some quick thoughts based on a code search:

 - removing lost-found seems safe
 - removing peek-remote seems safe
 - repo-config should probably warn before it is removed
 - removing tar-tree will probably break "make dist" for old
   projects.  I still am tempted to say removing it should be
   okay.

>    git-lost-found   2007-11-08       git fsck --lost-found

It can stay in contrib/examples for inspiration.

>    git-peek-remote  2007-11-24       git ls-remote

No one seems to be using it
(github.com/gitpan/App-GitHub-FindRepository.git uses it as a fallback
when ls-remote is not present).

>    git-repo-config  2008-01-17       git config

giggle[1] still uses it --- see libgiggle-git/giggle-git-config-read.c
and giggle-git-config-write.c.

Likewise darcs2git[2] and the stgit testsuite.

webkit's VCSUtils.pm only uses repo-config as a fallback when git
config is not present.

>    git-tar-tree     2007-11-08       git archive

Already prints a deprecation notice.  WWW::PkgFind from CPAN uses it
but doesn't seem to be maintained.

pilgrim[3] uses tar-tree in its "make dist" target.  I wouldn't be
surprised if some other projects use it in a similar way.

Jonathan

[1] git://git.gnome.org/giggle.git
[2] git://repo.or.cz/darcs2git.git
[3] git://git.fedorahosted.org/pilgrim.git
