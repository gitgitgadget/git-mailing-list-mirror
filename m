From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git peer-to-peer project: info needed
Date: Mon, 30 Aug 2010 12:31:11 +0100
Message-ID: <AANLkTi=Fr02G6u0tEhJvaZNhG=WGdQeJacH7XuJXkgaP@mail.gmail.com>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
	<vpq39twpp0e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 13:31:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq2a8-0001XO-06
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab0H3LbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 07:31:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46494 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab0H3LbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 07:31:12 -0400
Received: by vws3 with SMTP id 3so4897343vws.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ta4K6srzI/fVfrX7hILv0KOvgxfULl3M0Nw5XTiDgaA=;
        b=NDAuBcZbZ1ZtJ9gP573P2A6tYJjC/p8c5K9Y94K3gn6249rTgkchKvwiOl/jkFesfT
         MknKOhd1wMg/v4+m2sbwBKKx7czPnha/DP5r1GYZkw2eeCntntIARPFQpDrb131CrSh+
         3ZXImC7T1nVO8Vh60pXCrXyPbLe0M0oqj4v5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uvh0nYBKPlV8SwX3AlHBzmbDNl4Tc0h4+9iUBSyIcsHM3CK6IW+SSkXejZFlc1DSCT
         PsKJlUDEICArz8pfI82UcKblyPrp4VCMdEL8BcyvNmM0nI1zpYRdJsoR8PmtZjkDvYHB
         6azD0vDpHfetC4JVnPNUKmDuUsd0Pr+UjAlII=
Received: by 10.220.59.202 with SMTP id m10mr2826496vch.56.1283167871658; Mon,
 30 Aug 2010 04:31:11 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Mon, 30 Aug 2010 04:31:11 -0700 (PDT)
In-Reply-To: <vpq39twpp0e.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154787>

On Mon, Aug 30, 2010 at 7:56 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> writes:
>
>> hi folks,
>>
>> [please could you kindly cc on responses because i am subscribed with
>> "no mail" set]
>>
>> i need some guidance on what i should be doing, to add peer-to-peer
>> networking to "git fetch".
>
> There have already been some attempts at a "gittorrent" mechanism.
> Google will tell you more about that.

 i know.

 it's best to assume that i've been following those, given that i
wrote the advogato and slashdot articles which brought sam and jonas'
efforts to peoples' attention, but for the sake of brevity in
contacting the git list i didn't want to mention that, so i apologise
for not mentioning that i'm aware of gittorrent.

 sam has already ruled out the bittorrent protocol as a means to
create "mirrorsync".  mirrorsync is, as it stands, a lower-level
protocol requiring the addition of DHT and other peer-to-peer
infrastucture (NAT-busting), and sam is designing mirrorsync to be
part of git-daemon (i.e. it requires an HTTP port).

i believe that the use of HTTP is a mistake, and i believe that a
proper peer to peer git distribution protocol _requires_
bittorrent-like features, in order to have a chance of success (i.e.
be "simple" enough to use i.e. _not_ require knowledge of firewall
configuration etc.)

 so whilst this is all way outside of the scope of the git mailing
list, i'm describing the rough plan here in case anyone's interested:
the rough plan is to create a VFS layer into which i can then work
"pack objects" into quotes torrents quotes, named by filename after
the SHA1 hash.  the bittorrent protocol is perfectly capable of
supporting multiple files; thus it should not be too hard a job to rip
out the hard-coded filesystem access in the bittornado source code -
os.listdir, open(fname, "r"/"w"), osstat etc - and then redirect the
file/directory operations onto underlying git operations.

l.
