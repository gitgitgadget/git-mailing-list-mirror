From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Wed, 17 Feb 2010 17:51:23 +0900
Message-ID: <4B7BAE0B.6040001@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <7vljeyp1rj.fsf@alter.siamese.dyndns.org> <4B764B67.1020402@dcl.info.waseda.ac.jp> <7vsk95sht6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:51:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhfdQ-0000YE-OB
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934167Ab0BQIvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 03:51:48 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:57712 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934102Ab0BQIvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 03:51:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id C4240EDAB88;
	Wed, 17 Feb 2010 17:51:46 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMB9aEoIuTcP; Wed, 17 Feb 2010 17:51:46 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 7BFAAEDAB84;
	Wed, 17 Feb 2010 17:51:46 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7vsk95sht6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140219>


Sorry for my slow response...

On 2010=E5=B9=B402=E6=9C=8813=E6=97=A5 16:42, Junio C Hamano wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>> Because strlen(challenge_64) is the upper limit of length of challen=
ge.
>> So tail part of challenge may not be filled by EVP_DecodeBlock(),
>> non-zero filled buffer produces not NULL terminated string.
>> I've confused once by this problem before.
>
> If you know the length of the decoded thing, then you would just know
> how much to hash.  Doesn't the EVP_DecodeBlock() give you that number=
?
> Why do you need a NUL termination to begin with?
>
> Because you pretend as if you do not have the actual length, you run
> strlen() instead.  I am not that familiar with the API to EVP_* funct=
ions,
> but I'd be surprised if it were designed in such a stupid way to forc=
e you
> to write into a pre-zeroed buffer.

Sorry, what you say is completely correct.
And base64 is not an ascii specific thing, so strlen() cannot provide
correct information here.
Please forgive my foolish coding...

# I tried to reproduce the problem of not NULL terminated case,
# but I could not. I wonder what that was..
