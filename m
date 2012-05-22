From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/7] unpack-trees: record which unpack error messages
 should be freed
Date: Tue, 22 May 2012 22:22:42 +0200 (CEST)
Message-ID: <20120522.222242.2217647953969252595.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
	<20120521145610.1911.60207.chriscool@tuxfamily.org>
	<20120521204350.GC28331@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, artagnon@gmail.com,
	nbowler@elliptictech.com
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 22 22:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvbc-0002m2-OI
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab2EVUWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:22:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41235 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296Ab2EVUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:22:51 -0400
Received: from localhost (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7BC23A623A;
	Tue, 22 May 2012 22:22:43 +0200 (CEST)
In-Reply-To: <20120521204350.GC28331@burratino>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198238>

From: Jonathan Nieder <jrnieder@gmail.com>
> Christian Couder wrote:
> 
>> "struct unpack_trees_options" has a "const char *msgs[]" field
>> that is setup with string values in setup_unpack_trees_porcelain().
> 
> Hmm.  Incidentally, should callers (e.g., the 100 single-picks
> involved in a large multi-pick) be reusing these strings instead of
> allocating them again and again?

Some strings filling the msgs field are created with sprintf() using
the cmd argument passed to setup_unpack_trees_porcelain(). So they
could be different if different cmd arguments are used. In practice
now cmd is either "checkout" or "merge", so we could probably reuse
the same strings. But if we ever add a checkout command to the
sequencer for example, we might want to use different error messages.

Another possibility is to xmalloc all the strings and then free them
all.

Thanks,
Christian.
