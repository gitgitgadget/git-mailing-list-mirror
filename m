From: =?UTF-8?Q?beno=C3=AEt_person?= <benoit.person@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 12:26:18 +0200
Message-ID: <CAETqRCjCf0HKfAsgcWPnv81OY07T0JZdXVGGr-DgLsP3miWUvQ@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 18 12:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uot7K-0001Li-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab3FRK0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 06:26:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:63126 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab3FRK0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:26:18 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so9456298iee.20
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=I0ezPCoZNDaPk1IcxppB/+o9GNw/hPOFw2e88c4mWeA=;
        b=LNo4Np3svneNM8fZSmwpGuDYmO9x0HdTDabXFr6TOK3lO/p+GGACudDEAAEVM10yFT
         r/ey3QV2bGvYBCh7exDq72DuEJSWuWam6hfkOsIIEnrry9bxwbjKvlclqPqAdRj2GrTE
         HIlnncOaNWToXao62rqI2Cggob2lr3DM5SwmG8C1b5WjiEJfXZjcmIf87diYVMCkXkYa
         j3o/K0odzndu+A9POtNwBbiHkg3KcOxfeR3ZZ4+ru1mMORg/tCE82ryf92AJNA9j2s+I
         SaS1xSnonMWNKYL7rciZ4bZ5tDxyo2U78TKQBvBvKUPuIhmDa+e3tUntEm6q+hXRgIhi
         9Vjg==
X-Received: by 10.50.153.113 with SMTP id vf17mr7004495igb.101.1371551178272;
 Tue, 18 Jun 2013 03:26:18 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Tue, 18 Jun 2013 03:26:18 -0700 (PDT)
In-Reply-To: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-Google-Sender-Auth: tfH7bQ9YQsxccvhbd4O3eWYEC_g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228189>

> +sub split_email_list {
> +    my(@list) = @_;
> +    my @tmp;
> +    my @emails;
> +       for (my $i = 0; $i <= $#list; $i++) {
> +           if ($list[$i] =~ /,/) {
> +               @emails = split(/,/, $list[$i]);
> +           } else {
> +               @emails = $list[$i];
> +           }
> +           # Removal of unwanted spaces
> +           for (my $j = 0; $j <= $#emails; $j++) {
> +               $emails[$j] =~ s/^\s+//;
> +               $emails[$j] =~ s/\s+$//;
> +           }
> +           @tmp = (@tmp, @emails);
> +       }
> +    return(@tmp);
> +}
Why two regex ? You could do something like :
$emails[$j] =~ s/^\s+|\s+$//g;
to remove leading and trailing whitespaces at the same time.

I think it's better to use the builin 'push' function to concatenate
your two arrays:
push(@tmp, @emails);

Benoit Person
