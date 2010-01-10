From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Sat, 09 Jan 2010 22:31:43 -0800
Message-ID: <7vmy0mfp2o.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
 <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
 <7veilzaguf.fsf@alter.siamese.dyndns.org>
 <7vfx6f3dm3.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001091004380.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 07:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTrLx-0002iv-1D
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 07:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0AJGcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 01:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534Ab0AJGcB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 01:32:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab0AJGb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 01:31:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21BDE8F391;
	Sun, 10 Jan 2010 01:31:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=B0+NHZe3/rjGi5Fb8TPgUevdmoU=; b=uGRbZJx6lNzLYDj7BgKvjtb
	d48TPRjxtilTur8aabOjfre+MGnWi9msqUQzKjjC67YiYS7Mt8jedXukL1wH/9d+
	YgmDX1j7s3KerxjcvEVOTMPIKOQ81KhA7ADqkJay8DLUKhD8X2fwF76y1/VUGkqB
	6VnlWIpOPwz/yvN5P6PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dOjNJttm0/hontn3iF1/4cuZ9G3cFcJBZmJN3UXgVVPnxA6q0
	AhCtC//l9BcOMbOYy6pbAHBvC/4Zzq7HJr5YJVaOelTZkReo+g8n57qhIkkgnDlr
	n3yNmMlsVL9SBcKznBHhQ+EIVUO75YDaUloaktA30yHmgXb5uQhBcBM19g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A398F390;
	Sun, 10 Jan 2010 01:31:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 922628F38A; Sun, 10 Jan
 2010 01:31:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6784CD4-FDB1-11DE-AD29-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136558>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 9 Jan 2010, Junio C Hamano wrote:
>> 
>> Having sent these patches, I am wondering if the simplest fix might be this
>> one-liner.
>> 
>> diff --git a/dir.c b/dir.c
>> index d0999ba..7fba335 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -788,3 +788,3 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
>>  	simplify = create_simplify(pathspec);
>> -	read_directory_recursive(dir, path, len, 0, simplify);
>> +	read_directory_recursive(dir, "", 0, 0, simplify);
>>  	free_simplify(simplify);
>
> That one-liner doesn't work at all for me.
> ...
> IOW, it now ignores _everything_, because the dir and the path don't 
> match.

Hmph, you are right.  The real series is not equivalent to the one-liner
at all.
