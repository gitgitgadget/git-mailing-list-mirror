From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 22:10:55 +0100
Message-ID: <AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<m3y6bjnadu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 23:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrH6b-0002EX-9h
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748Ab0IBVLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 17:11:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54509 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab0IBVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 17:10:56 -0400
Received: by qyk36 with SMTP id 36so2480599qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=JQtT+mparhQCH11g5Vg+S47fz0lyiXT2nJPr5bKs3Tc=;
        b=damOH3aU+91qjQVy5/YPsQd34o1IggPmNPCs25+aOTIRGWuXjLWybm78i3yTAJTZeP
         sWDAt5QLaShzCHckIa2wzz7CDY7kGK43+9ti/etdY8bNEb5Gz4GPWo8i+7JTG1liZwum
         HupVQbQ2hcJrEkCrPVlO2ri3S/HrMuDRBdD48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A4CjNozzvnq0nBKHZq7tFU8YbATAl9D+nEe/1WPe/yzXGBw+SwaQ9BoHZPskHf6oPl
         rnHqHIqERtIketHqAL/9aetMLSBuEC1VGTyYzHYRQCXPz6y84MrWPXLuPTSpYqjdVyiY
         xgHagmT+ZrC5LgmkuuFy16/sgbAYDDBFsJBrI=
Received: by 10.224.37.134 with SMTP id x6mr354808qad.274.1283461855586; Thu,
 02 Sep 2010 14:10:55 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 14:10:55 -0700 (PDT)
In-Reply-To: <m3y6bjnadu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155207>

On Thu, Sep 2, 2010 at 9:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> If I remember the discussion stalled (i.e. no working implementation),
> and one of the latest proposals was to have some way of recovering
> objects from partially downloaded file, and a way to request packfile
> without objects that got already downloaded.

 oo.  ouch.  i can understand why things stalled, then.  you're
effectively adding an extra layer in, and even if you could add a
unique naming scheme on those objects (if one doesn't already exist?),
those object might (or might not!) come up the second time round (for
reasons mentioned already - threads resulting in different deltas
being picked etc.) ... and if they weren't picked for the re-generated
pack, you'd have to _delete_ them from the receiving end so as to
avoid polluting the recipient's object store haaarrgh *spit*, *cough*.

 ok.

 what _might_ work however iiiiIiis... to split the pack-object into
two parts.  or, to add an "extra part", to be more precise:

a) complete list of all objects.  _just_ the list of objects.
b) existing pack-object format/structure.

in this way, the sender having done all the hard work already of
determining what objects are to go into a pack-object, transfers that
*first*.  _theeen_ you begin transferring the pack-object.  theeeen,
if the pack-object transfer is ever interrupted, you simply send back
that list of objects, and ask "uhh, you know that list of objects we
were talking about?  well, here it is *splat* - are you able to
recreate the pack-object from that, for me, and if so please gimme
again"

and, 10^N-1 times out of 10^N, for reasons that shawn kindly
explained, i bet you the answer would be "yes".

... um... in fact... um... i believe i'm merely talking about the .idx
index file, aren't i?  because... um... the index file contains the
list of object refs in the pack, yes?

sooo.... taking a wild guess, here: if you were to parse the .idx file
and extract the list of object-refs, and then pass that to "git
pack-objects --window=0 --delta=0", would you end up with the exact
same pack file, because you'd forced git pack-objects to only return
that specific list of object-refs?

l.
