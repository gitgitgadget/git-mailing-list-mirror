From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 20:49:23 +0200
Message-ID: <CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
	<7vr4pt16ep.fsf@alter.siamese.dyndns.org>
	<505F5151.2080208@web.de>
	<7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
	<7v39271j3n.fsf@alter.siamese.dyndns.org>
	<5060A32D.1060902@web.de>
	<7vlifzz2vo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDio-0000tk-T3
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab2IXStZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:49:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39970 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617Ab2IXStY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:49:24 -0400
Received: by wgbdr13 with SMTP id dr13so3964899wgb.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wLnh7U8afgLdfiQIeWcxtWLT2J6FKPHx+Pgqe2fnqzI=;
        b=puPQvozssHSmJ/SaLLw3FGkMkUqGU6IMQer4GsCgoYRbN2IWXINz+KOVn126XFE7DT
         yOyJZFmRCVfviY/kRf3QGs38NL6oWAJxdJFg1LNplbFDTImv5cnJn7QgoPhM4FiLl3qo
         wiB5vglDZKYMTzs9sdwLMVKbnm1dutiaVnS0ZQLCsEKIl33+pgPruOWWkJXHdiLVuXDw
         sN0h2UfADPjWkJepdzrGzwLpjHcoA3oJuVAbNe9/o5MB2xfzcQqQi46bL3KFzxEfeupu
         oex3V3s54/ULJ1XSHHnXmWKp2T2Z0hb5gnKXTvttPyi6idWx1pb7hrBW+7TzaREyMfqX
         ebdw==
Received: by 10.180.105.163 with SMTP id gn3mr16238644wib.2.1348512563188;
 Mon, 24 Sep 2012 11:49:23 -0700 (PDT)
Received: by 10.194.54.166 with HTTP; Mon, 24 Sep 2012 11:49:23 -0700 (PDT)
In-Reply-To: <7vlifzz2vo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206309>

On Mon, Sep 24, 2012 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
> > Am 24.09.2012 18:27, schrieb Junio C Hamano:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>> In any case, the log message I suggested in the review needs to be
> >>> updated in the reroll to make it clear that this is about reading
> >>> from .gitmodules, not "configuration".  AFAICS, gitmodule_config()
> >>> does not even read from $GIT_DIR/config, right?
> >>
> >> OK.  gitmodule_config() does not read $GIT_DIR/config, but
> >> cmd_status() and cmd_commit() call git_diff_basic_config() that is
> >> called from git_diff_ui_config() to read submodule.$name.ignore from
> >> it.  So Orgad's patch is _only_ about submodule.$name.ignore that is
> >> in in-tree .gitmodule; the log message shouldn't mention "config",
> >> as setting configuration variables work for both status and commit
> >> just fine.
> >
> > Yes, I was just checking that call path too to make sure the user
> > settings from $GIT_DIR/config really override those found in
> > .gitmodules. And of course you are right, while the change to the
> > code is sane the commit message still needs some work.
>
> Here is what I tentatively queued on 'pu' (not pushed out yet).
>
> -- >8 --
> From: Orgad Shaneh <orgads@gmail.com>
> Date: Sun, 23 Sep 2012 09:37:47 +0200
> Subject: [PATCH] commit: pay attention to submodule.$name.ignore in
>  .gitmodules
>
> "git status" does not list a submodule with uncommitted working tree
> files as modified when "submodule.$name.ignore" is set to "dirty" in
> in-tree ".gitmodules" file.  Both status and commit honor the setting
> in $GIT_DIR/config, but "commit" does not pick it up from .gitmodules,
> which is inconsistent.
>
> Teach "git commit" to pay attention to the setting in .gitmodules as
> well.
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/commit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 66fdd22..3cb1ef7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1256,6 +1256,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         struct wt_status s;
>
>         wt_status_prepare(&s);
> +       gitmodules_config();
>         git_config(git_commit_config, &s);
>         in_merge = file_exists(git_path("MERGE_HEAD"));
>         s.in_merge = in_merge;
> --
> 1.7.12.1.441.g794a63b
>

That is not correct. git-config is ignored as well for commit. Maybe
another fix is needed?

- Orgad
