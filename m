From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 3 May 2013 13:23:32 -0500
Message-ID: <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 03 20:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYKdv-0007rv-3O
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 20:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763116Ab3ECSXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 14:23:34 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47572 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3ECSXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 14:23:34 -0400
Received: by mail-lb0-f178.google.com with SMTP id x10so1779277lbi.23
        for <git@vger.kernel.org>; Fri, 03 May 2013 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kwMt102vR5cmkoXXeFrLbxNtNE6B5bijliAz+LLnUV4=;
        b=aCSiCDm+OGTRsXDQ/NfkRzPkgeMmtkVG5Dt+TTkA6ZF4lrlmTSPzujS6g8LfBSFwUd
         /DhVyAvL8ERVkT09XgWmWaxGafoCBb3wkLJYk4/lxVwYMuZcFDvzcbZrSgr1KhGN3+yQ
         DgZM5EbEqzGLoOBc/McTCG+4Ndv2h99wudzzOY9NS/500iA67smnG9day07kScDs4Gk2
         osg7b5HJtMr1vYe//X147s6jxzS92MfCnHUOdZpOi581IIAeszo3CV6X4dfXjP/Ytdtt
         I9gmr8Un8U4wVgGFgYkqvgtn2OndUEUGO5+Rp+ssiaUgwXkNpv5jI0mmuLVcRczwNwCk
         e1ig==
X-Received: by 10.152.29.165 with SMTP id l5mr1432295lah.8.1367605412538; Fri,
 03 May 2013 11:23:32 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 3 May 2013 11:23:32 -0700 (PDT)
In-Reply-To: <87y5bw3q1s.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223317>

On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> How do we know that this doesn't break any users of fast-import?  Your
> comment isn't very reassuring:
>
>> the vast majority of them will never be used again
>
> So what's with the minority?

Actually I don't think there's any minority. If the client program
doesn't store blobs, the blob marks are not used anyway. So there's no
change.

However, there's a chance the client programs do rely on blob objects,
in which case things would break. I would like to analyze some client
programs of fast-import out there, to see what would be the impact.

But I think this has to be done either way, the only question is how.
Having a warning would take a lot of effort, and it might be for
nothing. I think it might make sense to knowingly make the potentially
dangerous change, and see what breaks. Most likely nothing will, but
if something does, we revert immediately.

Otherwise we would be stuck in this non-ideal state forever.

Cheers.

-- 
Felipe Contreras
