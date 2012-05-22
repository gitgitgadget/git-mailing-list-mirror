From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash destroys hard links
Date: Tue, 22 May 2012 10:41:32 -0700
Message-ID: <7v62bo5d0z.fsf@alter.siamese.dyndns.org>
References: <CAAXzdLWadNg9d_i8fZTawaxYm3ytcGCT4pzeth=LxrQYEO-3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWt5e-0005lo-T3
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759526Ab2EVRli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:41:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451Ab2EVRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:41:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C96498DDB;
	Tue, 22 May 2012 13:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VQkEccQKz5i4OXbb6A/nc/7bkEA=; b=DzKQpK
	/yyJbMsO2Vq/cOHNGoQHGGYDw7w6pWk8gAHrVRTaZJJd45u8afSq84iR725Ji0TT
	GfuJwJ+QXhMcYIZZKA2nWUrQN3Ck5kLHo1+RKihMVsJrG8pz9+Ffx2sPJ2/w6xyL
	8jOeUHrDv/ulLkz7iO1buSnAjqjfWVepjXfb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gnX/1LZhAMy2CfOAhmKRdzG297VRltAm
	lnrDb+g3PlACt42vChJUnj9qiQYlUjGjTr0lQiXra6QK3yP3WKk9XXVZm41ju+z4
	DC3qVYdcQkgxWnjeriZqGDf8V657ZMd6umTLVRiC+ZeF10dMnkVWnrnBJngqlQ27
	gUR9ayF+Ia8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA9DF8DDA;
	Tue, 22 May 2012 13:41:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B77C8DD9; Tue, 22 May 2012
 13:41:34 -0400 (EDT)
In-Reply-To: <CAAXzdLWadNg9d_i8fZTawaxYm3ytcGCT4pzeth=LxrQYEO-3ww@mail.gmail.com> (Steven
 Penny's message of "Mon, 21 May 2012 23:24:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FB689B2-A435-11E1-83F0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198213>

Steven Penny <svnpenn@gmail.com> writes:

> I dont know if this is even fixable, but I wanted to at least mention it.

I do not think there is anything specific to stash.  Whenever we write out
results of an operation to a file in the working tree, we first unlink(2)
and then creat(2), which essentially breaks hardlinked files and avoids
updating some _other_ paths that share the underlying file with the
updated path.
