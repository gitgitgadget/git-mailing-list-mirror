From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Effectively navigating branch history
Date: Tue, 31 May 2011 11:40:50 -0700
Message-ID: <7vtycaiuh9.fsf@alter.siamese.dyndns.org>
References: <18203023.45200.1306866084905.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRTsy-0005hu-Vq
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab1EaSlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 14:41:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab1EaSlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 14:41:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E32B95F20;
	Tue, 31 May 2011 14:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myDMAUzQZ4j3drW1CBx25sFx9Uo=; b=rvSPLz
	iKbZ/4PfXbispU/6LsOoV7BVA6SzRsZcszMKwpt13BWqLkfgnMHP2kq0l1aXDY6J
	b0H4+WAV2+l/NFtT2+//KkN0LoX+xhtXHXVHgoFdyPuZ4pbmUoXOoy1hks4kSKR3
	idSaLHiJAvmSrVTzpBUo7+910KAOT4CU4rnR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZFsNiDv8PnUz6GtwW6TACM3qEcSLicKA
	8AvuPhQi1a0eK1aj+vGobyMtb8TbMbBVVJimb6MjPJXHYtox4EdX5/Q1doA3Afia
	bWxq5+Fh9QWm6tNOPL6+64oVDiVKI7Pify/WOM+A7HInJzpQmzi26HzIMR0jv4dC
	ODUhmXsJsiA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1DB85F1F;
	Tue, 31 May 2011 14:43:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 90D485F1E; Tue, 31 May 2011
 14:43:01 -0400 (EDT)
In-Reply-To: <18203023.45200.1306866084905.JavaMail.root@mail.hq.genarts.com>
 (Stephen Bash's message of "Tue, 31 May 2011 14:21:24 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D268093E-8BB5-11E0-9B16-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174819>

Stephen Bash <bash@genarts.com> writes:

>> Yeah, I think it was 1f9a980636 which was a merge between fb674d7 and
>> 73546c0. I just compared the output between these two:
>> 
>> $ git diff fb674d7...73546c0 -- config.c ;# what the topic did
>> $ git diff fb674d7 1f9a980 -- config.c ;# what was merged
>
> I often find myself wanting to do the "what the topic did" operation but
> once the branch is merged and deleted, I have difficulty finding useful
> SHAs to diff.
>
> So in an attempt to educate myself, I tried to track down fb674d7 and
> 1f9a980 (and failed miserably).

I just did

    $ git log --first-parent master -- config.c

which was sufficient for my workflow as most of the commits on master are
merges from topics and I can see what each topic did from the merge commit
summary message.  


If I were doing this on a codebase I am not very familiar with, I probably
I would have first narrowed things down a bit by

    $ git grep -n -e NOGLOBAL -- config.c ;# to learn the line number 830
    $ git blame -L825,835 -- config.c

to learn where the offending NOGLOBAL came from (it is from ab88c363) so
that I can say

    $ git log -m -p -GNOGLOBAL ab88c363.. -- config.c

to find that 1f9a980 reintroduced it by mistake.
