From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 06/15] ref-filter: make %(upstream:track) prints "[gone]"
 for invalid upstreams
Date: Mon, 7 Mar 2016 17:55:16 -0800
Message-ID: <CA+P7+xpdW46_pS9=NuWOuuQd4LwE4_foiRirPNoyrubCYeBNcg@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com> <1457265902-7949-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:55:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad6s9-0000gp-9q
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 02:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbcCHBzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 20:55:37 -0500
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36618 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbcCHBzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 20:55:37 -0500
Received: by mail-ig0-f193.google.com with SMTP id ir4so797866igb.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c4IdXDpKNzaR2UZo4z3OfwoEzySpqItc9BReRWYh3q0=;
        b=itwxaql2fRrtLtm4oywITCZt5c2iQd+1zBGWDTyj3mJR7kFJ4SVZVRl2V6uavYgDCX
         WEmgy1+HOUjBZPh0pmxCl1MqgVJlPQ1NRyyPhoERGzH792FQuXwMX2m2OWTsF5CtcPzO
         Ufx4C3miLuc5DN6stxbuMOINxnQnG+rLqeprWEr5vM5tN4If2RiTxQKPbzpWMxjV5Q0H
         zEQQrt1kUw/loUpDAVe1jGJchhWXvUFCk6KiUJdpGDDKIjsNRP6iiXTuYRR4TyqQHoL3
         nyucqXoKmHH7GYb7rTac5QrKTVXOSFBc/U5T6yw4WXAbuMoVF6c00AOqA6O+nFwhR57m
         dh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c4IdXDpKNzaR2UZo4z3OfwoEzySpqItc9BReRWYh3q0=;
        b=UuFCUSlMz8+rYFUKBagi6kIU92n9ktW0vHnFy/eaD6qKnGytFVRpbAGKqyfecahleU
         K49I19Lgsf8UqEF4ZglfFHq2k0d1uiEYZsgnz/IUzVqtHIkw40q6Z1cIeYZeHlBKdXqW
         TIUR7K2qg/e7nHQPorPl53XxOXu4T8kyIhMgBOVKxxgYCAYNaR4eI0NOagTT5JvyNPNd
         ZMLskd8Yb9LtWFBdegp9/jxjH02kdBIfMZ2I2/J4PgWOWQcyOTSahhZ+nrX4f4gtQHv4
         vD7t13a+2Zm2e+us10McUfbIAJTWWTO9edutGDra4fjRxLto9B1ujex9Bqn5AhShxyuB
         3FjA==
X-Gm-Message-State: AD7BkJJ3lQR+WANSdL/z+lofKQLuWRiT38fl0niUCKef5KbHzuXbutX4p/mKamMrmsL+2pIVv1PkaG6JfsrltA==
X-Received: by 10.50.137.35 with SMTP id qf3mr15943277igb.92.1457402136165;
 Mon, 07 Mar 2016 17:55:36 -0800 (PST)
Received: by 10.107.10.202 with HTTP; Mon, 7 Mar 2016 17:55:16 -0800 (PST)
In-Reply-To: <1457265902-7949-7-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288411>

On Sun, Mar 6, 2016 at 4:04 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Borrowing from branch.c's implementation print "[gone]" whenever an
> unknown upstream ref is encountered instead of just ignoring it.
>
> This makes sure that when branch.c is ported over to using ref-filter
> APIs for printing, this feature is not lost.
>
> Make changes to t/t6300-for-each-ref.sh to reflect this change.
>

Shouldn't this be documented as well?

Thanks,
Jake
