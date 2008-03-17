From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 17:17:24 -0700
Message-ID: <7v4pb6dx0r.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
 <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161812340.19665@iabervon.org>
 <7vzlsyfgjg.fsf@gitster.siamese.dyndns.org>
 <7vbq5eff3e.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161904360.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 01:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb33S-0006x0-Fv
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 01:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbYCQARg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYCQARf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 20:17:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYCQARe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 20:17:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CECF71C73;
	Sun, 16 Mar 2008 20:17:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7345D1C72; Sun, 16 Mar 2008 20:17:28 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803161904360.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 16 Mar 2008 19:11:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77405>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 16 Mar 2008, Junio C Hamano wrote:
> ...
>> ...  It still has an independent issue
>> that this is now called by "git remote show" or "git remote prune", and it
>> will die with a nonsense "refusing to create" error message, though.
>> 
>> The error, as far as I can tell, is half about a misconfigured config
>> (e.g. "fetch = refs/heads/*:refs/remotes/[]?/*") and half about screwy
>> remote repository (e.g. a misnamed "[]?" branch on the remote end can try
>> to update a broken "refs/remotes/origin/[]?" even the configuration is a
>> perfectly valid "fetch = refs/heads/*:refs/remotes/origin/*").  It may
>> make sense to reword the error message to "ignoring" from "refusing" and
>> do just that without dying here.  I dunno.
>
> Yeah, I think that's right. (And this patch is also right)

Which means that an error checking (i.e. dying) needs to be added to
whatever reads from config to find "refs/heads/*:refs/remotes/[]?/*" to
cover the first half.  That's an configuration error and we should not
just say "ignoring" but actively urge the user to correct, no?
