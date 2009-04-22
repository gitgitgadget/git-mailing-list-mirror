From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH/RFC] Removed possibility to change stderr for ssh
	sessions
Date: Wed, 22 Apr 2009 08:46:57 -0700
Message-ID: <20090422154657.GK23604@spearce.org>
References: <85647ef50904211149lc4a4902h554c973017d87adb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwegd-0001oT-8Z
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZDVPq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbZDVPq6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:46:58 -0400
Received: from george.spearce.org ([209.20.77.23]:52606 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZDVPq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 11:46:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 26FEE38211; Wed, 22 Apr 2009 15:46:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50904211149lc4a4902h554c973017d87adb@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117208>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> The current implementation allowed to change stderr for the
> ssh sessions. However this functionality is broken.

Good catch.

I applied this, but two comments.

One, your patch was line wrapped, I had to manually unwrap it
to apply.  So your MUA is still not able to send patches right.
Thought you'd like to know.

Two,

> +	 * The method does not have to be implemented and will be removed in
> future versions.
>  	 *
>  	 * @return an OutputStream to receive the SSH error stream.
>  	 */
> -	public abstract OutputStream getErrorStream();
> +	@Deprecated
> +	public OutputStream getErrorStream() {
> +		throw new UnsupportedOperationException("This method should not be called.");
> +	}
>  }

I think deprecation here is silly.  I just deleted the method.

Nobody should be calling this except TransportGitSsh, as you
discovered.

If they are, getting UnsupportedOperationException at runtime is
as bad as NoSuchMethodError at runtime, and either is a lot less
friendly than a no such method error at compile time.

Given the method is being broken, I'd rather just remove it outright.
So I removed it from your patch when I applied it.

-- 
Shawn.
