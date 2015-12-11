From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier during loose-object directory traversal
Date: Fri, 11 Dec 2015 11:37:54 -0800
Message-ID: <xmqqvb84epyl.fsf@gitster.mtv.corp.google.com>
References: <55CA5EB0.1000308@kdbg.org>
	<b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
	<55CB85A5.5040802@kdbg.org>
	<20150812175629.GA24964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:38:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7TW3-0002l0-UK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbbLKTiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:38:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751552AbbLKTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:38:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57CD4324AC;
	Fri, 11 Dec 2015 14:37:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jL3osC3hqt9a5XT/8LIHXS+bbhE=; b=tMz7IC
	FNuKxNmGufm5TaI4mTogbGCGQnqs0+ZOUerOplX29/lpi2Mq4qR8zr7Jd5FRigLK
	curQ/jb5hHNdB0sL1D9dQ9gfSo6W/AqSlXPL568vyeakb2OPaO3MJstG3euuTwt0
	bO6xXKpkQNiMkGbUk5aigeR+fRx1dY/rskANI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PZK8SYDdEnSPNeEeDcICpTsL3NMzQeso
	PER3txMP3GK7hyZr583jrJ25dd+s9ZugcOhDS81+h3ewzSxWPTTDf/n7JLDGp55g
	ASZwyijDnb9FI52Ex0StsNuDc5ylcIM4vlb7GrUyPCzwhYQ2Wocy5fZtZ90NXYn3
	x4WwgIC/+oY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E71F324AB;
	Fri, 11 Dec 2015 14:37:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B4050324AA;
	Fri, 11 Dec 2015 14:37:58 -0500 (EST)
In-Reply-To: <20150812175629.GA24964@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Aug 2015 13:56:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AEF1D050-A03E-11E5-91D9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282271>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 12, 2015 at 07:43:01PM +0200, Johannes Sixt wrote:
>
>> 27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
>> introduced a new function for_each_loose_file_in_objdir() with a helper
>> for_each_file_in_obj_subdir(). The latter calls callbacks for each file
>> found during a directory traversal and finally also a callback for the
>> directory itself.
>> 
>> git-prune uses the function to clean up the object directory. In
>> particular, in the directory callback it calls rmdir(). On Windows XP,
>> this rmdir call fails, because the directory is still open while the
>> callback is called. Close the directory before calling the callback.
>
> Makes sense, and the patch looks good to me. Sorry for breaking things
> on Windows.
>
> Acked-by: Jeff King <peff@peff.net>

Sorry for reviving this old thread, but I noticed that we do not
have this patch in our tree yet.  I'll queue to 'pu' for now lest I
forget.  If I missed a good argument or concensus against the change
please let me know, otherwise I'll fast track the change to 2.7 final
