From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 14:38:15 -0400
Message-ID: <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
	 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
	 <20070815171152.GA15155@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNl9-0006Gx-SR
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933973AbXHOSiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933723AbXHOSiS
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:38:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:32126 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933598AbXHOSiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 14:38:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so10181wah
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 11:38:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i4XMMeIdZSSSBRwqBTG55kqTwhA5K4BOFEcEZDV2Ep75TlDco7hiYEQtc69pa57o9mSVH2N1hmmX5bzctih3qAsQ9BOfqp1P13c36JS4dON0jWPer0UnKXYEVnooodKSF/nqu33JkqQf/0CfHwlcR1O7f84lpwzoDyEMdsjbbvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OEYydqyPlTdbicfX7O6S8/7w85qbJ4mOVm/KrYXnjmkkMSf3V0iF07JAwYuMJ1xM3OQT9JS9a8LhulEpx6d25MiW3hxfUjDXclIoz4VxOzP+EPBzhwnmpcCGyWnOqELhOzvqrpBf6vL0v88b7ghUPz/mwUvNP2//XOopnKUBJSY=
Received: by 10.115.79.1 with SMTP id g1mr914133wal.1187203095731;
        Wed, 15 Aug 2007 11:38:15 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 15 Aug 2007 11:38:15 -0700 (PDT)
In-Reply-To: <20070815171152.GA15155@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55935>

On 8/15/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> git-pack-objects knows the order, in which it will use the objects.  A
> seperate thread could pre-read the next object and wait until the main
> thread starts processing it. After the read is complete, another
> thread could start computing the delta index.

The hope is that the new adaptive read ahead code in the kernel will
get this right and you won't need the second thread. Letting the
kernel handle the read ahead will dynamically scale as other demands
are made on the host. There's effectively only one read ahead cache in
the system, only the kernel really knows how to divide it up between
competing apps.

-- 
Jon Smirl
jonsmirl@gmail.com
