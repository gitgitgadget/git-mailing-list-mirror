From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Git newbie question: permissions
Date: Thu, 09 Oct 2008 23:41:14 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-09-23-41-14+trackit+sam@rfc1149.net>
References: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Ed Schofield" <edschofield@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3HO-0003xx-EL
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbYJIVlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYJIVlY
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:41:24 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:57316 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbYJIVlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:41:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 4FA66E38AF;
	Thu,  9 Oct 2008 23:41:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5nG-6BBJjXc; Thu,  9 Oct 2008 23:41:15 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id B1D55E287C;
	Thu,  9 Oct 2008 23:41:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id E15EEC40BC;
	Thu,  9 Oct 2008 23:41:14 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p+2LzXWFSvnx; Thu,  9 Oct 2008 23:41:14 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id B9519C40BD; Thu,  9 Oct 2008 23:41:14 +0200 (CEST)
In-Reply-To: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com> (Ed Schofield's message of "Thu\, 9 Oct 2008 21\:20\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97892>

>>>>> "Ed" == Ed Schofield <edschofield@gmail.com> writes:

Ed> I have now run "git --bare init --shared=group" to reinitialize
Ed> the repository. This seems to have changed the directories to be
Ed> g+sx. (Is this all it did?). There are still some objects
Ed> directories with 755 permissions rather than 770, which I presume
Ed> I want, and the group ownership of these is wrong. Shall I change
Ed> these by hand? The sha1 files all have 444 permissions; is this
Ed> right?

Ed> The last question I have is how to ensure that git creates object
Ed> files etc. with the right permissions when users push in future.

As Marc said, you should first make sure that "config" contains
"sharedrepository = 1" in the "[core]" section.

Then you can do the following:

  - remove all permissions for "others":  chmod -R o-rwx .
  - mirror "user" permissions to "group": chmod -R g=u .
  - add +s flag to directories:           find . -type d | xargs chmod g+s

This should fix your current situation. The "sharedrepository = 1"
will tell git to maintain a proper shared state in the future
on objects it creates (i.e. mirror "user" permission to "group" ones).

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
