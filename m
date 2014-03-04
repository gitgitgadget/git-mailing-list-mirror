From: Junio C Hamano <gitster@pobox.com>
Subject: [microproject idea]
Date: Tue, 04 Mar 2014 13:11:25 -0800
Message-ID: <xmqq4n3dk6te.fsf@gitster.dls.corp.google.com>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwcl-0007Au-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 22:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbaCDVLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 16:11:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463AbaCDVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 16:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97FDE7104A;
	Tue,  4 Mar 2014 16:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZwoVFqO0zyPp2uThn5yvCKSehpA=; b=bRc9dD
	McmkXkQhEB1Pq9d8O4cTp32/10kWiJVo5bqbcOiFBUSry+exUC6qFJ8pxXI5fuTw
	a4F5J1Ea14wz2X3FJSWTJrbLQMJBChD2GJ2pjGQ5Jm3B54YzEF7O2Ek/t+UJlaPW
	JGSmJSDp4za76/VSrOrB4ur2K7zRdTHBQEXK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZanKSX+B0ZXxc7UawnQK8x1AWXrXi/I
	+kFOgFpQEZQ3L4VdTQasKo069Mx473WrUbQ4fUzFcxgkr6GUaZ5HLw+vX4LAgPnV
	L0+fry7RTSaIbMfq8zU/QvGe7gaitSdjT2AQgcH+cvDg7oDROfW8yJVf7f5bUq6Y
	JIXZYh2I34g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8672871049;
	Tue,  4 Mar 2014 16:11:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A491671048;
	Tue,  4 Mar 2014 16:11:27 -0500 (EST)
In-Reply-To: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 4 Mar 2014 09:31:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8CD3220E-A3E1-11E3-8439-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243392>

Find places where we scan a string twice unnecessarily, once with
strchr() and then with strlen(), e.g.

	const char *colon = strchr(name, ':');
	int namelen = colon ? colon - name : strlen(name);

and rewrite such a pattern using strchrnul() as appropriate.

The above example can become

	const char *colon = strchrnul(name, ':');
        int namelen = colon - name;
