From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Fri, 22 May 2015 12:24:53 -0700
Message-ID: <CAPc5daVFA-FKTSUCRmb=JUr=H9ECtK8nJB3nyxHprCcJ+0CHBQ@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Fri May 22 21:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvsZN-0004Ya-F6
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 21:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024AbbEVTZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 15:25:16 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34703 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbbEVTZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 15:25:15 -0400
Received: by oige141 with SMTP id e141so21207649oig.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=wedDh8h8YHhyTYyH9gwTJamiMnYsVG44Qisjp04jYKw=;
        b=hXfoWAnE6KhG3nlxNNGMrSKpz7x5dFmwt0kiOl6ngvETJRocEBTTf7uwHNgpEeOYmq
         Sb7iJe4ScPnjgAZX3WcO7mccYSqqn4xT7Ak2M0BnysV7VZT1S3zz1XghOK7QSI1F8AOE
         IEXCtvcKy1Od1zVc6YnDH7cBEfdHfjMrnl8N/9zauA/2zyHaU7YYJEGJ18HoCRbhXTUd
         lSNieX2gEIeIJFu2CMIt2A33gtOoUorV3Ulq0cy8MAaqL/g5jq4mxk/6+kVspgh3JC8f
         C5qMC4MC/5g3VtOyy9edSIhj1C+JGBV66B4iYXmBEADUqZPNmbfrUgBlkNI0RzpLZD09
         xXZA==
X-Received: by 10.60.155.97 with SMTP id vv1mr4864413oeb.15.1432322714970;
 Fri, 22 May 2015 12:25:14 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Fri, 22 May 2015 12:24:53 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
X-Google-Sender-Auth: Gri59qtF-vWblH-QQN3FtOotNtM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269750>

The message "unordered stage entries in index" comes only when
two adjacent entries in the index are in a wrong order, e.g. "test0"
should come before "test1" but somehow the index records them
in the other way around. Doing something like this:

$ git ls-files >Q
$ LANG=C LC_ALL=C sort Q >R
$ diff Q R

may tell you which entries are wrong, even though it wouldn't show
who made them wrong.

(pardon top-posting, overlong lines and typos; sent from GMail web UI)

On Tue, May 19, 2015 at 6:48 AM, McHenry, Matt
<mmchenry@carnegielearning.com> wrote:
>
>         I've just upgraded my git from 2.0.5 to 2.3.6, and I'm now unable to run 'git svn fetch' in one of my repositories:
>
> $ git svn fetch
> fatal: unordered stage entries in index
> write-tree: command returned error: 128
>
>         'git status' shows a few untracked files but is otherwise clean.
>
>         It looks like this check was introduced in 15999d0be8179fb7a2e6eafb931d25ed65df50aa, with the summary "read_index_from(): catch out of order entries when reading an index file" (first appearing in 2.2.0).
>
>         Mailing list discussion looked like it implicated third-party tools.  I don't recall running any other tools on this repo; it doesn't do much day-to-day other than a long series of 'git svn fetch'es.  (But it's been around for a couple of years, so who knows.)
>
>         At any rate, what can I do to recover from this situation?  I tried to locate a path with multiple index entries like this, but got no results:
>
> $ git ls-files -s | cut -f 2-100 | sort | uniq -c | grep -v '^[ \t]*1 '
>
>         (I originally posted on SO at http://stackoverflow.com/questions/30264826/; I'll update that with any solutions that come up here, to ease future googling.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
