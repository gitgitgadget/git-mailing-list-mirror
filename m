From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] implement generic key/value map
Date: Sat, 04 Aug 2012 15:58:10 -0700
Message-ID: <7vehnm8dbv.fsf@alter.siamese.dyndns.org>
References: <20120804170905.GA19267@sigill.intra.peff.net>
 <20120804171038.GA19378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 01:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxnSv-0005ki-0d
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 01:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab2HDXI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 19:08:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2HDXIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 19:08:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E78FB9648;
	Sat,  4 Aug 2012 19:08:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=goPs6VHWKTMHY/GBdh5P5rUm+1Y=; b=x3b6CeFp+aBGaWIkDCHG
	yqa89mmYq4oAnb3ze6prDa9YAA8N3kdUdo/P94zoN7p4HkiBP5zfYIZoG5tUcKqA
	73wRBmquDApJxKtFKmdIGGJa4dRBk5sqpauGcAk+d53gY+gJfpuWfz6/XjZCMrCU
	c/oXIQRwBai7DbknEaFc6ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IXC/8nFGwjfXMzG+iPWmiCF1CLUJoR3SkWwlFMngdXclKB
	RKhwiUxKghq9hzy/knqxX94xZwiFn9Zw5GWLUzBaRExA0JabSyCuxSWJmlTxe7Fu
	LrzOcLvA5DX7c1oox80ar2cP2FwI4dCfyNaGFSflS8i/ap70zlpcfbrnMOsdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D56F09647;
	Sat,  4 Aug 2012 19:08:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49CB69646; Sat,  4 Aug 2012
 19:08:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C96B4B2-DE89-11E1-AE67-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202899>

Jeff King <peff@peff.net> writes:

> It is frequently useful to have a fast, generic data
> structure mapping keys to values. We already have something
> like this in the "decorate" API, but it has two downsides:
>
>   1. The key type must always be a "struct object *".
>
>   2. The value type is a void pointer, which means it is
>      inefficient and cumbersome for storing small values.
>      One must either encode their value inside the void
>      pointer, or allocate additional storage for the pointer
>      to point to.
>
> This patch introduces a generic map data structure, mapping
> keys of arbitrary type to values of arbitrary type.

Does the type of keys in a map have to be of the same size, or can a
key of a type with variable size (e.g. struct with a flex member at
the end)?  Same question for the type of values.

Is the type of keys in a map required to have a total order over it,
or is it suffice only to have equality defined?

The latter might matter once we start talking about a huge map that
we may not want to hold in-core.
