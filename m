From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git failing to create new branches, depending on the name
Date: Sat, 8 Aug 2009 19:04:57 +0200
Message-ID: <200908081904.58186.trast@student.ethz.ch>
References: <4A7D9AA7.1030709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 19:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZpMU-0007an-6F
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbZHHRFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZHHRFe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 13:05:34 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:19214 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbZHHRFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 13:05:34 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 19:05:33 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 19:05:11 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <4A7D9AA7.1030709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125290>

Artur Skawina wrote:
> + git checkout -f -b branch-g90bc1a6 askern/release
> fatal: git checkout: branch branch-g90bc1a6 already exists

This bisects to

commit 352eadc40024b141e1295693654ec20cc123844f
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Sun Sep 21 14:36:06 2008 -0400

    Check early that a new branch is new and valid

    If you fail to update refs to change branches in checkout, your index
    and working tree are left already updated. We don't have an easy way
    to undo this, but at least we can check things that would make the
    creation of a new branch fail. These checks were in the shell version,
    and were lost in the C conversion.

    The messages are from the shell version, and should probably be made nicer.

    [jc: added test to t7201]

    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


Not sure this is a bug though.  If we allow branch names that are
ambiguous to rev-parse, what do they resolve to?  E.g., in the
presence of only 'master', 'master-g01234567' is defined to be the
same as 01234567.  What is it if you also have a *branch* called
'master-g01234567'?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
