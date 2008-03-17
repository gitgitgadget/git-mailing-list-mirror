From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Mon, 17 Mar 2008 08:54:08 +0100
Message-ID: <47DE23A0.6040100@gnu.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org> <7v63vmicvf.fsf@gitster.siamese.dyndns.org> <47DD9890.3060005@gnu.org> <7v4pb6gv7x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, beuc@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbABb-0000wp-1b
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 08:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbYCQHyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 03:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYCQHyN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 03:54:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62916 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbYCQHyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 03:54:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1661798fgb.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=cQ0zm4WZC6sqcesZiF3e4x3bHEqQ7RAFtcUyFTuKcUE=;
        b=es9x08/1l9UqGgpAhl5D1lKrf554750KAMmSRkFYdZMmUdBZFprTQAQHvdpRct9aRwZBJVUC21oQA6W2C6MF64q3+x7h1kS2zV+Vn90Li7eoQrG9ruoqK/ebPI0jQKiZFuaPiLKxNi1nFluHe/orpIPnKZLNhl4d25l7wQrayJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=pwlWtaMaZ69RcIGTJDbzr+SMbqFB/ZJ++IObYCTWELo0/dHouWIsLqVJLuLIa3fzohWZ5eOky5WsCJceK7I1ACy+GhdZ6lk8rk55KlONSo9BnIaNx28aaf3S7EGW6kxqw1tT9PfBbT13M6K2wWHFLJhNMqo2QTVzo1OpVFm/fk0=
Received: by 10.86.28.5 with SMTP id b5mr5065079fgb.76.1205740451035;
        Mon, 17 Mar 2008 00:54:11 -0700 (PDT)
Received: from ?192.168.76.107? ( [195.176.176.226])
        by mx.google.com with ESMTPS id 12sm21140069fgg.6.2008.03.17.00.54.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Mar 2008 00:54:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7v4pb6gv7x.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77417>


> What I am questioning is what the code should do (IOW, what would be good
> for cvs clients to see).  Should it send a symlink as a regular file, or
> simply just omit it?  If the answer is "the former", then we do not have
> to worry about it any further after applying your patch.  Otherwise we
> still have to do something _else_ after applying your patch.  I did not
> know which way we would want to proceed, and I still don't.

The reason why my patch was enough for me, is that users would just use 
the cvs bridge to stay up-to-date, not to spelunk the history (maybe to 
spelunk it with annotate, but not to look at old versions etc.).  For 
that, all I need is that current checkouts are okay.  We have to decide 
if other cvsserver use cases are common enough.

If they are, I think the optimal way to proceed could be to detect 
relative symlinks and resolve them (sending the linked file's content), 
and do "something else" (omit it, send the destination path as a regular 
file?) for absolute symlinks.

Paolo
