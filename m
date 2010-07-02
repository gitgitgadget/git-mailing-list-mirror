From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 9
Date: Fri, 2 Jul 2010 23:57:52 +0200
Message-ID: <20100702215752.GD2306@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <daniel@shahaf.name>, Sam Vilain <sam@vilain.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 02 23:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUoDa-0002zm-MM
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0GBV4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 17:56:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55966 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab0GBV4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 17:56:12 -0400
Received: by ewy23 with SMTP id 23so1156811ewy.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=wU834uPWv1d6WBrSd66oHWXXBFwjgUYyzlObzuvOxOE=;
        b=iAdaBgwx9JsQ4UPs5z7Kb6UF/0n7/dYr1KREbBF3XWAfG6BYVf5uArOzLJqfUpdZLO
         Ca81L0z7IhxkPazHoFJcF0M8sqCF9BBJjF0e8fbF6b7vO+QAAUHucQUVKXF9o1fmzOjx
         tD1sG6YeuK2IP9aL8saNNwyGrp91xX33EGk8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=N+GDQ2Pzrd23hK6KZGCyvVHytljI+HHa01nlNfIxpXFTdI0liplcdzPbjNUMKC5WU3
         5FxJb7E2bzK4D81WJRPnn1jf/oq32oxddORqvE/GK0G2BHY4FGM/AjOiQQhpHnWz6cxQ
         uB6C9f7fDb3o0satcIlJFzcyk4CRffNFgY/Hg=
Received: by 10.213.32.136 with SMTP id c8mr4546988ebd.38.1278107770268;
        Fri, 02 Jul 2010 14:56:10 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm9158093eei.19.2010.07.02.14.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 14:56:09 -0700 (PDT)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <daniel@shahaf.name>, Sam Vilain <sam@vilain.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150170>

Hi,

I figured that I haven't posted a recent update about the RA
svnclient, so here it is. The good news is that using a combination of
trial-and-error and twisted logic, I seem to have to fix the memory
leaks and pool lifetime issues. I also managed to ouput the
text-content-length header by writing the dump to a temporary file and
stat'ing it. Unfortunately, the headers are still malformed, and this
requires some more work to get right. The client runs successfully and
manages to dump 5000 revisions of the ASF repository:

11.34s user 3.50s system 21% cpu 1:07.69 total

That's about 75 revisions per second, which isn't too bad I hope. This
is over the network, and my internet connection isn't all that fast.

The bad news is that the client seems to signal SIGABRT when it
finishes its work for some strange reason. Fortunately, I suspect that
this is a trivial issue where I'm leaking some error or forgetting to
clean up something. Hopefully, I'll be able to resolve this and fix
the dump headers within the next few days. After that, I'll scrub the
history clean and roll a series.

-- Ram
