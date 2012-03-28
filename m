From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 15:51:33 -0500
Message-ID: <20120328205133.GF8982@burratino>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328203758.GA10104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzqN-0007fa-Id
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab2C1Uvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:51:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164Ab2C1Uvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:51:39 -0400
Received: by yhmm54 with SMTP id m54so1075188yhm.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W9wNtts7q9oWQw4/ce3fBnGgaUeu1SP5T78ORPDh9fA=;
        b=AfVKXMhmnKsJD0LjAqwXrTMAvcwhbOPSoWutCzT/zU4chbPd9qhLO2HokZk2auuUf0
         V5UyVA0p3KxuS8v9iDTdWiTxLucH8JEv5jYrN/YByVH21GN7pu9jcGrXdEPatQuDlKBM
         2+C0+/32oyb25NT8JpWfZ++F0zVl0JruMy9ZhtFgRYvjhoMk03OkSvk+VYcnnN9cpihe
         K0zevVCO63+cwKQE1RucasiVbi6m0VbxaFnDz1PV9Aou+3fYFnPk0H6tjVrybhIfQSu3
         eNSjWrtKXNzk4NfvpA2BJr46/ktc+QwT6td0WmNroMXXR9bll/wgoTcF2OC6JvzDJdjx
         Shgg==
Received: by 10.60.30.70 with SMTP id q6mr41256708oeh.56.1332967899065;
        Wed, 28 Mar 2012 13:51:39 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d8sm1632501oba.17.2012.03.28.13.51.37
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 13:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120328203758.GA10104@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194194>

Jeff King wrote:
> On Wed, Mar 28, 2012 at 04:18:51PM -0400, Jeff King wrote:

>> +int sane_execvp(const char *file, char * const argv[])
>> +{
>> +	int ret = execvp(file, argv);
>> +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
>> +		errno = ENOENT;
>> +	return ret;
>> +}
>
> Hmm, this should check for (*file == '/') to handle absolute paths
> properly.

Or rather for "strchr(file, '/')", because "path/to/cmd" does not mean to
append that string to each term of $PATH.
