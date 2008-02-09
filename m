From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v4] Work around curl-gnutls not liking to be reinitialized
Date: Sat, 9 Feb 2008 21:51:19 +0000 (UTC)
Message-ID: <loom.20080209T214811-305@post.gmane.org>
References: <1202512124-28669-1-git-send-email-mh@glandium.org> <1202550096-13233-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 22:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNxfi-000296-4V
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 22:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbYBIVzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 16:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbYBIVzI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 16:55:08 -0500
Received: from main.gmane.org ([80.91.229.2]:50458 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904AbYBIVzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 16:55:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JNxf5-0002BG-04
	for git@vger.kernel.org; Sat, 09 Feb 2008 21:55:03 +0000
Received: from 1-1-5-26a.hud.sth.bostream.se ([82.182.26.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 21:55:02 +0000
Received: from daniel by 1-1-5-26a.hud.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 21:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.182.26.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071128 Iceweasel/2.0.0.11 (Debian-2.0.0.11-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73269>

Mike Hommey <mh <at> glandium.org> writes:

> curl versions 7.16.3 to 7.18.0 included had a regression in which https
> requests following curl_global_cleanup/init sequence would fail with ASN1
> parser errors with curl-gnutls. Such sequences happen in some cases such
> as git fetch.

Hi git hackers,

I am the main libcurl author and maintainer.

While I agree that this is a regression and a bug in libcurl, it puzzles me why
you found it in the first place. curl_global_init and curl_global_cleanup should
only be needed to call once per program's lifetime. I can't think of any
practical use to do this re-init at all. You will only waste time on this.

So, your best fix for this problem is to simply to a curl_global_init() in the
beginning and a curl_global_cleanup() in the end.

(I'm not subscribed to this list, just responding via gmane.org)
