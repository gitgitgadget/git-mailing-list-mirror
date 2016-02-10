From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 13:22:07 -0800
Message-ID: <20160210212207.GB10155@google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
 <xmqqh9hgz3km.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTcDH-0001iX-IB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbcBJVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:22:12 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36341 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcBJVWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:22:10 -0500
Received: by mail-pa0-f47.google.com with SMTP id yy13so17722257pab.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xjAOX8BhZ2OYbfB/azvm2sLIe3HpJCZBOe6o9tra2FE=;
        b=mj12sgbuNhNhUcxD94sA6feao+XQIjx49blfmbSEIgX2aC4b5Q8yXrn7NUujhlLfYy
         DlzkT1RGH9YL2yzC/9jJ14jRXT/i40tsw4W7h8XeHm1BNGuPxMx9dUaBz0vdTlOkU5+U
         wHCKKSg/6amBx9BRZhJbEUfn55kRuFqnES2IA2xmYpz5D/p0J17lcamlRYUy1CJzJCH/
         vrc1Lh1v9yAuXVV2THjWkt3ereNWUqkTAZo7UFsw7ph2GeVew3tmeMaC7SgMPAFPJgve
         R/gjnsgufvqXuyyUekvjmwdXYrGdS/80/xzEo0hjyKlvzyAtVwp/JWXQOTPhMgSEzvlr
         KPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xjAOX8BhZ2OYbfB/azvm2sLIe3HpJCZBOe6o9tra2FE=;
        b=Gh/jR4bYbEXeaWG8E0PjsGaTZc7Pa7Mk9DiqR39VaqPa6zL/WszZRfYphlrqeOWaVF
         XbRg/s6aHwzxsGzg6YOmfuNKSU63TSsTKlIJJIxY5NASPI/wVi90rmW5y2s0u0IZBE7/
         pVmnfuD0frWvoM9yv9RW7Y/YhtDZAO2SyhGA9015uEm473DpZTX5nY6zhZlVqU3QvC9L
         YQkERcd/1sKEsHOE0T4LxPFKPUFoYmta5OPnfwfLkYfVutPscDnIK8ZUosEVBwsXtrgB
         QbHLHFfpHLgCBHAATAxc3lq+QUZYkKswX46kNbBtZGjlTnyVuB96lWvHVq9gDl/lY027
         fi/Q==
X-Gm-Message-State: AG10YOR8ap9cMnSyhCwTRNwhcWR3eTozyYI+K55ka+oMtD0ZNYlhuOUtOdpyNLHrVkhE1A==
X-Received: by 10.66.102.40 with SMTP id fl8mr61359860pab.136.1455139330103;
        Wed, 10 Feb 2016 13:22:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:986b:44f8:244c:add9])
        by smtp.gmail.com with ESMTPSA id dg12sm7253523pac.47.2016.02.10.13.22.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 13:22:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqh9hgz3km.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285932>

Junio C Hamano wrote:

> I somehow doubt it.  Both index-pack and lost-found need to trace
> "object A depends on object B", but the similarity ends there.

You already responded about this in another side-thread, so the
following is mostly redundant. :)  I think this message can still be
useful to future readers since it more explicitly goes through the
trade-offs.

The relevant similarity is that both index-pack and lost-found need to
inflate all commit, tag, and tree objects.

This is the same idea that led to the introduction of "git index-pack
--strict".

[...]
> I am not quite sure if that is an advantage, though.  The second
> message proposes that the lost-found computation to be done by the
> client using *.pack, but any client, given the same *.pack, will
> compute the same result, so if the result is computed on the server
> side just once when the *.pack is prepared and downloaded to the
> client, it would give us a better overall resource utilization.  And
> in essence, that was what the *.info file in the first message was.

Advantages of not providing the list of roots:
 1. only need one round-trip to serve the packfile as-is
 2. less data sent over the wire (not important unless the list of roots
    is long)
 3. can be enabled on the server for existing repositories without an
    extra step of generating .info files

Advantage of providing the list of roots:
- speedup because the client does not have to compute the list of roots

For a client that is already iterating over all objects and inspecting
FLAG_LINK, the advantage (3) seems compelling enough to prefer the
protocol that doesn't sent a list of roots.

Except when people pass --depth, "git clone" sets
'check_self_contained_and_connected = 1'.  That means clients that
already iterate over all objects and inspect FLAG_LINK are the usual
case.

Thanks for your thoughtfulness,
Jonathan
