From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Thu, 20 Aug 2009 14:43:53 +0200
Message-ID: <c77435a80908200543h74fdb07dm7f30cee4fedef8c5@mail.gmail.com>
References: <op.uys3qwlmtdk399@sirnot.private>
	 <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
	 <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
	 <alpine.LFD.2.00.0908182313100.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 14:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me6zq-0002Eh-8o
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 14:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbZHTMnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 08:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbZHTMnx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 08:43:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:63773 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbZHTMnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 08:43:52 -0400
Received: by ey-out-2122.google.com with SMTP id 22so2985eye.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UrA0ALwBkOeQBzIznlc5++e/r2qXdRSt1c+ECNfCNco=;
        b=JmgYlnwK/RCDGFOZeYZcB6ShxKnqUM1YV2h+hRh0haVXqeGAYhjS3oo+s+O+ZruhW+
         eaJm+vE4BzuV33n/qDrh32IN4rKc0gDdGvm7Gwc/3BaJojBKYlrnkuhswf8WwZiW+AF4
         6yERax08L+lY106PwPXso4iwWJc1wcJLU2e+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iqPyOO/CYZTpo/DS0zqhOaR9VEwCMuMFhYptryOkmrw0DgVg3GV0MSCN74rX8/N0Ei
         qXPBJOnoAfj0EshNovQGFu0HZEoDXndWjUGEX9/2mJpl1BgJH/msT2pu1H6Jz7Z/We1f
         wW/Ng8lR2acIDFF8zbECoV13D3pxXIklZsR98=
Received: by 10.216.47.213 with SMTP id t63mr1899564web.134.1250772233431; 
	Thu, 20 Aug 2009 05:43:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908182313100.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126617>

> Result with the rev-cache populated returns the same number of
> revisions, but not the same amount of data.
> [...]
> So... Why is the leading path component dropped sometimes? =A0That
> explains the output size difference. =A0And the drop is not coherent
> either:

It looks like I didn't realize that tree_entry() returns only the
entry name, and not the full path, which seems like a case of not
thinking, just being logical.  The unit tests didn't catch it b/c it
only occurs for root commits, and none of the root commits in the test
had directories involved.

> The object order appears to be rather different. =A0Why so?

The non-commit object order has to be different because they're added
in a different way.  It's sorta like vanilla rev-list ordering, except
objects are /only/ appended that are introduced per current commit,
rather than all that haven't been seen yet.  It's still a coherent
ordering, and despite the different mechanism I've still enforced the
tag-tree-blob ordering of the normal rev-list.

I've fixed the name issue and added that scenario to the unit tests.
I'll re-upload this last patch in a bit (either minutes if my flight
dosn't leave soon or hours if so).

 - Nick
