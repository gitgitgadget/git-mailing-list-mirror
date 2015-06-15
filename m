From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/12] initial_ref_transaction_commit(): function for initial ref creation
Date: Mon, 15 Jun 2015 11:04:44 -0700
Message-ID: <xmqqk2v4alvn.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:04:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Yke-0001kv-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbbFOSEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:04:48 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33421 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFOSEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:04:47 -0400
Received: by iebgx4 with SMTP id gx4so67863271ieb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6dK92b+t85iI5k4sJ/3GbVpV/ElOp+URdigQMssK0WE=;
        b=Bab9JG/uF1HSEi1dgnaNRC5xpxTeNafXb07r2CzCOdbwbKOcOAR2CHGp5APAjIl6vZ
         /9c3pudSOEw522KEUniBnPyvvnkMuNwgpuclmZesxK1aevtL09+QvsYqzygqKI4AdRZ9
         d41r7yOv5L6D6vpa9uv84edgHuLsQJG72zN6gEzVtRfyv4+9UPgR7Erot7SuImfdSwbh
         Yp7Uqcf6ve3G46QIorU6FigPIgJeG+e/yET1ujS95NOYOKxgFwCJ8nyBuHuRi8P1A5yF
         qECVSaIHOPlTFqRPX6EUS334D03ED5G/Zh+iKlRyG8Xx/kPkp4lmOEYhUKW/RIA83kbf
         FdLA==
X-Received: by 10.50.30.138 with SMTP id s10mr3186431igh.3.1434391486607;
        Mon, 15 Jun 2015 11:04:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id e3sm2821185igq.21.2015.06.15.11.04.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:04:45 -0700 (PDT)
In-Reply-To: <19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271695>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +	struct ref_transaction *t;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	t = ref_transaction_begin(&err);
> +	if (!t)
> +		die(err.buf);
>  
>  	for (r = local_refs; r; r = r->next) {
>  		if (!r->peer_ref)
>  			continue;
> -		add_packed_ref(r->peer_ref->name, r->old_sha1);
> +		if (ref_transaction_create(t, r->peer_ref->name, r->old_sha1,
> +					   0, NULL, &err))
> +			die(err.buf);
> +	}
> +
> +	if (initial_ref_transaction_commit(t, &err)) {
> +		die(err.buf);
>  	}

I'll remove {} around this as you do not seem to touch this part to
add more statement here.

The series makes sense so far ;-)
