From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] receive-pack: check object type of sha1 before using
 them as commits
Date: Wed, 2 Jan 2008 14:21:51 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801021418510.3010@woody.linux-foundation.org>
References: <11992595612601-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABzW-0000YH-B2
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYABWWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYABWWs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:22:48 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58450 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557AbYABWWr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 17:22:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02MLqZH009582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jan 2008 14:21:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02MLplC008100;
	Wed, 2 Jan 2008 14:21:52 -0800
In-Reply-To: <11992595612601-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69499>



On Wed, 2 Jan 2008, Martin Koegler wrote:
>  
> -		old_commit = (struct commit *)parse_object(old_sha1);
> -		new_commit = (struct commit *)parse_object(new_sha1);
> +		old_object = parse_object(old_sha1);
> +		new_object = parse_object(new_sha1);

I think it would be better to use

	old_object = lookup_commit_reference(old_sha1);
	if (!old_object)
		return "bad ref";
	new_object = lookup_commit_reference(new_sha1);
	if (!new_object)
		return "bad ref";

which will write a slightly more useful error message if it's not a commit 
(ie it will use the "check_commit()" function in commit.c)

		Linus
