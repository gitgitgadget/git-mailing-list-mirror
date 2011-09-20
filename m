From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] fast-import: cache oe more often
Date: Mon, 19 Sep 2011 21:02:22 -0700
Message-ID: <7vy5xj7tf5.fsf@alter.siamese.dyndns.org>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 06:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5rXT-00025T-Dz
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 06:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab1ITEC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 00:02:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab1ITECZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 00:02:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F745CA4;
	Tue, 20 Sep 2011 00:02:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eC9yuLwixP4LOL98hHMlFqBaMrg=; b=GS8fa7
	9RR189LXDx4lIzOjmraKF3IhDnMF1BL2EUq8uo3F0Fv1L1MvymaJ1wlX3cH3Vyqz
	TtT2HPoCUkXLddxnWsFEqa6srtqe9wy82YLdiDmQhKRZZPOwKXHevI2pLOrocWWB
	hwrV5/i+fySvg+/EW7cjUAvQi/vbvfi10gquo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLTUiByhQqUHJhwL8TEid/xLY7An3GHi
	7R04lMhJ0bG1SuiJ3WxY1HNkB5Q+7QBJ5R1ozy4+lS3GolouS8PBYSXZmh16jdPs
	9FXDUW9MG1JBwsF4wHDrcw2nVAgYuTrXGyjL1pf5ssHR8PkPV++HXAQbQrBqhE1l
	zbODzyRC+MY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D97DF5CA3;
	Tue, 20 Sep 2011 00:02:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 614775CA2; Tue, 20 Sep 2011
 00:02:23 -0400 (EDT)
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Mon, 19 Sep 2011 07:27:29 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 584120DE-E33D-11E0-923C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181730>

Dmitry Ivankov <divanorama@gmail.com> writes:

> fast-import keeps a struct object_entry for each object written to
> it's pack. This is to keep type, pack-coordinates and delta_depth.
> struct object_entry is also used to cache this metadata for objects
> that exist outside fast-import's pack ('old' objects).
> struct object_entry has a small fixed size and thus it should be
> reasonable to cache any 'old' object metadata retrieval to save the
> disk i/o.
>
> Also it is a step toward making fast-import identify objects via
> struct object_entry rather than sha1. One pointer takes less than
> 20 bytes, it'll be later possible to have references to objects
> that don't yet have sha1 computed (fast-import with threads future).

I gave the series a cursory look, and the patches all looked like a good
and straight forward rewrites.  Provided if it is indeed a good idea
overall to stuff more objects in-core, that is.

Hopefully people more involved in fast-import can review and ack after the
pre-release feature freeze.
