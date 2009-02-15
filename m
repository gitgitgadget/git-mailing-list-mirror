From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/8] config: Don't return negative exit codes.
Date: Sun, 15 Feb 2009 15:30:12 +0200
Message-ID: <20090215133012.GA13801@annwn>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902151321310.10279@pacific.mpi-cbg.de> <94a0d4530902150439peac228ckec79f8c692b84e4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 14:31:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYh64-0008Kr-TC
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 14:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbZBONaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 08:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbZBONaV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 08:30:21 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:50205 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbZBONaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 08:30:20 -0500
Received: by fxm13 with SMTP id 13so4896123fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QVvaikTsTyYjpkWOogVsBVwa33w4VAvO7fDRwcMouFg=;
        b=Y+dyYuyxOLT/hJGbaigR8UmY418xskj0Oe1lfT1xtcf+WnbKsLhrQn+Hqo8sNKg834
         7bubi1WzyY5qS6AYx6MIGZDWQvbf2IsfvR0uHeYAV44SUaOd4We/0eJ7fVckCidBDget
         EXKDr+Z2tnYdb2iMKTbbaShIzgq+3F6XGD7+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UYJzJ/ncxwitMifuOeuPYt7bXuz6N8JqW8y9VBEl2zTqMI4A1RGNooiq8YzGuMgszp
         hkjhJCfvMZbOL/peWH8TfCE/UaJAXsXMsqHjT7uCzNcNt4ZLEPIljj8bFIpeCjkyXLAj
         g5R2ILDj5dMkF8TwNgnC0q3wvJrzbP+jFKc3Q=
Received: by 10.181.48.4 with SMTP id a4mr1551265bkk.59.1234704618358;
        Sun, 15 Feb 2009 05:30:18 -0800 (PST)
Received: from @ (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p17sm6011263fka.30.2009.02.15.05.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 05:30:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94a0d4530902150439peac228ckec79f8c692b84e4e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110007>

On Sun, Feb 15, 2009 at 02:39:47PM +0200, Felipe Contreras wrote:
> On Sun, Feb 15, 2009 at 2:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sun, 15 Feb 2009, Felipe Contreras wrote:
> >
> >
> >>       else if (actions & ACTION_RENAME_SECTION) {
> >> -             int ret;
> >>               check_argc(argc, 2, 2);
> >>               ret = git_config_rename_section(argv[0], argv[1]);
> >> -             if (ret < 0)
> >> -                     return ret;
> >>               if (ret == 0)
> >>                       die("No such section!");
> >>       }
> >
> > You need an "if (ret > 0) ret = 0;" to avoid regressions.
> >
> >>       else if (actions & ACTION_REMOVE_SECTION) {
> >> -             int ret;
> >>               check_argc(argc, 1, 1);
> >>               ret = git_config_rename_section(argv[0], NULL);
> >> -             if (ret < 0)
> >> -                     return ret;
> >>               if (ret == 0)
> >>                       die("No such section!");
> >>       }
> >
> > Likewise.
> 
> True. Fixed in the attached patch.

I'm inlining the patch as Johannes requested:

---
 builtin-config.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 5891a4e..0606ada 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -307,6 +307,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit;
 	char* value;
+	int ret = 0;
 	const char *prefix = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
@@ -380,57 +381,55 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	else if (actions & ACTION_ADD) {
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, "^$", 0);
+		ret = git_config_set_multivar(argv[0], value, "^$", 0);
 	}
 	else if (actions & ACTION_REPLACE_ALL) {
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, argv[2], 1);
+		ret = git_config_set_multivar(argv[0], value, argv[2], 1);
 	}
 	else if (actions & ACTION_GET) {
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_GET_ALL) {
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_GET_REGEXP) {
 		show_keys = 1;
 		use_key_regexp = 1;
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		ret = get_value(argv[0], argv[1]);
 	}
 	else if (actions & ACTION_UNSET) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+			ret = git_config_set_multivar(argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set(argv[0], NULL);
+			ret = git_config_set(argv[0], NULL);
 	}
 	else if (actions & ACTION_UNSET_ALL) {
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+		ret = git_config_set_multivar(argv[0], NULL, argv[1], 1);
 	}
 	else if (actions & ACTION_RENAME_SECTION) {
-		int ret;
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section(argv[0], argv[1]);
-		if (ret < 0)
-			return ret;
 		if (ret == 0)
 			die("No such section!");
+		if (ret > 0)
+			ret = 0;
 	}
 	else if (actions & ACTION_REMOVE_SECTION) {
-		int ret;
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section(argv[0], NULL);
-		if (ret < 0)
-			return ret;
 		if (ret == 0)
 			die("No such section!");
+		if (ret > 0)
+			ret = 0;
 	}
 	else if (get_color_slot) {
 		get_color(argv[0]);
@@ -440,8 +439,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 			stdout_is_tty = git_config_bool("command line", argv[0]);
 		else if (argc == 0)
 			stdout_is_tty = isatty(1);
-		return get_colorbool(argc != 1);
+		ret = get_colorbool(argc != 1);
 	}
 
-	return 0;
+	return !!ret;
 }
-- 
1.6.1.3

-- 
Felipe Contreras
