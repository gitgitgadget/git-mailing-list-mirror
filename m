From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Thu, 21 Aug 2008 07:43:23 +0700
Message-ID: <fcaeb9bf0808201743v6a5144c7u79c0a0ecd3416b69@mail.gmail.com>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
	 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
	 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
	 <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
	 <20080820223938.GN23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 02:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVyHy-0005oK-Ei
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbYHUAn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYHUAn0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:43:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:54499 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbYHUAnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 20:43:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so429601fgg.17
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zqhDEGUlzTXDNHgmSGn13aCZtblJbkLCGxkh8c+OOsc=;
        b=LgJgodqIl7dDPFJDL2wbTT9aex0n10Ffi7BW8tAXzBQRJWrX1xJGw9ozhmpjtP6SmH
         JBlO0vhzaOggCBtZNtUz2ksiywV389q/Pm3og7DR4koIE4CbjuXaAdWG1pKDPcyvyO/y
         vb3z2jymOYOt4k1LBBnI0atOWdPKr+qlL2fdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZIpfsu0m3wIHHb7L10jiqnkmlhppwFgvIVo2NVc6SVkbs7GfFNe+zDFEdJW2zcDBjn
         +ORlIY4Pb6NTtC5nqwgpT/2JRDbWd5o2ckBtfY9VqQN4YIkOOHyU7lc4x4wMZITRB94X
         2fWUNAkOT4phUh5ZCF5HiK70P5XgxS0ueCysU=
Received: by 10.86.1.1 with SMTP id 1mr622984fga.61.1219279403258;
        Wed, 20 Aug 2008 17:43:23 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Wed, 20 Aug 2008 17:43:23 -0700 (PDT)
In-Reply-To: <20080820223938.GN23800@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93080>

On 8/21/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Wed, Aug 20, 2008 at 02:13:42PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>  > completion: find out supported merge strategies correctly
>  >
>  > "git-merge" is a binary executable these days, and looking for assignment
>  > to $all_strategies variable does not work well.
>  >
>  > When asked for an unknown strategy, pre-1.6.0 and post-1.6.0 "git merge"
>  > commands respectively say:
>  >
>  >     $ $HOME/git-snap-v1.5.6.5/bin/git merge -s help
>  >     available strategies are: recur recursive octopus resolve stupid ours subtree
>  >     $ $HOME/git-snap-v1.6.0/bin/git merge -s help
>  >     Could not find merge strategy 'help'.
>  >     Available strategies are: recursive octopus resolve ours subtree.
>  >
>  > both on its standard error stream.  We can use this to learn what
>  > strategies are supported.
>  >
>  > The sed script is written in such a way that it catches both old and new
>  > message styles ("Available" vs "available", and the full stop at the end).
>  > It also allows future versions of "git merge" to line-wrap the list of
>  > strategies, and add extra comments, like this:
>  >
>  >     $ $HOME/git-snap-v1.6.1/bin/git merge -s help
>  >     Could not find merge strategy 'help'.
>  >     Available strategies are: blame recursive octopus resolve ours
>  >     subtree.
>  >     Also you have custom strategies: theirs
>  >
>  >     Make sure you spell strategy names correctly.
>
>
> I like this, not adding something to builtin-merge when it's already
>  there. :)

Me too. Did not realize it's already there :P

-- 
Duy
