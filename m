From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git server eats all memory
Date: Sat, 7 Aug 2010 10:42:08 +0400
Message-ID: <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, jaredhance@gmail.com,
	Avery Pennarun <apenwarr@gmail.com>, jnareb@gmail.com,
	git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-11@kanis.fr>
X-From: git-owner@vger.kernel.org Sat Aug 07 08:42:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohd6n-0000JR-BL
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 08:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761138Ab0HGGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 02:42:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53204 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab0HGGmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 02:42:09 -0400
Received: by qyk7 with SMTP id 7so375488qyk.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XR82lJZ54Cz4PIRolAmy+eVBEdjFCKKFzlaT654Tthc=;
        b=Y6/zxh0P9UmOqiesx9PQyvcjCNTPJHm89I4Zg7yTRh7OohanLdNdTJZlEg2OzOosW1
         xPK2Syillp7yOnoJLEJO+PPJpMYDq8/PM9YysHOKNeQe5D45XJ6Mx4p4tk0DCrlV/1JW
         x+uRXtO6I+CNIZKTwECskPwjwImhGnpQOea44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jpVfdq00XAw38LVM4+NYQRu+qZczZMqABYml9WjiEd8Uv4vZ51FbR/L11WndguxOaa
         77Ue8Kf6n8ljFk2Z3SDT3m6dgd+kx+HdHVxBMeNo21zKgLJaqKM6mtl+hgX0LVFZV0vp
         LFhzNpMKQRsQRY2RxgfLFoGdaTtvo5AguFPkQ=
Received: by 10.224.119.17 with SMTP id x17mr6823063qaq.242.1281163328917; 
	Fri, 06 Aug 2010 23:42:08 -0700 (PDT)
Received: by 10.229.186.83 with HTTP; Fri, 6 Aug 2010 23:42:08 -0700 (PDT)
In-Reply-To: <87hbj74pve.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152845>

On Fri, Aug 06, 2010 at 07:23:17PM +0200, Ivan Kanis wrote:
>
> I expected the malloc to take 4G but was surprised it didn't. It seems
> to be mmap taking all the memory. I am not familiar with that function,
> it looks like it's mapping memory to a file... Is it reasonable to mmap
> so much memory?

AFAIK, Git does not need to mmap the whole pack to memory, but it
is more efficient to mmap the whole pack wherever possible, because
it has a completely random access, so if you store only one sliding
window, you will have to re-read it many times. Besides, mmap size
does not mean that so much physical memory is used. Pages should
be loaded when they are necessary, and if you have more than one
client cloning the same repo, this memory should be shared by them.


Dmitry
