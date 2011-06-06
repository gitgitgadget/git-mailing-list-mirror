From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Sun, 05 Jun 2011 18:00:11 -0700
Message-ID: <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Ivankov <divanorama@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 03:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTODp-00068b-5e
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 03:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab1FFBA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 21:00:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab1FFBA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 21:00:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E9DC68B6;
	Sun,  5 Jun 2011 21:02:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJB7PUD9d5m32IJk5YAZJOgcCJY=; b=o3H8eT
	ssvL+kpBtv5ZpPwkNYLVwamsW4G8kozqcf8h1FISHEcDYEkDiIN3Bc+Egdu5mpj6
	3OCYwCT3++UdCmZdLFsdsG4gxsOmpJNaGAgIfDg8JRQr74iDwybIbV9FiiAgebwB
	TR23xpOfwJDqXpV/tPQWAQfB+PB7uJMs4gyqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJyqwSMlJoeJ8Ktn4a08Qz8/bcjv5vZf
	nT0jXl1gbi906Y5Ywlx3gjESqDCa6rtQcVc8ndVwpRFcmSTiMTwqL/VfTCcX+CoU
	HYK9CVpK6Kue23XDv0ASONhWSxulZ6h7QXqpiSy2SUyPRD463vbnRk9cU0Er/e99
	l1MJsRfL+G4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B034E68B5;
	Sun,  5 Jun 2011 21:02:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 29B6468B2; Sun,  5 Jun 2011
 21:02:23 -0400 (EDT)
In-Reply-To: <7vei37bxbp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Jun 2011 17:47:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A776B53C-8FD8-11E0-A011-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175089>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I did some more digging. I don't think the problem is with HEAD at all,
>> but rather with asking for more than one ref at all.
>> ...
>> Does that make sense? If so, then I think the right fix is for testgit
>> ti ignore all imports after the first one (since the first one will have
>> done all available refs). And the patch is:
>
> After reading Sverre's answer, I think this makes sense as a short-term
> workaround.  Shall we squah it in to 3/3?

I'll queue it separately as a tentative commit (below) and leave it in
'pu' for now. Please give it a better description so that we can move the
fix forward.

commit 2dbce8e7849279d9ef7d211390efd0da71e230ab
Author: Jeff King <peff@peff.net>
Date:   Fri Jun 3 14:10:52 2011 -0400

    remote-testgit: short-term fix to allow t5800 pass
    
    The test helper issues implements "import" but does not honor
    the branch argument; instead it imports everything and ends up
    not working well when more than one "import" is given.
    
    As a short-term workaround, just ignore second and later "import"
    commands.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..de644d2 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -111,13 +111,19 @@ def update_local_repo(repo):
     return repo
 
 
+did_import = False
 def do_import(repo, args):
     """Exports a fast-import stream from testgit for git to import.
     """
+    global did_import
 
     if len(args) != 1:
         die("Import needs exactly one ref")
 
+    if did_import:
+        return
+    did_import = True
+
     if not repo.gitdir:
         die("Need gitdir to import")
 
