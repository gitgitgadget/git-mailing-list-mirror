From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 15:36:19 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Efq-0001uP-Kw
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbXLKXhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbXLKXhm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:37:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44980 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbXLKXhl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 18:37:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBNaK00002859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 15:36:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBNaJFS014869;
	Tue, 11 Dec 2007 15:36:20 -0800
In-Reply-To: <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.639 required=5 tests=AWL,BAYES_00,TW_CP,TW_XD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67968>



On Tue, 11 Dec 2007, Junio C Hamano wrote:
> 
> Instead, how about discarding after we are done with each origin, like
> this?

Sure, looks fine to me. With either of these patches, all of the cost is 
in the diffing routines:

	samples  %        image name               app name                 symbol name
	191317   31.4074  git                      git                      xdl_hash_record
	120060   19.7096  git                      git                      xdl_recmatch
	99286    16.2992  git                      git                      xdl_prepare_ctx
	56370     9.2539  libc-2.7.so              libc-2.7.so              memcpy
	23315     3.8275  git                      git                      xdl_prepare_env
	..

and while I suspect xdiff could be optimized a bit more for the cases 
where we have no changes at the end, that's beyond my skills.

		Linus
