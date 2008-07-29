From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 17:46:05 -0700
Message-ID: <7vod4ho6uq.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann>
 <alpine.DEB.1.00.0807281605330.8986@racer>
 <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
 <20080729001751.GH10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNdMx-0004jI-07
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYG2AqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYG2AqO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:46:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYG2AqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:46:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E75D9499FE;
	Mon, 28 Jul 2008 20:46:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 334B0499FB; Mon, 28 Jul 2008 20:46:08 -0400 (EDT)
In-Reply-To: <20080729001751.GH10151@machine.or.cz> (Petr Baudis's message of
 "Tue, 29 Jul 2008 02:17:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE453E34-5D07-11DD-A7FD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90539>

Petr Baudis <pasky@suse.cz> writes:

> On Mon, Jul 28, 2008 at 12:19:19PM -0700, Junio C Hamano wrote:
>> We need to refresh the entry to pick up potential ctime changes.
>> 
>>  read-cache.c       |    7 ++++++-
>>  builtin-ls-files.c |   21 +++++++++++++++------
>>  2 files changed, 21 insertions(+), 7 deletions(-)
>> 
>> diff --git a/read-cache.c b/read-cache.c
>> index 1cae361..834096f 100644
>
> Oops, silly me. Sorry for being slower than you at fixing this. ;-)

I did think about ctime issues when I applied the patch.

rename(2) is hardlink to new name followed by unlink of old name, so
internally link count changes twice (and the first "link to new" can
exceed max links and is even allowed to make the whole thing fail); but I
do not think of any other reason for this change in ctime.
