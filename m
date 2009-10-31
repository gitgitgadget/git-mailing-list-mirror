From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 23:00:03 -0500
Message-ID: <20091031040003.GA6022@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
 <20091031022347.GA5569@progeny.tock>
 <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 04:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N44z4-0006Hy-HX
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 04:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696AbZJaDuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 23:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757691AbZJaDuK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 23:50:10 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55618 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688AbZJaDuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 23:50:09 -0400
Received: by yxe17 with SMTP id 17so3273873yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 20:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yPpAQlwdpk11QobUCOeXJvAnFS13jIbwlQ9aywvc5Eo=;
        b=K6YMgC0+JdXPpQG8dnRepvg2SU/6D5oMXRExa8ZmRJ3zc2gZ36HZgHbLkG29NuEfOE
         uZ4rc+Ry5TVSqZs7kA0GW7MCaVBy+PcvWkdyo7WqdCvMIesh9Kevb5G+dr+LpdY/Uqw7
         /bvcThzxRcrXp4lkkj6R0ahP17ecv1o37bd54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qVJlvNwrG+SK6uN2bw6ov9BgAYlLczgamARwpL+p4Bex81I+h//iY8ezd14UL+DnLv
         XMIwxj7hBIate3HAMfzez+CzzfX3jJjh5CGdKUWSqcXeNSrQajnabylWQ998WI68aC92
         egesUXkzZQlsSlj6bZhfGTH2x90u79gsgWMNA=
Received: by 10.90.22.2 with SMTP id 2mr6325618agv.104.1256961014391;
        Fri, 30 Oct 2009 20:50:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1637285yxe.38.2009.10.30.20.50.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 20:50:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131830>

Junio C Hamano wrote:

> But the user did not even ask for GIT_EDITOR.  Should it even mention
> "unusable"?  or should it just say something like
> 
> 	GIT_EDITOR=
> 
> without complaining?
> 
> For that matter, I also wonder if we can squelch the user.email one when
> we are only listing the variables (I know it is not part of this topic,
> but I can still wonder).
[...]
> I think people run "git var -l", store the results in variables (think
> Perl or Python script) and read from there, instead of making separate
> invocations of "git var" for individual variables.

In that case, most variable-specific warnings should be suppressed as
irrelevant.  So squelching the warnings makes sense.

How about this patch?  With the "git var GIT_EDITOR" patch applied on
top, "git var -l" silently omits the GIT_EDITOR variable when a suitable
editor cannot be found.

-- %< --
Subject: Suppress warnings from "git var -l"

For scripts using "git var -l" to read all logical variables at
once, not all per-variable warnings will be relevant.  Suppress
them.

The git source tree does not include any scripts using "git var
-l", so this change should not affect other git commands.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ident.c |    2 +-
 var.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 99f1c85..26409b2 100644
--- a/ident.c
+++ b/ident.c
@@ -205,7 +205,7 @@ const char *fmt_ident(const char *name, const char *email,
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name == git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
-			env_hint = NULL; /* warn only once, for "git var -l" */
+			env_hint = NULL; /* warn only once */
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
diff --git a/var.c b/var.c
index 125c0d1..dacbaab 100644
--- a/var.c
+++ b/var.c
@@ -22,7 +22,7 @@ static void list_vars(void)
 {
 	struct git_var *ptr;
 	for (ptr = git_vars; ptr->read; ptr++)
-		printf("%s=%s\n", ptr->name, ptr->read(IDENT_WARN_ON_NO_NAME));
+		printf("%s=%s\n", ptr->name, ptr->read(0));
 }
 
 static const char *read_var(const char *var)
-- 
1.6.5.2
