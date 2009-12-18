From: Karl Wiberg <kha@treskal.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Fri, 18 Dec 2009 10:23:38 +0100
Message-ID: <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@virtutech.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 10:23:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLZ3v-00012a-2m
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 10:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbZLRJXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 04:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZLRJXp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 04:23:45 -0500
Received: from mail1.space2u.com ([62.20.1.135]:47695 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZLRJXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 04:23:42 -0500
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com [209.85.220.221])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nBI9NVvB031222
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Fri, 18 Dec 2009 10:23:31 +0100
Received: by fxm21 with SMTP id 21so2614593fxm.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 01:23:39 -0800 (PST)
Received: by 10.102.252.7 with SMTP id z7mr1693137muh.12.1261128218722; Fri, 
	18 Dec 2009 01:23:38 -0800 (PST)
In-Reply-To: <20091217232212.4869.43002.stgit@toshiba-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135406>

On Fri, Dec 18, 2009 at 12:22 AM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:

> StGit commands resulting in a conflicting patch pushing record two
> transactions in the log (with one of them being inconsistent with
> HEAD != top). Undoing such operations requires two "stg undo"
> (possibly with --hard) commands which is unintuitive. This patch
> changes such operations to only record one log entry and "stg undo"
> reverts the stack to the state prior to the operation.

Hmm, OK. It was convenient to be able to undo just the last
conflicting step, but I guess the increase in UI complexity wasn't
worth it.

I think your patch doesn't go quite far enough, though.
self.__conflicting_push is currently set to a function that will do
the extra updates that take us from the first to the second state to
save in the log; if we'll be saving at only one point, we might as
well run those updates immediately instead of deferring them. In other
words, the entire __conflicting_push variable could be removed.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
