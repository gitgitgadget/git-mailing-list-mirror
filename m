From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git diff-index with relative git-dir does not work
Date: Tue, 9 Feb 2010 18:58:51 +0700
Message-ID: <fcaeb9bf1002090358v3d7f69d5ra80c186d30a1304d@mail.gmail.com>
References: <871vguy8hz.wl@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 12:59:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neok6-0005ki-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 12:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0BIL6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 06:58:53 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:59950 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0BIL6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 06:58:52 -0500
Received: by pzk2 with SMTP id 2so227902pzk.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 03:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2u334AH2xw/FRu3o6i28VOEX3c1LR7zNsBfRL2X3K4k=;
        b=FtW7PhKeKdKptrzbcAn5KQsXxpFUAh4j/W5rvZy48dQdyzyqRerkobTmyyqitxND+1
         iOjLtUGMfK9M5kiNdl1E8Cm5mpHpIOgQj5DceRXrzwQ9XNMM2nEhA6GMcALxgor8ucUQ
         19yYiOc1K29frn85Hb6MkxjW1jVtz+BIsB8H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xYX3rgOy5S9qO2YAidQMNVHMMF6S4cPdGJ9938+wZCx891/Bl3k/6ZeNbi12TTE+tp
         rzSE+Nw/FffXfK8XEWS2mPDb/Z5ePvNOl8gxcHPNlU083X79D+sMypyYgyYQwgrNxMZr
         XzZdlnA2jBkh4jlf8A4ObZ/4rdyTAaALYwHE0=
Received: by 10.114.215.30 with SMTP id n30mr586155wag.56.1265716731709; Tue, 
	09 Feb 2010 03:58:51 -0800 (PST)
In-Reply-To: <871vguy8hz.wl@dns1.atmark-techno.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139395>

On 2/9/10, Yasushi SHOJI <yashi@atmark-techno.com> wrote:
>  ...
>  This is because static variable 'base' in sha1_file_name is already
>  assigned _before_ setup_work_tree() from cmd_diff_index() is
>  called. setup_work_tree() eventually chdir to the given work tree dir,
>  but we use the old base to generate object file path. And that cause
>  open(2) to fail because the object file path and the current dir is
>  not in sync any more.
>
>  So, is it correct to assume that we must call setup_work_tree()
>  _before_ any function which call getter/setter in environment.c?  This
>  including open_sha1_file, in this case.

We must if gitdir is relative to cwd (and will be moved by
setup_work_tree). Or just make gitdir absolute path.

>  Also, would it be a good idea to make all builtin command to
>  _explicitly_ call setup_* functions, so that we can find calling order
>  bug?

If you agree that writing "RUN_SETUP" in git.c is explicit, then all
builtin commands do explictly call setup_*. It's about relative
directories and cwd being moved around.

>  In that case, we must change the setup functions signature to
>  allow marking "not interested" or something.

I'm not sure I get your idea.
-- 
Duy
