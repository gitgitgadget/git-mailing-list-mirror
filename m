From: Junio C Hamano <gitster@pobox.com>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 16:00:38 -0800
Message-ID: <7v7h0x6b89.fsf@alter.siamese.dyndns.org>
References: <20120109223737.GA1589@padd.com>
 <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net>
 <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
 <7vipki7ix9.fsf@alter.siamese.dyndns.org>
 <CALkWK0m+okqJk05BMQAEMww6FNLxaLVhAM92WmUDeA_J-drOdg@mail.gmail.com>
 <20120111195605.GB12333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:00:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl862-0001vA-G1
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 01:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2ALAAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 19:00:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab2ALAAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 19:00:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC246366;
	Wed, 11 Jan 2012 19:00:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kg511csJH91awHSVEYrSDYne2t4=; b=e09CSt
	kHFbAxc2T3RzenUYfzdnS+HdXHL7aLW8ilS+53hUXBzE6YLgWPcMgMrsr202KOjq
	7KHiSO6xDTm4WaXOzf7YZk9uMRjLdHFOH8pESVsqQzm325b5NRPp2UAQ7Nw3cs99
	/5sidg6S0vysyhzr37AVPySxwxB4vpYrky13o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SdDURvGuw9JnTq6fpg44Qr6fo6+unZHh
	ra6jHFSm7P5g31iH4vO9p0D3gb7oMH6iHoraohRnVK3g8Xg63TgyuSG8Ts7pT1DA
	sUr0P6VPLKT1yMh5t2wfP/yLXXDq1CYSshLv4n4DJxyirTU8uOLAwHcBzM3LWcJk
	yUeBkCCV8kY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4A816365;
	Wed, 11 Jan 2012 19:00:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E4F66363; Wed, 11 Jan 2012
 19:00:40 -0500 (EST)
In-Reply-To: <20120111195605.GB12333@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 11 Jan 2012 14:56:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76DDC228-3CB0-11E1-A790-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188408>

Jeff King <peff@peff.net> writes:

> Maybe this?
>
> diff --git a/attr.c b/attr.c
> index 76b079f..1656db4 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -301,6 +301,7 @@ static void free_attr_elem(struct attr_stack *e)
>  		}
>  		free(a);
>  	}
> +	free(e->attrs);
>  	free(e);
>  }

Yeah, that is definitely a leak.
