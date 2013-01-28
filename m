From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 18:21:00 -0800
Message-ID: <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
	<7v38xm12kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:21:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeLe-0008LW-3u
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab3A1CVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:21:04 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60267 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3A1CVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:21:03 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so1375133wgd.4
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QT1Rlt8EG9knLrcxaV6ChlydN2XTSv+z6UDfkGY4U7c=;
        b=Vj/SArTcbTw52ypNqOoKyCMq/8siyZfLh5+3gCSm/5KrBddsT1BUjEUPjtsHrPaXB4
         /+0inoRqWjt0hC+xmzjBMSdPFRB/Xz+gT+ki9xV8Tf58rxMKZCjseGKpwyl1x+jOxADd
         RWp1qdyeVMbGU9pP9gTjouT6sq9qdSA5dG9C3ao5unk5UARAxZexdMXa4Tyd2XQCbuKe
         MMRa/SCZ4+O3C9deCu3l6zUluCYPKqGJUvGPq+rj+eNerauGLM1OlyiXQKs5oPfjoOQ1
         zrT2C6GKDFtk71ApNWX/X5BYrc5QRqpXzaMgZEGyqXPRLW3TsDG8c/4OLhAV5VRTdlLb
         aY2w==
X-Received: by 10.194.76.7 with SMTP id g7mr18543689wjw.50.1359339660980; Sun,
 27 Jan 2013 18:21:00 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sun, 27 Jan 2013 18:21:00 -0800 (PST)
In-Reply-To: <7v38xm12kk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214787>

On Sun, Jan 27, 2013 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think our works crossed, while I was tweaking the previous series
> to push out as part of 'pu' you were already rerolling.  Could you
> compare this series with what I pushed out and see if anything you
> missed?  I think I fixed the (a && b || c && d) issue in the version
> I pushed out, but it is still there in this series.

Ah, I see.

I can add the addition of preamble for use by show_tool_help()
as a follow up along with using a here-doc when printing.

The other diff is the Makefile dependencies.

I currently have this diff against da/mergetool-docs:
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f595d26..834ec25 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -202,7 +202,11 @@ install-html: html
 #
 # Determine "include::" file references in asciidoc files.
 #
-doc.dep : $(wildcard *.txt) build-docdep.perl
+docdep_prereqs = \
+       mergetools-list.made $(mergetools_txt) \
+       cmd-list.made $(cmds_txt)
+
+doc.dep : $(docdep_prereqs) $(wildcard *.txt) build-docdep.perl
        $(QUIET_GEN)$(RM) $@+ $@ && \
        $(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
        mv $@+ $@

I'll send three follow-up patches.  - here-doc, preamble stuff,
and Makefile deps, based on what's currently in pu.
-- 
David
