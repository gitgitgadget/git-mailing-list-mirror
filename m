From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone -l
Date: Tue, 04 Mar 2008 16:32:14 -0800
Message-ID: <7vd4qa3t9t.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803041900080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWhZg-00005Z-JP
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976AbYCEAcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758896AbYCEAci
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:32:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760178AbYCEAcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:32:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D1FA232E;
	Tue,  4 Mar 2008 19:32:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B0E79232D; Tue,  4 Mar 2008 19:32:29 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0803041900080.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 4 Mar 2008 19:03:38 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76160>

Daniel Barkalow <barkalow@iabervon.org> writes:

> What, exactly, is -l supposed to do for clone? As far as I can tell, we 
> automatically do the local magic if we can. Would it be okay to make 
> "local" default to "if possible", have "-l" mean error if not possible, 
> and have "--no-local" able to avoid using local magic even if we could use 
> it?

It used to be that "-l" meant "When it is local, use hardlink if possible
otherwise copy without complaining, as either are cheaper than the pack
piped to unpack."  Lack of -l meant no local magic.

Recently lack of -l stopped to mean "no local magic".  We still do the
local magic, but we do not do hardlinks and instead do copies.  An "-l"
that asks clone across filesystems still falls back to copying but now
gets a warning.  "--no-hardlinks" does not have any significance anymore,
as that is what you would get for a local clone without -l.

The way to refuse local magic is to use file://$path/ explicitly; we do
not have --no-local.
