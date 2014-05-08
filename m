From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 20:36:22 -0500
Message-ID: <536adf96f37ec_3caaa612ec69@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 03:47:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiDR5-0004SM-L7
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbaEHBrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:47:12 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:41312 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbaEHBrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 21:47:11 -0400
Received: by mail-yh0-f41.google.com with SMTP id f73so1760803yha.0
        for <git@vger.kernel.org>; Wed, 07 May 2014 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=UcBKHSrs8lMxfbNp2pSNi0MZTWEqYnQ7SI8UG+tvIpk=;
        b=Y3kSmAVPcBXup06v0KRuG/U45wrwfZGFxafaaz9bmUyfmf1odHH/11+4HJ9h6LQMKc
         iW3q76bEpxCrHnMkMcPvvdhBoKA9Z7jJSoXEGtBhEOa5jp5IiBDYD14nzpbTpaHFJ+NX
         kucQwD0LNlO+BC6g6LeL4EzIt/cJkG9XOhHyCf71Uz3g4H7KV7F3ECIQRZ/+UtBZ7+5d
         w4jo8bSPLD+6tGZbqukbLpuT6XCMyl9dbiu6ScbN1Sa7znofSMBzjyaKf/UeHyS90ou1
         YhLHjCB8tor6QvZDGwLCLRSTSnDQejAS9yc01hMr5O0FnDu2JviWjAdSp+/ipr7R0RUs
         t5IA==
X-Received: by 10.236.206.7 with SMTP id k7mr809227yho.84.1399513630742;
        Wed, 07 May 2014 18:47:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e4sm13803677yhb.32.2014.05.07.18.47.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 18:47:09 -0700 (PDT)
In-Reply-To: <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248400>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> Here's a bunch of tests more, and a fixes for Mercurial v3.0.
> >
> > I think the discussion with John Keeping hints that we shouldn't be
> > rushing fc/remote-helpers-hg-bzr-graduation and this does not appear
> > to assume the presense of that series, which is good in order to
> > make these fixes jump over them.
> 
> When merged to a place somewhere early between the next and the pu
> branches (aka "the jch branch", which is the version I usually use
> myself), this seemed to break t5810, so I did today's integration
> cycle one more time by excluding this topic and then instead queuing
> it near the tip of the pu branch (read: today's 'pu' does not pass
> the test suite for me).
> 
> There may be some other changes that this series depends on that I
> may have missed that caused this breakage.  Can you take a look?

I'm such a bad maintainer and I don't take constructive criticism well
why would you expect me to take a look?

As usual, I did more than take a look and I went ahead to manually test
with multiple versions of Mercurial. The problem appears with hg < 2.6.

Here's the fix:

--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -905,7 +905,7 @@ def write_tag(repo, tag, node, msg, author):
         try:
             fctx = tip.filectx(f)
             data = fctx.data()
-        except error.ManifestLookupError:
+        except error.LookupError:
             data = ""
         content = data + "%s %s\n" % (node, tag)
         return context.memfilectx(f, content, False, False, None)

-- 
Felipe Contreras
