From: Jed Brown <jed@59A2.org>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 14:16:24 -0500
Message-ID: <87zjxo3b7b.fsf@59A2.org>
References: <51531059.8000407@atechmedia.com> <7vsj3gn55b.fsf@alter.siamese.dyndns.org> <515331F2.3060703@atechmedia.com> <874nfw4t0r.fsf@59A2.org> <51533E8D.5050206@atechmedia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@inf.ethz.ch>
To: Charlie Smurthwaite <charlie@atechmedia.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:17:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvqE-0000vU-G2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3C0TQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:16:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41526 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab3C0TQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:16:30 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so8177690ieb.23
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=9zRaf4fL1qR4qLBpoOdgOHILCPCUG5uswYqC3LnkZLs=;
        b=AbLBAaWakk3xEnfWNGsoxR4HjPG1xG6PG0t+LZVvaS+wwoXKPgw/qxQoJmH5vY22wn
         eqKSjNzyuabKnroh0SSx05mIAtvEkOl90O+jIYh2Mf02N8AWn8hpOOfqP5v4bqMcx/k0
         IMQbEkZoUgx5N/Wiu7VyPHga7CBHAiEy4SCfiCKUuVABuuRB0klyVHoqmDkp7VxqBa7n
         bvODFkBrMvjUFayjeApHK7BPjwbn/t4a3TlZFtCHYT2SgCTt8fz0v3gNGK5AQL0Wr6E+
         1nQ8G/QNHoNDqukGlrEf3mW9u22JPdU1NFMA4V13oJ0e4l8KE4AfVoiwUZwSNDJz580L
         SYjw==
X-Received: by 10.43.117.136 with SMTP id fm8mr12634582icc.33.1364411789567;
        Wed, 27 Mar 2013 12:16:29 -0700 (PDT)
Received: from batura (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id xd4sm8419969igb.3.2013.03.27.12.16.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 12:16:25 -0700 (PDT)
In-Reply-To: <51533E8D.5050206@atechmedia.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219308>

Charlie Smurthwaite <charlie@atechmedia.com> writes:

> Yes, I would need to be able to do this on a bare repo for my use case. 

And if it's on the server, you don't want this to be observable, so
you don't want HEAD to move around. I don't know a better way than:

  $ git clone --shared -b upstream-branch bare-repo.git /tmp/merge-repo
  $ cd /tmp/merge-repo
  $ git pull URL incoming-branch

Cloning with --shared just writes a path into .git/objects/info/alternatives
and it doesn't need to be on the same file system (unlike --local).

Since 'git merge-tree' just works with trees, it has less information
than 'git merge'.
