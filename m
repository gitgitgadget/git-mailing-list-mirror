From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 16:08:03 +0100
Message-ID: <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
	<AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
	<AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
	<20100831143839.GC16034@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSRc-0005V9-5l
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab0HaPIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:08:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64807 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309Ab0HaPIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:08:06 -0400
Received: by vws3 with SMTP id 3so5432068vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fok/6BzlhYQKfuI416BqcJyXYvDtYRo7Z51tci8m0C8=;
        b=LIFTiViYYIEtjKluWvFYwf967ljxt+8MdL9+5G52+SifiEa4eK+SHCGfWro4rI5bof
         rAozZXDBHiF0xe42qaPXVZbnCr+ZeWS52RlP/DWTD9RYKItIQ1rcooisjp9+ljblxAYT
         cxB/DcsN4YTx+jQIO0+0akka7ErqEvVkp+Z0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k5OXHI2hFn7koG23xxqJFqwABFa2Gxg/i54DpbhX5TfeefYi5xqMW2aIlOWXbi6jOV
         7GhRGFITieM0pEPN+rqcf4EeqRSVVZjSfbFP/uDYSscWXpZrM0g6XThltAgzDZCs7+6l
         WEc5hCTdG1kKPALHQTT/LoNDFoVSQvxvoXb/c=
Received: by 10.220.169.14 with SMTP id w14mr4151712vcy.17.1283267283593; Tue,
 31 Aug 2010 08:08:03 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Tue, 31 Aug 2010 08:08:03 -0700 (PDT)
In-Reply-To: <20100831143839.GC16034@foucault.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154908>

On Tue, Aug 31, 2010 at 3:38 PM, Casey Dahlin <cdahlin@redhat.com> wrot=
e:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0nguyen@host_b$ git config --add hive.uri h=
ttp://myproject.org
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nguyen@host_b$ git hive start host_a.com:2=
1121
>
> So from host_b we specify host_a's address and listen port, and we jo=
in the
> network. From here on out anyone who also connects to host_a will get=
 host_b's
> (randomly selected) listen port automatically and be able to connect =
to it as
> well.
>
> So now our two peers can see each other.

 ok - this only works if the two peers can see each other's ip
addresses.  i.e. if the two machines are either on a local subnet or
if the two machines are directly on the public internet.  ( or if
you've forced people to set up a firewall rule and/or UPnP rule, but
even then UPnP doesn't solve the entire problem - only one part of it)

 ... unless (and i haven't reviewed the code closely, i admit) you're
using the following protocol:

 * make tcp connection
 * send dedicated specific message "please tell me my public IP and por=
t"
 * far end does sockaddr lookup of the incoming socket
 * far end returns IP and port as response to requestor

in this way, requestors can determine what the "apparent" IP address
is as far as having been NAT'd through half a ton of ISP layers
performing NAT, local routers performing NAT, laptops such as mine
doing NAT sharing of a 3G connection over a netgear router and so on.

so it entirely depends on the scope / scale you're thinking of.  if
you are aiming hive at "local subnets", it's pretty much perfect, and,
much as i hate to say it and you should not _remotely_ consider using
it because of the vast and horrific dependencies, i can understand why
you were considering avahi, because it is a good "local subnets"
solution.

however for "global networking" - for putting hive out onto the public
internet - there is one hell of a lot more involved, and all these
"filesharing" applications have solved near as damnit every single one
of the issues.

so, answering the question you were asking earlier: i believe that you
really do need to consider taking the closest c-based bittorrent
library/application apart, and use it as the basis for git-hive.  if
you don't, you will be here forever, reinventing everything that these
fileshare-app-writers have spent nearly a decade perfecting.

l.
