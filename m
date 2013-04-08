From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Using a bit more decoration
Date: Mon,  8 Apr 2013 16:01:51 -0700
Message-ID: <1365462114-8630-1-git-send-email-gitster@pobox.com>
References: <20130408210903.GC9649@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 01:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPL4k-0001C6-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 01:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935869Ab3DHXB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 19:01:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935717Ab3DHXB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 19:01:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DED7414909;
	Mon,  8 Apr 2013 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZofS
	bNez70mmrTUS6MK8/dlBeKg=; b=s6uFyhoCYJ2bOBMyU0XbOqCUaJSmpH/3EOUj
	aHWcsXKPNIdQeqCXLAJsFfzcm8+ptHEwToth3J7fVLnzJZFQnRfni+XeQW9QhJGj
	A7OV9ESt5QgXCW9VlGKJx60h/IEdOEp7IJrIus8/O6hRpVSneSQcDGQMBKkSR5Zn
	KaNlPPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	NnlHKke7qHjrZ/EIbm6MxyCJ0hUTHNI0Mj+ZWiNdCL9xor24dp+3BvKG8J+JHIgT
	uL8SSF4T7iBELPtihPAgC0cxR3ieJunGHg4LRV99DH1rxXsOrwyRPE5Mr2SrEmyp
	dGMSochBlL/oo7kvsnHM5zhn/cx0jkur6jG3sL1CGF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D51D414908;
	Mon,  8 Apr 2013 23:01:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CA9514907; Mon,  8 Apr
 2013 23:01:56 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-450-gd047976
In-Reply-To: <20130408210903.GC9649@sigill.intra.peff.net>
X-Pobox-Relay-ID: 4F673AC6-A0A0-11E2-866C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220539>

This comes on top of the two "decorate" patches that introduced the
clear_decoration() function.

I am not sure if pre-parsing and sharing the encoding values in-core
would affect performance very much, but now we have 2 bytes (or 6
bytes, if you are on 64-bit archs) free to use in "struct commit"
for later use (e.g. extra object flags that are relevant only for
commit objects, without having to widen "struct object").

Junio C Hamano (3):
  commit: shrink "indegree" field
  commit: rename parse_commit_date()
  commit: add get_commit_encoding()

 commit.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 commit.h    |   5 ++-
 pretty.c    |  33 +--------------
 sequencer.c |  23 +---------
 4 files changed, 122 insertions(+), 77 deletions(-)

-- 
1.8.2.1-450-gd047976
