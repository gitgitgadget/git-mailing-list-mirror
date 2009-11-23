From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Mon, 23 Nov 2009 18:39:46 +0100
Message-ID: <fabb9a1e0911230939m56e20812o939456c41becf5fd@mail.gmail.com>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com> 
	<20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> 
	<20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCctu-0002Qb-HK
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbZKWRkC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 12:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbZKWRkB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:40:01 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46644 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbZKWRkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 12:40:00 -0500
Received: by fxm5 with SMTP id 5so4902195fxm.28
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F/AZN1/V0sNDCNfIAzZJweqGJ0beRqjpO4p31wUPQqU=;
        b=nExq+kuwsgQ5fBRFRgoOTUlZ/o2wnHAW3QkRdK9E3Fxn3xJjTjue5H5BCEFQqP2Z9f
         /Yq3pVl4M3Gwi7gYsUOfsTZ/vFmiVk3LxowbYONc6Onmoy+IzKpSd0kUSnaAF7CYKoNZ
         IY+26ZIpqzp2eIhJXFUF107xj1s2hktJKuEZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SF+DHyYSfRuebXzv5tO0xhOG4O6eMbq8S/zrzyTM67fBgIUkUfI7n4kKGY8q2MLNHz
         SrDQW/F3k2JiPiaZUsl+cu8dHoPccV8J0JQKaG26PZRb5RrXLojrrVUY2ce7roxfAY5/
         TX7Gkbx1Doww9pFbI5YIZxotGTbTZ90rrbxS4=
Received: by 10.216.89.194 with SMTP id c44mr1598930wef.199.1258998006312; 
	Mon, 23 Nov 2009 09:40:06 -0800 (PST)
In-Reply-To: <20090813172508.GO1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133513>

Heya,

[picking up a topic on what to do if there's a import-marks from the
stream and the commandline]

On Thu, Aug 13, 2009 at 18:25, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Thu, Aug 13, 2009 at 10:07, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> > ... and will import the marks twice?
>>
>> Ah, you're right :(. What's the best way to do this? Should we dump
>> any previous marks when importing new ones?
>
> Uh, well, yes. =A0We shouldn't define :5 if it was in the file that
> appeared in the stream, but isn't in the file on the command line.
>
> Worse, what happens if we do this:
>
> =A0echo "option import-marks=3D/not/found" \
> =A0| git fast-import --import-marks=3Dmy.marks
>
> I want this to work, even though /not/found does not exist, but
> my.marks does. =A0So that does complicate things...

According to the docs it is allowed to specify import-marks multiple
times (the latest series does not honor that, and there's apparently
no test to verify it). What should the behavior be wrt
stream/commandline arguments? Load from stream if present and valid,
and also load from commandline? In that case, how do you override
what's in the stream?

I think the simplest is to allow the stream to specify a marks file
exactly once, and commandline arguments override what's in the stream.
Listing import-marks on the commandline is still valid and keeps the
old behavior.

Sensible?

--=20
Cheers,

Sverre Rabbelier
