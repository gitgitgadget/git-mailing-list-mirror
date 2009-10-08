From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archive and trailing "/" in prefix
Date: Thu, 08 Oct 2009 09:26:59 -0700
Message-ID: <7v4oq9j1gs.fsf@alter.siamese.dyndns.org>
References: <loom.20091008T172303-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvvv9-0000vI-Td
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 18:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbZJHQ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbZJHQ2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 12:28:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559AbZJHQ2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 12:28:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50B9270DE8;
	Thu,  8 Oct 2009 12:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xBDWPLTOGUrT0TxXjhQd7zi0w6A=; b=HkWjX3FD7Ab+Yygv+0RpMT8
	o9hnsOITXjL2nmLoY/IYW9uyqO6D4MIX9rmpiMRFEWajD0RwcbZtVhk6MIOAZZvk
	RTehyd8yUaFSnpMWcVCpT8f2fUd1VnHeAo+ZBSt71imjpCQk3TREKw8xmWHQKAl2
	a/d2iNgNYK3BDsjrcJA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WAAEDuMbI5rFRaXh6pfM9gV6A1xNVg0Uhgr9sm9cKnVXJXmEt
	cLOCVUgXUwHUPU/Hcs+K3cn/XROTDGMU+Qb0XNLpWw4NIf1ut8sYktFz8b6ZAXxL
	cuOywJOuTFWVjN3YD91h806rlr72QF5qIiqaMP11dpwWUoOBJ2cKwr0i4I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 331D270DE7;
	Thu,  8 Oct 2009 12:27:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 391FE70DE6; Thu,  8 Oct 2009
 12:27:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69EE9EE8-B427-11DE-A812-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129698>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> The git-archive man page indicates that if the --prefix option is passed to
> git-archive, it is compulsory to end the prefix with a "/"

No, it does not have to.

	$ git archive --prefix=v1.6.0- v1.6.0 Makefile | tar xf -
	$ make -f v1.6.0-Makefile

This is consistent with the way the same --prefix option can be used with
checkout-index.  e.g. to swap Makefile in work tree and in the index:

	$ edit Makefile
	$ git checkout-index --prefix=old- Makefile
	$ git update-index Makefile
        $ mv old-Makefile Makefile

These may or may not be useful examples, but this feature has been with us
for a long time.  I wouldn't be surprised if removing the ability to
archive or checkout with filename prefix (not leading directory path
prefix) causes grief to existing scripts of people.
