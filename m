From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Config Question
Date: Mon, 19 Jul 2010 00:59:09 -0500
Message-ID: <20100719055909.GA16276@burratino>
References: <AANLkTin8tW_qiRO57F-yjYHzhUkrZbO1g3L_hmesenGL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Shilpa Kulkarni <syk@payasonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 08:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OajOg-0003jv-MN
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 08:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0GSGAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 02:00:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42909 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0GSGAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 02:00:05 -0400
Received: by iwn7 with SMTP id 7so4235978iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZJv4EUiA4a4nZIr0iWRa6LjoW34+u0VUvRqBj9tDxjk=;
        b=Rhyk0ySmgfJMqGIRWnfHPEiF1ido3MiMbzfSv64GeOuH4/3ECcw1DHtX14ExWEIOQj
         FwDv8nRMFKC34ERhMqtgLQzJY5DqgTtzrxoQF//JF19fWHkqXNvIIHBLpHi0fRagGdC7
         vVIUxNtDhh4vPcX+GdMMrh+Dt629QeVGqT9ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qxWrsvcPzivsFX+bDk63OHGHKU06y1xt/fARmH8Z8dm4244R6gthZnsyE689l8MuNE
         2WEtVXTH4zIk/9ftRg4/GdeI8b0tLWiIYwmqsXgX40yLwTvuk/Z8E8XOmV+YtHg89IK0
         vsE1NSSCf52OPHJIWaiA8E2OhpGqUvbQgK3Ko=
Received: by 10.231.185.142 with SMTP id co14mr3822946ibb.97.1279519203682;
        Sun, 18 Jul 2010 23:00:03 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm23615249ibk.19.2010.07.18.23.00.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 23:00:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin8tW_qiRO57F-yjYHzhUkrZbO1g3L_hmesenGL@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151244>

(+cc: Eyvind Bernhardsen, Finn Arne Gangstad)

Hi!

Shilpa Kulkarni wrote:

> 2. Person Y checks in code (commit & push). Checks in file a, b.
>
> 3. Person X does a 'git pull origin master'.
>
> Pull succeeds - however
> 'git status' shows file a, b as modified even though person X has done
> nothing with these files.
[...]
> Someone has recommended we all use
> core.safecrlf=false
> core.autocrlf=false
> But this would require running dos2unix cmd while running scripts on
> linux which seems like an overhead.

I have not kept up with the latest best practices.  But I suspect
something like the following would work:

1. In .git/config, ~/.gitconfig, or /etc/gitconfig, on Windows:

	[core]
		autocrlf = true

See core.autocrlf in git-config(1).  I think git for windows does this
automatically.

2. In .git/config, ~/.gitconfig, or /etc/gitconfig, on Unix:

	[core]
		autocrlf = input

3. Convert line-endings in the tracked content.  Something like:

	$ git status; # make sure there are no untracked files present
	$ git rm -fr --cached .; # stop tracking all files
	$ git add .; # fix line-endings on all files
	$ git commit; # record that you have done so

4. Convert line-endings in the work tree.  Something like:

	$ git rm -fr .; # remove all tracked files
	$ git checkout HEAD -- .; # fetch them back again

5. In .gitattributes, something like:

	*	auto
	*.sh	crlf
	*.[ch]	crlf
	*.jpg	-crlf

See gitattributes(5) for details.

Hope that helps,
Jonathan
