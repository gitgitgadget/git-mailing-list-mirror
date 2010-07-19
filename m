From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 22:49:57 +0200
Message-ID: <201007192249.58357.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <20100717093006.GA11452@localhost> <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 22:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxHy-00031W-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966738Ab0GSUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 16:50:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46842 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966728Ab0GSUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:50:05 -0400
Received: by fxm14 with SMTP id 14so2415017fxm.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=X0MvQSU9uxwII6JjPAiJY8YgGtATyVt5fSXMt7vUiVI=;
        b=dBoj0coWJ7t/Dy+BaC9blfJGgWyaOymKdkUxWn1qKsV/Kcu2fco4sMbgH8b17DYLXz
         JHPks8xhzj5+KxOjuzf6WZxS0AmioPPvrJjGiVxLLCHicJ2jWwfu5xglysP/NefM6Xms
         IwR2rtjtCsb/LSdZ7df5Uc2kU7OB6/lCf1QwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nei2FBBV4RUL6v6KCP9mOBaXFQCOGUjlzRnb0Jnhme1VG566nNiHvDKZ2Qk7yG0NTG
         ap5wZTF25qcRXWxU9yEKhrYJQi2rDdzamB62GZTzJobCxB7dNFdtX9zjYZIzxMV4jGVo
         13P5ODCVoub1QRcPZTJEnlZ62VaKGG1LctzPI=
Received: by 10.223.119.196 with SMTP id a4mr4343857far.65.1279572603930;
        Mon, 19 Jul 2010 13:50:03 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id e22sm863625faa.0.2010.07.19.13.50.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 13:50:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151279>

On Mon, 19 Jul 2010, Junio C Hamano wrote:

> If you take an analogy in say a file server implementation, yes, it should
> not be easy to lose information there.  But it is and should be easy to
> say "rm junk".  How would people recover from a mistake if they typed a
> wrong filename, "rm junio" to lose a precious file "junio", when they
> meant to lose "junk"?  They go to backups.

First, I guess that many people have 'rm' aliased to 'rm -i', so it
asks for confirmation... though it only moves safety a bit, as 
'rm -f junio' would be still dangerous.

Second, desktop environment have the notion of trashcan, where files
to be deleted are moved, and kept for some time or untill trashcan is
emptied (though it moves safety a bit to people using 'hard delete'
instead of moving to trashcan).  Or use undeletefs,

>                                            Can't git users do the same? 
> After all, .git directory is stored on a filesystem of some sort, and
> taking a backup (you do take backups, don't you?) and picking the stuff
> you lost from there should be a standard procedure that can be learned
> outside of the context of git.

People expect version control system to protect them more from mistakes.

Sidenote: there aere requests in last Git User's Survey (from 2009) to
have safety net against losing changes due to "git reset --hard", in the
form of automatically stashing blobs or something.

> 
> This is pretty-much a tangent, but I recall from time to time people
> wonder why the branch namespace is not flat.  If that is a common wish,
> your "tilde-suffix all the intermediate path components" trick could be
> used in later versions of git (perhaps 1.8.X series) to improve the system
> to allow "maint-1.7.0" branch and topic branches that forked from it
> e.g. "maint-1.7.0/fix-frotz" and "maint-1.7.0/fix-nitfol" peacefully
> co-exist.

Hmmmmm... true, this would make having 'foo' and 'foo/bar' branches 
coexists, whether they are loose or packed, and whether they have reflogs
or not.

-- 
Jakub Narebski
Poland
