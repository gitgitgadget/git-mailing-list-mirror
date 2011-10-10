From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Garbage collection creates many unpacked objects.
Date: Mon, 10 Oct 2011 16:49:12 -0700
Message-ID: <CAJo=hJtGyaudyL63AcaG=y4fvfO8Ka3pn=Orta-imb6AUXO6XA@mail.gmail.com>
References: <201110101730.43302.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 01:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPbF-0001vB-OB
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 01:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1JJXtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 19:49:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48510 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1JJXtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 19:49:32 -0400
Received: by iabz25 with SMTP id z25so888057iab.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 16:49:32 -0700 (PDT)
Received: by 10.43.49.131 with SMTP id va3mr21121360icb.51.1318290572081; Mon,
 10 Oct 2011 16:49:32 -0700 (PDT)
Received: by 10.42.4.68 with HTTP; Mon, 10 Oct 2011 16:49:12 -0700 (PDT)
In-Reply-To: <201110101730.43302.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183270>

On Mon, Oct 10, 2011 at 16:30, Martin Fick <mfick@codeaurora.org> wrote=
:
> If I clone linus' kernel, delete all the tags, and then run
> git gc, it ends up expanding into about 5K of unpacked
> objects. =A0The .git size goes from 473M to 511M. =A0This seems
> a bit strange no? =A0Shouldn't gcing yield a smaller repo an
> fewer unpacked refs?
>
> If I do this on our internal kernel repo (which has 2Ktags),
> it gets much more pathological, it expands to about 1M
> objects and grows to about 7G!!!

This is caused by unreachable objects being evicted from packs and
stored as loose objects for up to 2 weeks, until the next `git prune`
run. I think you can avoid this by using `git repack -a -d` instead of
`git gc`, but at the risk that a concurrent modification of the
repository may result in corruption due to a race condition between
the object being needed, and the object being deleted.
