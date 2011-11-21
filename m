From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Sun, 20 Nov 2011 23:59:23 -0800
Message-ID: <7vobw5hpno.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <00392567F0B045E38A429F95594C1BD2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Taylor Hedberg" <tmhedberg@gmail.com>,
	"Bertrand BENOIT" <projettwk@users.sourceforge.net>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 08:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSOmp-00070Y-PW
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 08:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab1KUH70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 02:59:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754414Ab1KUH70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 02:59:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2472926;
	Mon, 21 Nov 2011 02:59:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hPn+Fg6BtSxIJgdjPtOr3eltNtQ=; b=qW7xjy
	7+hHTuJlFYpGlO5+DJxFpErFkx+M4OJWV9yCYEr36oex2CH08UMXxDGuJMkRk1m5
	PoJqw2YLHvp8NWjcLzGUfKJrT0CfVdBlVyWUKOHKsfH459BQlf0v18xtDuewh0t6
	qJ+fefUnzT1nHATTIMk55nCnupP+FkuYg2fsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HpFzjtjkHCwYmXwCHZAWk8V1cEkpamKt
	RE+xnQkZzVOt1pZ69dUkQfB+t44tfKCTLIIiCBQXyrRLOME2srbo7bxvNVxl3puE
	lv1C9tAa7BHMGb+0QlwE3HGLQns3y9kzTqls7vIuY/PQjsH9sOXyNStQ26nxCBYP
	Mn3Z8LNRdNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B421A2925;
	Mon, 21 Nov 2011 02:59:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48C322924; Mon, 21 Nov 2011
 02:59:25 -0500 (EST)
In-Reply-To: <00392567F0B045E38A429F95594C1BD2@PhilipOakley> (Philip Oakley's
 message of "Mon, 21 Nov 2011 07:45:01 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAC466D0-1416-11E1-85ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185736>

"Philip Oakley" <philipoakley@iee.org> writes:

> Shouldn't there be some documentation changes to support this very
> useful feature.

I do not agree it is "useful", if it is info/exclude only, which by design
would not propagate across repositories and histories.

If we were to support "precious" as a feature, we should do that properly
with a properly defined syntax (e.g. just like '!' prefix is "no, this is
not 'ignored' entry", use some prefix to say "well, this is ignored in the
sense that not to be tracked, but that does not mean this can be nuked")
that can be in any exclude sources.

Exclude patterns in info/exclude should work just like ones in the in-tree
.gitignore only at different precedence for uniformity and consistency, so
the behaviour J6t showed in the new test should be fixed.

The entries in info/exclude are at lower priority than the ones in in-tree
.gitignore files, which probably was a design mistake, but that is a
separate issue.
