From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git bisect not finding the right commit
Date: Fri, 20 Jan 2012 10:09:51 -0800
Message-ID: <7vk44mfdow.fsf@alter.siamese.dyndns.org>
References: <87r4yw8j4i.fsf@franz.ak.mind.de>
 <7vlip4je87.fsf@alter.siamese.dyndns.org> <87ehuu958d.fsf@franz.ak.mind.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 19:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoIuU-0001IM-JX
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 19:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab2ATSJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 13:09:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab2ATSJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 13:09:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42B2B6A48;
	Fri, 20 Jan 2012 13:09:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=icTACH6+WqF995F/5TdWWwx7YQs=; b=uloS+v
	W+nY2QdoOWMjgsa2a4uZiffx6Ck/znTplOZ6CjShi8GJSjt2tZzXCcU3KEEuKVBj
	KGD5Y0iiRNakCXoQMx2corzQSaNFm6PuAN1ojjlWmxEmZXKQbx+A50gh7QGwxi6S
	fIDng4bA224IOlcPcfFK2Z2jV97bo8Xf6TGnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+gN4jbZkx8RQeI4IWSXPz0q5s8g/R3X
	Trmt8ty5BTfvI4ybpUscjfTL6INY85gve9Szzqu2yapA9vyce4u/19WYiuX0Sf9R
	o7LNuVa0jhbBHevjzugAYy03//oULmG5UZJIXtAZ95fU6pZLEC/E4HteqIVV3/Eb
	juarJTomVcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 389936A47;
	Fri, 20 Jan 2012 13:09:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDDEF6A46; Fri, 20 Jan 2012
 13:09:52 -0500 (EST)
In-Reply-To: <87ehuu958d.fsf@franz.ak.mind.de> (Andreas J. Koenig's message
 of "Fri, 20 Jan 2012 08:56:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F33B3FCA-4391-11E1-AFB4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188889>

andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig) writes:

>>>>>> On Thu, 19 Jan 2012 09:23:01 +0100, Johannes Sixt <j.sixt@viscovery.net> said:
>
>  js> Am 1/19/2012 4:29, schrieb Andreas J. Koenig:
>  >> - A -> B      ->     C - D ->
>  >>          \         /
>  >>           - E - F -
>  >> 
>  >> A v5.15.5
>  >> B v5.15.5-20-gfd76d40
>  >> C v5.15.5-81-gcfe287a
>  >> D v5.15.5-159-ga71d67b
>  >> E v5.15.4-110-g27b29ec
>  >> F v5.15.4-169-g3582575
>
>  js> I haven't looked at the actual history, but given the names of the commits
>  js> as produced by git-describe, I doubt that your history graph sketched
>  js> above is correct. Doesn't it look more like this:
>
>  js>       A -- B -- C -- D --
>  js>      /         /
>  js>  -- X -- E -- F
>
>  js> where X is v5.15.4?
>
> Yes, thank you for finding that out. X is actually v5.15.4-109-g3ea0c58
> and since there was a long timespan between the start of the development
> of the code and the merge (May-Nov), the gitk presentation got a bit
> complex to read.

(This is somewhat off-topic, so Andreas is on Cc: and the list is on To:)

I doubt --simplify-by-decoration alone would make it easier to view such a
complex and long history, but I wonder if we can use the same logic to
help users in a case like this. Instead of only keeping tagged versions in
the result to show topology, perhaps we can allow the user to feed a list
of "key points in history" as command line arguments and apply the same
kind of simplification to help visualizing the topology?
