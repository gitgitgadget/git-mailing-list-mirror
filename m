From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 18:56:44 +0200
Message-ID: <200905131856.46344.jnareb@gmail.com>
References: <1242205190383-2879913.post@n2.nabble.com> <m3iqk5l4ps.fsf@localhost.localdomain> <20090513160415.GA4097@andros.launchmodem.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, takeshin <admirau@gmail.com>,
	git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 18:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Hm0-0005TN-6H
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760727AbZEMQ4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 12:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760705AbZEMQ4u
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:56:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:61021 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758842AbZEMQ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 12:56:49 -0400
Received: by fg-out-1718.google.com with SMTP id 16so264673fgg.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VkIsCl7OmQxhsh+8DlBNdFgFeCliKSqnSlSZ/HQJEc8=;
        b=YviG+bB2j3qsF4WssRucwN95dXPKrWcOHe2tEhxeH074+8ggxuMaJz4ile+ONV6atv
         vzeY//YoBeDzhcsMzOWTuEsmNMzTsipwCCyJdx1Rn60B6WGbAkFSo5iDgDjpKZT7J9HG
         GXlyLVXlcn2vPc+lNtLezviopK60R7RQbrFOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nOpFED0Piveh7laJ4fcMm2gJ1xl06qRY+LD/Ec7r+ksqH5UlMRoN8JQXjKOPs4ZQj7
         DT7dD0Wd4NAb0u2phTN3Juv58/QwKzqVcF6VpwFp3O2m2t0Dtzna/tr76DEHCEBaMT8X
         8WumA7CHIX07lwN/+KCopQoItbExkdnoFYpy8=
Received: by 10.86.59.18 with SMTP id h18mr1415541fga.71.1242233809149;
        Wed, 13 May 2009 09:56:49 -0700 (PDT)
Received: from ?192.168.1.13? (abwb156.neoplus.adsl.tpnet.pl [83.8.225.156])
        by mx.google.com with ESMTPS id 12sm309691fgg.25.2009.05.13.09.56.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 09:56:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090513160415.GA4097@andros.launchmodem.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119066>

On Wed, 13 May 2009, Dan Loewenherz wrote:
> On 13/05/09 02:42 -0700, Jakub Narebski wrote:
> > Andreas Ericsson <ae@op5.se> writes:

> > > No, but see GIT-VERSION-GEN and "git help describe" for info on how to
> > > replace such version tags using a script when you cut a release of your
> > > project.
> 
> Couldn't Git be a little more friendly? 

No, Git cannot have that feature.

> You can choose to ignore an uncommitted file through the `git update-index 
> --assume-unchanged` command. But AFAIK, Git doesn't allow one to ignore 
> uncommitted _lines_ in tracked files. If this feature were implemented, a 
> post commit hook could write in the latest commit hash and git wouldn't care.

No, I am afraid it is not possible. Let me explain

1. Git doesn't touch files which didn't change during rewinding (going
   back in history, perhaps to start development of maintenance branch,
   or doing bisection of history to find commit which introduced a bug),
   and when switching branches. If keyword expansion was about *commit*
   information (like description/decoration e.g. 'v1.6.3-17-g35805ce',
   or author, or change date) then when switching branches (going to
   other commit, with other info) you would have to rewrite all files.
   This would very badly affect performance. Also, when committing you
   would have to rewrite all files.

2. If you wanted however to have *file* version (like in CVS), then it
   is impossible because Git doesn't store such info (well, beside
   blob id of a contents of a file, but that is not exactly a version
   number); moreover it doesn't make much sense to know such number.
   It is next to useless; it is changesets that matter. CVS has it
   because it evolved from file-based version control system, only
   cobbled together.
 
> Is this something that is worth pursuing?

You can write your own clear/smudge filters if you are stubborn
about having version info in files which are under version control
(and you can ask SCM at which version you are), rather than adding
version info on release (so the program can support --version option).
-- 
Jakub Narebski
Poland
