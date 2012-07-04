From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Replace ce_namelen() with a ce_namelen field
Date: Wed, 04 Jul 2012 12:26:07 -0700
Message-ID: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
References: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 21:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmVDx-0000le-2B
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 21:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab2GDT0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 15:26:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab2GDT0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 15:26:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C7ED8E10;
	Wed,  4 Jul 2012 15:26:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4t+Db3ZyzKCb4bujlMujXBMTjoc=; b=MJOrPk
	Pleptc7JQoNdYE1phcDSxH7pd/nZYEsWB8aKEYCQPT3pKAaDfGoMBr2ONkHV6JU9
	Zq8/iLbJInHr5wYWRq3JJF695ssMttR565wOFGGXkBr00fzlok+2h/aDQAHHOReT
	ONW2X8UYcsN9iROeVZtQK4UJH/rgQ8LR6G9+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uAFc37wyyBVae3PEoPvhcNkHcoCYqHfP
	MtcDWneG29/TpvrSacMud2nBkbOjDJVidr9FJ5L7pr5BbgyQkO+nndloMkseYUag
	qJTyduEVOzS4czCKVlz6m4ZejVjTACCQ5m0aKZTozojozPZERtvhMfWiYunezdrP
	Hr9E25TQQx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E458E0F;
	Wed,  4 Jul 2012 15:26:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B347E8E0E; Wed,  4 Jul 2012
 15:26:08 -0400 (EDT)
In-Reply-To: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 4 Jul 2012 11:18:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B494D0A-C60E-11E1-8078-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201012>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Replace the ce_namelen() function in cache.h with a ce_namelen
> field in struct cache_entry.

NAK, at least in this form that duplicates the same information in
ce_namelen (new field) and bits in ce_flags, making it easier for
them to go out of sync with new bugs (or misconversions in this
patch, if there is one).

At least, keep the ce_namelen() inline used in the existing calling
site, as the whole point of it is that they do not have to care how
the name length is stored or computed.
