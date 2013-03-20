From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Wed, 20 Mar 2013 12:03:28 -0700
Message-ID: <7vfvzpevwf.fsf@alter.siamese.dyndns.org>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:03:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOIo-0007H7-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab3CTTDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:03:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3CTTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:03:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C9DAAEE8;
	Wed, 20 Mar 2013 15:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OIrTXqdF0qT3u21FurtHCj5Dbs=; b=DceGHE
	Ss+K/b9q+poqn+aspjl/cFlSAKvQmUps7KVznNG0AtJXDsoiQjEI1zVE+6NMzdvr
	Yt+9NW2IFrSo7Xt+t3+oXrbEfXpzldalRLBSvgQbz1S1aqAOUiwagwcFrriOwqHy
	G4QzS+fX0OATNsq7Hd8mmy2cMk1RgoZDgdrEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbVBCBJc/MdkLuKrhS69rFpQ6z8RG6sq
	jsLdSNdWTECqw0CqVXdUwATOTUxZxwNk+tn+PGzz9dnMBYPu42iRPkvfKenZY+I/
	m+UYfVsqtarKoPiNDwTycSTji6H/TxDNt5c9zIdUlGJSFSQsVr93Nb+Xa3XTG85q
	/zcX2y38YGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8159CAEE7;
	Wed, 20 Mar 2013 15:03:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2B7DAEE5; Wed, 20 Mar 2013
 15:03:29 -0400 (EDT)
In-Reply-To: <1363783501-27981-5-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 20 Mar 2013 18:14:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA5CF0B8-9190-11E2-8FF4-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218658>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  	if (name)
>  		name_given = 1;
>  	else {
> -		name = default_remote_name;
> -		name_given = explicit_default_remote_name;
> +		if (pushremote_name) {
> +			name = pushremote_name;
> +			name_given = 1;
> +		} else {
> +			name = default_remote_name;
> +			name_given = explicit_default_remote_name;
> +		}
>  	}

The code to read branch.$name.remote configuration flips
explicit_default_remote_name to one when it is used to set the
default_remote_name, and that controls the value of name_given in
this codepath.  At this point in the series, you do not have a
corresponding branch.$name.pushremote, but your [6/6] does not seem
to do the same.

Why isn't it necessary to add explicit_default_pushremote_name and
do the same here in patch [6/6]?
