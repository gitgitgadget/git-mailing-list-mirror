From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 10:15:57 -0400
Message-ID: <9e4733910608280715s52ae1d48n8886f24034cf44a5@mail.gmail.com>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
	 <20060828024720.GD24204@spearce.org>
	 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
	 <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
	 <20060828060029.GB25285@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 16:16:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHhua-0006PI-V8
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWH1OQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 10:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWH1OQA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 10:16:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:63148 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750901AbWH1OP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 10:15:59 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1026792nzf
        for <git@vger.kernel.org>; Mon, 28 Aug 2006 07:15:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUuBUfsaLRJafzSVVTQOTQGWzwJPbzjzwomNuyDMGX/+P7ocixlXezrAQRU0Mur+i9/z0O/KpXnMz10Qv4xmK3cYWkdoado5bwYJ8EnEvTtt1DduZnmgteYiEG3NIuBClXqr6H9AfCZxoFWNrC1MSkkvfnbR7wKsHsSZWRTYTsA=
Received: by 10.65.157.13 with SMTP id j13mr6911177qbo;
        Mon, 28 Aug 2006 07:15:57 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Mon, 28 Aug 2006 07:15:57 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060828060029.GB25285@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26158>

On 8/28/06, Shawn Pearce <spearce@spearce.org> wrote:
> Of course the major problem with pack-local, stream global
> dictionaries is it voids the ability to reuse that zlib'd content
> from that pack in another pack without wholesale copying the
> dictionary as well.  This is an issue for servers which want to
> copy out the pack entry without recompressing it but also want the
> storage savings from the global dictionaries.

If you copy an entire pack with a dictionary embedded in it everything
is fine. But if you pull objects out of the pack for transmission it
looks like they will need to be unpacked and repacked without the
dictionary. My plan was to only use dictionaries in archival packs
that would be used in a read only manner and copied around whole.

So there would need to something like an archive flag on git-repack
which would spend extra CPU time trying to make the pack as small as
possible. Normal use of git-repack wouldn't touch packs marked with
the archive flag since they were already in optimal form.

-- 
Jon Smirl
jonsmirl@gmail.com
