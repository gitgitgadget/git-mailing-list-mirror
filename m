From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to the command invocation path
Date: Fri, 25 Jul 2008 10:32:02 +0200
Message-ID: <1216974722.48898f82e80d6@webmail.eunet.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <200807232112.18352.johannes.sixt@telecom.at> <7vd4l37vz7.fsf@gitster.siamese.dyndns.org> <200807242124.14583.johannes.sixt@telecom.at> <7v3aly5zz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIjf-0005br-Fa
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYGYIcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYGYIcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:32:09 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:44771 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYGYIcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:32:07 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp1.srv.eunet.at (Postfix) with ESMTPS id 20CEC33C6A;
	Fri, 25 Jul 2008 10:32:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6P8W2Sn018157;
	Fri, 25 Jul 2008 10:32:04 +0200
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Fri, 25 Jul 2008 10:32:02 +0200
In-Reply-To: <7v3aly5zz3.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90011>

Zitat von Junio C Hamano <gitster@pobox.com>:
> However, I have to wonder if it is the right thing to do, like your patch
> does, for "git --exec-path" to return "../libexec/git-core/" in a relative
> form, without saying what it is relative to.  Shouldn't we be showing the
> full path after resolving that relative path to git executable?

Does it? "git --exec-path" calls git_exec_path(), and that now returns
system_path(GIT_EXEC_PATH), and that is an absolute path, although it's
not normalized.

Oh, I see: You tested it on Linux, right? This patch series does not work
correctly on Linux (Unix? bash?), as Dscho has pointed out, since argv[0]
does not have a directory part if "git" is in $PATH. In this case, system_path()
just returns its argument, which is the relative path. :-/

-- Hannes
