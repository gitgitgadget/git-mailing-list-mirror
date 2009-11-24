From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk does not show path file list
Date: Tue, 24 Nov 2009 00:11:11 -0800
Message-ID: <7v1vjoibq8.fsf@alter.siamese.dyndns.org>
References: <33e2b2760911170409q4cbdad8ay83ae5c941bc5ff95@mail.gmail.com>
 <loom.20091124T060334-836@post.gmane.org> <4B0B91DC.1020902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Blakeney <markb@berlios.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 09:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCqUj-0008RH-E0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 09:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474AbZKXILQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 03:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbZKXILP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 03:11:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbZKXILP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 03:11:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C407A1D9C;
	Tue, 24 Nov 2009 03:11:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=95DjjMi6/s14W22QCI5c9Yi4qCs=; b=vjX7/0
	li00LMdoh0XgmGuSe4RgZyo2AVBbAyD+dT92BypFYdfsZWMaiJX2RovcFgn9CMJy
	kFmlTmpQPh/GmhruRBDxFskoNrQ57VBxIxVSXuJESPpAxx4wbDr874nNsa3uaAVm
	0APQfoVZxguP0QqiWr50sKS2fIslFV/OAQbQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUJ0uV3vlETuSoBbSRze/OL9cYpYVcwy
	I2sHl1pBZLr0q4Va8xBJy+ChFni5Z3DnQb1Ri2rmd2q/SgucqptPU+X/aH/Ti62R
	B6QsXpBgUvMaVs39Q9yhMZuJnh409OE1/T5f4LhwZpfXRLt4YKP9iGHmxY9rMikj
	/S7IYn9WO/Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E451A1D9B;
	Tue, 24 Nov 2009 03:11:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B766DA1D9A; Tue, 24 Nov 2009
 03:11:13 -0500 (EST)
In-Reply-To: <4B0B91DC.1020902@viscovery.net> (Johannes Sixt's message of
 "Tue\, 24 Nov 2009 08\:57\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1424A66-D8D0-11DE-AF9C-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133569>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Mark Blakeney schrieb:
>> This seems to me to be a straight out bug but given I've had no response here
>> and  given this is such a simple issue then I guess it's not a bug and I'm just
>> missing something? Please somebody, why does gitk (usually) not show the subset
>> list of files affected when you give it a path?
>> 
>> E.g. If I am in a src dir then "gitk ." does not list files. Neither does "gitk
>> $PWD" nor "gitk ../src". However "cd ..; git src" does list files!?
>
> gitk doesn't list the files in your examples because the patterns you gave
> are not initial substrings of any files in the list.

Yes, but if you are in src/ and run "gitk .", then...

 - clicking on a commit runs "diff-tree $commit .", that lists
   src/hello.c, src/goodbye.c, etc.

 - gitk tries to filter paths read from diff-tree with the "." given from
   the command line as the filter---it removes paths that do not match.

So the only case that would produce any output would be for you to have:

 src/src/hello.c
 src/frotz.c

and run

 cd src && gitk src

whose invocation of "diff-tree src" will show _only_ src/src/hello.c and
then the filter procedure will limit it to whatever begins with src/
(which would be everything).

That does not sound very useful to me...

   
