From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 12:00:09 +0700
Message-ID: <20130728050009.GA10844@lanh>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 07:00:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3J5T-0004RP-IQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 07:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab3G1E7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 00:59:43 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44310 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3G1E7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 00:59:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id p11so151116pdj.32
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=V+bEn3PwF+i/LGJxIblnT0FMZpLgoYXgmTvy/iFJkKk=;
        b=DVS+VouRrFYI47QLGkxGqR31p/seEFzLh8ebOJUnh7XYvE0VKqcsfM77h4O35MrJOa
         N2t+hJFrAqoo7cR/SYS1gtZAFK8TVJQO6FTgwC9DdwZ3owWt9O4x0k+I8oyX+SJq3JJM
         FYsUO2U1/cfv5U0TwRbxf7dvWu6F0qCQVB3RxYuFb3IV2hEh9EKwDTpgpPP29Jl4eg7X
         mT4xjW7Q4b16JajUjyHb6remt8WP3gU6s8psCJ/i6/dcB/D7Acu/qgm4FmXGC9yIN+Cm
         g5nAk4pQkTSl2n/754b2t8nHWRlKafjwUzzgZFn4DisRZOQCfa+IR0WIFWtiCJWAeDsy
         B5/g==
X-Received: by 10.66.240.2 with SMTP id vw2mr63614260pac.137.1374987582276;
        Sat, 27 Jul 2013 21:59:42 -0700 (PDT)
Received: from lanh ([115.73.251.38])
        by mx.google.com with ESMTPSA id kc8sm69228984pbc.18.2013.07.27.21.59.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 21:59:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Jul 2013 12:00:09 +0700
Content-Disposition: inline
In-Reply-To: <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231260>

On Sat, Jul 27, 2013 at 09:35:40PM +0530, Ramkumar Ramachandra wrote:
> Duy Nguyen wrote:
> > I was involved with this code (the gitdir setup code, not submodule)
> > and am interested to know what's going on too. Could you produce a
> > small script to reproduce it?
> 
> Here's your reduced testcase. Just point mygit to a HEAD build.
> 
>   #!/bin/sh
> 
>   mygit=~/src/git/git
>   cd /tmp
>   $mygit clone https://github.com/artagnon/clayoven
>   cd clayoven
>   $mygit submodule add https://github.com/lewang/flx .elisp/flx
>   $mygit commit -a -m "Added submodule"
>   cd /tmp
>   ln -s clayoven/.elisp
>   cd .elisp/flx
>   EDITOR="emacs -Q" git commit --amend
>   # buffer-file-name = "/tmp/.git/modules/.elisp/flx/COMMIT_EDITMSG"
> 
> Note that this is emacs 24.3. I used -Q to make sure that none of my
> init magic (magit etc.) was responsible for changing directories or
> doing something equally stupid. However, considering that it's
> impossible to reproduce the problem with either cat or vim as the
> EDITOR, you might be inclined to classify this as an Emacs bug. In
> that case, why can't I reproduce it without submodules?

How about something like this as a workaround for emacs?

-- 8< --
diff --git a/editor.c b/editor.c
index 27bdecd..fda3e41 100644
--- a/editor.c
+++ b/editor.c
@@ -37,7 +37,8 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		return error("Terminal is dumb, but EDITOR unset");
 
 	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, path, NULL };
+		char *rpath = realpath(path, NULL);
+		const char *args[] = { editor, rpath, NULL };
 		struct child_process p;
 		int ret, sig;
 
@@ -51,6 +52,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		free(rpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
-- 8< --

> 
> I'm going off to eat cake before I tear my hair out in frustration.
