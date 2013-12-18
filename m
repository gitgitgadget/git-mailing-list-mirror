From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: "git fsck" fails on malloc of 80 G
Date: Wed, 18 Dec 2013 16:08:47 -0500
Message-ID: <201312182108.rBIL8lAo015570@hobgoblin.ariadne.com>
References: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com> <20131216191500.GD29324@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 23:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtPUI-00079P-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 23:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab3LRWUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 17:20:49 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:46997
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab3LRVIv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 16:08:51 -0500
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id 36YX1n0030Fqzac5698qdT; Wed, 18 Dec 2013 21:08:50 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id 398p1n00m1KKtkw3U98qYq; Wed, 18 Dec 2013 21:08:50 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id rBIL8lFn015573;
	Wed, 18 Dec 2013 16:08:48 -0500
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id rBIL8lAo015570;
	Wed, 18 Dec 2013 16:08:47 -0500
In-reply-to: <20131216191500.GD29324@sigill.intra.peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1387400930;
	bh=dBy1ePL1qJDTy63w/uteX2RZziokXPfDOBnfRmoQbRk=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=Fopf6rhqX6Qq3t9XfwFrHlitovASNxLKIagp+0pyhtE/UqXx8meRu8ZNONz6UaiZh
	 pFAkj3MA17K/X1DyTBP/dxsah8KKDgXic0LBagThq48Zmpv9Sv29w7FLJfMwZn8P9j
	 PEhSxbWZXAI2nWOdtvYkR/FWO1QeVQpviir7aZeBPxmH60topOv00bcXhBCcx11xbk
	 PcQXchhUmBaNtmr54iPdkH8vRBC4F1zmhsQ7a3INJnUXj0m0m5vjvkifKEuAjffTz2
	 G8hEsTvBQjFkc64YHzL6hDvdzIb6POdktMEgKGYOSHDeHkHnhwHO3tDcDSpD3cTxka
	 EYCtRZUap+ODQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239496>

> From: Jeff King <peff@peff.net>

> One of the problems I ran into recently is that
> corrupt data can cause it to make a large allocation

One thing I notice is that in unpack_compressed_entry() in
sha1_file.c, there is a mallocz of "size" bytes.  It appears that
"size" is the size of the object that is being unpacked.  If so, this
code cannot be correct, because it assumes that any file that is
stored in the repository can be put into a buffer allocated in RAM.

Dale
