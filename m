From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 01/44] Add support for ruby commands
Date: Sun, 29 Sep 2013 10:00:34 +0530
Message-ID: <CALkWK0m+LW-R-WJ6DmQkf1GKbCgvpzaGc2=rCNnmiPkf8x_qLg@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8f9-0003jX-Nc
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3I2EbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:31:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61599 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3I2EbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:31:15 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so7501990iec.27
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vPTnanahz3S3M32Jdy0huLw5A4sxih/w5pCOU4ZY4GI=;
        b=ayRDGVeiCd24E1NbdcyWh7QMKWYQluCp8sKl0bSwVqDiZqS78rqJMaYPjvQFEEkuAq
         4BD1k4nyprvRZfi1/P4tDAcKtUVn1gmXYigL0pFE+AxiNJs6WsunPWjWUOlBTjh8614w
         xk29+T+ziwOuxljPD4/PzbRG+N8HX0gybYdQSO4sTSwR06v3JjYbcPA6rSzZPSFkOGvU
         vnqHcD+jOCsesrke7/FIq6Jg8hsWJnHMYwMu8sVxXBIeyOXfoALmVOs1FbK9E37CtCqV
         faaZFDNbdr90T4LYJrn0gpAAuckz/GAQ0cm1afkQGsDACnACenFNy7GqiZl+ZDzHQCJM
         +8Gw==
X-Received: by 10.50.132.68 with SMTP id os4mr8702805igb.55.1380429075095;
 Sat, 28 Sep 2013 21:31:15 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 21:30:34 -0700 (PDT)
In-Reply-To: <1380405849-13000-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235580>

Felipe Contreras wrote:
> +test_expect_success 'argument passing' '
> +       cat > script <<-"EOF" &&
> +       p($0)
> +       p(ARGV)
> +       EOF
> +       git ruby script foo bar > actual &&
> +       cat > expected <<-EOF &&
> +       "script"
> +       ["foo", "bar"]
> +       EOF
> +       test_cmp expected actual
> +'

So, git-ruby is a new builtin that's just like a ruby interpreter,
except that it has certain git-related functions defined: you pass it
source code on stdin, and it returns the result on stdout. I wonder
what the purpose of passing arguments to it is though.

> +test_expect_success 'test for_each_ref()' '
> +       test_commit foo &&
> +       git ruby > actual <<-EOF &&
> +       for_each_ref() do |name, sha1, flags|
> +               puts "%s: %s" % [name, sha1_to_hex(sha1)]
> +       end
> +       EOF
> +       git for-each-ref --format="%(refname): %(objectname)" > expected &&
> +       test_cmp expected actual
> +'

I find it interesting that you chose to implement for-each-ref in the
initial version. It currently takes no arguments, but we can always
extend it to do ref-hierarchy filtering like f-e-r in the future.
