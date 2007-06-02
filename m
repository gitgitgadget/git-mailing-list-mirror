From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] always start looking up objects in the last used pack first
Date: Sat, 2 Jun 2007 08:00:52 -0700
Message-ID: <56b7f5510706020800o10541844t151cb82221d077d5@mail.gmail.com>
References: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
	 <20070531050211.GV7044@spearce.org>
	 <alpine.LFD.0.99.0705311015410.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 17:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuV6H-0004mU-BX
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 17:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXFBPAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758901AbXFBPAy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 11:00:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbXFBPAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 11:00:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so421372ugf
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 08:00:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TgrCf7dV/iBfMkQnwhG20LlNhoFZtOSXwuaPv9ZdwaK0Byz8fe3l6oa6EI1SYZ/t40Yh7QDMsTuB14BBv/QEBI3u9ylxhMYdag0If4nDaB/CBqZaEC72AUnzW+utVwzF8S9SML5C0F/WrT1FEZkkoFCRooCgPuMWMeOrmMoUzGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=exi32JArn0IPajbF7eLHN6OFRW91sk0zc9FGUp0NETM9N3DTMpve4g0Zf1oPp0OqdKo4zhLKrZxUvFloi+L1oNdMDs/VCi0fPSYiLMgsR+CxAvbRWnBQDQWQQMRjcwZE7ry4Hei385rl7osOKAYGWHnX/tsCrIixt+0TQWLqdxM=
Received: by 10.78.178.5 with SMTP id a5mr1585531huf.1180796452084;
        Sat, 02 Jun 2007 08:00:52 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sat, 2 Jun 2007 08:00:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705311015410.11491@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48932>

On 5/31/07, Nicolas Pitre <nico@cam.org> wrote:
> Which makes me wonder about a possible incremental improvement to my
> patch: on failure to find an object in the last used pack, the search
> should then start again from the pack containing the commit from which
> this object search is related to.  In the split pack case all commit
> objects will be located in the first pack so nothing will change there.
> In the multiple-fetch case then the search will always reset to packs
> not younger than the commit triggering those object lookups.  Question
> is how to implement that nicely...

My immediate reaction to this patch  was that there should be
a last-used-pack per object type.  Or perhaps one for commits,
and one for trees+blobs [since the latter are intermingled]?
Unfortunately the interface only specifies
the SHA-1,  not the object type,  and certainly not the "commit
this is related to".  I think your related-commit idea could be
very useful,  but it does require some extra info to be passed
around which currently is not.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
