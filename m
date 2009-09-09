From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Use git-add-file for unmerged files, remove
 git-resolve-file
Date: Wed, 09 Sep 2009 12:10:43 -0700
Message-ID: <7vhbvcszm4.fsf@alter.siamese.dyndns.org>
References: <4AA026AC.10907@gmail.com>
 <7vtyzdrq1h.fsf@alter.siamese.dyndns.org> <87ocpk6qwe.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Nordholts <enselic@gmail.com>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 21:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlSZL-0007in-5x
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 21:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZIITKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 15:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbZIITKu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 15:10:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZIITKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 15:10:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2462CFDE;
	Wed,  9 Sep 2009 15:10:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3t8DIipVTif8LcIm13OrViHYzWg=; b=WVoKbo
	YZkF2WVcWtST6ZhKxr+iH7dAnVjbGOXpppVyQjzLTToDGyH0BLrVUEUWaR4H3YRV
	02jBfnqyETLF+18CG56e18uCAE/qW9k3QBLnAmHXNWSbbRbKHcsCdwbv+W5apYek
	sZ2JWhvasNf1qA/ROjhbJ1fyEp9xFGGhGa1lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YIKPC917jwDZzp/XxG+vOeMGo6ZfiC28
	0J+W2Ql9vpRFI8sI6TN5kmfyYfPTVOxbkBcWCVtumwI8s5NcA8Rkaf8Mw1PnlKBi
	fp/zvd00kRcfCttFFYFLCvEHUnWvUIqN7KWetbzzWYEvse+bspvWeWBtZU2EkUgw
	aTLZNgG1m9Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E619D2CFDD;
	Wed,  9 Sep 2009 15:10:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 220F42CFD8; Wed,  9 Sep
 2009 15:10:44 -0400 (EDT)
In-Reply-To: <87ocpk6qwe.fsf@wine.dyndns.org> (Alexandre Julliard's message
 of "Wed\, 09 Sep 2009 18\:09\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C8DA388-9D74-11DE-A500-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128078>

Alexandre Julliard <julliard@winehq.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not know all the details of how Emacs keybinding works, but I had an
>> impression that something-x sequence is triggered if you type something-X
>> and you do not have an explicit binding for something-X but you do have a
>> binding for something-x.
>>
>> IOW, if I only have
>>
>> 	(define-key global-map "\C-xc" 'compile)
>>
>> then both "\C-xc" and "\C-xC" runs "compile", but in addition to the
>> above if I also have
>>
>> 	(define-key global-map "\C-xC" 'grep-find)
>>
>> then I can invoke these two commands with lower- and upper- case 'c/C'
>> after control-x.
>>
>> If people have been relying on the historical behaviour that typing "R"
>> marked the path resolved (which may internally have been implemented with
>> whatever way), and if you are removing that binding, wouldn't that now
>> expose them to whatever happens to be bound to "r"?
>
> No, I don't claim to understand exactly how that works for the C-x case,
> but it doesn't apply here, "r" and "R" are two different bindings.

Thanks.  I just wanted to make sure that a user who is used to typing "R"
won't get the file removed with the new code.
