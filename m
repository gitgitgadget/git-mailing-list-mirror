From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 07:58:57 -0700
Message-ID: <20080826145857.GF26523@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY02B-0004O4-49
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 17:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYHZO67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 10:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbYHZO67
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 10:58:59 -0400
Received: from george.spearce.org ([209.20.77.23]:36504 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbYHZO66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 10:58:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9862B38375; Tue, 26 Aug 2008 14:58:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B36BCA.8060103@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93750>

"H. Peter Anvin" <hpa@zytor.com> wrote:
>> Detecting Smart Servers
>> -----------------------
>>
>> HTTP clients can detect a smart Git-aware server by HEADing
>> $repo/backend.git-http and looking for a 302 redirect to the
>> repository's smart service URL:
...
>> All subsequent communcation for this transaction is done through
>> the smart service URL ($ssurl), not the original URL.
>
> I actually suggest embedding the forwarding URL into an ordinary  
> payload.  Instead of a HEAD request here, then do a GET (or, even  
> better, POST) and get the redirected URL in return.
>
> Why?  Because it's common enough to redirect entire trees, and use of  
> HTTP-layer redirections here is an unnecessary layering violation.

Hmm.  I'm actually thinking the exact opposite here.  My rationale
for putting the response as a standard HTTP 302/303 style redirect
is to permit hardware load balancers or Apache mod_rewrite rules
to implement simple load balancing with a HTTP redirect.

If we embed the redirect URL into the payload then configuring that
will become a lot more complex.  At the minimum you may have to
make up a dummy file for each server (holding the response payload)
then then let mod_rewrite rewrite the request internally to make
Apache serve that file.  Ugly.

> If you insist on using a HTTP status code, I would claim that 303 is a  
> better status code.

Ok.

-- 
Shawn.
