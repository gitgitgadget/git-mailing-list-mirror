From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 04:47:01 +0200
Message-ID: <201108020447.02545.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-18-git-send-email-artagnon@gmail.com> <201108020436.42148.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 04:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo50n-0000dd-QT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 04:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab1HBCrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 22:47:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33614 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab1HBCrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 22:47:12 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 842CCA6103;
	Tue,  2 Aug 2011 04:47:04 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <201108020436.42148.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178433>

On Tuesday 02 August 2011 04:36:41 Christian Couder wrote:
>
> static int parse_insn_buffer(char *buffer,
> 			     struct commit_list **todo_list,
> 			     struct replay_opts *opts)
> {
> 	struct commit_list **next = todo_list;
> 	char *p = buffer;
> 	int i;
> 
> 	for (i = 1; p && *p; i++) {
> 		struct commit *commit = parse_insn_line(p, opts);
> 		if (!commit)
> 			return error(_("Could not parse line %d."), i);
> 		next = commit_list_append(commit, next);
> 		p = strchr(p, '\n');
> 		if (p)
> 			p++;
> 	}

We can simplify this loop using strchrnul() like this:

 	for (i = 1; *p; i++) {
 		struct commit *commit = parse_insn_line(p, opts);
 		if (!commit)
 			return error(_("Could not parse line %d."), i);
 		next = commit_list_append(commit, next);
 		p = strchrnul(p, '\n');
 	}

Thanks,
Christian.
