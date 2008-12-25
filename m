From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] handle_remote_ls_ctx can parsing href starting at
 http://
Date: Wed, 24 Dec 2008 23:04:46 -0800
Message-ID: <7vmyekag6p.fsf@gitster.siamese.dyndns.org>
References: <7v3aghnv1t.fsf@gitster.siamese.dyndns.org>
 <1230021075-10113-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Thu Dec 25 08:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFkM9-0000OI-5w
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 08:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYLYHE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 02:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYLYHE4
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 02:04:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYLYHE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 02:04:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90FC71AFF8;
	Thu, 25 Dec 2008 02:04:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5CD3A1AFAB; Thu,
 25 Dec 2008 02:04:47 -0500 (EST)
In-Reply-To: <1230021075-10113-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Tue, 23 Dec 2008 11:31:15 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 53C905F2-D252-11DD-8DBF-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103894>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> The program call remote_ls() to get remote objects over http;
> handle_remote_ls_ctx() is used to parse it's response to populated
> "struct remote_ls_ctx" that is returned from remote_ls().
>
> The handle_remote_ls_ctx() function assumed that the server will
> returned local path in href field, but RFC 4918 demand of support full
> URI (http://localhost/repo.git for example).
>
> This resulted in push failure (git-http-push ask server
> PROPFIND /repo.git/alhost:8080/repo.git/refs/) when a server returned
> full URI.

Thanks.

Do you mean PROPFIND was made to that garbage with :8080 in it when the
server returned a full URI http://localhost/repo.git as in the example in
the previous paragraph, or are you using a different example here?

I am contemplating of munging your commit log message like this...

commit e1f33efe07b9a520505fccd71bea1292fc9448dd
Author: Kirill A. Korinskiy <catap@catap.ru>
Date:   Tue Dec 23 11:31:15 2008 +0300

    http-push: support full URI in handle_remote_ls_ctx()
    
    The program calls remote_ls() to get list of files from the server over
    HTTP; handle_remote_ls_ctx() is used to parse its response to populate
    "struct remote_ls_ctx" that is returned from remote_ls().
    
    The handle_remote_ls_ctx() function assumed that the server returns a
    local path in href field, but RFC 4918 (14.7) demand of support full URI
    (e.g. "http://localhost:8080/repo.git").
    
    This resulted in push failure (e.g. git-http-push issues a PROPFIND
    request to "/repo.git/alhost:8080/repo.git/refs/" to the server).
    
    Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
