From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 05:18:47 +0300
Message-ID: <20100214021847.GA9704@dpotapov.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vtytk61im.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 03:20:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgU6U-0004Rv-Kr
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 03:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab0BNCSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 21:18:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:18278 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758276Ab0BNCSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 21:18:53 -0500
Received: by fg-out-1718.google.com with SMTP id 16so48349fgg.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PQD0LOIkS84IO8kfv6vt/L525rsr0BhHjVHQefemJlY=;
        b=mswmErvpeIt0Jz+QURjofuE5+rWw3otzGH+0hKu/KhZlGg81YBUbX3TfO2XSP80VaS
         h62E5w1VJKtRZYxowBHUumS/Hq8//E3y7HtN3a5WXJYsvk274g1MLqpWZbRjzpa8bzQq
         DHcASkw1KwtQ0FB71FjmPLjThvMPu+nQ9ZwZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dc/EYIZBTfxCy4QHLua09f254C6El+UBT7dyZCTQhdiauuKcejXX7zl2qmePwxsPxN
         mWScQpvlEff2NQVhygaIxEqE3uAExKU5s9adgIDbz77lVu96A2I71pSigA8ULd8zmUf1
         pQzzTjIBkFb8WH/k+lUuUOWe5ktGFfmuS6bCk=
Received: by 10.87.51.13 with SMTP id d13mr5954509fgk.11.1266113930171;
        Sat, 13 Feb 2010 18:18:50 -0800 (PST)
Received: from localhost (ppp91-76-16-167.pppoe.mtu-net.ru [91.76.16.167])
        by mx.google.com with ESMTPS id d8sm10376759fga.8.2010.02.13.18.18.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 18:18:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtytk61im.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139883>

On Sat, Feb 13, 2010 at 05:37:21PM -0800, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > If a mmapped file is changed by another program during git-add, it
> > causes the repository corruption. Disabling mmap() in index_fd() does
> > not have any negative impact on the overall speed of Git. In fact, it
> > makes git hash-object to work slightly faster....
> > ...
> > I think more people should test this change to see its impact on
> > performance. For me, it was positive. Here is my results:
> 
> I wasn't particularly impressed by the original problem description, but
> this is a very interesting result.

My initial reaction was to write that the whole problem is due to abuse
Git for the purposes that it was not intended. But then I decided to do
some testing to see what impact it has. And, because I do not see any
negative impact (in fact, slightly improve speed), and I decided to ask
other people (who are interested in this patch) to do more testing.


Dmitry
