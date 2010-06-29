From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below D/F 
	conflicts
Date: Tue, 29 Jun 2010 06:52:07 -0600
Message-ID: <AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
	<1277773936-12412-5-git-send-email-newren@gmail.com>
	<20100629075442.GB31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	spearce@spearce.org, raa.lkml@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 29 14:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTaIb-0001iv-CL
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 14:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0F2MwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 08:52:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54997 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab0F2MwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 08:52:08 -0400
Received: by mail-vw0-f46.google.com with SMTP id 5so1405610vws.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kYfRJcw7ucrkLtLFocbWCN61zsFRwCUYcpR13tdjh9E=;
        b=EHVTDS5Gjkf+5wa81GoLLTVjWugqWBA31ADz/ySANf0DorLJBuGKKhli3iM5XvV3pK
         HOepniQRqx8AuCJtQcXo470ixVnhsBIBlSdWugFqx3IBk+T/Hg8gfw/AUq0NImZfPg0i
         6TL14UR3xoY3DzxSF1qN6SPOkoswYLYrZisV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yCTUTLjiaHPGAo42bDq0GBcYvoUdtLlua/TNrg9Q13Q1elWrqgHRCy62d8DMbKRwRw
         wKGDFOLouyOdiw5CmiKRFDWVupb0hbV6wA3r4uBhpPkUDIx3u1b8vHdEg7qYPQuT2gji
         FqYUGetA0egf26WfYw6vkYKbld2rCsgn9K1N4=
Received: by 10.220.109.196 with SMTP id k4mr526404vcp.61.1277815927846; Tue, 
	29 Jun 2010 05:52:07 -0700 (PDT)
Received: by 10.220.83.138 with HTTP; Tue, 29 Jun 2010 05:52:07 -0700 (PDT)
In-Reply-To: <20100629075442.GB31048@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149902>

On Tue, Jun 29, 2010 at 1:54 AM, Miklos Vajna <vmiklos@frugalware.org> =
wrote:
> On Mon, Jun 28, 2010 at 07:12:15PM -0600, newren@gmail.com wrote:
>> I'm a little uneasy with this change, mainly because I don't fully
>> understand the rename processing logic (I was actually kind of surpr=
ised
>> when I made these changes and it worked). =C2=A0Although I verified =
that
>> these changes (and my others in this patch series) introduce no new
>> breakages in the testsuite and even fix a known issue, I'm still not
>> quite sure I follow the logic well enough to feel fully confident in
>> this change. =C2=A0I'm particularly worried I may have neglected som=
e closely
>> related cases that I should have fixed but which may still be broken=
=2E
>
> Same here, I touched merge-recursive, but not this part of it, so oth=
ers
> will give you a better review, I'm sure. :)
>
> Other than that, I like it, thanks!

Oh, it looks like I was off by a couple lines when trying to read the
authorship out of git blame -C -C.  You touched lines that were pretty
close, but it looks like this if block was actually due to Alex.  So
I'll add him to the cc.

Alex: I think the basic idea is just that the rename logic isn't aware
that there may be higher stage entries in the index due to D/F
conflicts; by checking for such cases and marking the entry as not
processed, it allows process_entry() later to look at it and handle
those higher stages.  But I'm not sure if that's the right way to
handle it, or if just having process_renames() should take care of
clearing out the higher stage entries, or if something else entirely
should be done.

Thanks,
Elijah
