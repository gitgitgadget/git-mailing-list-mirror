From: Stefan Beller <sbeller@google.com>
Subject: Re: git mergetool: create temporary files in different sub-folders
 but with same filenames
Date: Tue, 2 Jun 2015 11:57:01 -0700
Message-ID: <CAGZ79kbiOe1Krs1Kxb_eKLF9gn830sSVArMp8oXcnHRPQngkvQ@mail.gmail.com>
References: <556DFA79.9020904@anbos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andre Bossert <anb0s@anbos.de>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrNB-0007Vt-HO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbbFBS5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:57:04 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36205 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbFBS5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:57:02 -0400
Received: by qgep100 with SMTP id p100so530092qge.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0vsKmv8PmMoEJp92GNYpSQEPAbopRcVjOG0DiE1+9zY=;
        b=Kw9TxEVpn8NJlsthpAYgLEdZ+DyLXhNZRNNJyaX/+AhVJNTq5BzlQWg3flTnU7/07k
         DhJvGez/UtnLTCF6c+7LssoXeqe5r+pZD4IB2PDCsxDQAfYhrd/d2jGnNJpzjvKi3AAO
         nxYLw4cQZSEoIbkJh65bdk1ZMAv6/eqVdiEj5n69+Rk4YBhOnl6Ldjhul4MAGcKdauaG
         figxXGYRhNUnMxi9OgajbFRW2rJYzNxtKxjogm9BLy5ZxpXZTKlQSPN7P20qXZOQKiJJ
         TgZmQb9F3t+vS4gvmNFF74DEXdbNsDFoPBmTQILl5LOk2CWWs4D2OGTiuQ4aHF+wFJxa
         7bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0vsKmv8PmMoEJp92GNYpSQEPAbopRcVjOG0DiE1+9zY=;
        b=heuUnCTsh6oRyMP/xyynoYuGKVabGd5MbN+WbQypmAYzs1WUQyOI2n5/RmvzVT4kX9
         BQ6gY5KyJO+vdRhSZ8zU6Ynyj8kZLrKZ/HJB9Wqf+gtDPvtCnDfl6QI0cytHQ9Zo8hRv
         ihk7RUPyUY1Ta2Dp5A3S4JmwirDSohpi5vzFvpisQZrBlhjV0dtOjOiQTPrC4luE//jQ
         K5IAAOveZl5iqGyH6vGe9m6mFng8KOFyorBxDTduNojRoDj58HZby+fFdjwlUOvPvO3D
         rPqHtNl+Ai0m4fWcIMXF8E25QsWS9y8nwIqt4++cq19VyMPwpX5l+GDYaJ6HGz4Zg92W
         Kc+A==
X-Gm-Message-State: ALoCoQkTK75PVTXS0jzMZ35rRqbG3zGeke+E5qafCt0hHpEJHCN+RdVIDdEGInmHB8fCGT9ajB4j
X-Received: by 10.140.196.140 with SMTP id r134mr31544703qha.60.1433271421618;
 Tue, 02 Jun 2015 11:57:01 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 11:57:01 -0700 (PDT)
In-Reply-To: <556DFA79.9020904@anbos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270584>

On Tue, Jun 2, 2015 at 11:48 AM, Andre Bossert <anb0s@anbos.de> wrote:
> Hello,
>
> we are moving from ClearCase to Git (MSYS 1.9.5 at Win7x64) and trying to
> configure one special merge tool "DiffMerge" for IBM Rhapsody files. So
> we've added our merge tool (script) to gitconfig. The merge script calls the
> DiffMerge for some file-extensions (sbs, rpy etc.). It works in general, but
> the different file names passed to DiffMerge (e.g.
> <base-name>.LOCAL.xyz.<ext>, <base-name>.REMOTE.xyz.<ext>) are shown as
> conflict  --> user have to solve it manually.
>
> I've found the new feature (mergetool.writeToTemp = true) in
> "https://github.com/git/git/blob/master/git-mergetool.sh
> <https://github.com/git/git/blob/master/git-mergetool.sh>" that creates one
> temporary folder for all four files with different names. I've added some
> handling for sub-folders.
>
> Instead of:
>     BACKUP="./$MERGED.BACKUP.$ext"
>     LOCAL="./$MERGED.LOCAL.$ext"
>     REMOTE="./$MERGED.REMOTE.$ext"
>     BASE="./$MERGED.BASE.$ext"
>
> i've added this definitions (and some other handling for creation etc.)
> ...
>     TEMP_BACKUP="$MERGETOOL_TMPDIR/BACKUP"
>     TEMP_LOCAL="$MERGETOOL_TMPDIR/LOCAL"
>     TEMP_REMOTE="$MERGETOOL_TMPDIR/REMOTE"
>     TEMP_BASE="$MERGETOOL_TMPDIR/BASE"
>
>     BACKUP="$TEMP_BACKUP/${BASE}$ext"
>     LOCAL="$TEMP_LOCAL/${BASE}$ext"
>     REMOTE="$TEMP_REMOTE/${BASE}$ext"
>     BASE="$TEMP_BASE/${BASE}$ext"
> ...
>
> I've tested the script with normal merge-workflows and it worked. May i
> request a review and integration in Git?

https://github.com/git/git/blob/master/Documentation/SubmittingPatches
explains how to get your change into Git.

So essentially you'd not write an email as this in prose, but rather as a patch.
So you'd make the change as above in your copy of git.git and commit it,
then format it with git format-patch and then send the result to this list. :)

>
> --
> Regards
> Andre (anb0s)
> eMail: anb0s@anbos.de <mailto:anb0s@anbos.de>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
