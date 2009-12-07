From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH v3 6/8] Support remote helpers implementing smart
 transports
Date: Mon, 7 Dec 2009 22:35:24 +0200
Message-ID: <20091207203524.GA29629@Knoppix>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260116931-16549-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091207181148.GG17173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkIv-0003yk-Tk
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbZLGUfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934939AbZLGUfW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:35:22 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:54416 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935185AbZLGUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:35:21 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 6218A8BFB2;
	Mon,  7 Dec 2009 22:35:27 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A047C754BA8; Mon, 07 Dec 2009 22:35:27 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 4B8E01C6383;
	Mon,  7 Dec 2009 22:35:25 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091207181148.GG17173@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134779>

On Mon, Dec 07, 2009 at 10:11:48AM -0800, Shawn O. Pearce wrote:
> 
> We should already be connected because of the prior call into
> get_refs_list().  If I read your code correctly we'd try to open
> a new connection right here, which makes no sense. 

The have prior connection case can't happen since take_over_transport()
overwrites the method pointers.

> But its also
> possible for us to be in a different transport, so we do code with
> the assumption that we didn't get invoked through get_refs_list()
> first and therefore need to open the connection ourselves.

Right. The reason why the code is there is in case somebody invokes
fetch() first.

The same things apply to push function too.

> Also, given the above invocation pattern, I see no reason why you
> need the disown virtual function on struct transport*.  Just pass
> the #@!**! struct child* into transport_take_over() from the 3
> call sites here and get rid of that unnecessary indirection.

Fixed.

-Ilari
