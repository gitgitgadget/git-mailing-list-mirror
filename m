From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 10:25:07 -0400
Message-ID: <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
References: <20080701150119.GE5852@joyeux>
	 <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <20080706160758.GA23385@jhaampe.org>
	 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
	 <20080707062142.GA5506@jhaampe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Lars Hjemli" <hjemli@gmail.com>, "Ping Yin" <pkufranky@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
To: "Sylvain Joyeux" <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrfO-0005K9-JA
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbYGGOZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYGGOZL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:25:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:58990 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYGGOZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:25:10 -0400
Received: by wx-out-0506.google.com with SMTP id h29so794429wxd.4
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mMQbEwxDqn3QzRIAWwA8V5TXPKxK1A1nJc3tCAQdLPE=;
        b=fkpbH1ArCa0K3qpw3BGUVsRJ3XNrMaIqjRcXswQyrLQLpphvREqQHXiZ0IMGyoLCMd
         OCqSLm7Zsrv8tdifgd+KxfoPO8pLed4MjyeJ0ZtxiL01CC6z6OK414/8oJaYj0L437R0
         lQfT9YcIS1qxvNoxggPvEQZ7e3U3DanDZeAxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CDq6U7VfcW+6Nsi3ZgjN4x4iGGAXDaq9sYl31eWlilOumccvoY56XMH2wmkv9cH9og
         IbAN/C5IyFzxqDQbEOQXu9XyoE8U/XQ02uBpe4UdyxWt839LOTJOBRWYpftm1y7RbyXO
         m0zdFgc3XrJo61mmV0JMD2pnY4CIbsTYWKei8=
Received: by 10.151.141.8 with SMTP id t8mr8266264ybn.192.1215440707197;
        Mon, 07 Jul 2008 07:25:07 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 7 Jul 2008 07:25:07 -0700 (PDT)
In-Reply-To: <20080707062142.GA5506@jhaampe.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87612>

On 7/7/08, Sylvain Joyeux <sylvain.joyeux@dfki.de> wrote:
> Yes, it fetches objects (admittedly, it updates something on the current
>  partition), but AFAIK does not change the state of the repository. So I thought
>  that it could be considered as a no-op from the repo point of view. The idea
>  behind the 'fetch' thing was to get the latest objects from the repository,
>  therefore being able to know the relationship between the currently committed
>  submodule state

I haven't looked at your patch, so I don't know if you're calling
fetch in such a way that it doesn't update any refs.  Anyway, fetching
is definitely not a no-op as far as the user is concerned.  For
example, if I'm on my laptop outside my company's LAN and I try to
fetch, it might take 30+ seconds for fetch to time out waiting for our
server.  So it's not okay to fetch unless I specifically ask for a
fetch.

The trick here, I think, is that there's only one time the submodule
should be linked to a commit you don't actually have.  It should only
happen if your parent module (supermodule) has been updated, but you
haven't recently done a fetch in the submodule.  Thus, I'd say the
best fix would be to find a way to have "git pull" or "git fetch" in
the supermodule also do a fetch in the submodule.  I think it's fair
to expect "fetchy" operations like fetch and pull to perhaps do some
extra fetches, but not fair to expect "status" to do extra work like
that.

Also note that "your supermodule links to a commit that you haven't
fetched yet" is a perfectly okay state to report to the user.  I might
use a "?" or something to indicate that.

Have fun,

Avery
