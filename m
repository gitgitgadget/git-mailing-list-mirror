From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of
 xmalloc + sprintf
Date: Tue, 24 Jun 2014 20:30:26 +0700
Message-ID: <CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
References: <20140619211659.GA32412@sigill.intra.peff.net> <20140619212800.GF28474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:31:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzQoP-0008V0-LX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 15:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbaFXNa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 09:30:58 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:57327 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaFXNa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 09:30:57 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so252023qgd.7
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W4dWuwxwDs8X9SU2LquFFPBcymmC2got1y5ouS79jbI=;
        b=LXU5RAaGijvs6+niIy8vNrdRxfnPtSJ00lm4wE7gq+QnB7cyk/vwq5V1foOrFIgsFs
         94d8oHrLKZSJQymqsFAXgmb61Qzp2oyQC/rrZ29KfkBw9QVoBg/ODV1uQ+TNLxaE8m8Z
         wN2FzNn3rcU47VPaGfnnZH+kFWCsk2anNKjxT6eRGyglQ1xqMTm+LqeJnRbZsj+EyzpJ
         GsDF6MZnzRUB3TZL0LbFdTNCc/Wg5b9y7+J8eQTe0WRveL0TgCjB0ImyLFPqHHIeAtdn
         fWhbe69UsRbQI4/MjTZyFq4QyPKFWDzhRRBjpT6CUrv1/AuSKMukRxrVNhnWls5dzBoy
         T4fQ==
X-Received: by 10.224.3.68 with SMTP id 4mr1913756qam.24.1403616656791; Tue,
 24 Jun 2014 06:30:56 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 24 Jun 2014 06:30:26 -0700 (PDT)
In-Reply-To: <20140619212800.GF28474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252409>

While it's about malloc..

On Fri, Jun 20, 2014 at 4:28 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/environment.c b/environment.c
> index 4dac5e9..4de7b81 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -135,15 +135,11 @@ static void setup_git_env(void)
>         gitfile = read_gitfile(git_dir);
>         git_dir = xstrdup(gitfile ? gitfile : git_dir);
>         git_object_dir = getenv(DB_ENVIRONMENT);
> -       if (!git_object_dir) {
> -               git_object_dir = xmalloc(strlen(git_dir) + 9);
> -               sprintf(git_object_dir, "%s/objects", git_dir);
> -       }

If DB_ENVIRONMENT is set, we should xstrdup(git_object_dir) because
getenv's return value is not guaranteed persistent. Since you're touch
this area, perhaps do it too (in this, or another patch)?
-- 
Duy
