From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: feature suggestion: optimize common parts for checkout --conflict=diff3
Date: Wed, 6 Mar 2013 19:27:59 +0100
Message-ID: <CALWbr2zjrKN-op+deOvjT5ZC+6X=we7eoXTPv9W4AkcNst4yMw@mail.gmail.com>
References: <20130306150548.GC15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, kernel@pengutronix.de
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 06 19:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDJ4m-0003ds-C8
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 19:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3CFS2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 13:28:01 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:52590 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3CFS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 13:28:00 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so1540791qco.35
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wRzxPObcy09r1CAHGpF5zMKq36myK5ldOKK6zMP+5Bk=;
        b=0hkgZKh+muekSAF8vfgfxW11JjHx0PypXJy9P4fdtJHvDF3U4ZOThQDikj00UqBcc+
         oU6CNnO9QvRGSRXiGlaiu0HDqpsOB3A3ZvwJBzTSfF9mPn/BkLaHmPTABr204XkshhRV
         fpQoTclIQlkID1ahFe9k1a2AYOEtfdUz+j+0c1HiNMD6N7GwdZkXREIKF5ngXzWFGA2L
         KqQgndbXBms2TbefAc6Q+bhAQTX8CIbeekPooMsINkrCIHx77Q4DLWjaj7USp3ljw7ZY
         HurU1pPuw4PGHA2d3hEiAmLXtPC/7vZZpbEW4YSfqNV6SgBcALNJ9qtfCSctm/MLIsTo
         ONsA==
X-Received: by 10.224.180.15 with SMTP id bs15mr46086245qab.24.1362594479935;
 Wed, 06 Mar 2013 10:27:59 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Wed, 6 Mar 2013 10:27:59 -0800 (PST)
In-Reply-To: <20130306150548.GC15375@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217535>

>         git checkout --conflict=diff3 file

That's somehow unrelated, but shouldn't we have a "conflict" option to
git-merge as we have for git-checkout ?

With something like this (pasted into gmail):

diff --git a/builtin/merge.c b/builtin/merge.c
index 7c8922c..edad742 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -65,6 +65,7 @@ static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
 static const char *sign_commit;
+static char *conflict_style;

 static struct strategy all_strategy[] = {
  { "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -213,6 +214,7 @@ static struct option builtin_merge_options[] = {
  { OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
   N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
  OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, N_("update
ignored files (default)")),
+ OPT_STRING(0, "conflict", &conflict_style, N_("style"), N_("conflict
style (merge or diff3)")),
  OPT_END()
 };

@@ -1102,6 +1104,9 @@ int cmd_merge(int argc, const char **argv, const
char *prefix)
  if (verbosity < 0 && show_progress == -1)
  show_progress = 0;

+ if (conflict_style)
+ git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+
  if (abort_current_merge) {
  int nargc = 2;
  const char *nargv[] = {"reset", "--merge", NULL};
