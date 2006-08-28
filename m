From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 11:44:37 -0400
Message-ID: <9e4733910608280844q41ea1a61r33c3eadc3e942604@mail.gmail.com>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
	 <20060828024720.GD24204@spearce.org>
	 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
	 <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
	 <20060828060029.GB25285@spearce.org>
	 <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 17:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHjI2-0007zu-Ce
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 17:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWH1Poj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 11:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWH1Poj
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 11:44:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:27577 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751092AbWH1Poi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 11:44:38 -0400
Received: by wr-out-0506.google.com with SMTP id i3so376924wra
        for <git@vger.kernel.org>; Mon, 28 Aug 2006 08:44:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMXVv0p+xLSx2MOb02bgIdJS+wUau6Ao5+tgQVML6QWm3FcKu1nD1jGIAjUtVfk892Xi5jT9Bf+XfDBNQYQ1LncE8C2o0WIvWfwQXGa2zASBuM6Ym1qN7QOkpuZYX4wej9b7KOXT5/KuEcSPyu5KVHdRlElKffFoJApDmotHqX8=
Received: by 10.65.73.16 with SMTP id a16mr7050957qbl;
        Mon, 28 Aug 2006 08:44:37 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Mon, 28 Aug 2006 08:44:37 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26162>

On 8/28/06, Nicolas Pitre <nico@cam.org> wrote:
> > Of course the major problem with pack-local, stream global
> > dictionaries is it voids the ability to reuse that zlib'd content
> > from that pack in another pack without wholesale copying the
> > dictionary as well.  This is an issue for servers which want to
> > copy out the pack entry without recompressing it but also want the
> > storage savings from the global dictionaries.
>
> Why would copying the dictionary as well be a problem?  How large might
> it be?  Can it be stored deflated itself?

The dictionaries are only 4KB. But they have to match up with the
objects compressed using them. If you bring an object straight down
out of a dictionary based pack and make it standalone you won't be
able to read it. You need the dictionary to decode it. What if the
local and remote packs have been packed using two different
dictionaries? You can't directly move objects between them.

-- 
Jon Smirl
jonsmirl@gmail.com
