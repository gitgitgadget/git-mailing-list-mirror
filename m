From: Eric Raible <raible@gmail.com>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 11:05:08 -0700
Message-ID: <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
	 <20090630040337.GA23741@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLhhn-00060E-Vl
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 20:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZF3SFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 14:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbZF3SFH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 14:05:07 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:33912 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbZF3SFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 14:05:06 -0400
Received: by qyk31 with SMTP id 31so358151qyk.33
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fsF9NxHIfxeiLyxCzREn4tAjiyxhTmvWuznoHuQqNF4=;
        b=s6Bdgc/D5v/kOB4ih9uuX+sCJJcJ/FpnE0BJwff8P7R4ugOCgzqKTkG2Q+pA0g/ERD
         UPvfVmBlkRrF0D1vQHjdIdpac4WXSVJ6vHE4Vy+nhdJl708liuiB2F2jMDM8ZhYvLpPx
         r6IEIeBkDKOExTgM5OVHNuXk93AgUIVV6i2RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ncc3JWVD4OVOUTMFk+oECKBoqYV3zSBJ+Bm7LgfmI1GhVXH9occKNk0JD5SiVYRT09
         9EMHBFYpf491MzEwxunNdVGcDDmgodiF5ytAfFEdiJegc2yQBxNlz9sUhBO5U7h25c5/
         ZPc11NwplPrMlz0/KhdbeCjZil9QYyvAENBjM=
Received: by 10.220.74.2 with SMTP id s2mr6812137vcj.37.1246385108952; Tue, 30 
	Jun 2009 11:05:08 -0700 (PDT)
In-Reply-To: <20090630040337.GA23741@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122525>

On Mon, Jun 29, 2009 at 9:03 PM, Jeff King<peff@peff.net> wrote:

> You can at least combine rev-list and diff into one command, and grep
> like this (for 'foo'):
>
> =A0git log -z -p | perl -0ne 'print if /^[-+].*foo/m' | tr '\0' '\n'
>
> -Peff

Thank you, that will do very nicely as a starting point.

What I _really_ want is the subset of all commits containing foo
who's oneline commit message doesn't match a given regexp.

So I'm used something like this to extract the commits of interest:

git log -z -p | perl -0ne 'print if /^[-+].*foo/m' | tr '\0' '\n' |
grep "^commit [0-9a-f]" | awk '{print $2}' |
xargs -n1 git log --pretty=3Doneline -1 |
grep -v dont_want

In this specific case of wanting to ignore particular commits a loop
over git-rev-list might yield a better solution.  But the 'git-log | pe=
rl | tr'
snippet is a nice idiom for day-to-day use.
