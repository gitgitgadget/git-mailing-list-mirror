From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list -S ?
Date: Tue, 20 Mar 2012 13:53:14 -0700
Message-ID: <7vaa3b570l.fsf@alter.siamese.dyndns.org>
References: <4F68CDA4.6060109@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 21:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA640-000489-6G
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 21:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab2CTUxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 16:53:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2CTUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 16:53:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF577496;
	Tue, 20 Mar 2012 16:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yuwxuchRaDDMOzeRWj9n2yuIhAw=; b=VnquIn
	HPCCkNGXEr3zawPZOUa7mbLz2q8h+FKH3KWreV1+KQlDWdBar+FHA2F2wLqYblob
	/PNFCafRKu8uuzlmHjm2vQqem1mUrpBD62D9vrMhAQk+rk/rGcDev8cdiL59LPYU
	+rLjEbPEUG7EGLQ8SgYoMnv5iCaiS1l7vqwao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVcislbdWb2EY4CgoK/fWkdh10TQTMkt
	gzyX1FNAfijB7vRHcwbEYRoMGd49X5T77EtpSAXsE5NBqQjmefmv07P1epGR3Dz9
	JE6qCgN7Hco1rgj4MGOELSKQ9m63sEpGkum8x7mn6qF61KlOHUnKudquL+zqtg7g
	xh7HtVI/Mbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2FC47495;
	Tue, 20 Mar 2012 16:53:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 142647494; Tue, 20 Mar 2012
 16:53:15 -0400 (EDT)
In-Reply-To: <4F68CDA4.6060109@ira.uka.de> (Holger Hellmuth's message of
 "Tue, 20 Mar 2012 19:34:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B73DCB70-72CE-11E1-8A5B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193540>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> I read the GsoC page about the ultimate tracking tool just now and
> couldn't find the -S option in git rev-list documentation...

Slippery finger.

|    $ git log -S'it drives an external
|   an external' master Documentation/RelNotes

is a way to find commits that introduced and then removed the block of
text to files in the named directory, starting at the tip of 'master'.

Most of the "ultimate tracking tool" dream has already been realized in
"git blame" except one major part.  Once you find where the blame lies,
the tool _could_ help the user to find where these blamed lines came from
more than it currently does.  Were they typed anew?  Were similar lines
removed by the commit from other files?  Often people run "blame" on a
line range they are interested in, find the commits that were blamed, look
at "git show $the_found_commit" to see if they can find similar lines in
deleted parts of other files and then finally run blame again on the
deleted line range of these other files starting from the parent commit of
the found commit to do this (and this needs to be repeated).  A good GUI
should be able to help this process quite a lot, if backed by a good logic
to detect "similar" code blocks.
