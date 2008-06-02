From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Mon, 02 Jun 2008 15:52:11 +0200
Message-ID: <4843FB0B.60607@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <7vr6bkmkbm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 15:54:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3AU2-0007IA-Uh
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 15:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761428AbYFBNwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 09:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761417AbYFBNwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 09:52:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:32211 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761358AbYFBNwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 09:52:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so741152fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=EqxEQDWZ4GBDN+kP9GBfydHkma87yXwvg90xVCt79E0=;
        b=KKrmYrxWUtahw9Wq2TED6X1UpH8i7akxClaNknnxOPwiocOLyobvhipxEO5qFqm99KctRRX7nWktiBQKxBQXjxkMynSX0W/qztGWqkxMbbWvNUMWsNN6IsMeHOtnMtzigX6nx0IVpdPtWJ9U0SMqC8zukuGa52h9tCOVbNGIGuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=x1i80hWVUmP8GiWacC2eq7M+HgqTqaRA1+CxinlDd8wHcxgTC9o5LzUITcrKyQyo3Cw67+PMNFa0AeQqLI9QPS3aDDu1q17tFmtqhmDHB+bsI3G9MleLfzxrxkMNs8Nv77xcmGFDlZW1DNVj7WD5Rdib7tYfyTYi2SqQzvvfeB8=
Received: by 10.86.77.5 with SMTP id z5mr1159329fga.13.1212414733580;
        Mon, 02 Jun 2008 06:52:13 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id l19sm4294747fgb.7.2008.06.02.06.52.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 06:52:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vr6bkmkbm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83521>


> If your change were so that "git commit --interactive" reverts the index
> when one of the hooks exited non-zero just like COMMIT_NORMAL case (as
> opposed to the current code which does not revert the index), I would
> understand the need to change what's inside "if (interactive)" block.

So why does the COMMIT_AS_IS path need to lock?  The comment is not clear:

          * The caller should run hooks on the real index, and run
          * hooks on the real index, and create commit from the_index.
          * We still need to refresh the index here.

It seems to me that the lock+refresh+write+commit done by plain "git 
commit" is useless too, since it also runs in the case "pathspec && 
*pathspec".

I guess the patch should be withdrawn, and so I didn't want to follow up 
anymore, but the weird comment made me change my mind...

(The other patch I sent -- which is at 
http://permalink.gmane.org/gmane.comp.version-control.git/83209 -- is 
not withdrawn and not related to this one).

Paolo
