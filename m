From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] rm: better error message on failure for multiple files
Date: Sat, 8 Jun 2013 19:21:56 +0530
Message-ID: <CALkWK0mqVCfrPgSLi1dnDv26YAyRrJJD_S179VYfEApmGkd4Uw@mail.gmail.com>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:52:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJZe-0007OZ-GF
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3FHNwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:52:37 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45150 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3FHNwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:52:37 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so10113964iec.7
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t4PdqHiU55oJ5bgfj6IsNK3m3S1I/odbw+aPcQcxIpg=;
        b=VVPeExZNaHVuL6yxy4nDXFDxc3l7WtybBoUwCLUuKETG/v5/4lUweiL6jSmhKu1AEs
         lY9dpNtr4W5yheKa4k8fBbROI/5aBO5M64dRh7XgWsSqvf2bGJgzNWKRrIeOKLVSgoj9
         nGMWKXwQm6+EJT1LrqE7XgrR3Ec8VahePABN/SudiQoD624OXCvuuKnpC+BJfULGiUik
         LNoZ0QZBOXkiVWHpMewlh3m1YH8C+00bRKkPFGU+ucWebldCUpln1vjhwsJor1Jbmf+c
         R0szXxpIpvugadl1oq2bOgbfMMzEi3cTYsYywaTuUkeeYriirtDYURq48MgZurkjUIhD
         gbSw==
X-Received: by 10.50.79.231 with SMTP id m7mr912212igx.40.1370699556615; Sat,
 08 Jun 2013 06:52:36 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 06:51:56 -0700 (PDT)
In-Reply-To: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226823>

Mathieu Lienard--Mayor wrote:
> @@ -170,30 +175,47 @@ static int check_local_mod(unsigned char *head, int index_only)
>                  * "intent to add" entry.
>                  */
>                 if (local_changes && staged_changes) {
> -                       if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
> -                               errs = error(_("'%s' has staged content different "
> -                                            "from both the file and the HEAD\n"
> -                                            "(use -f to force removal)"), name);
> +                       if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD)) {
> +                               strbuf_addstr(&files_staged, "\n        ");

Ouch.  Wouldn't a string-list be more appropriate for this kind of thing?
