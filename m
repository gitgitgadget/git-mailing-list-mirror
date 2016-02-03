From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Tue, 2 Feb 2016 23:35:07 -0800
Message-ID: <CA+P7+xq8sv6f8K8K0EEjXg=wdKpFg6z0K5F6P4SGEp+wKdU=rA@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:36:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQryv-0006ir-HG
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 08:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbcBCHf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 02:35:28 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35356 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbcBCHf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 02:35:27 -0500
Received: by mail-ig0-f172.google.com with SMTP id hb3so5122670igb.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L2l/0RMJ0EiBry7CHww+/OLzUCTX46leHKHDPBjmK2g=;
        b=jvLt4uwdey3/Q6g7EcK7JHKHXUYTh8W5bVi1PcEztGvmP8d9hkmylkpWjStfIJBSb4
         arx6s99YJSOgVHSzXYsTahOZz6LPhkNQ6bN35962ZP+6UISoM07PT82Cju8fpm+IYOFv
         zYOuQcdHVa778/Ia2zQfh3NYZMw0nMMCFk+gLd5tgbyFYX7B0v/rHFSZkEJOo3oQKGZ4
         BPJjZ3s1XEo3kTnutfM0HyGFLf2SC9GOCyAdhUivmP39+s2fmtS8GzycygQU4sApWo2T
         HiKdkjXXibjrJA6nDo7xxsCoUF/mv+MUrO9H5uQ/kqzvQR2MT4MTU2u5vZpAA1tEIo/D
         l+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L2l/0RMJ0EiBry7CHww+/OLzUCTX46leHKHDPBjmK2g=;
        b=JTYXFsFdIpwe6VyVbg5n2im+Py9AWDAK1+wqlDC/Mf4sJnQ3ARqNojo0llRi3s1j07
         mtLJUoFGiXtD52qiehQLy46QbFqYIpSbb7RavR+F1g1wcHaCBui0zHg/r14hwAeLa8v1
         08Gy4QmvlYpsvDJo5Tqc7ef2n2itjHKBZZ4VI00uv/j/RRC2bsyOW+Tcwrfud2IOPSrD
         /JHaNJjrCXQzFcR0CCW8gmDeQl+dpH2hVgCshvVVWFXUqD0+NAFEhahbICKwensu51nF
         /J6XIAXp+dXWhcHJZU8Rt9ACYX5lwDBqPatIWatxk5HyhHtWjI+H0OeDYTedTvWdnKhu
         ky9Q==
X-Gm-Message-State: AG10YOR2PVhS9cm331y0s0HgMDatSX54r3IP1NauBZRPQNp7c4VQnb27mu8OafhzkUXJ0uoDZeo0LEaQHBRQwA==
X-Received: by 10.50.142.73 with SMTP id ru9mr22600415igb.92.1454484926884;
 Tue, 02 Feb 2016 23:35:26 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Tue, 2 Feb 2016 23:35:07 -0800 (PST)
In-Reply-To: <20160203042554.GA21179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285337>

On Tue, Feb 2, 2016 at 8:25 PM, Jeff King <peff@peff.net> wrote:
> I think the problem is that when git "switches" to working in the
> submodule repository, it clears the environment, which includes any "-c"
> command switches. This makes sense for some situations, but not for
> others. This thread shows a similar problem:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/264840
>
> Jens suggested there adding an option to tell clone to pass specific
> variables to the submodule, which I think makes sense. AFAIK, nobody has
> done any work yet on that approach.
>

This is something that I am also interested in, haven't had a chance
to look at it just yet though. I may have some time soon to take a
stab at this.

Regards,
Jake
