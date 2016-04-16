From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Fri, 15 Apr 2016 17:11:34 -0700
Message-ID: <CAGZ79kYUGue5r773BMjPALSAN0U2MRnq8kpDpfn_o9npfBDxLA@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
	<1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:11:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDpt-0000s1-2O
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcDPALg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:11:36 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37767 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcDPALf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:11:35 -0400
Received: by mail-ig0-f180.google.com with SMTP id g8so37250692igr.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xJACTiT1GYKFRyRXrIw1j8FB8A5+5IVvkKHvsBBA4Ec=;
        b=kz8mNWLW263f95kvTYi6nRQwXSUemTvnEfLfB+NInjociEmdIcrvBAcOHTyBtR0Hz0
         cP1VH6QVB+5R6x5UBPvATp01Mnd3QrhKDEqUWR/xISHcu9z73w3BJmD7JsP4IsIfYFnq
         +403rWuuapc04jRHQh5RTOOMm6O7v/vwYwMNJL8+WLLmNtoNl6+n+8B7VMLRhrO4zool
         aAJ4W+jHQCIu2fbtVweEC1ftz8h5fDcRCxQvE3vimCDZZmLRRN6D6+vrIh6tSVBNacT2
         o4/rAWsmYwcawiDQSsRPBAUV6tLckZ13EmgUH98XqV7BeRO72SxJtK5XRW+wF8FoYto5
         mbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xJACTiT1GYKFRyRXrIw1j8FB8A5+5IVvkKHvsBBA4Ec=;
        b=C1ifSzQANL6ceERDwYQl4gvfEbbruupRPlGV390OEbWVuWZH2w2m0dN9S/gmp0rpa+
         QGiaeeEgpoBLWZARCh/LbRQOAkbuT792S5UQ2DePO8Nd9IfjhSyspq78hadyqUEH79em
         09NoFVTFltxvMO5P5rqXikHXOgZdq7Y2CJWc4d8ElncooldrtiprbDok9aUnfF8HO+mJ
         6jYbUgqiZKs67ATOH4HEi+lj5nsz2LU4lGfPEo5tummfmob/0okOrgnsf5XEQAzMDKho
         WQl73eqV0wJK23sR6xN4qRcTO0DNAM29YzscbSLZZzfVNII9Ht77MPSm9JKO4kpdpTKp
         dVdw==
X-Gm-Message-State: AOPr4FUqr1F5Zhq9bIv5DPocSRYZULHVt/eQkoMkDjBJdWvnRwJcxxX9Ba38ncxkJ/RPOUtmJzceskfKeaetcPLA
X-Received: by 10.50.23.80 with SMTP id k16mr8202902igf.94.1460765494306; Fri,
 15 Apr 2016 17:11:34 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 17:11:34 -0700 (PDT)
In-Reply-To: <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291703>

>  static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>  {
>         int i, max = 0;
> @@ -432,7 +281,10 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>
>                 skip_prefix(it->refname, "refs/heads/", &desc);
>                 skip_prefix(it->refname, "refs/remotes/", &desc);
> -               w = utf8_strwidth(desc);
> +               if (it->kind == FILTER_REFS_DETACHED_HEAD)
> +                       w = strlen(get_head_description());

get_head_description returns memory, which needs to be free'd.
(found by catching up on reading the coverity scan log. I see
you deleted get_head_description in another part of the patch;
nevertheless would you like to take care of this memleak?)
