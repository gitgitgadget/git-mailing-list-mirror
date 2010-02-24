From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Wed, 24 Feb 2010 19:23:16 -0300
Message-ID: <55bacdd31002241423i10ee177cnda545c9aac071b39@mail.gmail.com>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com> 
	<7viq9nfwg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkPe0-0001bk-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 23:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375Ab0BXWXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 17:23:43 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55131 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758343Ab0BXWXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 17:23:42 -0500
Received: by gwj16 with SMTP id 16so1369952gwj.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=pXQ3PGJJUJenOLBkRNJJydI2neKNFg3Ju5JlDGAv810=;
        b=t++W/DDvon5qqKs8P8e+nLzyRmODRqbegWrncX5PII7FyTIeAQpmd0X5m2dSvhiqKJ
         VJ68sT/Y3m8X9DAxi3RexTBZatJUtQ31KEy1EBQeSA+oMCRYVo4sDBeeeyy6bGndRiax
         hhz/Z+NxlR4ao0nYrjqoA/URJnnqRhvNzcEws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=W4mNo1piwrXJ9wWlRExabc4KCGn2Z+0Gu9xo982d37MowDEYxx5b3cF8UIybQQzo+1
         UKXJs8RBP73hEBYW64r+E/mNYpA/ZJcICMlUteTB02EOo3dEvWrcTCCQueNWkAnFDd0G
         zkHqOJseCSjxqgyDQvSa8Z2oQ0eB0KH39IpwU=
Received: by 10.150.214.6 with SMTP id m6mr252191ybg.230.1267050216496; Wed, 
	24 Feb 2010 14:23:36 -0800 (PST)
In-Reply-To: <7viq9nfwg8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140995>

Erick Mattos <erick.mattos@gmail.com> writes:

> A good example to show the need of this option is a Debian folder of control
> files.  Whenever a maintainer needs to debianize a source code to build
> packages he needs to add a folder called Debian with a lot of files inside it.
> Those files are connected to the source code of the program but they are not
> really part of the program development.  On this situation using the new
> option, that maintainer would do:
>
>       git checkout -ob debian
>       git clean -df
>       mkdir Debian
>       add all control files
>       ...hack it enough...
>       git add Debian
>       git commit

I do not think that is a good example.

If you have an extract of an upstream tarball, say frotz-1.42.tar.gz, and
you are not porting anything older than that version, why not have two
branches, frotz and master, and do things this way?

 - frotz (or "vanilla" or "upstream") that keeps track of the "vendor
  drop" without debian/ directory;

 - master that forks from frotz and adds "debian/" and nothing else; and

 - any other topic branches that either fork from frotz if you are fixing
  upstream bug (or enhancing the vanilla version), or fork from master if
  you are fixing or enhancing the debianization.

When you receive frotz-1.43.tar.gz, you will advance 'frotz' branch with
it, and probably fork maint-1.42 branch from master so that you can keep
supporting older debianized frotz, while merging frotz into master so that
you can prepare a debianized version of newer package.

Your debianization will _never_ be totally independent of the vendor
version, so there is no good reason to have it as a rootless branch.
