From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -S doesn't find some commits
Date: Tue, 04 Nov 2008 15:45:25 -0800
Message-ID: <7vod0voy22.fsf@gitster.siamese.dyndns.org>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
 <alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:47:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVcS-0004Io-2X
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbYKDXpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758371AbYKDXpo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:45:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668AbYKDXpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:45:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02DC479336;
	Tue,  4 Nov 2008 18:45:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8397D79335; Tue,
  4 Nov 2008 18:45:31 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 5 Nov 2008 00:15:44 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0F57882-AACA-11DD-862F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100120>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Nov 2008, Bernt Hansen wrote:
>
>> Commits B, C, and D are not included in the git log -S output even
>> though with gitk you can see that 'org-publish-validate-link' is in the
>> patch.
>
> It is not sufficient for it to be in the patch, it has to be added or 
> deleted in whole.  So for example if you had a line
>
> 	org-publish-validate-link Hello
>
> and you changed it to
>
> 	org-publish-validate-link World
>
> git log -SWorld will find the commit, but git log 
> -Sorg-publish-validate-link will not.

It seems nobody has looked at the actual commits, but Dscho got it 80%
right.

There seems to be a misconception on what -S<foo> does.  It does *NOT*
grep for string <foo> in the patch text.  It counts number of <foo> in
preimage and postimage and decides that the commit is worth showing iff
they differ.

If you look at, for example (B):

    http://repo.or.cz/w/org-mode.git?a=commitdiff;h=837c81ce51

You can see that in org-publish.el, org-publish-validate-link appears once
as removed and once as added, so the total number of the appearance of the
symbol in preimage and postimage are the same.
