From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 01/14] Detect path names which overflow the name
 length field in the index
Date: Mon, 18 Aug 2008 17:11:51 -0700
Message-ID: <7v7iadlv7c.fsf@gitster.siamese.dyndns.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:13:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEqN-0004f3-KT
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbYHSAL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbYHSAL7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:11:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbYHSAL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:11:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 63FA65F2A5;
	Mon, 18 Aug 2008 20:11:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 647295F2A4; Mon, 18 Aug 2008 20:11:53 -0400 (EDT)
In-Reply-To: <1219103602-32222-2-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Mon, 18 Aug 2008 16:53:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FC036D8-6D83-11DD-A3DF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92786>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> C Git allows a path name to be longer than 4095 bytes by storing 4095
> into the path name length field within flags and then searching for a
> null terminator at the end of the path name, instead of relying on the
> length indicatior.

This reminds me.

In the longer term, we should make this "CE_NAMEMASK gives the real length
for sane names but otherwise we need to count" merely a property of the
on-disk index structure.  In-core index should gain a new ce_namelen field
that records the real name (even when it is longer than the mask would
permit).  IOW, the knowledge of CE_NAMEMASK should be confined to
read_index_from() and ce_write_entry().

I expect this to be a relatively easy janitor project; hint, hint...
