From: Ryan Anderson <ryan@michonline.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 00:57:45 -0700
Message-ID: <20060807075744.GB15477@h4x0r5.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 07 09:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9zzn-000147-DS
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 09:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHGH5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 03:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWHGH5v
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 03:57:51 -0400
Received: from h4x0r5.com ([70.85.31.202]:8467 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751143AbWHGH5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 03:57:51 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1G9zzd-0006z0-Rw; Mon, 07 Aug 2006 00:57:45 -0700
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060806180323.GA19120@spearce.org>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25001>

On Sun, Aug 06, 2006 at 02:03:24PM -0400, Shawn Pearce wrote:
> 
>   - It expects an estimated object count as its second parameter.
>     In your case this would be something around 760000.  This tells
>     it how large of an object table to allocate, with each entry
>     being 24 bytes + 1 pointer (28 or 32 bytes).  Overshooting
> 	this number will cause it to degrade by allocating one
> 	overflow entry at a time from malloc.

Hrm, you're allocating a big table and then assigning consecutive
entries out of it, as pointers.

Why not just malloc a big block, and assign offsets into it, as if it
were a really big array.  Every time it runs out, realloc it to double
the current size, and update the base pointer.

-- 

Ryan Anderson
  sometimes Pug Majere
