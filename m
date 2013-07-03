From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Wed, 3 Jul 2013 12:02:49 +0200
Message-ID: <CAEef6WxnRbPVFgZP4asQrvYGVTTbGzeQCwPJrwj4a-6k9vFcbQ@mail.gmail.com>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
	<CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
	<7vip0ui757.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJtn-0003gk-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab3GCKCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:02:51 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:48168 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab3GCKCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:02:50 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so2813536bkc.27
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=01lYrOE4x4MgeHKWriwV8bhoXgQLrr6C+LKEg/R6i+w=;
        b=P4ZuuEJkwHvysHbpTX/0EjJ1X9sjXJ2Hyo01BXVRw6KXPZUjkiawnUdoiy2X1ATY+K
         uKbj8CA2Fvt4k8UokiwLMe2bUDWQbfu2cXXZySjquaSIqxEs6bYZ55lL4rBcrkZnaFfB
         VSejquhJPt2ji7WL5U3/O1hZU2irlJZ1hdsh7EZki5IWwHE/kcjU2uGqWN47RqK6rY7B
         GUQVFSwDM5cIgbc6M96MO/kXE7qcOUPRIBvvfnsSIjYG27ZZXSZ5sz0HJarlhO/eUYPb
         cqeBNvDCd12n/M2t2NZuNma14LHSYANPLBzPqFAqI7ECaoSeEKNeV1QwS6Gv3VDlooeQ
         RZ5g==
X-Received: by 10.204.224.204 with SMTP id ip12mr30760bkb.47.1372845769345;
 Wed, 03 Jul 2013 03:02:49 -0700 (PDT)
Received: by 10.204.164.9 with HTTP; Wed, 3 Jul 2013 03:02:49 -0700 (PDT)
In-Reply-To: <7vip0ui757.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl9J8ZQmerporJ+xsab08mW7kpofi5FVgLYKRnAKPphmLJs07wnNTuCI0leIAl63GlGMaD/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229482>

On Mon, Jul 1, 2013 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if we should care that deeply about them in the first
> place.

Fine by me; I don't really have a strong opinion on the matter.

> Besides, I think you can make a hardlink to a file that you cannot
> read.

Not always.  The Linux kernel can at least be configured not to allow
it.  It seems this is enabled by default in at least Debian.

This restriction had me a bit confused when I was testing variations
here; I expected all "access denied" failures to be because of .keep
files, but in fact creating hardlinks to other files (.idx and .pack)
failed too, even though they were readable.  This caused "git clone
--local" to fail, while "git clone" succeeded after falling back to
copying instead of linking.
