From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 14
Date: Tue, 24 Jul 2012 08:23:18 +0700
Message-ID: <CACsJy8A8J-FXtJezOZrmqfUPX5unbGG15A6BuZnDW+164n6-kw@mail.gmail.com>
References: <20120723190847.GA40532@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mhagger@alum.mit.edu, trast@student.ethz.ch,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 03:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StTqt-0006yO-HG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 03:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab2GXBXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 21:23:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43781 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2GXBXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 21:23:49 -0400
Received: by obbuo13 with SMTP id uo13so10345021obb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yl+Iws5bFRwOnPSWx1p5vwctIzJDYwRGRGE9foDQXL0=;
        b=K3acdbJR9uVNby/aapOxNa9OxYND4i5rymV3kJAJPe9YVXuQ7yxaIhwLzHHJisqown
         VU+3uQ2RkXSPY4N5VZgAiHNq8vGgA0/udgAzydMe8MG0K6B8f5e9aLLC+kSwWAqKaWas
         BSp5AUvebxoPgH5mbB5fhWUc0lXrpL73wFoaavqGPEZxctFgH1vNEU5RumSjYmT57lkP
         +9v1urcJLsmllPKfkCXsGlWSCm+iFLJuFFYuyIIrKz67m8L8R+wcqWk6fXXbdYEjbjCi
         Z0NoD3uMvCd5LDR4K1lwp/hvDeGyq5xj3GCOkOSbhHUNlDBbYZFE9YYAfYdVYJyNtnpL
         HQbw==
Received: by 10.182.167.41 with SMTP id zl9mr23777656obb.43.1343093028715;
 Mon, 23 Jul 2012 18:23:48 -0700 (PDT)
Received: by 10.182.177.67 with HTTP; Mon, 23 Jul 2012 18:23:18 -0700 (PDT)
In-Reply-To: <20120723190847.GA40532@tgummerer.surfnet.iacbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202006>

On Tue, Jul 24, 2012 at 2:08 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> - We added a POC, for partial loading in git grep. This is still a
>   pretty hacky implementation, but it demonstrates pretty well
>   how much can be gained. Here are the timings Thomas posted on
>   IRC yesterday. The improvements of ls-files are not drastic
>   compared to index-v4, but git greps in subdirs benefit a lot
>   from partial loading.
>
>   Test                                      this tree
>   -----------------------------------------------------------
>   0002.2: v[23]: ls-files                   0.13(0.11+0.02)
>   0002.3: v[23]: grep nonexistent -- subdir 0.12(0.10+0.02)
>   0002.5: v4: ls-files                      0.11(0.09+0.01)
>   0002.6: v4: grep nonexistent -- subdir    0.10(0.08+0.02)
>   0002.8: v5: ls-files                      0.10(0.07+0.02)
>   0002.9: v5: grep nonexistent -- subdir    0.01(0.00+0.00)
>

Is ls-files improvement not drastic because you do not limit subdir
like grep? I see Thomas Rast put similar partial loading hack to
ls-files.c so I assume it can partial load too. Is partial loading
still fast with when a lot of unmerged entries are present?
-- 
Duy
