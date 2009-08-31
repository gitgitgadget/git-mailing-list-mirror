From: Daniele Segato <daniele.bilug@gmail.com>
Subject: how to skip branches on git svn clone/fetch when there are errors
Date: Mon, 31 Aug 2009 10:26:36 +0200
Message-ID: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi2Du-0004Dv-7v
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 10:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbZHaI0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZHaI0g
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 04:26:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60904 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZHaI0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 04:26:36 -0400
Received: by bwz19 with SMTP id 19so2629986bwz.37
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=3b/1aVKQ6NB6s8IhBeyLntZl3UrojtJYh7OBPzzTmgE=;
        b=ew76ljKAoShWbrDF2XuMbPoTTBoQAQFj67/aOnRcs0l2CMfO2qifORXWKENL3GyiYo
         +x9pYmeK7IFKZuhY6tFlGETnNox+gHb5xyOAt+LdBVQcUwbR96yDuyUTsHNYo5X9KIk8
         YJcVtvIX6gVJMyhTjWMWlu2YcD9fPN5GdYQb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tioeJ9MdQJ0Yy5GmRvWqlIXjQ57qmRtKLgek3kpFPNXuU2o9qDOT4cukogadRMQMqh
         prtkdfeGeh4b05l9l3Ysr7vRTmphNUXS24nbOsjSAFcGxQqjvVjQypSfInQkAsbTMHIr
         g6j8OlO8aX6gPK2vBZmkfhfaYoxsL8U7d3vTo=
Received: by 10.223.101.156 with SMTP id c28mr1421548fao.52.1251707196184; 
	Mon, 31 Aug 2009 01:26:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127472>

Hi,

I'm trying to clone a big repository.

I follow this steps:

git init
git svn init svn://svn.mydomain.com/path/to/repo -T HEAD -b BRANCHES -t TAGS

vim .git/config # edited the svn-remote config as follow (add /root to
branches and tag) to match the repo structure
[svn-remote "svn"]
       url = svn://svn.mydomain.com
       fetch = path/to/repo/HEAD/root:refs/remotes/svn/trunk
       branches = path/to/repo/BRANCHES/*/root:refs/remotes/svn/*
       tags = path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*

git svn fetch

When I reach revision ~7500 (I don't remember the exact number) I get an error:

$ git svn fetch
Use of uninitialized value in concatenation (.) or string at
/usr/lib/perl5/SVN/Core.pm line 584.
Authorization failed:  at /usr/bin/git-svn line 1415


After some debugging I found out the reason is something strange on
the SVN server: there is a folder in the SVN that give an error when
trying to access:

$ svn info svn://svn.mydomain.com/path/to/repo/BRANCHES/V2.1-A
svn: Authorization failed

The same error with svn list.

I don't know what's wrong with that branch but I just want to skip it...

I tried modifying the .git/config svn-remote configuration adding this:

ignore-paths = path\\/to\\/repo\\/BRANCHES\\/V2\\.1-A

and re-launching git svn fetch.

I had no luck.

Ho do I skip a path on the svn repository?

(I can't provide the real svn repo because it is password protected
and I can't give you the access)

Thanks,
Regards,
Daniele
