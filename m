From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 14:28:02 -0700
Message-ID: <7vhd4vq23h.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
	<7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141719290.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 23:28:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUVpn-0001Vk-VC
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 23:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWDNV2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 17:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWDNV2E
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 17:28:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49822 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965178AbWDNV2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 17:28:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414212803.JEPC26035.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 17:28:03 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604141719290.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 14 Apr 2006 17:20:13 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18703>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 14 Apr 2006, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > $  git log -h
>> > fatal: unrecognized argument: -h
>> > $ git log --help
>> > fatal: unrecognized argument: --help
>> >
>> > Maybe the usage string could be printed in those cases?
>> 
>> Perhaps.  Alternatively, "git help log", perhaps.
>
> What about git-log then?

What about it?

Asking for help on log could be spelled as "git log --help" with
a patch like the attached, but I am not sure that is worth it...

-- >8 --
diff --git a/git.c b/git.c
index 78ed403..7fdacdd 100644
--- a/git.c
+++ b/git.c
@@ -497,6 +497,16 @@ int main(int argc, const char **argv, ch
 	}
 	argv[0] = cmd;
 
+	/* It could be git blah --help or git boo -h, but be
+	 * careful; most commands have their own '-h' and '--help'.
+	 */
+	if (argc == 2 &&
+	    (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
+		argv[0] = "help";
+		argv[1] = cmd;
+		exit(cmd_help(1, argv, envp));
+	}
+
 	/*
 	 * We search for git commands in the following order:
 	 *  - git_exec_path()
