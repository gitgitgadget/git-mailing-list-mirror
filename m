From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories
 in git-prune/repack
Date: Tue, 06 Mar 2012 12:19:06 -0800
Message-ID: <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
References: <OF93114E93.E64C1F7D-ONC12579B9.0032A592-C12579B9.00332D78@dcon.de>
 <4F565849.80303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: karsten.blees@dcon.de, kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:19:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50qq-00016l-5P
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030973Ab2CFUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:19:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030950Ab2CFUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:19:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A556CD7;
	Tue,  6 Mar 2012 15:19:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+vr1edjkd+L8O0xOPbginWIpHQ=; b=FxjgNC
	6bj7kNPzi+Z4tKLeImC82JU4zTaHkgmeqnrhhZhBIsH44snnmn/rhNCoJn1ZS93h
	d8DzL3Ip/3aOf0My64z9Nq+V+XDQXMsb/XNPwQhE0x1FbgrmFsx9Ep/2oyaM/15q
	3HbrwLXAIDIP0zMmFMn71wTzybCUEYPONljio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HMFdVo9hYPuNvQ7VJpqXNSYvhAhUmaEh
	/Fgc6s+yb4bo7TXThb85XyrZdB842MtzwJmkDrkB5orIgCuSiP++eW4/DaW9ytlb
	ElzwTwWFHeNoLcsQc0I/VZPnPVoOiRiYpq0hRaS50Ha02lOgkZSx8d28RF7QwXyU
	TCxTbO/hDso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFC36CD6;
	Tue,  6 Mar 2012 15:19:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558AF6CD5; Tue,  6 Mar 2012
 15:19:08 -0500 (EST)
In-Reply-To: <4F565849.80303@kdbg.org> (Johannes Sixt's message of "Tue, 06
 Mar 2012 19:32:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0EE5DC2-67C9-11E1-BA61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192385>

Johannes Sixt <j6t@kdbg.org> writes:

>> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
>> index f9463de..a834417 100644
>> --- a/builtin/prune-packed.c
>> +++ b/builtin/prune-packed.c
>> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, 
>> int len, int opts)
>>                 display_progress(progress, i + 1);
>>         }
>>         pathname[len] = 0;
>> -       rmdir(pathname);
>
> After moving the rmdir() away from prune_dir(), the truncation of the
> pathname does not logically belong here anymore. It should be moved with
> the rmdir(). Looks good otherwise.

I agree that it is better to have the NUL termination close to where
it actually matters.

Do you want me to take it after locally fixing it up, or do you
prefer to feed this as part of msysgit related updates to me later?
