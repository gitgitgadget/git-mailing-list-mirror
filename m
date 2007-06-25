From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Working on builtin-commit
Date: Mon, 25 Jun 2007 15:27:11 -0400
Message-ID: <1182799631.1689.35.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 21:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2uDY-0003tE-87
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 21:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbXFYT1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 15:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXFYT1T
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 15:27:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbXFYT1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 15:27:18 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5PJRHXl004001
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:27:17 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5PJRHqo032272
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:27:17 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5PJRGF6032747
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:27:16 -0400
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50914>

Hi,

To avoid duplication of work, here's a short heads up.  I've started
working on porting git-commit.sh (and status) to builtins.  It's still
work in progress, and nowhere near a full-time effort, but to prevent
doing double work as with builtin-tag, I thought I'd let the list know.
I have a repo over here:

	git://people.freedesktop.org/~krh/git.git

and the code is browsable here:

	http://cgit.freedesktop.org/~krh/git.git

on the 'builtin-commit' branch.

It's just a snapshot of my current progress, so don't slam my lack of
error checking etc just yet.  The work also needs to be split out in a
few patches (eg the read_pipe stuff). One thing that might be
interesting to discuss now, though, is my approach to option parsing.  I
realize real men do this by hand using a lot of strcmp's, but I broke
down and wrote a little option parser.  You give it a pointer to argv
and an array of these:

	struct option {
		enum option_type type;
		const char *long_name;
		char short_name;
		void *value;
	};

with

	enum option_type {
		OPTION_NONE,
		OPTION_STRING,
		OPTION_INTEGER,
		OPTION_LAST
	};

and it goes and parses the command line.  As the shell script, it
accepts all abreviations of long options, eg all of --messa doit,
--message=doit, -mdoit, -m doit, for the long_name="message";
short_name='m' case.  Ambiguous abbreviations are resolved according to
the order the options appears in the array.  I've kept it as simple as
possible and it works well for builtin-commit.c.  It's obviously useful
for other commands, but my goal here is to get git-commit.sh ported to
C, not to host a flamewar over the option parser API and whether we
should port other builtins.

cheers,
Kristian
