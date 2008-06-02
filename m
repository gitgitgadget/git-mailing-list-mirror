From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Mon, 2 Jun 2008 07:35:39 -0700
Message-ID: <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
	 <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
	 <20080602064218.GA15144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 16:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3B9D-0005fs-PF
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbYFBOfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 10:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYFBOfl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 10:35:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:2600 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbYFBOfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 10:35:39 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1065320rvb.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=l0DbQQU9v2qV0z3DKf7B+MFrbfy2jMUZO/zY9x8OGUI=;
        b=UURK/iV3j1nvjLFwratAoD6+taKY3+wHmLrFPzPgMPwBGW8+S0vjb/eafryRUL39nqfSPfifHyRzHbio4VjHzs/X1irMjDQx+LfBym4FtqTqyLdYvVJmdb6tD05XAfjMV0z3qFSR594k1A4MTb48KJMU9E9qbyqtXPgpUGbgTnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EvuNfkPTlgUS4TeaPvmCAJaQ2eoAX04nbsOL2l5vs9M5Who/SnsAJdQnlqS//vfOEqwX7o3Ztvue1eDUp3mEMGChhBCpvWaBWYq7FaHXrYG4fTZGEJ7n3jPjfthVAs6ybC2RkAAljxM5WrI2PXVIdnYHn6HJ4fbVA5o9LljxHYc=
Received: by 10.141.195.5 with SMTP id x5mr4957345rvp.263.1212417339125;
        Mon, 02 Jun 2008 07:35:39 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Mon, 2 Jun 2008 07:35:39 -0700 (PDT)
In-Reply-To: <20080602064218.GA15144@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 84848ebb2543ed5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83526>

On Sun, Jun 1, 2008 at 11:42 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 02, 2008 at 07:13:14AM +0100, Johannes Schindelin wrote:
>
>> I do not think that this "read-the-entire-table-into-memory" paradigm is a
>> wise choice. mmap()ing, I would have understood, but reading a potentially
>> pretty large table into memory?
>
> When I was just a git-youth, I wrote a fast mmap-based cache for storing
> SHA1 pairs. It might give some direction. You should be able to find it
> here:
>
>  http://mid.gmane.org/20060629035849.GA30749@coredump.intra.peff.net
>
> It mmaps and binary searches a sorted list. New entries are added to an
> in-memory list, and then at the end of a run, the two sorted lists are
> merged to create the new on-disk version.

I don't need sorting (and neither did you), so I think a hash table is
better (O(1) instead of O(log n), and we don't even need to compute
hash keys.  I'll leave it up to you and Dscho (or anyone else who
cares to chime in) which one you think I should do.

Geoffrey
