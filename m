From: Karl Wiberg <kha@treskal.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Sun, 20 Dec 2009 00:50:03 +0100
Message-ID: <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@virtutech.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 00:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM93v-00031y-1z
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 00:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZLSXuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbZLSXuI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 18:50:08 -0500
Received: from mail1.space2u.com ([62.20.1.135]:46180 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbZLSXuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 18:50:07 -0500
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com [209.85.220.221])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nBJNngTX022711
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Sun, 20 Dec 2009 00:49:42 +0100
Received: by fxm21 with SMTP id 21so3806821fxm.21
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 15:50:03 -0800 (PST)
Received: by 10.102.196.31 with SMTP id t31mr2672514muf.72.1261266603472; Sat, 
	19 Dec 2009 15:50:03 -0800 (PST)
In-Reply-To: <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135507>

On Fri, Dec 18, 2009 at 4:49 PM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:

> @@ -371,12 +369,10 @@ class StackTransaction(object):
>             # We've just caused conflicts, so we must allow them in
>             # the final checkout.
>             self.__allow_conflicts = lambda trans: True
> -
> -            # Save this update so that we can run it a little later.
> -            self.__conflicting_push = update
> +            self.__patches = _TransPatchMap(self.__stack)
> +            update()
>             self.__halt("%d merge conflict(s)" % len(self.__conflicts))
>         else:
> -            # Update immediately.
>             update()
>
>     def push_tree(self, pn):

Better. But couldn't you remove the update function completely and
just inline the code in it, since it's called immediately?

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
