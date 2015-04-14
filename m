From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 01:05:10 -0700
Message-ID: <CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 10:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhvqn-00023O-LP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 10:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbbDNIFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 04:05:36 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36263 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbDNIFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 04:05:32 -0400
Received: by qku63 with SMTP id 63so4669809qku.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jEsuOlb4dbYNWecI4qdZ8KgAbz4VvzBOzZYa2k58jGg=;
        b=CiuMRYesLldpdMui3rYwQNg0+Coz251B7Em698GN8xKNCKdNNrroFmu5aZCaYSH6sF
         Jz5TvKPoouxwcg/pYhAGiq0/ygrdRTP31/gpEu+VbIicfJPV1AfgvXxrv4yM1/oyzgQd
         s164O/IzUPmo5nZtY4ntjiKxiUAZF1VO3fO3UlylB4XfHr4ZicEUd0C/SOlaeMeU03Vu
         hOTe3h/Z4X/UxlBr35R8Zwp9OXm0xJnZ9d7UuBNJfquAIV+oKyBJKrEARS7B+qKD3DfC
         DKRCjgEwRzmh43OlLx96Va6i0zq+VuKBNUy186L05m28FsMAJT3AvSApU1WzjXslXa4d
         PkOQ==
X-Received: by 10.182.165.69 with SMTP id yw5mr14965361obb.5.1428998730626;
 Tue, 14 Apr 2015 01:05:30 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 14 Apr 2015 01:05:10 -0700 (PDT)
In-Reply-To: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
X-Google-Sender-Auth: iIaO29wDFrW6leUpwFHW7YmEmRE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267120>

On Tue, Apr 14, 2015 at 12:16 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> reading through the fsck docs [1] I'm having a hard time understanding
> what the difference between "unreachable" and "dangling" objects are.
>
> By example, suppose I have a commit A that is the tip of exactly one
> branch (and no tag or other ref points to A). If I delete that branch,
> is A now dangling, or unreachable, or both?

Suppose that branch consists of two commits, A and A^.
When you lose that branch (git branch -D that-branch),
both A and A^ become unreachable. So are trees and
blobs that appear only in A and A^ and nowhere else;
they are also unreachable.

A dangling object is an unreachable object that cannot be
made reachable by any way other than pointing at it
directly with a ref. A^ is not dangling, because you can
make it reachable by pointing A (the tip of the original
branch you just lost) with a ref. A on the other hand is
dangling (if you had a tag object that points at A that
you lost, then A is merely unreachable but not dangling,
because you can point at that tag with a ref and make A
reachable).
