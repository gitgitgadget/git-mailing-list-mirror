From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 2/3] run-command: make sure hooks have always
 GIT_DIR
Date: Wed, 23 Apr 2014 16:15:36 -0500
Message-ID: <53582d78e82e6_24448772ecf8@nysa.notmuch>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
 <1398282160-26151-3-git-send-email-felipe.contreras@gmail.com>
 <xmqqoazrye6w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4gF-0001fJ-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbaDWV0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:26:05 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47171 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaDWV0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:26:03 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so1718416obc.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cExRfAybN12v2ma9OwUxBuHsCZTyeKjRv4AU0yyi+kw=;
        b=1Afb+6tqmAgcIGbMR004gCsjdQWyeUXhHbfiiNqgjzPwXixG2kvFrOdaSnv6FJEJl1
         cW5sCnsBFAfxeU14v8vjgWPrS+6dNUijAPyiuYzGjNRQ5GCIoyJVHLZ93p6bCyiE79S9
         /UwSPHK/RTsoGM5/fEsoVKP5GBQ7XR2W2bQg9OWKz2dLhT0+HD+CrYODaLaRMz3Axgbi
         XBcDVmBkMIGMbotN6daRt58TMKxvjZcKGHWPQ5r1JPoZzaIj5Z8zRjh0I+LPvN3cTgCe
         XAXoIKIhOdnQXT3Cq9vqoWKsKPDb2yHVtnA8VFiGLnCezpv0gleVbKzPmhYwh5kXnYgg
         FUXg==
X-Received: by 10.182.29.225 with SMTP id n1mr45043708obh.2.1398288362674;
        Wed, 23 Apr 2014 14:26:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm4140694obq.18.2014.04.23.14.26.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:26:01 -0700 (PDT)
In-Reply-To: <xmqqoazrye6w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246901>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Why is this a good change?

When a hook is called from a command without NEED_WORK_TREE, GIT_DIR is not set
(e.g. git branch).

> How does it prevent existing hook scripts from suddenly start
> misbehaving, where they do *not* expect to see an explicit GIT_DIR
> pointing at the original repository hook gets run in exported into
> their environment?

Fine, I'll use "${GIT_DIR-.git}" in my hook tests.

> For example, one of my post-receive hooks in a repository I push into records
> $cwd (which is the GIT_DIR of receiving repository), chdir's to another
> repository and then executes "git pull $cwd" from there, and that relies on
> the fact that being at the top-level of that other repository without GIT_DIR
> environment pointing at elsewhere but having .git directory in that top-level
> repository is sufficient to kick the auto-discovery of the repository that
> receives the "pull" in order to work correctly.

Let's hope post-receive is never called from a command that has NEED_WORK_TREE then.

-- 
Felipe Contreras
